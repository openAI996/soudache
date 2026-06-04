function startup()
    local hfcont = tonumber(globalinfo(3))
    --  print("服务器启动")

    lualib:SetDBVar(VarCfg["是否生成npc"],0)
    --for i=1,#map_effect_tb do
    --    if map_effect_tb[i].x ~= nil then
    --        mapeffect(i,map_effect_tb[i].mapid,map_effect_tb[i].x,map_effect_tb[i].y,map_effect_tb[i].effect,map_effect_tb[i].times,map_effect_tb[i].mode)
    --    end
    --end

    lualib:SetMergeCount()       ----设置合区次数
    zhunBeiZhanDou.genMon(1)
    setontimerex(1,1)
    GameEvent.push(EventCfg.onSystemCache)
end
