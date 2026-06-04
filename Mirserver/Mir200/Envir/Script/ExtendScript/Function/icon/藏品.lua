cangPin = {}
cangPin.configCache = include("Script/ExtendScript/cfgcsv/npc/cfg_藏品.lua")
cangPin.config = {}

for k, sceneConfig in pairs(cangPin.configCache) do
    if type(k) == "number" and type(sceneConfig.type) == "table" then
        local currentTable = cangPin.config
        local qualityTable = nil
        for num, typeValue in ipairs(sceneConfig.type) do
            if currentTable[typeValue] == nil then
                currentTable[typeValue] = {}
            end

            currentTable = currentTable[typeValue]
            if num == 2 then
                qualityTable = currentTable
            end
        end

        currentTable.name = sceneConfig.name
        currentTable.attr = sceneConfig.attr
        currentTable.attrName = sceneConfig.attrName
        if sceneConfig.suit ~= nil and qualityTable ~= nil then
            qualityTable.suit = sceneConfig.suit
            qualityTable.suitName = sceneConfig.suitName
        end
    end
end


---打开藏品主界面，并把当前配置、收录状态、进度、属性发送给客户端
function cangPin.main(player)
    lualib:ShowFormWithContent(player,"藏品_receiveMessage",cangPin.getData(player))
    return ""
end

---点击收录藏品，扣除对应道具后保存收录状态并刷新属性
function cangPin.click(player,type1,type2,type3)
    type1 = tonumber(type1)
    type2 = tonumber(type2)
    type3 = tonumber(type3)
    if type1 == nil or type2 == nil or type3 == nil then
        return ""
    end

    local itemConfig = cangPin.getItemConfig(type1,type2,type3)
    if itemConfig == nil then
        return ""
    end

    local _data = cangPin.getVar(player)
    if _data[type1] == nil then
        _data[type1] = {}
    end

    if _data[type1][type2] == nil then
        _data[type1][type2] = {}
    end

    if _data[type1][type2][type3] == 1 then
        lualib:SendMsgGetColor(player,9,"#ff0800|该藏品已经收录！")
        return ""
    end

    local need = {itemConfig.name,1}
    if not lualib:CheckNeedItems(player,need) then
        return ""
    end

    lualib:DelNeedItems(player,need,"藏品收录")
    _data[type1][type2][type3] = 1
    lualib:SetVar(player,VarCfg["藏品"],tbl2json(_data))
    cangPin.setAttr(player)
    lualib:ShowFormWithContent(player,"藏品_syncData",cangPin.getData(player))
    return ""
end

---按大类、品质、序号取得单个藏品配置
function cangPin.getItemConfig(type1,type2,type3)
    if cangPin.config[type1] == nil then
        return nil
    end

    if cangPin.config[type1][type2] == nil then
        return nil
    end

    return cangPin.config[type1][type2][type3]
end

---读取玩家藏品收录变量，并按配置补齐未收录的默认值
function cangPin.getVar(player)
    local _data = {}
    local str = lualib:GetVar(player,VarCfg["藏品"])
    if str ~= "" then
        _data = json2tbl(str)
    end

    for type1,typeConfig in pairs(cangPin.config) do
        if type(type1) == "number" then
            if _data[type1] == nil then
                _data[type1] = {}
            end

            for type2,qualityConfig in pairs(typeConfig) do
                if type(type2) == "number" then
                    if _data[type1][type2] == nil then
                        _data[type1][type2] = {}
                    end

                    for type3,_ in pairs(qualityConfig) do
                        if type(type3) == "number" then
                            if _data[type1][type2][type3] == nil then
                                _data[type1][type2][type3] = 0
                            end
                        end
                    end
                end
            end
        end
    end

    return _data
end

---统计每个大类、品质下已收录数量和总数量
function cangPin.getProgress(player)
    local _data = cangPin.getVar(player)
    local progress = {}

    for type1,typeConfig in pairs(cangPin.config) do
        if type(type1) == "number" then
            progress[type1] = {}
            for type2,qualityConfig in pairs(typeConfig) do
                if type(type2) == "number" then
                    local max = 0
                    local count = 0
                    for type3,_ in pairs(qualityConfig) do
                        if type(type3) == "number" then
                            max = max + 1
                            if _data[type1] ~= nil and _data[type1][type2] ~= nil and _data[type1][type2][type3] == 1 then
                                count = count + 1
                            end
                        end
                    end

                    progress[type1][type2] = {count = count,max = max}
                end
            end
        end
    end

    return progress
end

---把配置中的属性累加到总属性表
function cangPin.addAttr(attr,attrConfig)
    if attrConfig == nil then
        return attr
    end

    for i=1,#attrConfig do
        local attrId = attrConfig[i][1]
        local value = attrConfig[i][2]
        if attrId ~= nil and value ~= nil then
            attr[attrId] = (attr[attrId] or 0) + value
        end
    end

    return attr
end

---计算玩家当前已激活的藏品属性和套装属性
function cangPin.getAttr(player)
    local _data = cangPin.getVar(player)
    local progress = cangPin.getProgress(player)
    local attr = {}

    for type1,typeConfig in pairs(cangPin.config) do
        if type(type1) == "number" then
            for type2,qualityConfig in pairs(typeConfig) do
                if type(type2) == "number" then
                    for type3,itemConfig in pairs(qualityConfig) do
                        if type(type3) == "number" then
                            if _data[type1] ~= nil and _data[type1][type2] ~= nil and _data[type1][type2][type3] == 1 then
                                cangPin.addAttr(attr,itemConfig.attr)
                            end
                        end
                    end

                    if progress[type1] ~= nil and progress[type1][type2] ~= nil then
                        if progress[type1][type2].max > 0 and progress[type1][type2].count >= progress[type1][type2].max then
                            cangPin.addAttr(attr,qualityConfig.suit)
                        end
                    end
                end
            end
        end
    end

    return attr
end

---把藏品属性写入临时属性列表，登录或收录后需要重新添加
function cangPin.setAttr(player)
    lualib:DelAttrList(player,"藏品")
    local attr = cangPin.getAttr(player)
    local attrStr = lualib:BuffAttrList2Str(attr)
    if attrStr ~= "" then
        lualib:AddAttrList(player,"藏品","=",attrStr)
    end
end
---组装发送给客户端的藏品数据，只发送玩家状态和计算结果，不直接下发大配置表
function cangPin.getData(player)
    local data = {}
    ---玩家收录状态，客户端结合本地 cfg_藏品.lua 显示
    data.var = cangPin.getVar(player)
    ---每个大类、品质的收录进度
    data.progress = cangPin.getProgress(player)
    ---当前已经激活的属性汇总，用于客户端展示
    data.attr = cangPin.getAttr(player)
    return data
end

---登录后重新添加藏品临时属性，避免下线清除后失效
local function _onLogin(player)
    cangPin.setAttr(player)
end

GameEvent.add(EventCfg.onLogin,_onLogin,cangPin)
Message.RegisterClickMsg("藏品", cangPin)
setFormAllowFunc("藏品", {"main","click"})
setNpcRangeAllowFunc("藏品", {"main","click"}, 10)

return cangPin