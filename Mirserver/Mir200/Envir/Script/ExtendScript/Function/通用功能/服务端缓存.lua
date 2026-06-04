ServerCache = {}
--玩家缓存
ServerCache.Players = {}
--装备缓存
ServerCache.PlayersEquipmentsConfig = {
    [0] = 1,
    [1] = 1,
    [2] = 1,
    [3] = 1,
    [4] = 1,
    [5] = 1,
    [6] = 1,
    [7] = 1,
    [8] = 1,
    [9] = 1,
    [10] = 1,
    [11] = 1,
    [12] = 1,
    [14] = 1,
    [15] = 1,
    [16] = 1,
    [17] = 1,
    [18] = 1,
    [20] = 1,
    [21] = 1,
    [22] = 1,
    [23] = 1,
    [24] = 1,
    [25] = 1,
    [26] = 1,
    [27] = 1,
    [28] = 1,
    [30] = 1,
    [31] = 1,
    [32] = 1,
    [33] = 1,
    [34] = 1,
    [35] = 1,
    [36] = 1,
    [37] = 1,
    [38] = 1,
    [39] = 1,
    [40] = 1,
    [41] = 1,
    [42] = 1,
    [43] = 1,
    [44] = 1,
    [71] = 1,
    [72] = 1,
    [73] = 1,
    [74] = 1,
    [75] = 1,
    [76] = 1,
    [77] = 1,
    [78] = 1,
    [79] = 1,
    [84] = 1,
    [85] = 1,
    [87] = 1,
    [88] = 1,
    [90] = 1,
    [91] = 1,
    [92] = 1,
    [93] = 1,
    [94] = 1,
    [95] = 1,
    [96] = 1,
    [111] = 1,
    [114] = 1,
    [115] = 1,
    [116] = 1,
    [117] = 1,
}

--属性缓存
ServerCache.PlayersAttrSpecialConfig = {
    [0] = 1,
    [1] = 1,
    [2] = 1,
    [3] = 1,
    [4] = 1,
    [5] = 1,
    [6] = 1,
    [7] = 1,
    [8] = 1,
    [9] = 1,
    [10] = 1,
    [11] = 1,
    [12] = 1,
    [14] = 1,
    [15] = 1,
    [16] = 1,
    [17] = 1,
    [18] = 1,
    [20] = 1,
    [21] = 1,
    [22] = 1,
    [23] = 1,
    [24] = 1,
    [25] = 1,
    [26] = 1,
    [27] = 1,
    [28] = 1,
    [30] = 1,
    [31] = 1,
    [32] = 1,
    [33] = 1,
    [34] = 1,
    [35] = 1,
    [36] = 1,
    [37] = 1,
    [38] = 1,
    [39] = 1,
    [40] = 1,
    [41] = 1,
    [42] = 1,
    [43] = 1,
    [44] = 1,
    [71] = 1,
    [72] = 1,
    [73] = 1,
    [74] = 1,
    [75] = 1,
    [76] = 1,
    [77] = 1,
    [78] = 1,
    [79] = 1,
    [84] = 1,
    [85] = 1,
    [87] = 1,
    [88] = 1,
    [90] = 1,
    [91] = 1,
    [92] = 1,
    [93] = 1,
    [94] = 1,
    [95] = 1,
    [96] = 1,
    [111] = 1,
    [114] = 1,
    [115] = 1,
    [116] = 1,
    [117] = 1,
}

ServerCache.PlayersVarsConfig = {
    number = {

    },
    string = {

    }
}

--属性缓存
ServerCache.PlayersAttrConfig = {

}

--通用缓存
ServerCache.PlayersUniversalAttr = {

}
--所有玩家初始化
function ServerCache.init()
    local tablePlayerList = getplayerlst()
    for _, v in ipairs(tablePlayerList) do
        ServerCache.onInitPlayerEquipments(v)
        ServerCache.onInitPlayerVars(v)
        ServerCache.onInitPlayerSpecialAttr(v)
        --ServerCache.onInitPLayerRedPoint(v)
    end
end
--初始化玩家个人缓存
function ServerCache.onInitPlayer(player)
    --print("个人缓存")
    --print("个人缓存")
    ServerCache.onInitPlayerEquipments(player)
    ServerCache.onInitPlayerVars(player)
    ServerCache.onInitPlayerSpecialAttr(player)
    --ServerCache.onInitPLayerRedPoint(player)
end
--清除玩家缓存
function ServerCache.Clear(player)
    ServerCache.Players[player] = nil
end
--初始化玩家装备
function ServerCache.onInitPlayerEquipments(player)
    if ServerCache.Players[player] == nil then
        ServerCache.Players[player] = {}
    end
    ServerCache.Players[player].Equipments = {}
    for k, v in pairs(ServerCache.PlayersEquipmentsConfig) do
        local item = linkbodyitem(player, k)
        if item then
            local itemid = getiteminfo(player, item, 2)
            if itemid then
                ServerCache.Players[player].Equipments[k] = itemid
            end
        else
            ServerCache.Players[player].Equipments[k] = nil
        end
    end
    --lualib:dbg("装备缓存：xxxxxx:"..tbl2json(ServerCache.Players[player].Equipments))
end
--初始化玩家特殊属性
function ServerCache.onInitPlayerSpecialAttr(player)
    if ServerCache.Players[player] == nil then
        ServerCache.Players[player] = {}
    end

    if ServerCache.Players[player].SpecialAttr == nil then
        ServerCache.Players[player].SpecialAttr = {}
    end

    for k, v in pairs(ServerCache.PlayersAttrSpecialConfig) do
        if item_special_tb.special[k]  ~= nil then
            local item = linkbodyitem(player, k)
            if item ~= nil and item ~= "0" then
                local itemid = getiteminfo(player, item, 2)
                if itemid and item_special_tb.special[k][itemid] ~= nil then
                    ServerCache.Players[player].SpecialAttr[k] = item_special_tb.special[k][itemid]
                end
            end
        end
    end

    ServerCache.onInitPlayerTitleSpecialAttr(player)
    ServerCache.onInitPlayerSuitSpecialAttr(player)
    ServerCache.specialAttrClassify(player)
end
--初始化通用属性缓存
function ServerCache.onInitPlayerUniversalAttr(player)
    if ServerCache.Players[player] == nil then
        ServerCache.Players[player] = {}
    end

    if ServerCache.Players[player].UniversalAttr == nil then
        ServerCache.Players[player].UniversalAttr = {}
    end
end
--初始化称号特殊属性
function ServerCache.onInitPlayerTitleSpecialAttr(player)
    if ServerCache.Players[player].SpecialAttr[70] == nil then
        ServerCache.Players[player].SpecialAttr[70] = {}
    end

    for k,v in pairs(item_special_tb.special[70]) do
        if lualib:CheckTitle(player,k) then
            ServerCache.Players[player].SpecialAttr[70][k] = v
        end
    end
end
--初始化套装属性
function ServerCache.onInitPlayerSuitSpecialAttr(player)
    if ServerCache.Players[player].SpecialAttr.suit == nil then
        ServerCache.Players[player].SpecialAttr.suit = {}
    end

    for k,v in pairs(item_special_tb.special.suit) do
        if lualib:GetFlag(player,VarCfg[k]) == 1 then
            ServerCache.Players[player].SpecialAttr.suit[k] = v
        end
    end
end
--更新通用属性缓存
function ServerCache.onUpdatePlayerUniversalAttr(player, attr, value)
    if ServerCache.Players[player] == nil then
        ServerCache.Players[player] = {}
    end

    if ServerCache.Players[player].UniversalAttr == nil then
        ServerCache.Players[player].UniversalAttr = {}
    end

    if value == nil then
        if ServerCache.Players[player].UniversalAttr[attr] ~= nil then
            ServerCache.Players[player].UniversalAttr[attr] = nil
        end
    else
        ServerCache.Players[player].UniversalAttr[attr] = value
    end

    --lualib:dbg("通用属性缓存："..serialize(ServerCache.Players[player].UniversalAttr))
end
--更新称号特殊属性
function ServerCache.onUpdatePlayerTitleSpecialAttr(player, title,t)
    if ServerCache.Players[player].SpecialAttr[70] == nil then
        ServerCache.Players[player].SpecialAttr[70] = {}
    end

    if item_special_tb.special[70][title] ~= nil then
        if t == 0 then
            ServerCache.Players[player].SpecialAttr[70][title] = nil
            local _t = item_special_tb.special[70][title]
            if type(_t.type) == "number" then
                if _t.type == 1 then
                    ServerCache.Players[player].AttackEquip[_t.name] = nil
                elseif _t.type == 2 then
                    ServerCache.Players[player].StruckEquip[_t.name] = nil
                elseif _t.type == 3 then
                    ServerCache.Players[player].OtherEquip[_t.name] = nil
                end
            elseif type(_t.type) == "table" then
                for i=1,#_t.type do
                    if _t.type[i] == 1 then
                        ServerCache.Players[player].AttackEquip[_t.name] = nil
                    elseif _t.type[i] == 2 then
                        ServerCache.Players[player].StruckEquip[_t.name] = nil
                    elseif _t.type[i] == 3 then
                        ServerCache.Players[player].OtherEquip[_t.name] = nil
                    end
                end
            end
        else
            ServerCache.Players[player].SpecialAttr[70][title] = item_special_tb.special[70][title]
        end
        ServerCache.specialAttrClassify(player)
    end
end
--更新套装属性
function ServerCache.onUpdatePlayerSuitSpecialAttr(player, id,type)
    if item_special_tb.special.suit["套装"..id] ~= nil then
        if type == 2 then
            ServerCache.Players[player].SpecialAttr.suit["套装"..id] = nil
        else
            ServerCache.Players[player].SpecialAttr.suit["套装"..id] = item_special_tb.special.suit["套装"..id]
        end
        --ServerCache.specialAttrClassify(player)
    end
end
--更新玩家装备
function ServerCache.onUpdatePlayerEquipments(player,item,pos,itemName,makeIndex,type)
    local itemid = getiteminfo(player, item, 2)
    if ServerCache.Players[player] == nil then
        ServerCache.Players[player] = {}
    end
    if ServerCache.Players[player].Equipments == nil then
        ServerCache.Players[player].Equipments = {}
    end

    if type == 2 then
        if ServerCache.Players[player].AttackEquip[itemName] ~= nil then
            ServerCache.Players[player].AttackEquip[itemName] = nil
        end

        if ServerCache.Players[player].StruckEquip[itemName] ~= nil then
            ServerCache.Players[player].StruckEquip[itemName] = nil
        end

        if ServerCache.Players[player].OtherEquip[itemName] ~= nil then
            ServerCache.Players[player].OtherEquip[itemName] = nil
        end

        ServerCache.Players[player].Equipments[pos] = nil
    else
        ServerCache.Players[player].Equipments[pos] = itemid
    end

    ServerCache.onUpdatePlayerSpecialAttr(player,item,pos,itemName,makeIndex,type)
end
--玩家装备特殊属性
function ServerCache.onUpdatePlayerSpecialAttr(player,item,pos,itemName,makeIndex,type)
    local itemid = getiteminfo(player, item, 2)
    if item_special_tb.special[pos] == nil then
        return
    end

    if ServerCache.Players[player] == nil then
        ServerCache.Players[player] = {}
    end

    if ServerCache.Players[player].SpecialAttr == nil then
        ServerCache.Players[player].SpecialAttr = {}
    end

    if type == 2 then
        ServerCache.Players[player].SpecialAttr[pos] = nil
        ServerCache.Players[player].Equipments[pos] = nil
    else
        if ServerCache.Players[player].Equipments[pos] ~= nil and item_special_tb.special[pos][itemid] ~= nil then
            ---print(itemid,pos)
            ServerCache.Players[player].SpecialAttr[pos] = item_special_tb.special[pos][itemid]
        end
    end
    --print("xxxxxxxxxxxx = specialAttrClassify")
    ServerCache.specialAttrClassify(player)
end
--装备缓存区分攻击和被攻击触发
function ServerCache.specialAttrClassify(player)
    if ServerCache.Players[player] == nil then
        ServerCache.Players[player] = {}
    end

    if ServerCache.Players[player].AttackEquip == nil then
        ServerCache.Players[player].AttackEquip = {}
    end

    if ServerCache.Players[player].StruckEquip == nil then
        ServerCache.Players[player].StruckEquip = {}
    end

    if ServerCache.Players[player].OtherEquip == nil then
        ServerCache.Players[player].OtherEquip = {}
    end

    local _data = ServerCache.Players[player].SpecialAttr
    for k,v in pairs(_data) do
        if k ~= 70 then
            if type(v.type) == "number" then
                if v.type == 1 then
                    ServerCache.Players[player].AttackEquip[v.name] = v
                elseif v.type == 2 then
                    ServerCache.Players[player].StruckEquip[v.name] = v
                elseif v.type == 3 then
                    ServerCache.Players[player].OtherEquip[v.name] = v
                end
            elseif type(v.type) == "table" then
                for i=1,#v.type do
                    if v.type[i] == 1 then
                        ServerCache.Players[player].AttackEquip[v.name] = v
                    elseif v.type[i] == 2 then
                        ServerCache.Players[player].StruckEquip[v.name] = v
                    elseif v.type[i] == 3 then
                        ServerCache.Players[player].OtherEquip[v.name] = v
                    end
                end
            end
        end
    end

    for k,v in pairs(ServerCache.Players[player].SpecialAttr[70]) do
        if type(v.type) == "number" then
            if v.type == 1 then
                ServerCache.Players[player].AttackEquip[v.name] = v
            elseif v.type == 2 then
                ServerCache.Players[player].StruckEquip[v.name] = v
            elseif v.type == 3 then
                ServerCache.Players[player].OtherEquip[v.name] = v
            end
        elseif type(v.type) == "table" then
            for i=1,#v.type do
                if v.type[i] == 1 then
                    ServerCache.Players[player].AttackEquip[v.name] = v
                elseif v.type[i] == 2 then
                    ServerCache.Players[player].StruckEquip[v.name] = v
                elseif v.type[i] == 3 then
                    ServerCache.Players[player].OtherEquip[v.name] = v
                end
            end
        end
    end

    for k,v in pairs(ServerCache.Players[player].SpecialAttr.suit) do
        if type(v.type) == "number" then
            if v.name == "套装2001" or v.name == "套装2002" then
                local item = linkbodyitem(player,80)
                local num = lualib:GetItemInt(player,item,1)
                if num == 10 then
                    if v.type == 1 then
                        ServerCache.Players[player].AttackEquip[v.name] = v
                    elseif v.type == 2 then
                        ServerCache.Players[player].StruckEquip[v.name] = v
                    elseif v.type == 3 then
                        ServerCache.Players[player].OtherEquip[v.name] = v
                    end
                end
            else
                if v.type == 1 then
                    ServerCache.Players[player].AttackEquip[v.name] = v
                elseif v.type == 2 then
                    ServerCache.Players[player].StruckEquip[v.name] = v
                elseif v.type == 3 then
                    ServerCache.Players[player].OtherEquip[v.name] = v
                end
            end
        elseif type(v.type) == "table" then
            for i=1,#v.type do
                if v.type[i] == 1 then
                    ServerCache.Players[player].AttackEquip[v.name] = v
                elseif v.type[i] == 2 then
                    ServerCache.Players[player].StruckEquip[v.name] = v
                elseif v.type[i] == 3 then
                    ServerCache.Players[player].OtherEquip[v.name] = v
                end
            end
        end
    end

    ----print(lualib:Name(player).."套装1111缓存："..serialize(ServerCache.Players[player].SpecialAttr.suit))
    ----print(lualib:Name(player).."攻击1111缓存："..serialize(ServerCache.Players[player].AttackEquip))
    ----print(lualib:Name(player).."受击1111缓存："..serialize(ServerCache.Players[player].StruckEquip))
    ----print(lualib:Name(player).."其他1111缓存："..serialize(ServerCache.Players[player].OtherEquip))
    lualib:SetVar(player,"N$服务端缓存",1)
    GameEvent.push(EventCfg.onAllAttrChange,player)
end
--变量初始化
function ServerCache.onInitPlayerVars(player)
    if ServerCache.Players[player] == nil then
        ServerCache.Players[player] = {}
    end
    ServerCache.Players[player].NumberVars = {}
    ServerCache.Players[player].StringVars = {}
    for k, v in pairs(ServerCache.PlayersVarsConfig.string) do
        ServerCache.Players[player].StringVars[k] = v
    end

    for k, v in pairs(ServerCache.PlayersVarsConfig.number) do
        ServerCache.Players[player].NumberVars[k] = v
    end
end
--更新玩家number变量
function ServerCache.onUpdatePlayerNumberVars(player, key, value)
    if ServerCache.Players[player] == nil then
        ServerCache.Players[player] = {}
    end
    if ServerCache.Players[player].NumberVars == nil then
        ServerCache.Players[player].NumberVars = {}
    end
    --release_print(key,value)
    ServerCache.Players[player].NumberVars[key] = value
end
--获得玩家number缓存
function ServerCache.getPlayerNumberVars(player, key)
    if ServerCache.Players[player] == nil then
        ServerCache.Players[player] = {}
    end

    if ServerCache.Players[player].NumberVars == nil then
        ServerCache.Players[player].NumberVars = {}
    end

    if ServerCache.Players[player].NumberVars[key] == nil then
        ServerCache.Players[player].NumberVars[key] = 0
    end

    return ServerCache.Players[player].NumberVars[key]
end
--更新玩家string变量
function ServerCache.onUpdatePlayerStringVars(player, key, value)
    if ServerCache.Players[player] == nil then
        ServerCache.Players[player] = {}
    end

    if ServerCache.Players[player].StringVars == nil then
        ServerCache.Players[player].StringVars = {}
    end

    --if key == "主线剧情" then
    --    print(serialize(value))
    --end
    ServerCache.Players[player].StringVars[key] = value
end
--获得玩家string缓存
function ServerCache.getPlayerStringVars(player, key)
    if ServerCache.Players[player] == nil then
        ServerCache.Players[player] = {}
    end

    if ServerCache.Players[player].StringVars == nil then
        ServerCache.Players[player].StringVars = {}
    end

    if ServerCache.Players[player].StringVars[key] == nil then
        ServerCache.Players[player].StringVars[key] = ""
    end

    if key == "当前地图" then
        if ServerCache.Players[player].StringVars[key] == "" then
            ServerCache.Players[player].StringVars[key] = lualib:GetMapId(player)
        end
    end

    if key == "抽卡套装" then
        if ServerCache.Players[player].StringVars[key] == "" then
            ServerCache.Players[player].StringVars[key] = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
        end
    end

    return ServerCache.Players[player].StringVars[key]
end
--全区缓存
function ServerCache.onInitSystemVars(key, value)
    if ServerCache.SystemVars == nil then
        ServerCache.SystemVars = {}
    end
end
--更新全区缓存
function ServerCache.onUpdateSystemVars(key, value)
    if ServerCache.SystemVars == nil then
        ServerCache.SystemVars = {}
    end
    --release_print(key,serialize(value))
    ServerCache.SystemVars[key] = value
end
--QF初始化
local booleanLoadStatus, stringLoadErrorMessage = pcall(function()
    ServerCache.init()
end)

if booleanLoadStatus == false then
    --lualib:dbg("后端缓存.lua 执行失败：" .. stringLoadErrorMessage)
end

GameEvent.add(EventCfg.onLoadQF,ServerCache.onInitPlayerSpecialAttr,ServerCache,1)
GameEvent.add(EventCfg.onTakeChange,ServerCache.onUpdatePlayerEquipments,ServerCache,1)
GameEvent.add(EventCfg.onTitleChange,ServerCache.onUpdatePlayerTitleSpecialAttr,ServerCache,1)
GameEvent.add(EventCfg.onSuitChange,ServerCache.onUpdatePlayerSuitSpecialAttr,ServerCache,1)
GameEvent.add(EventCfg.onLogin,ServerCache.onInitPlayer,ServerCache,1)

return ServerCache

