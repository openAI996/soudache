
--图标,红点,特效,倒计时,删除图标,删除红点,删除特效,倒计时结束回调,引导,点击事件
TimerGift = {}

--设置图标
---@param player Player
function TimerGift.SetIcon(player,param)
    param = param or nil
    --{id = "天天省钱",icon = "res/public/icon/vip.png",w = 70, h = 70,row = 1,column = 1,callback = 111,scale = true,times = 0},
    --{id = "交易行",icon = "res/public/icon/jf.png",w = 70,h = 70,row = 1,column = 2,callback = "测试_show",scale = true,times = 0},
    lualib:ShowFormWithContent(player, "右上图标_ClearAllIcon")
    local row,column = 1,1
    TimerGift.AddIcon(player,"交易行","res/public/icon/jyh.png",66,66,row,column,35,0,0)

    ----第二列
    row,column = 1,column + 1
    TimerGift.AddIcon(player,"天天省钱","res/public/icon/ttsq.png",66,66,row,column,111,0,0)

    lualib:ShowFormWithContent(player, "右上图标_InitIcon",param)
end

--添加右上图标
---@param player Player
---@param id number 客户端使用id(不可重复)
---@param icon string 客户端使用图标路径
---@param w number 图标宽度
---@param h number 图标高度
---@param row number 图标行
---@param column number 图标列
---@param callback function 点击图标回调
---@param scale (1/0) 是否固定在界面上
---@param times number 倒计时时间(不填写则不显示倒计时)

function TimerGift.AddIcon(player,id,icon,w,h,row,column,callback,scale,times)
    if  not id then
        lualib:dbg("AddIcon id is nil",tostring(id))
        return
    end
    if  not icon then
        lualib:dbg("AddIcon icon is nil",tostring(icon))
        return
    end
    if  not w then
        lualib:dbg("AddIcon w is nil",tostring(w))
        return
    end
    if  not h then
        lualib:dbg("AddIcon h is nil",tostring(h))
        return
    end
    if  not row then
        lualib:dbg("AddIcon row is nil",tostring(row))
        return
    end

    if  not column then
        lualib:dbg("AddIcon column is nil",tostring(column))
        return
    end

    if scale == nil then
        scale = 0
    end

    times = times or 0

    lualib:ShowFormWithContent(player, "右上图标_AddIcon", id, icon, w, h, row, column,callback,scale,times)
end

--删除右上图标
---@param player Player
---@param id number 客户端使用id(不可重复)
function TimerGift.DelIcon(player,id)
    if  not id then
        lualib:dbg("DelIcon id is nil",tostring(id))
        return
    end

    --TimerGift.SetIcon(player)
    lualib:ShowFormWithContent(player, "右上图标_DelIcon", id)
end

--添加右上红点
---@param player Player
---@param id number 客户端使用id(不可重复)
---@param x number 红点x坐标
---@param y number 红点y坐标
function TimerGift.AddRedPoint(player,id,x,y)
    if  not id then
        lualib:dbg("AddRedPoint id is nil",tostring(id))
        return
    end
    if  not x then
        lualib:dbg("AddRedPoint x is nil",tostring(x))
        return
    end
    if  not y then
        lualib:dbg("AddRedPoint y is nil",tostring(y))
        return
    end

    lualib:ShowFormWithContent(player, "右上图标_AddRedPoint", id, x, y)
end

--删除右上红点
---@param player Player
---@param id number 客户端使用id(不可重复)
function TimerGift.DelRedPoint(player,id)
    if  not id then
        lualib:dbg("DelRedPoint id is nil",tostring(id))
        return
    end

    lualib:ShowFormWithContent(player, "右上图标_DelRedPoint", id)
end

--添加右上特效
---@param player Player
---@param id number 客户端使用id(不可重复)
---@param effect string 特效路径
---@param x number 特效x坐标
---@param y number 特效y坐标
function TimerGift.AddEffect(player,id,effect,x,y,type,scale)
    if  not id then
        lualib:dbg("AddEffect id is nil",tostring(id))
        return
    end

    if  not effect then
        lualib:dbg("AddEffect effect is nil",tostring(effect))
        return
    end

    if  not x then
        lualib:dbg("AddEffect x is nil",tostring(x))
        return
    end

    if  not y then
        lualib:dbg("AddEffect y is nil",tostring(y))
        return
    end
    scale = scale or 1

    lualib:ShowFormWithContent(player, "右上图标_AddEffect", id, effect, x, y,type,scale)
end

--删除右上特效
---@param player Player
---@param id number 客户端使用id(不可重复)
function TimerGift.DelEffect(player,id)
    if  not id then
        lualib:dbg("DelEffect id is nil",tostring(id))
        return
    end

    lualib:ShowFormWithContent(player, "右上图标_DelEffect", id)
end

--添加右上引导
---@param player Player
---@param id number 客户端使用id(不可重复)
---@param desc string 引导描述
function TimerGift.AddGuide(player,id,desc)
    if not id then
        lualib:dbg("AddGuide id is nil",tostring(id))
        return
    end

    if  not desc then
        lualib:dbg("AddGuide desc is nil",tostring(desc))
        return
    end

    lualib:ShowFormWithContent(player, "右上图标_AddGuide", id, desc)
end

GameEvent.add(EventCfg.onLogin, TimerGift.SetIcon, TimerGift,2)
GameEvent.add(EventCfg.onTimeGift, TimerGift.SetIcon, TimerGift)
Message.RegisterClickMsg("时间礼包", TimerGift)
setFormAllowFunc("时间礼包", {"SetIcon"})
return TimerGift