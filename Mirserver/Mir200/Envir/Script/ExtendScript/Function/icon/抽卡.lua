chouKa = {}
chouKa.config = include("Script/ExtendScript/cfgcsv/npc/cfg_抽卡.lua")
chouKa.kill = include("Script/ExtendScript/cfgcsv/npc/cfg_杀怪获得抽取次数.lua")
chouKa.max = 100

chouKa.map = {
    ["d601"] = 1,
    ["d602"] = 2,
    ["d604"] = 3,
    ["d603"] = 4,
    ["d605"] = 5,
    ["d613"] = 6,
    ["d618"] = 7,
    ["d606"] = 8,
    ["mishi1"] = 1,
    ["mishi2"] = 2,
    ["mishi3"] = 3,
    ["mishi4"] = 4,
    ["mishi5"] = 5,
    ["mishi6"] = 6,
    ["mishi7"] = 7,
    ["mishi8"] = 8,
}

chouKa.card9 = {
    ["沃玛武器(1级)"] = "祖玛武器(2级)",
    ["祖玛武器(2级)"] = "赤月武器(3级)",
    ["赤月武器(3级)"] = "魔龙武器(4级)",
    ["魔龙武器(4级)"] = "战神武器(5级)",
    ["战神武器(5级)"] = "星王武器(6级)",
    ["星王武器(6级)"] = "星王武器(6级)",
    ["雷炎武器(7级)"] = "星王武器(6级)",
    ["沃玛衣服(1级)"] = "祖玛衣服(2级)",
    ["祖玛衣服(2级)"] = "赤月衣服(3级)",
    ["赤月衣服(3级)"] = "魔龙衣服(4级)",
    ["魔龙衣服(4级)"] = "战神衣服(5级)",
    ["战神衣服(5级)"] = "星王衣服(6级)",
    ["星王衣服(6级)"] = "星王衣服(6级)",
    ["雷炎衣服(7级)"] = "星王衣服(6级)",

}

chouKa.monType = include("Script/ExtendScript/cfgcsv/npc/cfg_怪物区分.lua")
---需要解锁套装第一个卡片
chouKa.needSuit1Card  = {
    --[4] = 50,
    --[6] = 59,
    --[8] = 69,
    --[11] = 85,
    --[12] = 95
}

chouKa.card94 = {"元宝",1000}     ---需要元宝
---
chouKa.ziSe = {
    "乘黄脊骨",
    "鲲鹏遗珠",
    "巴蛇蜕皮",
    "柔骨兔耳",
    "夫诸利爪",
    "赤沙蝎尾",
    "地心幽莲",
    "星辰泪兰",
    "冰火神果",
    "幻心绿萝",
    "虚空莲子",
    "悟道茶树",
    "千年人参",
    "三千焱炎火",
    "九幽风炎",
    "骨灵冷火",
    "九龙雷罡火",
    "龟灵地火",
    "陨落心炎",
    "海心焰",
}

chouKa.canPin = {
    "乘黄脊骨",
    "鲲鹏遗珠",
    "巴蛇蜕皮",
    "柔骨兔耳",
    "夫诸利爪",
    "赤沙蝎尾",
    "地心幽莲",
    "星辰泪兰",
    "冰火神果",
    "幻心绿萝",
    "虚空莲子",
    "悟道茶树",
    "千年人参",
    "三千焱炎火",
    "九幽风炎",
    "骨灵冷火",
    "九龙雷罡火",
    "龟灵地火",
    "陨落心炎",
    "海心焰",
    "火云水炎",
    "火山石焰",
    "风怒龙炎",
    "青莲地心火",
    "幽冥毒火",
    "阴阳双炎",
    "万兽灵火",
    "玄黃炎",
    "魔猿冠",
    "狡犬齿",
    "天蛛网",
    "苍狼爪",
    "神鹿首",
    "灵龟甲",
    "冰龙首",
    "凝露草",
    "芭蕉叶",
    "赤炎藤",
    "蒲公英",
    "通幽兰",
    "蛇信草",
    "灵火枫",
    "攀星枝",
}
-------------------------------------------------------抽看展示----------------------------------------------------------
function chouKa.show(player,page)
    local guid = player
    if page == 2 then
        guid = lualib:GetVar(player,"S$查看别人装备")
    end

    lualib:ShowFormWithContent(player,"抽卡展示_receiveMessage",chouKa.showData(guid))
end

function chouKa.showData(player)
    local data = {}
    data.card = chouKa.getPicked(player)
    data.max = chouKa.getMax(player)
    data.suit = chouKa.getSuitNum(player)
    return data
end
-----------------------------------------------------抽卡展示结束---------------------------------------------------------
function chouKa.main(player)
    local max = chouKa.getMax(player)
    local _t = chouKa.getPickedCount(player)
    if max <= _t then
        lualib:SendMsgGetColor(player,9,"#ff0d00|卡槽已满无法再抽取！")
        return ""
    end

    lualib:ShowFormWithContent(player,"抽卡_receiveMessage",chouKa.getData(player))
    return ""
end
---选择激活属性
function chouKa.click(player,page)
    if type(page) ~= "number" then
        return ""
    end

    if page < 1 or page > 3 then
        return ""
    end
    local level = lualib:GetVar(player,VarCfg["杀怪等级"])
    local count = chouKa.getPickedCount(player)
    if level <= count then
        lualib:SendMsgGetColor(player,9,"#ff0d00|没有可抽取次数！")
        return ""
    end

    local _data = chouKa.getPicked(player)
    if chouKa.getPickedCount(player) >= chouKa.getMax(player) then
        lualib:SendMsgGetColor(player,9,"#ff0d00|卡槽已满无法再抽取！")
        return ""
    end

    local config = chouKa.config
    local _t = chouKa.getCard(player)
    if _t[page] == 94 then
        if not lualib:CheckNeedItems(player,{"元宝",1000}) then
            return ""
        end

        lualib:DelNeedItems(player,{"元宝",1000},"氪命扣除材料")
        lualib:SetVar(player,VarCfg["获得下次全部卡片"],1)
    end

    if lualib:GetVar(player,VarCfg["获得下次全部卡片"]) == 0 then
        _data[#_data + 1] = _t[page]
    else
        for i = 1,#_t do
            _data[#_data + 1] = _t[i]
        end
    end

    if _t[page] == 91 then
        local _card = chouKa.pick3Unique(player,config,2)
        local txt = ""
        for i=1,#_card do
            _data[#_data + 1] = _card[i]
            chouKa.special(player,_card[i])
            txt = txt .. chouKa.config[chouKa.config[tostring(_card[i])].group].name .. "   "
        end
        lualib:MsgBox(player,"恭喜获得随机卡片：<font color='#00ffdd'>"..txt.."</font> ")
    elseif _t[page] == 93 then
        local _card = chouKa.pick3Unique(player,config,1,1)
        local txt = ""
        for i=1,#_card do
            _data[#_data + 1] = _card[i]
            chouKa.special(player,_card[i])
            txt = txt .. chouKa.config[chouKa.config[tostring(_card[i])].group].name .. "   "
        end
        lualib:MsgBox(player,"恭喜随机棱彩级卡片：<font color='#00ffdd'>"..txt.."</font> ")
    elseif _t[page] == 92 then
        local _card = chouKa.pick3Unique(player,config,#_data,1)
        for i=1,#_card do
            _data[i] = _card[i]
            chouKa.special(player,_card[i])
        end
        lualib:MsgBox(player,"所有卡片都换成棱彩级符文，请在角色界面上查看抽中的卡")
    end


    lualib:SetVar(player,VarCfg["抽中卡片"],tbl2json(_data))
    lualib:SetVar(player,VarCfg["抽卡刷新次数"],0)
    chouKa.special(player,_t[page])

    lualib:SetVar(player,VarCfg["抽卡刷新次数"],0)
    lualib:SetVar(player,VarCfg["抽卡记录"],"")
    lualib:SetVar(player,VarCfg["单卡刷新记录"],"")
    delaygoto(player,100,"click,设置等级_setLevel")
    if level <= chouKa.getPickedCount(player) then
        lualib:ShowFormWithContent(player,"抽卡_close")
    else
        lualib:ShowFormWithContent(player,"抽卡_syncData",chouKa.getData(player))
    end
    chouKa.updateKillMon(player)
    lualib:SendMsgGetColor(player,9,"#28ef00|成功选择：|#e3ef00|"..chouKa.config[chouKa.config[tostring(_t[page])].group].name )
    return ""
end
---特殊奖励需要单独走脚本
function chouKa.special(player,id)
    if id == 9 then
        local item = lualib:GetItem(player,0)
        if item ~= nil then
            local name = lualib:ItemName(player,item)
            if chouKa.card9[name] ~= nil then
                lualib:AddItem(player,chouKa.card9[name],1)
            end
        end

        item = lualib:GetItem(player,1)
        if item ~= nil then
            local name = lualib:ItemName(player,item)
            if chouKa.card9[name] ~= nil then
                lualib:AddItem(player,chouKa.card9[name],1)
            end
        end
    elseif  id == 19 then
        senddelaymsg(player,"%s剩余撤离时间",20,250,1,"@gohome",0)
    end

    chouKa.setCache(player)
end
---增加属性
function chouKa.setAttr(player)
    delaygoto(player,50,"click,设置等级_setLevel")
    return ""
end
---重置
function chouKa.reset(player)
    lualib:SetVar(player,VarCfg["可撤离数据"],"")
    lualib:SetVar(player,VarCfg["抽中卡片"],"")
    lualib:SetVar(player,VarCfg["抽卡记录"],"")
    lualib:SetVar(player,VarCfg["杀怪记录"],"")
    lualib:SetVar(player,VarCfg["抽卡刷新次数"],0)
    lualib:SetVar(player,VarCfg["抽中技能"],"")
    lualib:SetVar(player,VarCfg["下地图"],"")
    lualib:SetVar(player,VarCfg["单卡刷新记录"],"")

    lualib:SetVar(player,"N$能量护盾",0)
    lualib:SetVar(player,VarCfg["坦克引擎"],0)
    lualib:SetVar(player,VarCfg["攻速进化"],0)
    lualib:SetVar(player,VarCfg["屠杀进化"],0)
    lualib:SetVar(player,VarCfg["移速进化"],0)
    lualib:SetVar(player,VarCfg["噬魂进化"],0)
    lualib:SetVar(player,VarCfg["猎魔进化"],0)
    lualib:SetVar(player,VarCfg["猎魔进化精英"],0)
    lualib:SetVar(player,VarCfg["猎魔进化BOSS"],0)
    lualib:SetVar(player,VarCfg["控制欲极强"],0)
    lualib:SetVar(player,VarCfg["铁甲觉醒"],0)
    lualib:SetVar(player,VarCfg["巨人收割机"],0)
    lualib:SetVar(player,VarCfg["获得下次全部卡片"],0)
    lualib:SetVar(player,VarCfg["杀怪进度"],0)
    lualib:SetVar(player,VarCfg["杀怪等级"],0)
    lualib:SetVar(player,VarCfg["赏金猎人"],0)
    lualib:DelAttrList(player,"聚宝成锋")
    lualib:DelAttrList(player,"铁甲觉醒")
    lualib:DelAttrList(player,"无限进化")

    local list_buff = getallbuffid(player)
    for i, buffid in ipairs(list_buff) do
        lualib:DelBuff(player,buffid)
    end

    lualib:SetVar(player,VarCfg["进入地图"],0)
    clearplayeffect(player,80345)
    ----anQuanXiang.setLevel(player)
    chouKa.setCache(player)
    chouKa.setAttr(player)

end
---刷新抽卡
function chouKa.updateCards(player)
    local num = lualib:GetVar(player,VarCfg["抽卡刷新次数"])
    local level = num + 1
    local max = chouKa.getMaxChange(player)
    local mianfei = 1
    if lualib:GetFlag(player,VarCfg["月卡"]) == 1 then
        mianfei = mianfei + 1
    end

    if level > max then
        lualib:SendMsgGetColor(player,9,"#ff0d00|已经没有刷新次数了！")
        return ""
    end

    local count = chouKa.getPickedCount(player)
    if lualib:GetVar(player,VarCfg["杀怪等级"]) <= count then
        lualib:SendMsgGetColor(player,9,"#ff0d00|没有可抽取次数！")
        return ""
    end


    if level > mianfei then
        local need = lualib:CopyTable(chouKa.config.basic.need[level-mianfei])
        if ServerCache.Players[player].OtherEquip["打折卡"] ~= nil then
            need[2] = need[2]/2
        end

        if not lualib:CheckNeedItems(player,need) then
            return ""
        end

        lualib:DelNeedItems(player,need,"抽卡刷新扣除材料")
    end

    lualib:SetVar(player,VarCfg["抽卡记录"],"")
    lualib:SetVar(player,VarCfg["抽卡刷新次数"],num + 1)

    lualib:ShowFormWithContent(player,"抽卡_syncData",chouKa.getData(player))
    return ""
end
---刷新单卡
function chouKa.changeOneCard(player,page)
    if type(page) ~= "number" then
        return ""
    end

    if page < 1 or page > 3 then
        return ""
    end

    local _update = chouKa.getUpdateData(player)
    local num = _update[page]           ---lualib:GetVar(player,VarCfg["抽卡刷新次数"])
    local level = num + 1
    local max = chouKa.getMaxChange(player)
    local mianfei = 1
    if lualib:GetFlag(player,VarCfg["月卡"]) == 1 then
        mianfei = mianfei + 1
    end

    if level > max then
        lualib:SendMsgGetColor(player,9,"#ff0d00|已经没有刷新次数了！")
        return ""
    end

    local count = chouKa.getPickedCount(player)
    if lualib:GetVar(player,VarCfg["杀怪等级"]) <= count then
        lualib:SendMsgGetColor(player,9,"#ff0d00|没有可抽取次数！")
        return ""
    end

    if level > mianfei then
        local need = lualib:CopyTable(chouKa.config.basic.need[level-mianfei])
        if ServerCache.Players[player].OtherEquip["打折卡"] ~= nil then
            need[2] = need[2]/2
        end

        if not lualib:CheckNeedItems(player,need) then
            return ""
        end

        lualib:DelNeedItems(player,need,"抽卡刷新扣除材料")
        GameEvent.push(EventCfg.onConsumeRecord,{
            yuanbao = need[2]
        })
    end

    local _data = chouKa.getCard(player)

    local _t = chouKa.pick1Unique(player,chouKa.config,1,_data)
    _data[page] = _t
    _update[page] = _update[page] + 1
    lualib:SetVar(player,VarCfg["抽卡记录"],tbl2json(_data))
    ---lualib:SetVar(player,VarCfg["抽卡刷新次数"],num + 1)
    lualib:SetVar(player,VarCfg["单卡刷新记录"],tbl2json(_update))
    lualib:ShowFormWithContent(player,"抽卡_syncData",chouKa.getData(player))
end

function chouKa.getUpdateData(player)
    local str = lualib:GetVar(player,VarCfg["单卡刷新记录"])
    local data = {0,0,0}
    if str ~= "" then
        data = json2tbl(str)
    end

    return data
end
---单换一张卡
function chouKa.pick1Unique(player,t,count,result)
    result = result or {}
    local flag = 0
    -- 最多抽取3个，或表中剩余的所有元素
    t = chouKa.exclude(player,result)
    local page = lualib:Weight(t)
    flag = t[page].id

    return flag
end
---抽卡逻辑
function chouKa.pick3Unique(player,t,count,is,result)
    result = result or {}
    count = count or 3        ---抽取数量
    is = is or 0            ---是否抽取彩卡
    -- 最多抽取3个，或表中剩余的所有元素
    for i = 1, count do
        t = chouKa.exclude(player,result,is)
        local page = lualib:Weight(t)
        result[i] = t[page].id
    end

    return result
end
---获得抽到的卡片
function chouKa.getCard(player)
    local _data = {}
    local str = lualib:GetVar(player,VarCfg["抽卡记录"])

    if str ~= "" then
        _data = json2tbl(str)
    else
        local _t = chouKa.getPicked(player)
        if #_t >= chouKa.getMax(player) then
            lualib:SendMsgGetColor(player,9,"#ff0d00|卡槽已经无法再抽取！")
            return 0
        end

        local count = chouKa.getPickedCount(player)
        if lualib:GetVar(player,VarCfg["杀怪等级"]) <= count then
            return 0
        end

        _data = chouKa.pick3Unique(player,chouKa.getConfig(player))
        lualib:SetVar(player,VarCfg["抽卡记录"],tbl2json(_data))
    end

    return _data
end
---排除已经抽取的卡片
function chouKa.exclude(player,t,is)
    is = is or 0
    local result = {{},{}}
    local _data = chouKa.getPicked(player)
    ---记录已经抽取的卡片，避免重复抽取，但是需要记录可多次抽取的卡片次数，以便后续排除卡片
    local reversed = {}
    local config = chouKa.config
    for i=1,#config do
        if config[i].group ~= nil then
            if chouKa.needSuit1Card[config[i].group] ~= nil then
                if reversed[tostring(chouKa.needSuit1Card[config[i].group])] == nil then
                    if config[i].id ~= chouKa.needSuit1Card[config[i].group] then
                        reversed[tostring(config[i].id)] = 1
                    end
                end
            end
        end
    end

    for i=1,#config do
        if is == 1 then
            if config[i].type ~= 1 then
                if reversed[tostring(config[i].id)] == nil then
                    reversed[tostring(config[i].id)] = 1
                end
            end
        else
            break
        end
    end

    for k, v in ipairs(_data) do
        if reversed[tostring(v)] == nil then
            reversed[tostring(v)] = 1
        else
            reversed[tostring(v)] = reversed[tostring(v)] + 1
        end
    end

    t = t or {}
    for k, v in ipairs(t) do
        if reversed[tostring(v)] == nil then
            reversed[tostring(v)] = 1
        else
            reversed[tostring(v)] = reversed[tostring(v)] + 1
        end
    end


    local flag = 1
    ---print(serialize(reversed),"排除卡")
    ---排除已经抽取的卡片，但是有可多次抽取的卡片，所以需要排除
    for i=1,#config do
        if reversed[tostring(config[i].id)] == nil then
            result[flag] = config[i]
            flag = flag + 1
        end
    end

    return result
end
---可抽卡
function chouKa.getConfig(player)
    local config = lualib:CopyTable(chouKa.config)

    return config
end
---可抽卡次数
function chouKa.getMax(player)
    local max = 12
    local suit = ServerCache.getPlayerStringVars(player,"抽卡套装")
    if suit[12] >= 5 then
        max = max + 3
    elseif suit[12] >= 3 then
        max = max + 2
    elseif suit[12] >= 1 then
        max = max + 1
    end

    return max
end
---最大刷新次数
function chouKa.getMaxChange(player)
    local max = #chouKa.config.basic.need + 1
    if lualib:GetFlag(player,VarCfg["月卡"]) == 1 then
        max = max + 1
    end

    return max
end
---获取已经抽取卡片
function chouKa.getPicked(player)
    local _data = {}
    local str = lualib:GetVar(player,VarCfg["抽中卡片"])
    if str ~= "" then
        _data = json2tbl(str)
    end
    ---print(serialize(_data),lualib:Name(player))
    return _data
end

function chouKa.getPickedCount(player)
    local _data = chouKa.getPicked(player)
    local count = #_data

    return count
end
---卡片缓存
function chouKa.setCache(player)
    local _t = chouKa.getPicked(player)
    ServerCache.onUpdatePlayerStringVars(player,"抽取卡片",_t)
    ---print(serialize(_t))
    ---清理缓存
    for i=1,#chouKa.config do
        local _data = item_special_tb.special["脚本效果"][chouKa.config[i].name]
        if _data ~= nil then
            if type(_data.type) == "number" then
                if _data.type == 1 then
                    ServerCache.Players[player].AttackEquip[_data.name] = nil
                elseif _data.type == 2 then
                    ServerCache.Players[player].StruckEquip[_data.name] = nil
                elseif _data.type == 3 then
                    ServerCache.Players[player].OtherEquip[_data.name] = nil
                end
            else
                for k=1,#_data.type do
                    if _data.type[k] == 1 then
                        ServerCache.Players[player].AttackEquip[_data.name] = nil
                    elseif _data.type[k] == 2 then
                        ServerCache.Players[player].StruckEquip[_data.name] = nil
                    elseif _data.type[k] == 3 then
                        ServerCache.Players[player].OtherEquip[_data.name] = nil
                    end
                end
            end
        end

        if lualib:GetAttrList(player,chouKa.config[i].name) ~= "" then
            lualib:DelAttrList(player,chouKa.config[i].name)
        end
    end
    ServerCache.Players[player].AttackEquip["灵魂火符"] = nil
    ServerCache.Players[player].AttackEquip["火苗"] = nil
    ServerCache.Players[player].AttackEquip["小人国"] = nil
    ---缓存抽卡
    local attr = {}     --缓存属性
    local tx = 0        --缓存体型
    local level = lualib:Level(player)
    local skill2 = 0
    for i=1,#_t do
        if chouKa.config[chouKa.config[tostring(_t[i])].group] ~= nil then
            ---卡片缓存
            local _data = item_special_tb.special["脚本效果"][chouKa.config[chouKa.config[tostring(_t[i])].group].name]
            if _data ~= nil then
                if type(_data.type) == "number" then
                    if _data.type == 1 then
                        ServerCache.Players[player].AttackEquip[_data.name] = _data
                    elseif _data.type == 2 then
                        ServerCache.Players[player].StruckEquip[_data.name] = _data
                    elseif _data.type == 3 then
                        ServerCache.Players[player].OtherEquip[_data.name] = _data
                    end
                else
                    for k=1,#_data.type do
                        if _data.type[k] == 1 then
                            ServerCache.Players[player].AttackEquip[_data.name] = _data
                        elseif _data.type[k] == 2 then
                            ServerCache.Players[player].StruckEquip[_data.name] = _data
                        elseif _data.type[k] == 3 then
                            ServerCache.Players[player].OtherEquip[_data.name] = _data
                        end
                    end
                end
            end
            ---增加属性卡片就行记录到表中
            ---暴击之爪
            if _t[i] == 1 then
                if attr[21] ~= nil then
                    attr[21] = attr[21] + 10 + level*0.5        ---暴击几率
                else
                    attr[21] = 10 + level*0.5
                end

                if attr[22] ~= nil then
                    attr[22] = attr[22] + 10 + level*0.5         ---暴击伤害
                else
                    attr[22] = 10 + level*0.5
                end
            end

            if _t[i] == 2 then
                skill2 = 1
            end

            if _t[i] == 3 then
                if lualib:GetVar(player,"N$组队进入") == 0 then
                    local list = getgroupmember(player)
                    if list == nil then
                        if attr[236] ~= nil then
                            attr[236] = attr[236] + 5 + level           ---攻击
                        else
                            attr[236] = 5 + level
                        end

                        if attr[235] ~= nil then
                            attr[235] = attr[235] + 5 + level           ---生命
                        else
                            attr[235] = 5 + level
                        end

                        if attr[36] ~= nil then
                            attr[36] = attr[36] + 5 + level             ---防御
                        else
                            attr[36] = 5 + level
                        end
                    end
                end
            end

            if _t[i] == 4 then
                tx = tx + 30
                if attr[235] ~= nil then
                    attr[235] = attr[235] + 35           ---生命
                else
                    attr[235] = 35
                end

                if attr[36] ~= nil then
                    attr[36] = attr[36] + 15             ---防御
                else
                    attr[36] = 15
                end
            end

            if _t[i] == 6 then
                tx = tx + 20
                if attr[235] ~= nil then
                    attr[235] = attr[235] - 35           ---生命
                else
                    attr[235] = -35
                end

                if attr[76] ~= nil then
                    attr[76] = attr[76] + 15             ---对人伤害
                else
                    attr[76] = 15
                end

                if attr[75] ~= nil then
                    attr[75] = attr[75] + 15             ---对怪伤害
                else
                    attr[75] = 15
                end
            end

            if _t[i] == 8 then
                tx = tx - 30
            end

            if _t[i] == 11 then
                if attr[21] ~= nil then
                    attr[21] = attr[21] + 10        ---暴击几率
                else
                    attr[21] = 10
                end
            end

            if _t[i] == 15 then
                if attr[235] ~= nil then
                    attr[235] = attr[235] + 30        ---生命
                else
                    attr[235] = 10 + 30
                end
            end

            if _t[i] == 17 then
                if attr[28] ~= nil then
                    attr[28] = attr[28] + level        ---暴击几率
                else
                    attr[28] = level
                end
            end

            if _t[i] == 18 then
                if attr[232] ~= nil then
                    attr[232] = attr[232] + 20        ---移速
                else
                    attr[232] = 20
                end

                if attr[216] ~= nil then
                    attr[216] = attr[216] - 15        ---攻速
                else
                    attr[216] = -15
                end
            end

            if _t[i] == 23 then
                --攻速
                if attr[216] ~= nil then
                    attr[216] = attr[216] + 5 + level*0.5        ---攻速
                else
                    attr[216] = 5 + level*0.5
                end
            end

            if _t[i] == 26 then
                ---攻击力
                if attr[236] ~= nil then
                    attr[236] = attr[236] + 5 + level*0.5        ---攻击
                else
                    attr[236] = 5 + level*0.5
                end
            end

            if _t[i] == 30 then
                --移动速度
                if attr[232] ~= nil then
                    attr[232] = attr[232] + 20
                else
                    attr[232] = 20
                end
            end

            if _t[i] == 55 then
                ---攻速
                if attr[216] ~= nil then
                    attr[216] = attr[216] + 10        ---攻速
                else
                    attr[216] = 10
                end
                ---暴击几率
                if attr[21] ~= nil then
                    attr[21] = attr[21] + 10        ---暴击几率
                else
                    attr[21] = 10
                end
            end

            if _t[i] == 57 then
                ---攻速
                if attr[216] ~= nil then
                    attr[216] = attr[216] + 5 + level*0.5        ---攻速
                else
                    attr[216] =  5 + level*0.5
                end

                ---暴击几率
                if attr[21] ~= nil then
                    attr[21] = attr[21] + 5 + level*0.5        ---暴击几率
                else
                    attr[21] = 5 + level*0.5
                end
            end

            if _t[i] == 58 then
                ---攻速
                if attr[216] ~= nil then
                    attr[216] = attr[216] + 10        ---攻速
                else
                    attr[216] =  10
                end
            end

            if _t[i] == 59 then
                ---移动速度
                if attr[232] ~= nil then
                    attr[232] = attr[232] + 10
                else
                    attr[232] = 10
                end
            end

            if _t[i] == 61 then
                ---移动速度
                if attr[232] ~= nil then
                    attr[232] = attr[232] + 20
                else
                    attr[232] = 20
                end
            end

            if _t[i] == 74 then
                tx = tx + 30
                --生命
                if attr[235] ~= nil then
                    attr[235] = attr[235] + 30        ---生命
                else
                    attr[235] = 30
                end
                ---防御
                if attr[36] ~= nil then
                    attr[36] = attr[36] + 30
                else
                    attr[36] = 30
                end
            end

            if _t[i] == 75 then
                if attr[235] ~= nil then
                    attr[235] = attr[235] + 30        ---生命
                else
                    attr[235] = 30
                end
            end
        end

        if _t[i] == 80 then
            tx = tx - 30
        end
    end

    local suit = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
    for i=1,#chouKa.config do
        ---套装记录
        if chouKa.config[i].group ~= nil then
            for j=1,#_t do
                if chouKa.config[i].id == _t[j] then
                    suit[chouKa.config[i].group] = suit[chouKa.config[i].group] + 1
                end
            end
        end
    end

    if suit[1] > 0 then
        ServerCache.Players[player].AttackEquip["火苗"] = item_special_tb.special["脚本效果"]["火苗"]
    end

    if suit[4] > 0 then
        ServerCache.Players[player].AttackEquip["灵魂火符"] = item_special_tb.special["脚本效果"]["灵魂火符"]
    end
    ---suit
    if suit[3] >= 4 then
        if attr[201] ~= nil then
            attr[201] = attr[201] + 30
        else
            attr[201] = 30
        end
    elseif suit[3] >= 2 then
        if attr[201] ~= nil then
            attr[201] = attr[201] + 10
        else
            attr[201] = 10
        end
    end

    if suit[5] >= 4 then
        ---攻速
        if attr[216] ~= nil then
            attr[216] = attr[216] + 30        ---攻速
        else
            attr[216] =  30
        end
        ---暴击伤害
        if attr[22] ~= nil then
            attr[22] = attr[22] + 30        ---暴击伤害
        else
            attr[22] = 30
        end
    elseif suit[5] >= 2 then
        ---攻速
        if attr[216] ~= nil then
            attr[216] = attr[216] + 10        ---攻速
        else
            attr[216] =  10
        end
        ---暴击伤害
        if attr[22] ~= nil then
            attr[22] = attr[22] + 10        ---暴击伤害
        else
            attr[22] = 10
        end
    end

    if suit[9] >= 5 then
        if attr[235] ~= nil then
            attr[235] = attr[235] + 40
        else
            attr[235] = 40
        end

        if attr[36] ~= nil then
            attr[36] = attr[36] + 40
        else
            attr[36] = 40
        end

        tx = tx + 40
    elseif  suit[9] >= 3 then
        if attr[235] ~= nil then
            attr[235] = attr[235] + 20
        else
            attr[235] = 20
        end

        if attr[36] ~= nil then
            attr[36] = attr[36] + 20
        else
            attr[36] = 20
        end

        tx = tx + 20
    elseif  suit[9] >= 2 then
        if attr[235] ~= nil then
            attr[235] = attr[235] + 10
        else
            attr[235] = 10
        end

        if attr[36] ~= nil then
            attr[36] = attr[36] + 10
        else
            attr[36] = 10
        end

        tx = tx + 10
    end


    if  suit[10] >= 2 then
        ServerCache.Players[player].AttackEquip["小人国"] =  item_special_tb.special["脚本效果"]["小人国"]
        if  suit[10] >= 5 then
            ServerCache.Players[player].AttackEquip["小人国"].level = 1
        elseif  suit[10] >= 3 then
            ServerCache.Players[player].AttackEquip["小人国"].level = 2
        elseif  suit[10] >= 2 then
            ServerCache.Players[player].AttackEquip["小人国"].level = 3
        end
    end

    if suit[6] > 0 then
        if suit[6] >= 4 then
            if getskillinfo(player,1032,1) == nil then
                addskill(player,1032,1)
            end
        end

        if suit[6] >= 2 then
            if getskillinfo(player,18,1) ~= nil then
                delskill(player,18)
            end

            if getskillinfo(player,19,1) == nil then
                addskill(player,19,1)
            end

            if attr[232] ~= nil then
                attr[232] = attr[232] + 20
            else
                attr[232] = 20
            end
        else
            if getskillinfo(player,18,1) == nil then
                addskill(player,18,1)
            end
        end
    else
        if getskillinfo(player,19,1) ~= nil then
            delskill(player,19)
        end

        if getskillinfo(player,18,1) ~= nil then
            delskill(player,18)
        end

        if getskillinfo(player,1032,1) ~= nil then
            delskill(player,1032)
        end

        if getskillinfo(player,5003,1) ~= nil then
            delskill(player,5003)
        end
    end

    if suit[8] > 0 then
        if suit[8] >= 2 then
            if getskillinfo(player,29,1) == nil then
                addskill(player,29,1)
            end
        else
            if getskillinfo(player,2,1) == nil then
                addskill(player,2)
            end
        end

        if getskillinfo(player,15,1) == nil then
            addskill(player,15,1)
        end
    else
        if getskillinfo(player,2,1) ~= nil then
            delskill(player,2,1)
        end

        if getskillinfo(player,29,1) ~= nil then
            delskill(player,29)
        end

        if getskillinfo(player,15,1) ~= nil then
            delskill(player,15)
        end
    end

    if suit[11] > 0 then
        if getskillinfo(player,76,1) == nil then
            addskill(player,76)
        end
    else
        if getskillinfo(player,76,1) ~= nil then
            delskill(player,76)
        end
    end

    if ServerCache.Players[player].OtherEquip["花来"] ~= nil then
        if getskillinfo(player,5003,1) == nil then
            addskill(player,5003,1)
        end
    else
        if getskillinfo(player,5003,1) ~= nil then
            delskill(player,5003)
        end
    end

    if ServerCache.Players[player].OtherEquip["聚宝成锋"] ~= nil then
        local num = cheLiDian.getGold(player)
        if num > 10000 then
            local x = math.floor(num/10000)
            local txt = lualib:GetVar(player,"N$".."聚宝成锋")
            if x ~= txt then
                lualib:AddAttrList(player,"聚宝成锋","=","3#1#"..(10*x).."|3#4#"..x)
            end
        end
    end

    if lualib:HasBuff(player,20014) then
        lualib:DelBuff(player,20014)
    end

    if next(attr) ~= nil then
        lualib:AddBuff(player,20014,0,1,player, attr)
    end

    if skill2 == 1 then
        if getskillinfo(player,5002,1) == nil then
            lualib:AddSkill(player,5002,1)
        end
    else
        lualib:DelSkill(player,5002)
    end

    ServerCache.onUpdatePlayerNumberVars(player,"人物体型",tx)
    ServerCache.onUpdatePlayerStringVars(player,"抽卡套装",suit)

    chouKa.changeModel(player)
    ----print("体型 = ",tx)
    --print("攻击",serialize(ServerCache.Players[player].AttackEquip))
    --print("受击",serialize(ServerCache.Players[player].StruckEquip))
    --print("其他",serialize(ServerCache.Players[player].OtherEquip))
end
---杀怪记录
function chouKa.getKill(player)
    local _data = {0,0,0,0,0,0,0,0}
    local str = lualib:GetVar(player,VarCfg["杀怪记录"])
    if str ~= "" then
        _data = json2tbl(str)
    end
    return _data
end
---获得羁绊数据
function chouKa.getSuitNum(player)
    local _t = chouKa.getPicked(player)
    local suit = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
    for i=1,#chouKa.config do
        ---套装记录
        if chouKa.config[i].group ~= nil then
            for j=1,#_t do
                if chouKa.config[i].id == _t[j] then
                    suit[chouKa.config[i].group] = suit[chouKa.config[i].group] + 1
                end
            end
        end
    end
    return suit
end
-----客户端需要的数据
function chouKa.getData(player)
    local data = {}
    data.card = chouKa.getCard(player)
    data.change  = lualib:GetVar(player,VarCfg["抽卡刷新次数"])
    data.max = chouKa.getMaxChange(player)
    data.update = chouKa.getUpdateData(player)
    data.suit = chouKa.getSuitNum(player)
    data.half = 0
    if ServerCache.Players[player].OtherEquip["打折卡"] ~= nil then
        data.half = 1
    end

    return data
end

function chouKa.getMapCard(player)
    local data = {0,0,0,0,0,0,0,0}
    local str = lualib:GetVar(player,VarCfg["下地图"])
    if str ~= "" then
        data = json2tbl(str)
    end
    return data
end
------- 改变体型 ----------------------------------------------------------
function chouKa.changeModel(player)
    local num = ServerCache.getPlayerNumberVars(player,"人物体型")
    local tk = lualib:GetVar(player,VarCfg["坦克引擎"])
    num = num + tk
    if num > 100 then
        num = 100
    elseif num < -70 then
        num = -70
    end

    lualib:AddAttrList(player,"坦克引擎","=","3#235#"..tk)

    if num == 0 then
        lualib:AddBuff(player,30000)
    elseif num > 0 then
        lualib:AddBuff(player,30099+num)
    elseif num < 0 then
        lualib:AddBuff(player,30000 + math.abs(num))
    end

    lualib:SetVar(player,"S$人物体型",num)
end
------- 无限进化 ----------------------------------------------------------
function chouKa.setKillAttr(player)
    local attr = {}
    local num = 0
    local _t = ServerCache.getPlayerStringVars(player,"抽卡套装")
    local mon,s,max = 10,1,20
    if ServerCache.Players[player].OtherEquip["攻速进化"] ~= nil then
        num = lualib:GetVar(player,VarCfg["攻速进化"])
        if _t[2] >= 5 then
            max = 99999999999
            num = num * 2
        elseif _t[2] >= 3 then
            max = max * 2
            num = num * 2
        elseif _t[2] >= 2 then
            num = num * 2
        end

        num = math.floor(num/mon)
        if num > max then
            num = max
            lualib:SetVar(player,VarCfg["攻速进化"],num)
        end

        if attr[216] ~= nil then
            attr[216] = attr[216] + s * num
        else
            attr[216] = s * num
        end
    end

    if ServerCache.Players[player].OtherEquip["屠杀进化"] ~= nil then
        mon,s,max = 1,1,10
        num = lualib:GetVar(player,VarCfg["屠杀进化"])

        if _t[2] >= 5 then
            max = 99999999999
            num = 2*num
        elseif _t[2] >= 3 then
            max = max * 2
            num = 2*num
        elseif _t[2] >= 2 then
            num = 2*num
        end

        num = math.floor(num/mon)
        if num > max then
            num = max
            lualib:SetVar(player,VarCfg["屠杀进化"],num)
        end

        if attr[4] ~= nil then
            attr[4] = attr[4] + s * 15 * num
        else
            attr[4] = s * 15 * num
        end

        if attr[1] ~= nil then
            attr[1] = attr[1] + s * 150 * num
        else
            attr[1] = s * 150 * num
        end
    end

    if ServerCache.Players[player].OtherEquip["巨人收割机"] ~= nil then
        max = 50
        num = lualib:GetVar(player,VarCfg["巨人收割机"])

        if _t[2] >= 5 then
            max = 99999999999
            num = 2*num
        elseif _t[2] >= 3 then
            max = max * 2
            num = 2*num
        elseif _t[2] >= 2 then
            num = 2*num
        end

        num = math.floor(num/mon)
        if num > max then
            num = max
            lualib:SetVar(player,VarCfg["巨人收割机"],num)
        end

        if attr[4] ~= nil then
            attr[4] = attr[4] + 50 * num
        else
            attr[4] = 50 * num
        end
    end

    if ServerCache.Players[player].OtherEquip["移速进化"] ~= nil then
        mon,s,max = 10,1,20
        num = lualib:GetVar(player,VarCfg["移速进化"])
        if _t[2] >= 5 then
            max = 99999999999
            num = 2*num
        elseif _t[2] >= 3 then
            max = max * 2
            num = 2*num
        elseif _t[2] >= 2 then
            num = 2*num
        end

        num = math.floor(num/mon)
        if num > max then
            num = max
            lualib:SetVar(player,VarCfg["移速进化"],num)
        end

        if attr[232] ~= nil then
            attr[232] = attr[232] + s * num
        else
            attr[232] = s * num
        end
    end

    if ServerCache.Players[player].OtherEquip["噬魂进化"] ~= nil then
        mon,s,max = 1,1,100
        num = lualib:GetVar(player,VarCfg["噬魂进化"])
        if _t[2] >= 5 then
            max = 99999999999
            num = 2*num
        elseif _t[2] >= 3 then
            max = max * 2
            num = 2*num
        elseif _t[2] >= 2 then
            num = 2*num
        end

        num = math.floor(num/mon)
        if num > max then
            num = max
            lualib:SetVar(player,VarCfg["噬魂进化"],num)
        end

        if attr[1] ~= nil then
            attr[1] = attr[1] + s * 10 * num
        else
            attr[1] = s * 10 * num
        end

        if attr[4] ~= nil then
            attr[4] = attr[4] + s * 1 * num
        else
            attr[4] = s * 1 * num
        end
    end

    if ServerCache.Players[player].OtherEquip["猎魔进化"] ~= nil then
        mon,s,max = 1,1,20
        num = lualib:GetVar(player,VarCfg["猎魔进化精英"])
        if _t[2] >= 5 then
            max = 99999999999
            num = 2*num
        elseif _t[2] >= 3 then
            max = max * 2
            num = 2*num
        elseif _t[2] >= 2 then
            num = 2*num
        end

        num = math.floor(num/mon)
        if num > max then
            num = max
            lualib:SetVar(player,VarCfg["猎魔进化精英"],num)
        end

        if attr[1] ~= nil then
            attr[1] = attr[1] + s * 50 * num
        else
            attr[1] = s * 50 * num
        end

        if attr[4] ~= nil then
            attr[4] = attr[4] + s * 5 * num
        else
            attr[4] = s * 5 * num
        end

        mon,s,max = 1,1,10
        num = lualib:GetVar(player,VarCfg["猎魔进化BOSS"])
        if _t[2] >= 5 then
            max = 99999999999
            num = 2*num
        elseif _t[2] >= 3 then
            max = max * 2
            num = 2*num
        elseif _t[2] >= 2 then
            num = 2*num
        end

        num = math.floor(num/mon)
        if num > max then
            num = max
            lualib:SetVar(player,VarCfg["猎魔进化BOSS"],num)
        end

        if attr[1] ~= nil then
            attr[1] = attr[1] + s * 100 * num
        else
            attr[1] = s * 100 * num
        end

        if attr[4] ~= nil then
            attr[4] = attr[4] + s * 10 * num
        else
            attr[4] = s * 10 * num
        end
    end

    if ServerCache.Players[player].OtherEquip["控制欲极强"] ~= nil then
        num = lualib:GetVar(player,VarCfg["控制欲强"])
        mon,max = 1,10
        if _t[2] >= 5 then
            max = 99999999999
            num = 2*num
        elseif _t[2] >= 3 then
            max = max * 2
            num = 2*num
        elseif _t[2] >= 2 then
            num = 2*num
        end


        num = math.floor(num/mon)
        if num > max then
            num = max
            lualib:SetVar(player,VarCfg["控制欲强"],num)
        end

        if attr[1] ~= nil then
            attr[1] = attr[1] +  50 * num
        else
            attr[1] =  50 * num
        end

        if attr[4] ~= nil then
            attr[4] = attr[4] + 5 * num
        else
            attr[4] = 5 * num
        end
    end

    lualib:DelAttrList(player,"无限进化")
    lualib:AddAttrList(player,"无限进化","=",lualib:BuffAttrList2Str(attr))
end
------- 灼烧 ---------------------------------------------
function chouKa.setZhuoSao(player,target)
    local _t = ServerCache.getPlayerStringVars(player,"抽卡套装")
    local s,sh,rh = 3,1,0
    if ServerCache.Players[player].OtherEquip["不灭焰"] ~= nil then
        s = 8
    end

    if ServerCache.Players[player].OtherEquip["焚心爆"] ~= nil then
        if lualib:GetVar(target,"N$灼烧比例") == 0 then
            if math.random(1,100) <= 20  then
                sh = 2
            end
        else
            sh = lualib:GetVar(target,"N$灼烧比例")
        end
    end

    if ServerCache.Players[player].OtherEquip["弱化火焰"] ~= nil then
        rh = 1
    end

    if _t[1] >= 5 then
        s = s + 10
        sh = sh * 3
    elseif _t[1] >= 3 then
        s = s + 6
        sh = sh * 2
    elseif _t[1] >= 2 then
        s = s + 3
        sh = sh * 2
    end

    if not lualib:HasBuff(target,20011) then
        lualib:SetVar(target,"N$灼烧比例",sh)
        lualib:AddBuff(target,20011,s,1,player)
        if rh == 1 then
            lualib:SetVar(target,"N$灼烧弱化",1)
        end
    end

    if ServerCache.Players[player].OtherEquip["火势蔓延"] ~= nil then
        local list = getobjectinmap(lualib:GetMapId(player),lualib:X( player),lualib:Y(player),10,1)
        if #list > 1 then
            for i=1,#list do
                if list[i] ~= target and list[i] ~= player then
                    if not lualib:HasBuff(list[i],20011) then
                        lualib:SetVar(list[i],"N$灼烧比例",sh)
                        lualib:AddBuff(list[i],20011,s,1,player)
                        if rh == 1 then
                            lualib:SetVar(list[i],"N$灼烧弱化",1)
                        end
                    end
                end
            end
        end
    end

end
------- 弹射火符  ---------------------------------------------
function chouKa.huoFu(actor,Target,damage,zs,num)
    local cfg_posM = {}
    cfg_posM[1] = getbaseinfo(actor,2)
    cfg_posM[2] = getbaseinfo(Target,2)
    local mapID = getbaseinfo(actor,3)
    local x = getbaseinfo(actor,4)
    local y = getbaseinfo(actor,5)
    local mons = getobjectinmap(mapID,x,y,6,2)
    local list = getobjectinmap(mapID,x,y,6,1)
    if #mons + #list <= 2 then
        releasemagic_target(actor,13,1,1,Target,0)
        return
    end

    for i, mon in ipairs(mons or {}) do
        if Target ~= mon and not ismob(mon) then
            local monsterName = lualib:Name(mon)
            if monsterName ~= "檀木宝箱" and monsterName ~= "白银宝箱" and monsterName ~= "黄金宝箱" then
                cfg_posM[#cfg_posM + 1] = mon--getbaseinfo(mon,2)
            end
        end
    end

    for i, obj in ipairs(list or {}) do
        if actor ~= obj then
            cfg_posM[#cfg_posM + 1] = obj
        end
    end

    local _t = {}
    local pool = {}
    -- 先把除第一个外的元素复制到 pool
    for i = 2, #cfg_posM do
        pool[#pool + 1] = cfg_posM[i]
    end

    delaygoto(actor,300,"humanhpex,"..cfg_posM[1]..","..damage..","..zs,1)

    _t[1] = cfg_posM[1]
    local count = math.min(num, #pool)
    for i = 2, count do
        local idx = math.random(#pool)
        _t[#_t + 1] = getbaseinfo(pool[idx],2)
        delaygoto(actor,300 * i,"humanhpex,"..pool[idx]..","..damage..","..zs,1)
        table.remove(pool, idx)   -- 移除已抽取的，避免重复
    end

    lualib:ShowFormWithContent(actor,'裂神符_receiveMessage',_t)
end

function humanhpex(player,mon,damage,zs)
    if not isnotnull(mon) or mon == "0" then
        return
    end
    --damage = 200
    if tonumber(zs) == 1 then
        if lualib:Player_IsPlayer(mon) then
            chouKa.setZhuoSao(player,mon)
        end
    end

    humanhp(mon, "-", tonumber(damage), 0, 0, player, 1)
end
------- 控制欲强 ------------------------------------------
function chouKa.setBBAttr(player)
    local ncount=getbaseinfo(player,38)
    for i = 0 ,ncount-1 do
        local mon = getslavebyindex(player, i)
        if mon and isnotnull(mon) then
            if ServerCache.Players[player].OtherEquip["神兽狂化"] ~= nil then
                changemobability(player,mon,11,"=",lualib:Hp( mon,true)*0.2,65535)
                changemobability(player,mon,13,"=",20,65535)
                changemobability(player,mon,14,"=",20,65535)
            end

            if ServerCache.Players[player].OtherEquip["万兽共鸣"] ~= nil then
                changemobability(player,mon,13,"+",ncount,65535)
                changemobability(player,mon,11,"+",lualib:Hp( mon,true)*0.01*ncount,65535)
            end

            addhpper(mon,100)
        end
    end
end
------- 铁甲觉醒 -------------------------------------
function chouKa.tieJia(player)
    local num = lualib:GetVar(player,VarCfg["铁甲觉醒"])
    if num > 1000 then
        local max = 50
        local _t = ServerCache.getPlayerStringVars(player,"抽卡套装")
        if _t[2] >= 5 then
            max = 99999999999
        elseif _t[2] >= 3 then
            max = max * 2
        end

        num = math.floor(num/1000)
        if num > max then
            num = max
        end

        lualib:AddAttrList(player,"铁甲觉醒","=","3#1#"..(10*num).."|3#4#"..num)
    end
end
------- 杀怪获得抽卡次数 -------------------------------------
function chouKa.updateKillMon(player)
    local num = lualib:GetVar(player,VarCfg["杀怪进度"])
    local level = lualib:GetVar(player,VarCfg["杀怪等级"])
    local over = 0
    if level > chouKa.getPickedCount(player) then
        over = 1
    end

    level = level + 1
    if level > chouKa.getMax(player) then
        level = chouKa.getMax(player)
        num = chouKa.kill[level].kill
    end

    lualib:ShowFormWithContent(player,"右上图标_TaskWindow",{num,chouKa.kill[level].kill,over})
end

function chouKa.clickCard(player)
    local level = lualib:GetVar(player,VarCfg["杀怪等级"])
    if level > chouKa.getPickedCount(player) then
        chouKa.main(player)
    end
end
---登录
local function _onLogin(player)
    if lualib:GetVar(player,VarCfg["本轮次数"]) ~= lualib:GetDBVar(VarCfg["第几轮"]) then
        lualib:SetVar(player,VarCfg["本轮次数"],lualib:GetDBVar(VarCfg["第几轮"]))
    end

    delaygoto(player,100,"click,准备战斗_daojishi")
    chouKa.setAttr(player)

    chouKa.updateKillMon(player)
end

local function _onEnterMap(player, mapName, oldmap,x,y)
    if anQuanXiang.config[mapName] ~= nil then
        if chouKa.map[mapName] ~= nil then
            if lualib:GetVar(player,VarCfg["杀怪等级"]) == 0 then
                lualib:SetVar(player,VarCfg["杀怪等级"],1)
            end
        end
    end

    chouKa.updateKillMon(player)
end

local function _onKillMon(player,monster,monsterName,mapName)
    local flag = false
    if ServerCache.Players[player].OtherEquip["攻速进化"] ~= nil then
        local num = lualib:GetVar(player,VarCfg["攻速进化"])
        lualib:SetVar(player,VarCfg["攻速进化"],num+1)

        if (num + 1)%10 == 0 then
            flag = true
        end
    end

    if ServerCache.Players[player].OtherEquip["移速进化"] ~= nil then
        local num = lualib:GetVar(player,VarCfg["移速进化"])
        lualib:SetVar(player,VarCfg["移速进化"],num+1)
        if (num + 1)%10 == 0 then
            flag = true
        end
    end

    if ServerCache.Players[player].OtherEquip["噬魂进化"] ~= nil then
        local num = lualib:GetVar(player,VarCfg["噬魂进化"])
        lualib:SetVar(player,VarCfg["噬魂进化"],num+1)
        flag = true
    end

    if ServerCache.Players[player].OtherEquip["猎魔进化"] ~= nil then
        if  chouKa.monType[monsterName] ~= nil then
            if chouKa.monType[monsterName].type == 1 then
                local num = lualib:GetVar(player,VarCfg["猎魔进化精英"])
                lualib:SetVar(player,VarCfg["猎魔进化精英"],num+1)
                flag = true
            elseif chouKa.monType[monsterName].type == 2 then
                local num = lualib:GetVar(player,VarCfg["猎魔进化BOSS"])
                lualib:SetVar(player,VarCfg["猎魔进化BOSS"],num+1)
                flag = true
            end
        end
    end

    if flag then
        chouKa.setKillAttr(player)
    end

    if ServerCache.Players[player].OtherEquip["赏金猎人"] ~= nil then
        local num = lualib:GetVar(player,VarCfg["赏金猎人"])
        num = num + 1
        lualib:SetVar(player,VarCfg["赏金猎人"],num)
        if num%100 == 0 then
            local item = {[chouKa.ziSe[math.random(1,#chouKa.ziSe)]] = 1}
            local mapID = lualib:GetMapId(player)
            local data = {
                ["map"] =  lualib:GetMapId(player),
                ["source"] =  5,
                ["mon"] = monsterName,
            }

            local list = gendropitem(mapID,nil,lualib:X(monster),lualib:Y(monster),tbl2json(item),tbl2json(data),2,1)
            lualib:SendMsgGetColor(player,9,"#f6ff00|掉落紫色藏品")
        end
    end

    if ServerCache.Players[player].OtherEquip["散财童子"] ~= nil then
        if math.random(1,100) <= 10 then
            local item = {["金币"] = 300}
            local mapID = lualib:GetMapId(player)
            local list = gendropitem(mapID,player,lualib:X(monster),lualib:Y(monster),tbl2json(item),nil,2,1)
            lualib:SendBuffMsg(player,"{散财童子/FCOLOR=251}BUFF触发：{掉落300金币/FCOLOR=249}")
        end
    end

    if ServerCache.Players[player].OtherEquip["是藏品"] ~= nil then
        if math.random(1,100) <= 5 then
            local item = {[chouKa.canPin[math.random(1,#chouKa.canPin)]] = 1}
            local mapID = lualib:GetMapId(player)
            local data = {
                ["map"] =  lualib:GetMapId(player),
                ["source"] =  5,
                ["mon"] = monsterName,
            }

            local list = gendropitem(mapID,nil,lualib:X(monster),lualib:Y(monster),tbl2json(item),tbl2json(data),2,1)
        end
    end

    if ServerCache.Players[player].OtherEquip["打了小的来大的"] ~= nil then
        if math.random(1,100) == 1 then
            genmon(lualib:GetMapId(player),lualib:X(monster),lualib:Y(monster),"骷髅王1",1,1,249)
            lualib:SendMsgGetColor(player,9,"#f6ff00|打小来大的|#f6ff00|效果：|#11ff00|召唤BOSS|#f6ff00|")
        elseif math.random(1,100) <= 5 then
            genmon(lualib:GetMapId(player),lualib:X(monster),lualib:Y(monster),"邪恶钳虫1",1,1,224)
            lualib:SendMsgGetColor(player,9,"#f6ff00|打小来大的|#f6ff00|效果：|#11ff00|召唤精英怪|#f6ff00|")
        end
    end
    ---判断是否在活动地图
    if anQuanXiang.config[mapName] ~= nil then
        if chouKa.map[mapName] ~= nil then
            if anQuanXiang.config[mapName].type == 2 then
                local num = lualib:GetVar(player,VarCfg["杀怪进度"])
                local level = lualib:GetVar(player,VarCfg["杀怪等级"])
                if level < chouKa.getMax(player) then
                    num = num + chouKa.map[mapName]
                    if num >= chouKa.kill[level+1].kill then
                        for i=level + 1,chouKa.getMax(player) do
                            if num >= chouKa.kill[i].kill then
                                num = num - chouKa.kill[i].kill
                                level = level + 1
                            else
                                break
                            end
                        end
                        lualib:SetVar(player,VarCfg["杀怪等级"],level)
                    end

                    lualib:SetVar(player,VarCfg["杀怪进度"],num)

                    local over = 0
                    if level > chouKa.getPickedCount(player) then
                        over = 1
                    end

                    level = level + 1
                    if level > chouKa.getMax(player) then
                        level = chouKa.getMax(player)
                        num = chouKa.kill[level].kill
                    end

                    lualib:ShowFormWithContent(player,"右上图标_TaskWindow",{num,chouKa.kill[level].kill,over,})
                end
            end
        end
    end
end

local function _onKillPlay(player,die)
    if isplayer(die) then
        if ServerCache.Players[player].OtherEquip["坦克引擎"] ~= nil then
            lualib:SetVar(player,VarCfg["坦克引擎"],lualib:GetVar(player,VarCfg["坦克引擎"]) + 3)
            chouKa.changeModel(player)
        end

        if ServerCache.Players[player].OtherEquip["屠杀进化"] ~= nil then
            local num = lualib:GetVar(player,VarCfg["屠杀进化"])
            lualib:SetVar(player,VarCfg["屠杀进化"],num+1)
            chouKa.setKillAttr(player)
        end

        if ServerCache.Players[player].OtherEquip["狂飙"] ~= nil then
            if not lualib:HasBuff(player,20013) then
                lualib:AddBuff(player,20013,3,1,player,{[216]=lualib:Attr(player,216)})
            end
        end

        if ServerCache.Players[player].OtherEquip["巨人收割机"] ~= nil then
            local num = lualib:GetVar(player,VarCfg["巨人收割机"])
            lualib:SetVar(player,VarCfg["巨人收割机"],num+50)
            chouKa.setKillAttr(player)
        end
    end
end

GameEvent.add(EventCfg.onKillPlay,_onKillPlay,chouKa)
GameEvent.add(EventCfg.onKillMon,_onKillMon,chouKa)
GameEvent.add(EventCfg.onEnterMap,_onEnterMap,chouKa)
GameEvent.add(EventCfg.onLogin,_onLogin,chouKa)
GameEvent.add(EventCfg.onLoadQF,_onLogin,chouKa)
Message.RegisterClickMsg("抽卡",chouKa)
setFormAllowFunc("抽卡", {"main","click","updateCards","show","changeOneCard","clickCard"})

return chouKa
