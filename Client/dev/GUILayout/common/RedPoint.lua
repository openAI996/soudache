RedPoint = {}
RedPoint.star = false
RedPoint.CDTimes = 0
RedPoint.bag = false
--服务器下发的变量改变
SL:RegisterLUAEvent('LUA_EVENT_SERVER_VALUE_CHANGE', "服务器变量变化", function(data)
    SL:release_print("进入服务器变量改变："..SL:JsonEncode(data))

end)

--货币改变
SL:RegisterLUAEvent(LUA_EVENT_MONEYCHANGE, "红点-货币变化", function(table)
    if os.time() - RedPoint.CDTimes > 2 then
        RedPoint.CDTimes = os.time()
    else
        return
    end

end)

SL:RegisterLUAEvent(LUA_EVENT_WINDOW_CHANGE, "红点-窗口变化", function()
    screen_W = SL:GetMetaValue("SCREEN_WIDTH")
    screen_H = SL:GetMetaValue("SCREEN_HEIGHT")
end)


SL:RegisterLUAEvent('LUA_EVENT_BAG_ITEM_CHANGE', "红点-背包数据变化", function(data)
    --SL:Print(tostring(RedPoint.star))
    --SL:Print("背包红点--数据变化")
    if os.time() - RedPoint.CDTimes > 2 then
        RedPoint.CDTimes = os.time()
    else
        return
    end

    if RedPoint.star then
    end
end)

Message.RegisterClickMsg("红点相关", RedPoint)
