--- @class 消息类
Message = {
}

local dispatch_click_handler = {}
--派发事件
---@msgName string 消息名
function Message.dispatch( msgName, msgData)
    SL:release_print(msgName)
    local module, method = msgName:match "([^.]*)_(.*)"
    local target = dispatch_click_handler[module]
    if not target or not target[method] then
        return
    end
   
    target[method](unpack(msgData))
end
--- 注册点击分发实体
--- @param msgType string 消息类型
--- @param target table 实体
function Message.RegisterClickMsg(msgType, target)
    ---SL:release_print("注册点击分发实体"..msgType.."  ")
    dispatch_click_handler[msgType] = target
end
--
SL:RegisterLuaNetMsg(666, function (msgID, p1, p2, p3, msgData)
    SL:release_print("收到消息"..msgID.."  "..p1.."  "..p2.."  "..p3.."  "..msgData)
    msgData = SL:JsonDecode(msgData,false)
    msgData = convert_keys_to_numbers(msgData)
    Message.dispatch(msgData.script,msgData.paramList)
end)

function convert_keys_to_numbers(tbl)
    local new_tbl = {}
    for k, v in pairs(tbl) do
        if type(k) == "string" and tonumber(k) then
            k = tonumber(k)
        end
        if type(v) == "table" then
            v = convert_keys_to_numbers(v)
        end
        new_tbl[k] = v
    end
    return new_tbl
end


