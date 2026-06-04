---local mapSkip_tb = include("Script/ExtendScript/cfgcsv/npc/cfg_地图跳转条件.lua")
--local auto_gen_monster = include("Script/ExtendScript/cfgcsv/npc/cfg_自动补怪.lua")
--进地图触发
function entermap(player,map,x,y)
    if lualib:GetVar(player,VarCfg["第一次登陆"]) == 0 then
        return ""
    end
    ----print(serialize( map),x,y,"嘻嘻嘻嘻嘻嘻嘻嘻嘻")
    --副本
    local oldmap = getconst(player,"<$oldmap>")
    if ServerCache.Players[player] == nil then
        ServerCache.onInitPlayer(player)
    end

    if ServerCache.Players[player].StringVars["当前地图"] == nil then
        ServerCache.onUpdatePlayerStringVars(player, "当前地图", map)
    end

    if map ~= ServerCache.Players[player].StringVars["当前地图"] then
        ServerCache.onUpdatePlayerStringVars(player, "当前地图", map)
    end

    if special_map_tb["禁止拾取地图"][map] ~= nil then
        pickupitems(player,0,0,500)
        stoppickupitems(player)
    else
        pickupitems(player,0,0,500)
    end

    if lualib:GetVar(player,"N$不自动挂机") == 1 then
        lualib:SetVar(player,"N$不自动挂机",0)
    end

    if map == "3" then
        local ncount=getbaseinfo(player,38)
        for i = 0 ,ncount-1 do
            local mon = getslavebyindex(player, i)
            if mon and isnotnull(mon) then
                killmonbyobj(player,mon,false,false,false)
            end
        end
    end

    --if auto_gen_monster[map] ~= nil then
    --    if lualib:GetDBVar(VarCfg["开服分钟"])  < 120 then
    --        auto_gen(player,map)
    --    end
    --end
    --
    --local list = getstorageitems(player)


    GameEvent.push(EventCfg.onEnterMap, player, map, oldmap,x,y)
end
--离开地图触发
function leavemap(player,map,x,y)
    GameEvent.push(EventCfg.onLeaveMap, player, map ,x,y)
end

--进入连接点(跳转点)前触
function beforeroute(player,mapid,x,y)
   --- print("进来了",mapid,x,y)
    local num = lualib:GetVar(player,"N$挂机状态")
    if num > 0 then
        lualib:Map(player,lualib:GetMapId(player),lualib:X(player),lualib:Y(player))
        return false
    end

    return true
end

--function auto_gen(player,map)
--    if auto_gen_monster[map] ~= nil then
--        if getmoncount(map,-1,true) < auto_gen_monster[map].need then
--            for i=1,#auto_gen_monster[map].gen do
--                local fuben = {}
--                fuben[1] = map
--                fuben[2] = 0
--                fuben[3] = 0
--                fuben[4] = auto_gen_monster[map].gen[i][1]
--                fuben[5] = 200
--                fuben[6] = auto_gen_monster[map].gen[i][2]
--                fuben[7] = auto_gen_monster[map].gen[i][3]
--
--                lualib:GenMon(fuben)
--            end
--        end
--    end
--end