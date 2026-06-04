anQuanXiang = {}
anQuanXiang.config = include("Script/ExtendScript/cfgcsv/npc/cfg_地图区分.lua")
anQuanXiang.level = include("Script/ExtendScript/cfgcsv/npc/cfg_技能学习.lua")
anQuanXiang.no = {
    ["天纵钥匙碎片"] = 1,
    ["天纵钥匙"] = 1,
    ["沃玛套装卷轴(1级)"] = 1,
    ["祖玛套装卷轴(2级)"] = 1,
    ["赤月套装卷轴(3级)"] = 1,
    --["魔血石(1级)"] = 1,
    --["魔血石(2级)"] = 1,
    --["魔血石(3级)"] = 1,
    --["魔血石(4级)"] = 1,
    --["魔血石(5级)"] = 1,
}
function anQuanXiang.main(player)
    lualib:ShowFormWithContent(player,"安全箱_receiveMessage",anQuanXiang.getData(player))
    return ""
end

function anQuanXiang.click(player,makeIndex,page)
    ---local mapName = lualib:GetMapId(player)
    --if anQuanXiang.config[mapName] ~= nil then
    --    if anQuanXiang.config[mapName].type == 1 then
    --        lualib:SendMsgGetColor(player,9,"#ff0800|该地图无法使用安全箱!!")
    --        return ""
    --    end
    --end
    if not lualib:IsMainCity(player) then
        lualib:SendMsgGetColor(player,9,"#ff0800|该地图无法使用安全箱!!")
        return ""
    end

    if not hasitem(player,makeIndex,1) then
        lualib:MsgBox(player,"物品不存在！！")
        return ""
    end

    local _data = anQuanXiang.getVar(player)
    if _data[page] == nil then
        return ""
    end

    local item = getitembymakeindex(player,makeIndex)
    if item == "0" then
        lualib:MsgBox(player,"物品不存在！！")
        return ""
    end

    local num = lualib:GetItemInt(player,item,1)
    local name = lualib:ItemName(player,item)
    if anQuanXiang.no[name] ~= nil then
        lualib:MsgBox(player,"该物品无法放入安全箱！！")
        return ""
    end

    local chiJiu = getdura(player,makeIndex)
    delitembymakeindex(player,makeIndex)
    local max = getiteminfo(player,item,5)
    if max == 0 then
        max = 1
    end

    local bind = 0
    if _data[page][1] ~= "" then
        if _data[page][2] == 1 then
            bind = 258
        end

        item = lualib:AddItem(player,_data[page][1],_data[page][4],bind,"取出安全箱")
        setdura(player,getiteminfo(player, item,1),"=",_data[page][3])
        lualib:SetItemInt(player,item,1,_data[page][2])
    end

    _data[page] = {name,num,chiJiu,max} ---道具名字，类型,耐久，数量
    lualib:SetVar(player,VarCfg["安全箱"],tbl2json(_data))
    return ""
end

function anQuanXiang.change(player,page)
    local _data = anQuanXiang.getVar(player)
    if _data[page] == nil then
        return ""
    end

    if _data[page] == 0 then
        return ""
    end

    local bind = 0
    if _data[page][2] == 1 then
        bind = 258
    end

    if lualib:GetBagNum(player) < 3 then
        lualib:SendMsgGetColor(player,9,"#ff0800|背包空间不足！！")
        return ""
    end

    local item = lualib:AddItem(player,_data[page][1],_data[page][4],bind,"取出安全箱")
    lualib:SetItemInt(player,item,1,_data[page][2])
    setdura(player,getiteminfo(player, item,1),"=",_data[page][3])

    _data[page] = {0,0,0,0} ---道具名字，类型,耐久，数量
    lualib:SetVar(player,VarCfg["安全箱"],tbl2json(_data))
    lualib:ShowFormWithContent(player,"安全箱_syncData",anQuanXiang.getData(player))
end

function anQuanXiang.getVar(player)
    local _data = {}
    local str = lualib:GetVar(player,VarCfg["安全箱"])
    local num = lualib:GetVar(player,VarCfg["安全箱数量"])
    if  str == "" then
        for i=1,num do
            _data[i] = {0,0,0,0}    ---道具名字，类型,耐久，数量
        end
    else
        _data = json2tbl(str)
        for i=1,num do
            if _data[i] == nil then
                _data[i] = {0,0,0,0} ---道具名字，类型,耐久，数量
            end
        end
    end

    return _data
end

function anQuanXiang.setLevel(player)
    sheZhiDengJi.setLevel(player)
    return ''
end

function anQuanXiang.getData(player)
    local data = {}
    data.num = lualib:GetVar(player,VarCfg["安全箱数量"])
    data.var = anQuanXiang.getVar(player)
    return data
end

local function _onEnterMap(player, map, oldmap,x,y)
    if anQuanXiang.config[map] ~= nil then
        if anQuanXiang.config[map].type == 1 then
            if oldmap ~= map then
                setattackmode(player,0,0)
            end
        end
    end

    anQuanXiang.setLevel(player)
    zhunBeiZhanDou.daojishi(player)
end

local function _onTakeChange(player,item,where,itemName,makeIndex,type)
    anQuanXiang.setLevel(player)
end

GameEvent.add(EventCfg.onTakeChange,_onTakeChange,anQuanXiang)
GameEvent.add(EventCfg.onEnterMap,_onEnterMap,anQuanXiang)
Message.RegisterClickMsg("安全箱", anQuanXiang)
setFormAllowFunc("安全箱", {"main","click","change"})

return anQuanXiang