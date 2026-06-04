Global = {}
Global.Bind = 307
--µã»÷Ä³NPC
function Global.ClickNpcResponse(actor, npcid)
    Message.sendmsg(actor, ssrNetMsgCfg.Global_ClickNpcResponse, npcid)
end

--µã»÷Ä³icon
function Global.ClickIconResponse(actor, param)
    Message.sendmsg(actor, ssrNetMsgCfg.Global_ClickIconResponse,0,0,0,param)
end
-------------------------------¼àÌýÊÂ¼þ---------------------------------------
GameEvent.add(EventCfg.onClicknpc, Global.ClickNpcResponse, Global, 1)
GameEvent.add(EventCfg.onClickIcon, Global.ClickIconResponse, Global, 1)
-------------------------------¼àÌýÍøÂç---------------------------------------
Message.RegisterNetMsg(ssrNetMsgCfg.Global, Global)

return Global