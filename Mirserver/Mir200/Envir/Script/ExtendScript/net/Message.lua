--- @class 消息类
Message = {
    WARN_MSG_TB = {
        Msg = "",
        FColor = nil,
        BColor = nil,
        Type = 1,
        Time = nil,
        SendName = nil,
        SendId = nil
    }
}

--- 自定义颜色文字信息
--- @param player string 玩家id
--- @param FColor number 字体景色
--- @param BColor number 背景色
--- @param msg string 消息内容
--- @param flag number 发送对象：Self：只发给自己；Group：发送给组队：Map：发送到当前地图中的人物；省略参数四表示全服发送
function Message:NoticeMsg(player, FColor, BColor, msg, flag)
    guildnoticemsg(player, FColor, BColor, msg, flag)
end

--- 警告消息
--- @param player string 玩家id
--- @param Msg string 消息内容
--- @return void 无
function Message:Warn(player, Msg) --发送对象：1-自己，
    local msgT = table.deepCopy(self.WARN_MSG_TB, msgT)
    msgT.Msg = Msg
    local msg = tbl2json(msgT)
    sendmsg(player, 1, msg)
    return true
end

---弹框
---@param player void 玩家id
---@param str string 内容
---@param par1 string 确认函数@confirm
---@param par2 string 取消函数@cancel
function Message:Box(player, str, par1, par2)
    par1 = par1 or ""
    par2 = par2 or ""
    messagebox(player, str, par1, par2)
    return true
end

--- 发送滚动消息
---@param player string 玩家对象
---@param type number 模式，发送对象 0-自己 1-所有人 2-行会 3-当前地图 4-组队
---@param FColor number 字体景色
---@param BColor number 背景色
---@param Y number Y坐标
---@param scroll number 滚动次数
---@param msg string 消息内容
function Message:MoveMsg(player, type, FColor, BColor, Y, scroll, msg)
    return sendmovemsg(player, type, FColor, BColor, Y, scroll, msg)
end

--- 发送屏幕中间大字体信息
--- @param player string 玩家对象
--- @param FColor number 字体景色
--- @param BColor number 背景色
--- @param Msg string 消息内容
--- @param flag number 发送对象：0=发送给自己；1=发送所有人物；2=发送行会；3=发送国家；4=发送当前地图；5=替换模式；7=组队
--- @param time number 显示时间
--- @param func string 倒计时结束后跳转的脚本位置，对应脚本需要放QFunction脚本中，使用跳转时，消息文字提示中必须包含%d，用于显示倒计时时间
function Message:CenterMsg(player, FColor, BColor, Msg, flag, time, func)
    sendcentermsg(player, FColor, BColor, Msg, flag, time, func)
end

--- 重新封装sendmsg
--- 实际使用时，只需要传入player, sendTarget, msg, Type
--- lualib:SendMsg(player, sendTarget, msg, Type)
--- 其他参数可选
---@param player void 玩家id
---@param sendTarget void 发送目标 1-自己，2-全服 3-行会，4-当前地图 5-组队
---@param msg void 消息内容
---@param Type void 消息类型 1 系统频道;2 行会频道;3 组队频道;4 顶部跑马灯公告;5 屏幕跑马灯公告 可控制Y轴;6 聊天上方公告;8 固定聊天;9 systemtips;10 可控制xy坐标广播;11 屏幕跑马灯公告 系统公告;12 系统频道 带超链;13 系统公告缩放
---@param FColor void 字体颜色
---@param BColor void 背景颜色
---@param Time void 消息显示时间
---@param SendName void 发送者名称
---@param SendId void 发送者id
---@return ：无返回值
function Message:Msg(player, sendTarget, msg, Type, FColor, BColor, Time, SendName, SendId)
    if player == nil or player == "0" or player == 0 then
        return
    end
    local msgT = table.deepCopy(Message.WARN_MSG_TB, msgT)
    msgT.Msg = msg
    msgT.Type = Type
    msgT.FColor = FColor
    msgT.BColor = BColor
    msgT.Time = Time
    msgT.SendName = SendName or ""
    msgT.SendId = SendId
    sendmsg(player, sendTarget, tbl2json(msgT))
end

--- 发送消息0
--- 全服广播发送，白字红底
---@param player string 玩家对象
---@param msg string 消息内容
function Message:Msg0(player, msg)
    self:Msg(player, 2, msg, 1, 255, 57)
end

--- 发送消息1
--- 全服广播发送，白字红底
---@param player string 玩家对象
---@param msg string 消息内容
function Message:Msg1(player, msg)
    if not player then
        player = globalinfo(0)
    end
    self:Msg(player, 2, msg, 1, 255, 57)
end

--- 发送消息5
--- 个人消息，白字红底
---@param player string 玩家对象
---@param msg string 消息内容
function Message:Msg5(player, msg)
    self:Msg(player, 1, msg, 1, 255, 249)
end

--- 发送消息6
--- 个人消息，绿字白底
---@param player string 玩家对象
---@param msg string 消息内容
function Message:Msg6(player, msg)
    self:Msg(player, 1, msg, 1, 219, 255)
end

--- 发送消息9
--- 给自己发送系统tips，白字红底
---@param player string 玩家对象
---@param msg string 消息内容
function Message:Msg9(player, msg)
    self:Msg(player, 1, msg, 9, 255, 57)
end
--- 发送消息扩展——ZSF
--- 给自己发送系统tips
function Message:Msg_zsfEX(player, msg)
    sendmsg(player, 1, msg)
end

--- 发送聊天框固定消息
--- @param player string 玩家对象
--- @param type number 发送对象 0-所有人 1-自己 2-行会 3-当前地图 4-组队
--- @param FColor number 字体景色
--- @param BColor number 背景色
--- @param time number 显示时间，自动替换内容中的%d
--- @param msg string 消息内容
--- @param showflag number 是否显示人物名称 0-是 1-否
function Message:TopFixChat(player, type, FColor, BColor, time, msg, showflag)
    return sendtopchatboardmsg(player, type, FColor, BColor, time, msg, showflag)
end

---向玩家发送渐变色公告信息
---@param stringPlayer string 玩家对象
---@param _numberTYPE number 发送对象：1-自己 2-全服 3-行会 4-当前地图 5-组队
---@param _tableJsonParam table sendmsg参数列表[不填Msg参数]
---@param _stringMESSAGE string 提示内容
---@param _stringLINK string 跳转链接
---@param _stringStartHexColor string 开始颜色[十六进制]
---@param _stringEndHexColor string 结束颜色[十六进制]
---@return boolean 是否发送成功
function Message.sendGradientMessage(stringPlayer, _numberTYPE, _tableJsonParam, _stringMESSAGE, _stringLINK, _stringStartHexColor, _stringEndHexColor)
    if not _numberTYPE then
        release_print("Message.sendSYSGradientMessage:_numberTYPE为nil。")
        return false
    end

    if not _tableJsonParam then
        release_print("Message.sendSYSGradientMessage:_tableJsonParam为nil。")
        return false
    end

    if not _stringMESSAGE then
        release_print("Message.sendSYSGradientMessage:_stringMESSAGE为nil。")
        return false
    end

    if not _stringLINK then
        release_print("Message.sendSYSGradientMessage:_stringLINK为nil。")
        return false
    end

    if not _stringStartHexColor then
        release_print("Message.sendSYSGradientMessage:_stringStartHexColor为nil。")
        return false
    end

    if not _stringEndHexColor then
        release_print("Message.sendSYSGradientMessage:_stringEndHexColor为nil。")
        return false
    end

    local tableStartRGBColor = YuanServerColor.HEX2RGBA(_stringStartHexColor)
    local tableEndRGBColor = YuanServerColor.HEX2RGBA(_stringEndHexColor)
    local tableMESSAGE = string.splitGBK(_stringMESSAGE)
    local tableDeltaRGBColor = {
        r = (tableEndRGBColor.r - tableStartRGBColor.r) / (#tableMESSAGE or 1),
        g = (tableEndRGBColor.g - tableStartRGBColor.g) / (#tableMESSAGE or 1),
        b = (tableEndRGBColor.b - tableStartRGBColor.b) / (#tableMESSAGE or 1)
    }

    local tableCurrentRGBColor = {
        r = tableStartRGBColor.r,
        g = tableStartRGBColor.g,
        b = tableStartRGBColor.b
    }

    local stringSingleFormat = [[<font color='%s'>%s</font>]]
    local tableGradient = {}
    for i = 1, #tableMESSAGE do
        tableCurrentRGBColor.r = tableCurrentRGBColor.r + tableDeltaRGBColor.r
        tableCurrentRGBColor.g = tableCurrentRGBColor.g + tableDeltaRGBColor.g
        tableCurrentRGBColor.b = tableCurrentRGBColor.b + tableDeltaRGBColor.b
        local stringSingleHexColor = YuanServerColor.RGBA2HEX(
                {
                    r = math.min(255, math.max(0, tableCurrentRGBColor.r)),
                    g = math.min(255, math.max(0, tableCurrentRGBColor.g)),
                    b = math.min(255, math.max(0, tableCurrentRGBColor.b))
                }
        )

        table.insert(
                tableGradient,
                string.format(
                        stringSingleFormat,
                        stringSingleHexColor,
                        tableMESSAGE[i]
                )
        )
    end

    _tableJsonParam.Msg = table.concat(tableGradient) .. _stringLINK
    sendmsg(stringPlayer, _numberTYPE, tbl2json(_tableJsonParam))
    return true
end

local dispatch_handler = {}
local dispatch_click_handler = {}
Message.formAllowFunc = {}
Message.npcRangeAllowFunc = {}

function Message.sendmsg(actor, msgID, arg1, arg2, arg3, data)
    local str = data and tbl2json(data) or nil
    --LOGPrint("sendmsg msgID=", msgID, arg1, arg2, arg3, str)
    --LOGWrite("sendmsg msgID=", msgID, arg1, arg2, arg3, str)
    --print("sendmsg msgID=", msgID, arg1, arg2, arg3, str)
    sendluamsg(actor, msgID, arg1, arg2, arg3, str)
end

function Message.dispatch(actor, msgID, arg1, arg2, arg3, str)
    --LOGPrint("dispatch msgID=", msgID, arg1, arg2, arg3, str)
    --print("dispatch msgID=", msgID, arg1, arg2, arg3, str)
    local msgName = ssrNetMsgCfg[msgID]
    if not msgName then
        return
    end

    local module, method = msgName:match "([^.]*)_(.*)"
    local target = dispatch_handler[module]
    if not target or not target[method] then
        return
    end

    --如果是条件开启模块并且模块还未开启不处理网络消息
    -- local moduleid = target.ID
    -- if moduleid and xxx[moduleid] then
    --如果未开启
    --return
    -- end

    --派发
    local data = (str and str ~= "") and cjson.decode(str) or nil
    target[method](actor, arg1, arg2, arg3, data)
end

function Message.RegisterNetMsg(msgType, target)
    dispatch_handler[msgType] = target
end


---检查模块是否需要 NPC 距离限制，白名单模块的所有允许回调都会走这里
function Message.checkNpcRangeAllow(player, module)
    local config = Message.npcRangeAllowFunc[module]
    if config == nil then
        return true
    end

    local npcIdx = NPC.getNpcIdxByScript(config.script)
    if npcIdx ~= nil and UCheckNPCRange(player,nil,npcIdx,config.range) then
        return true
    end

    lualib:SendMsgGetColor(player,9,"#ff0800|请靠近NPC后操作！")
    return false
end
function click(player, msgName, ...)
    if os.time() == lualib:GetVar(player,"") then
        lualib:SendMsgGetColor(player, 1, "#ffffff")
        return ""
    end

    local module, method = msgName:match "([^.]*)_(.*)"
    local target = dispatch_click_handler[module]
    --print(msgName,module)

    if not target or not target[method] then
        print("click not found func:" .. msgName.." "..module)
        return
    end

    if Message.formAllowFunc[module].kuaFu == nil then
        if checkkuafu(player) then
            lualib:SendMsgEx(player, 9, "<font color='#f10028'>跨服状态无法使用！！</font>")
            return
        end
    end

    local args = {...}
    for i = 1, #args do
        if type(args[i]) == "number" then
            args[i] = math.floor(args[i])
        end
    end

    if Message.formAllowFunc[module][method] ~= nil then
        if not Message.checkNpcRangeAllow(player,module) then
            return
        end

        target[method](player,unpack(args))
    else
        lualib:dbg("click not allow func:" .. msgName .. " " .. method)
    end
end

---设置允许被客户端回调的注册函数
---@param msgType string 消息类型
---@param funcTb table 允许的函数名表
function setFormAllowFunc(msgType, funcTb)
    if not msgType then
        print("setFormAllowFunc msgType is nil", tostring(msgType))
        return
    end

    if type(funcTb) ~= "table" then
        print("setFormAllowFunc func is not table", tostring(msgType))
        return
    end
    Message.formAllowFunc[msgType] = {}
    for i, v in pairs(funcTb) do
        Message.formAllowFunc[msgType][v] = true
    end
end


---设置需要 NPC 距离校验的表单模块，模块下 setFormAllowFunc 允许的函数都会统一校验
---@param msgType string 表单模块名，例如 "藏品"
---@param npcScript string NPC 配置表中的 script，例如 "藏品_main"
---@param range number 检查范围，默认 10
function setNpcRangeAllowFunc(msgType,npcScript,range)
    if not msgType then
        print("setNpcRangeAllowFunc msgType is nil", tostring(msgType))
        return
    end

    npcScript = npcScript or (msgType.."_main")
    Message.npcRangeAllowFunc[msgType] = {script = npcScript,range = range or 10}
end
--- 注册点击分发实体
--- @param msgType string 消息类型
--- @param target table 实体
function Message.RegisterClickMsg(msgType, target)
    --lualib:dbg("RegisterClickMsg:" .. msgType)
    dispatch_click_handler[msgType] = target
end
