local ssrNetMsgCfg = {}

ssrNetMsgCfg.sync                           = 100       --同步数据

ssrNetMsgCfg.Global                         = "Global"
ssrNetMsgCfg.Global_ClickNpcResponse        = 1000      --点击某Npc
ssrNetMsgCfg.Global_OpenModuleRun           = 1001      --开启某模块
ssrNetMsgCfg.Global_SyncOpenDay             = 1002      --同步开服天数
ssrNetMsgCfg.Global_SyncCreateActor         = 1003      --同步创建角色信息
ssrNetMsgCfg.Global_SyncTotalRealRecharge   = 1004      --同步总实冲分
ssrNetMsgCfg.Global_SyncTodayRealRecharge   = 1005      --同步今日实冲分
ssrNetMsgCfg.Global_Recharge                = 1006      --充值触发
ssrNetMsgCfg.Global_SyncAdmini              = 1007      --同步GM权限
ssrNetMsgCfg.Global_RequestOpenTTSQ         = 1008      --请求打开天天省钱
ssrNetMsgCfg.Global_ClickIconResponse       = 1009      --点击图标

--main
-- ssrNetMsgCfg.Main                               = "main"   

------------------------------------A------------------------------------
--美女客服
ssrNetMsgCfg.basicMap                         = "basicMap"
ssrNetMsgCfg.basicMap_SyncResponse            = 10000      --同步数据
ssrNetMsgCfg.basicMap_RequestReceive          = 10001      --请求领取
ssrNetMsgCfg.basicMap_UpdataResponse          = 10002      --响应领取

--福利中心
ssrNetMsgCfg.welfare                          = "welfare"
ssrNetMsgCfg.welfare_SyncResponse             = 10010      --同步数据
ssrNetMsgCfg.welfare_RequestReceive           = 10011      --请求领取
ssrNetMsgCfg.welfare_UpdataResponse           = 10012      --响应领取

ssrNetMsgCfg.Awards                          = "Awards"     --奖励显示
ssrNetMsgCfg.Awards_UpdataResponse           = 10020      --响应领取

--活动中心
ssrNetMsgCfg.activity                         = "activity"
ssrNetMsgCfg.activity_SyncResponse            = 10030      --同步数据
ssrNetMsgCfg.activity_RequestReceive          = 10031      --请求领取
ssrNetMsgCfg.activity_UpdataResponse          = 10032      --响应领取

--合服活动
ssrNetMsgCfg.hefu                            = "hefu"
ssrNetMsgCfg.hefu_SyncResponse               = 10040      --同步数据
ssrNetMsgCfg.hefu_RequestReceive             = 10041      --请求领取
ssrNetMsgCfg.hefu_UpdataResponse             = 10042      --响应领取


local t = {}
for msgName,msgID in pairs(ssrNetMsgCfg) do
    t[msgName] = msgID
    t[msgID] = msgName
end
ssrNetMsgCfg = t

return ssrNetMsgCfg