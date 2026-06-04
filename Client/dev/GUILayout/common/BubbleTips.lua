BubbleTips = {}
fuWuQiChuShiHua = false
BubbleTips.CDTimes = 0

function BubbleTips.init()

end

SL:RegisterLUAEvent('LUA_EVENT_BAG_ITEM_CHANGE', "提升-背包数据变化", function(data)
    SL:release_print("提升背包数据变化")
    if fuWuQiChuShiHua then
        if os.time() -  BubbleTips.CDTimes >= 3  then
            BubbleTips.init()
        end
        BubbleTips.CDTimes = os.time()
    end

    SL:ScheduleOnce(function()
        TopIcon.topInit()
    end,0.1)
end)


SL:RegisterLUAEvent('LUA_EVENT_QUICKUSE_DATA_OPER', "快捷栏道具数据变动触发", function(data)
    ---SL:release_print("提升背包数据变化")
    SL:ScheduleOnce(function()
        TopIcon.topInit()
    end,0.1)
end)

SL:RegisterLUAEvent('LUA_EVENT_SERVER_VALUE_CHANGE', "提升-服务器变量变化", function(data)
    ---SL:release_print("提升  进入服务器变量改变："..SL:JsonEncode(data))
    if data.key == "U17" then
        if not fuWuQiChuShiHua then
            fuWuQiChuShiHua = true
            RedPoint.star = true
        end
        BubbleTips.init()
        TopIcon.topInit()
    end

    if data.key == "T1" then
        TopIcon.topInit()
    end

    if data.key == "U16" then
        TopIcon.topInit()
    end
end )

SL:RegisterLUAEvent('LUA_EVENT_MONEYCHANGE', "提升-货币变化", function(data)
    SL:release_print("提升-货币变化："..SL:JsonEncode(data))
    if os.time() -  BubbleTips.CDTimes  >= 3  then
        if fuWuQiChuShiHua then
            BubbleTips.init()
        end
        BubbleTips.CDTimes = os.time()
    end

    TopIcon.topInit()
end)

--- {isSuccess = 是否成功, pos = 成功穿戴装备位}
SL:RegisterLUAEvent('LUA_EVENT_TAKE_ON_EQUIP', "提升-玩家穿戴装备", function(data)
    ----SL:release_print("提升-玩家穿戴装备："..SL:JsonEncode(data))
    if data.isSuccess then
        TopIcon.topInit()
    end
end)

--- {isSuccess = 是否成功, pos = 成功脱下装备位}
SL:RegisterLUAEvent('LUA_EVENT_TAKE_OFF_EQUIP', "提升-玩家脱掉装备", function(data)
    ----SL:release_print("提升-玩家脱掉装备："..SL:JsonEncode(data))
    if data.isSuccess then
        TopIcon.topInit()
    end
end)

---table — {currReinLevel = 当前转生等级, lastReinLevel = 上次转生等级}
SL:RegisterLUAEvent('LUA_EVENT_REINLEVELCHANGE', "提升-玩家转生", function(data)

end)

---table — {opera = 类型 (1:初始化 2:增加 3:删除 4:激活 5:卸下 6: 清理全部称号)}
SL:RegisterLUAEvent("LUA_EVENT_PLAYER_TITLE_CHANGE","提升-称号改变",function(data)
    if data.opera == 2 and data.opera == 3 then

    end
end)


Message.RegisterClickMsg("气泡提升", BubbleTips)
