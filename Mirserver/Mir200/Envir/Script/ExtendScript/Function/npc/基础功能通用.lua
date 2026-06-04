tongyong = {}
tongyong.config = {}
--tongyong.bag = include("Market_Def/ExtendScript/cfgcsv/npc/cfg_背包神器.lua")
--tongyong.yuanShenEquip = include("Market_Def/ExtendScript/cfgcsv/npc/cfg_元神装备.lua")

function tongyong.openWindow(player,page)
    if page == 1 then
        openstorage(player)
    elseif page == 2 then
        ---recycle.main(player)
    elseif page == 4 then
        refreshbag(player)
    elseif page == 5 then
        ---duiHuan.main(player)
    elseif page == 6 then
        local num = lualib:GetFlag(player,VarCfg["屏蔽消息"])
        if num == 1 then
            lualib:SetFlag(player,VarCfg["屏蔽消息"],0)
            filterglobalmsg(player,0)
            lualib:SendMsgGetColor(player,9,"#ff0d00|全服消息过滤已经关闭！！！")
        else
            lualib:SetFlag(player,VarCfg["屏蔽消息"],1)
            filterglobalmsg(player,1)
            lualib:SendMsgGetColor(player,9,"#00ff00|全服消息过滤已经开启！！！")
        end
    elseif page == 7 then
    --    changename.main(player)
    --elseif page == 8 then
    --    if lualib:GetFlag(player,VarCfg["经验合成"]) == 0 then
    --        lualib:SetFlag(player,VarCfg["经验合成"],1)
    --        lualib:SendMsgGetColor(player,9,"#00ff00|经验合成已经开启！！！")
    --    else
    --        lualib:SetFlag(player,VarCfg["经验合成"],0)
    --        lualib:SendMsgGetColor(player,9,"#ff0d00|经验合成已经关闭！！！")
    --    end
    --elseif page == 9 then
    --    if  checkkuafu(player) then
    --        lualib:SendMsgGetColor(player,9,"#00ff00|跨服地图只能使用跨服传音功能。")
    --        return ""
    --    end
    --    chuanyin.main(player)
    --elseif page == 10 then
    --    if not checkkuafu(player) then
    --        lualib:SendMsgGetColor(player,9,"#00ff00|请在跨服地图使用跨服传音功能。")
    --        return ""
    --    end
    --    chuanyin.main(player)
    end
end

function tongyong.autoGame(player)
    local mapid = getbaseinfo(player,3)
    if special_map_tb[mapid] == 1 then
        lualib:SendMsgGetColor(player,9,"#f6ff00|当前地图禁止自动挂机！！！")
        return ""
    end

    local num = lualib:GetVar(player,"N$挂机状态")
    if num == 0 then
        startautoattack(player)
    else
        stopautoattack(player)
    end
    return ""
end

Message.RegisterClickMsg("基础功能通用", tongyong)
setFormAllowFunc("基础功能通用", {"openWindow","autoGame"})

return tongyong