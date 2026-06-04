TopIcon = {
    Scalin = { [true] = "res/public/icon/1.png", [false] = "res/public/icon/0.png" },
    icon = {
        --{id = "天天省钱",icon = "res/public/icon/vip.png",w = 70, h = 70,row = 1,column = 1,callback = 111,scale = true,times = 0},
    },
    redPoint = {--
        --["天天省钱"] = {x = 0,y = 0},
    },
    effect = {--
        --["天天省钱"] = {x = 0,y = 0,eff = 0,type = 0},
    }
}

TopIcon.size = {
    0,1,2,3,4,5,6,7,8,9,10,11,12
}

TopIcon.shenFuIs = 0
TopIcon.daoJiShi = 0

TopIcon.Name = "TopIconFrame"
TopIcon.scale = true
TopIcon.first = true
TopIcon.WndHandle = nil
function TopIcon.InitIcon(param)
    local _OffsetX, _OffsetY = -195 , -20
    local _WndSizeX, _WndSizeY = 700 , 260

    if SL:GetMetaValue("CURRENT_OPERMODE") == 1 then
        _OffsetX, _OffsetY = -210 , -40
    end

    if param == nil then
        TopIcon.first = true
    else
        TopIcon.first = false
    end

    local _LeftTop = GUI:Attach_LeftTop_B()
    if _LeftTop then
        if not GUI:GetWindow(_LeftTop,"Image_up") then
            local image = GUI:Image_Create(_LeftTop, "Image_up",screen_W/2 , -30, "res/public/icon/up.png")
            if image then
                GUI:setAnchorPoint(image, 0.5, 0)
            end
        end
    end

    --MainMiniMap._parent = GUI:Attach_MainMiniMap()

    local _Parent = GUI:GetWindow( MainMiniMap._parent, TopIcon.Name)
    if _Parent ~= nil then
        GUI:removeAllChildren(_Parent)
    else
        _Parent = GUI:Layout_Create( MainMiniMap._parent, TopIcon.Name, _OffsetX, _OffsetY, _WndSizeX, _WndSizeY)
        if _Parent then
            TopIcon.WndHandle = _Parent
            GUI:setAnchorPoint(_Parent, 1, 1)
        end
    end

    TopIcon.WndHandle = _Parent
    if _Parent then
        local _GUIHandle = nil
        local path = TopIcon.Scalin[TopIcon.scale]
        local _Handle = GUI:Button_Create(_Parent, "scale", _WndSizeX -15, _WndSizeY + 10 ,  path)
        if _Handle ~= nil then
            GUI:setAnchorPoint(_Handle, 0.5, 0.5)
            GUI:Timeline_StopAll(_Handle)
            if TopIcon.first then
                GUI:Timeline_FadeOut(_Handle, 0.15, function ()
                    GUI:Timeline_FadeIn(_Handle,0.15,function ()
                    end)
                end)

                GUI:Timeline_RotateTo(_Handle, 180, 0.3, function()
                end)
            else
                GUI:setRotation(_Handle, 180)
            end

            GUI:addOnClickEvent(_Handle, function()
                TopIcon.scale = not TopIcon.scale
                TopIcon.InitIcon()
            end)
        end

        local numberAmount = 0
        for i = 1,#TopIcon.icon do
            local _PosX,_PosY = _WndSizeX - (TopIcon.icon[i].row - 1) * (TopIcon.icon[i].w + 10 ) - 90, _WndSizeY - (TopIcon.icon[i].column - 1 ) * (TopIcon.icon[i].h + 10) + 6
            _GUIHandle = GUI:Button_Create(_Parent, TopIcon.icon[i].id,  _PosX, _PosY, TopIcon.icon[i].icon)
            if _GUIHandle then
                GUI:Win_SetParam(_GUIHandle, i)
                GUI:setAnchorPoint(_GUIHandle,0.5, 0.5)
                GUI:setTouchEnabled(_GUIHandle, true)
                if TopIcon.first then
                    if not TopIcon.scale then
                        if TopIcon.icon[i].scale == 0 then
                            GUI:runAction(_GUIHandle,
                                    GUI:ActionSequence(
                                            GUI:DelayTime(0.05 * numberAmount),
                                            GUI:ActionEaseExponentialInOut(
                                                    GUI:ActionSpawn(
                                                            GUI:ActionFadeOut(0.5),
                                                            GUI:ActionScaleTo(0.5, 0),
                                                            GUI:ActionMoveTo(0.5, _PosX, _PosY)
                                                    )
                                            ),
                                            GUI:CallFunc(
                                                    function(_GUIHandle)
                                                        GUI:removeFromParent(_GUIHandle)
                                                    end
                                            )
                                    )
                            )
                        end
                    else
                        if TopIcon.icon[i].scale == 0 then
                            GUI:runAction(_GUIHandle,
                                    GUI:ActionSequence(
                                            GUI:ActionSpawn(
                                                    GUI:ActionFadeOut(0),
                                                    GUI:ActionScaleTo(0, 0)
                                            ),
                                            GUI:DelayTime(0.05 * numberAmount),
                                            GUI:ActionEaseExponentialInOut(
                                                    GUI:ActionSpawn(
                                                            GUI:ActionFadeIn(0.5),
                                                            GUI:ActionMoveTo(0.5, _PosX, _PosY),
                                                            GUI:ActionScaleTo(0.5, 1)
                                                    )
                                            )
                                    )
                            )
                        end
                    end
                end

                GUI:addOnClickEvent(_GUIHandle, TopIcon.submit)
                --红点显示
                if TopIcon.redPoint[TopIcon.icon[i].id] ~= nil then
                    TopIcon.AddRedPoint(TopIcon.icon[i].id,TopIcon.redPoint[TopIcon.icon[i].id].x,TopIcon.redPoint[TopIcon.icon[i].id].y)
                end

                --特效显示
                if TopIcon.effect[TopIcon.icon[i].id] ~= nil then
                    TopIcon.AddEffect(TopIcon.icon[i].id,TopIcon.effect[TopIcon.icon[i].id].eff,TopIcon.effect[TopIcon.icon[i].id].x,TopIcon.effect[TopIcon.icon[i].id].y,TopIcon.effect[TopIcon.icon[i].id].type)
                end

                --倒计时
                if TopIcon.icon[i].times ~= 0  then
                    local Text_1 = GUI:Text_Create(_GUIHandle, "times", TopIcon.icon[i].w/2, -14, 14, "#33ff00", TopIcon.icon[i].times)
                    GUI:setAnchorPoint(Text_1, 0.5, 0.00)
                    GUI:setTouchEnabled(Text_1, false)
                    GUI:Text_COUNTDOWN(Text_1,TopIcon.icon[i].times,function()

                    end,1)

                    GUI:schedule(_Handle,function()
                        TopIcon.icon[i].times = TopIcon.icon[i].times - 1
                        if TopIcon.icon[i].times <= 0 then
                            GUI:unSchedule(_Handle)
                        end
                    end)
                end
                numberAmount = numberAmount + 1
            end
        end
    end

    --GUI:Timeline_StopAll(_Parent)
    if TopIcon.frist then
        TopIcon.frist = false
    end

    TopIcon.windowInit()
    TopIcon.topInit()
    ----TopIcon.TaskWindow()
end

function TopIcon.MainMiniMapAction()
    local _InitX,_InitY = GUI:getPositionX(TopIcon.WndHandle),GUI:getPositionY(TopIcon.WndHandle)
    if MainMiniMap._showState then
        _OffsetX, _OffsetY = -40 , 0
        if _InitX ~= _OffsetX then
            GUI:Timeline_EaseSineIn_MoveTo(TopIcon.WndHandle, { x = _InitX + 140, y = _InitY }, 0.2)
        end
    else
        _OffsetX, _OffsetY = -180 , 0
        if _InitX ~= _OffsetX then
            GUI:Timeline_EaseSineIn_MoveTo(TopIcon.WndHandle, { x = _InitX - 140, y = _InitY }, 0.2)
        end
    end
end

function TopIcon.AddIcon(id,icon,w,h,row,column,callback,scale,times)
    if not id then
        return
    end
    if not icon then
        return
    end
    if not w then
        return
    end
    if not h then
        return
    end
    if not row then
        return
    end
    if not column then
        return
    end
    if not callback then
        return
    end
    if not scale then
        scale = 0
    end
    if not times then
        times = 0
    end
    --插入数据到TopIcon.limit
    table.insert(TopIcon.icon,{id = id,icon = icon,w = w,h = h,row = row,column = column,callback = callback,scale=scale,times = times})
end

function TopIcon.DelIcon(id)
    if id == nil then
        return
    end
    --SL:release_print("删除："..id)
    --根据ID删除TopIcon.limit中的数据
    for i = 1,#TopIcon.icon do
        if TopIcon.icon[i].id == id then
            table.remove(TopIcon.icon,i)
            TopIcon.InitIcon(1)
            break
        end
    end

end

function TopIcon.AddRedPoint(id,x,y)
    if id == nil then
        return
    end
    if x == nil then
        x = 50
    end
    if y == nil then
        y = 50
    end
    --SL:release_print("添加红点")
    --根据ID添加红点
    for i = 1,#TopIcon.icon do
        if TopIcon.icon[i].id == id then
            TopIcon.redPoint[id] = {x = x,y = y}
            --添加红点

            if GUI:GetWindow(TopIcon.WndHandle,id.."/红点容器") == nil then
                CL:AddRedPoint(GUI:GetWindow(TopIcon.WndHandle,id),x,y)
            end
            break
        end
    end
end

function TopIcon.DelRedPoint(id)
    if id == nil then
        return
    end

    for i = 1,#TopIcon.icon do
        if TopIcon.icon[i].id == id then
            TopIcon.redPoint[id] = nil
            if GUI:GetWindow(TopIcon.WndHandle,id.."/红点容器") then
                GUI:removeFromParent(GUI:GetWindow(TopIcon.WndHandle,id.."/红点容器"))
            end
        end
    end

    TopIcon.redPoint[id] = nil
end
--引导
function TopIcon.AddGuide(id,guide)
    if id == nil then
        return
    end

    if guide == nil then
        return
    end
    local num = 0
    for i = 1,#TopIcon.icon do
        if TopIcon.icon[i].id == id then
            num = i
            break
        end
    end
    --根据ID添加引导
    local data = {}
    data.dir           = 8                -- 方向（1~8）从左按瞬时针
    data.guideWidget   = GUI:GetWindow(TopIcon.WndHandle,id)        -- 当前节点
    data.guideParent   = TopIcon.WndHandle          -- 父窗口
    data.guideDesc     = guide           -- 文本描述
    data.clickCB       = function()
        SL:SubmitForm(TopIcon.icon[num].callback)
    end       -- 回调
    data.autoExcute    = 3                -- 自动执行秒数
    data.isForce       = true             -- 强制引导

    SL:StartGuide(data)
end

function TopIcon.submit(_Handle)
    local param = GUI:Win_GetParam(_Handle)
    local temp = TopIcon.icon[tonumber(param)].callback
    ---SL:release_print("顶部图标提交："..type(temp))
    if type(temp) == "number" then
        SL:JumpTo(temp)
    else
        SL:SubmitForm(temp)
    end
end
--倒计时
function TopIcon.OnTimer(_TimerNode)
    local param = GUI:Win_GetParam(_TimerNode)
    local flag = 0

    if TopIcon.icon[tonumber(param)] then
        if TopIcon.icon[tonumber(param)].times ~= 0 then
            TopIcon.icon[tonumber(param)].times = TopIcon.icon[tonumber(param)].times - 1
            if TopIcon.icon[tonumber(param)].times <= 0 then
                flag = 1
            end
        else
            flag = 1
        end
    else
        flag = 1
    end

    if flag == 1 then
        TopIcon.DelTimer(TopIcon.icon[tonumber(param)].id)
    else
        local _TextGUIHandle = GUI:GetWindow(_TimerNode, "timerText")
		if _TextGUIHandle then
			GUI:removeFromParent(_TextGUIHandle)
		end

        local _TextGUIHandle = GUI:GetWindow(_TimerNode, "timerText")
		if nil == _TextGUIHandle then
			_TextGUIHandle = GUI:Text_Create(_TimerNode, "timerText", 34, 0, 14, "#00FF00", "")
			if _TextGUIHandle then
				GUI:setAnchorPoint(_TextGUIHandle, 0.5, 0)
				GUI:Text_setTextHorizontalAlignment(_TextGUIHandle, 1)
				GUI:setContentSize(_TextGUIHandle, { width = 120, height = 16 })
			end
		end
        GUI:Text_setString(_TextGUIHandle, SL:TimeFormatToStr(TopIcon.icon[tonumber(param)].times))
    end
end
--删除倒计时
function TopIcon.DelTimer(id)
    if id == nil then
        return
    end

    for i = 1,#TopIcon.icon do
        if TopIcon.icon[i].id == id then
            TopIcon.icon[i].times = 0
            break
        end
    end
end

--添加特效
---@param id string 客户端使用id(不可重复)
---@param eff string 特效ID
---@param x number 特效X坐标
---@param y number 特效Y坐标
---@param type number 特效类型(1(只显示)，2(可点击))
function TopIcon.AddEffect(id,eff,x,y,show,scale)
    if id == nil then
        return
    end

    if eff == nil then
        return
    end
    --根据ID添加特效
    for i = 1,#TopIcon.icon do
        if TopIcon.icon[i].id == id then
            if TopIcon.effect[id] == nil then
                TopIcon.effect[id] = {x = x,y = y,eff = eff,type = show,scale = scale}
            end

            if GUI:GetWindow(TopIcon.WndHandle,id .. ",effect") == nil  then
                local _EffectHandle = GUI:Effect_Create(GUI:GetWindow(TopIcon.WndHandle,id), "effect", x, y, 0,eff)
                if _EffectHandle then
                    GUI:setScale(_EffectHandle, scale)

                end

                if show == 2 then
                    local _Handle = GUI:Layout_Create( GUI:GetWindow(TopIcon.WndHandle,id), "click", x-30, y-15, TopIcon.icon[i].w, TopIcon.icon[i].h)
                    if _Handle then
                        GUI:setTouchEnabled(_Handle, true)
                        --GUI:Layout_setBackGroundColorType(_Handle, 1)
                        --GUI:Layout_setBackGroundColor(_Handle, "#00FF00")
                        GUI:Win_SetParam(_Handle, i)
                        GUI:addOnClickEvent(_Handle, TopIcon.submit)
                    end
                end
            end
            break
        end
    end
end

function TopIcon.ClearAllIcon()
    TopIcon.icon = {}
    TopIcon.InitIcon()
end
---杀怪进度
function TopIcon.TaskWindow(data)
    local _GUIHandle = GUI:Win_FindParent(110)
    if _GUIHandle ~= nil then
        GUI:removeAllChildren(_GUIHandle)
        SL:Print("任务窗口",SL:JsonEncode(data))
        if cfg_Map[SL:GetMetaValue("MAP_ID")] ~= nil then
            if cfg_Map[SL:GetMetaValue("MAP_ID")].type ~= 1 then

                local _Handle = GUI:Button_Create(_GUIHandle, "查看羁绊", 269, 120, "res/gmbox/1900000679.png")
                if _Handle then
                    GUI:setAnchorPoint(_Handle, 0.5, 0.5)
                    GUI:Button_setTitleText(_Handle, "查看羁绊")
                    GUI:Button_setTitleColor(_Handle, "#FFFFFF")
                    GUI:Button_setTitleFontSize(_Handle, 16)
                    GUI:Button_titleEnableOutline(_Handle, "#000000", 1)
                    GUI:addOnClickEvent(_Handle, function()
                        SL:SubmitForm("抽卡_show",1)
                    end)
                end

                local bgk = GUI:Image_Create(_GUIHandle, "bgk", 225, 1, "res/public/1900012700.png")
                GUI:setAnchorPoint(bgk, 0.00, 0.00)
                GUI:setTouchEnabled(bgk, true)
                GUI:setTag(bgk, 0)

                local scale = math.floor(data[1]/data[2]*100)
                local LoadingBar_1 = GUI:ProgressTimer_Create(bgk, "LoadingBar_1", 44, 42, "res/public/1900012703.png")
                GUI:ProgressTimer_setReverseDirection(LoadingBar_1, true)
                GUI:ProgressTimer_setPercentage(LoadingBar_1, scale)
                GUI:setAnchorPoint(LoadingBar_1, 0.50, 0.50)
                GUI:setTag(LoadingBar_1, 0)
                if data[3] == 1 then
                    local _EffectHandle = GUI:Effect_Create(bgk, "effect", 44, 42, 0, 4001, 0, 0, 0, 1)
                    if _EffectHandle then
                        GUI:setScale(_EffectHandle, 1)
                        --GUI:setAnchorPoint(_EffectHandle,1,1)
                    end

                    local Panel_1 = GUI:Layout_Create(bgk, "Panel_1", 45, 45, 90, 90, false)
                    GUI:setAnchorPoint(Panel_1, 0.50, 0.50)
                    GUI:setTouchEnabled(Panel_1, true)
                    GUI:setTag(Panel_1, 0)
                    GUI:addOnClickEvent(Panel_1, function()
                        SL:SubmitForm("抽卡_clickCard")
                    end)

                    local _TextHandle = GUI:Text_Create(bgk, "入局金币", 45, 45, 16, "#ffff00","可抽取")
                    if _TextHandle then
                        GUI:setAnchorPoint(_TextHandle, 0.5, 0.5)
                    end
                end

                local txt = "进度："..data[1].."/"..data[2]
                if data[1] == data[2] then
                    txt = "已全部获取"
                end

                local _TextHandle = GUI:Text_Create(bgk, "进度", 45, -14, 16, "#ffff00",txt)
                if _TextHandle then
                    GUI:setAnchorPoint(_TextHandle, 0.5, 0.5)
                end
            end
        end
    end
end
--buff状态栏
function TopIcon.windowInit()
    if SL:GetMetaValue("CURRENT_OPERMODE") == 1 then
        local _GUIHandle = GUI:Win_FindParent(107)
        if _GUIHandle then
            local _Handle = GUI:GetWindow(_GUIHandle,"icon")
            if _Handle then
                GUI:removeFromParent(_Handle)
            end

            _GUIHandle = GUI:Layout_Create(_GUIHandle, "icon", 30, 40, 30, 120, false)
            GUI:setAnchorPoint(_GUIHandle, 0.50, 0.50)
            GUI:setTouchEnabled(_GUIHandle, false)
            GUI:setTag(_GUIHandle, 0)

            _Handle = GUI:Button_Create(_GUIHandle, "自动挂机", -50, 0, "res/private/main/skill/1900012708.png")
            if _Handle then
                GUI:setAnchorPoint(_Handle, 0.5, 0.5)
                GUI:addOnClickEvent(_Handle, function()
                    SL:SubmitForm("基础功能通用_autoGame")
                end)
            end

            _Handle = GUI:Layout_Create(_GUIHandle, "开始挂机", -50, 0, 60, 60, false)
            GUI:setAnchorPoint(_Handle, 0.50, 0.50)
            GUI:setVisible(_Handle,false)
            GUI:setTouchEnabled(_Handle, true)
            GUI:setTag(_Handle, 0)
            GUI:addOnClickEvent(_Handle, function()
                SL:SubmitForm("基础功能通用_autoGame")
            end)

            --Create Frames_1
            local Frames_1 = GUI:Frames_Create(_Handle, "Frames_1", 30, 30, "res/private/main/Skill/zdz-", ".png", 1, 10, {count=10, speed=100, loop=-1, finishhide=0})
            GUI:setAnchorPoint(Frames_1, 0.50, 0.50)
            GUI:setTouchEnabled(Frames_1, false)
            GUI:setTag(Frames_1, 0)

            --
            _Handle =  GUI:Button_Create(_GUIHandle, "设置", -50, 70, "res/private/main/bottom/1900013017.png")
            if _Handle then
                GUI:setAnchorPoint(_Handle, 0.5, 0.5)
                GUI:addOnClickEvent(_Handle, function()

                    SL:OpenSettingUI()
                end)
            end

            _Handle =  GUI:Button_Create(_GUIHandle, "装扮", -50, 140, "res/private/main/bottom/1900013019.png")
            if _Handle then
                GUI:setAnchorPoint(_Handle, 0.5, 0.5)
                GUI:addOnClickEvent(_Handle, function()
                    if SL:GetMetaValue("MAP_ID") ~= "3" then
                        SL:ShowSystemTips("当前地图禁止使用！！")
                        return ""
                    end
                    SL:OpenAuctionUI()
                end)
            end
        end
    end
end
--顶部属性
function TopIcon.topInit(times)
    times = times or TopIcon.daoJiShi
    TopIcon.daoJiShi = times
    local _GUIHandle = GUI:Attach_LeftTop()---GUI:Win_FindParent(106)
    if _GUIHandle then
        GUI:removeAllChildren(_GUIHandle)
        if cfg_Map[SL:GetMetaValue("MAP_ID")] ~= nil then
            if cfg_Map[SL:GetMetaValue("MAP_ID")].type ~= 1 then
                local _Parent = GUI:Image_Create(_GUIHandle, "xinxi",-20 ,-460, "res/public/x.png")
                if _Parent then
                    GUI:setAnchorPoint(_Parent, 0, 0.5)
                end

                local y = 200
                local x = 20
                SL:schedule(_Parent, function()
                    TopIcon.daoJiShi = TopIcon.daoJiShi  - 1
                end, 1)
                local count = 0
                local num =  tonumber(SL:GetMetaValue("SERVER_VALUE", "U16")) or 0
                local _Handle = GUI:Image_Create(_Parent, "bg1", x ,y + 2, "res/public/1900000668.png")
                if _Handle then
                    GUI:setAnchorPoint(_Handle, 0, 0.5)
                end

                local _TextHandle = GUI:Text_Create(_Parent, "入局金币", x + 5, y, 16, "#ffff00","入局物资："..num )
                if _TextHandle then
                    GUI:setContentSize(_TextHandle, {width = 230, height = 24 })
                    GUI:setAnchorPoint(_TextHandle, 0, 0.5)
                end

                count = count - num
                ---SL:Print(count,"本局收益1")
                num = 0
                local str = SL:GetMetaValue("SERVER_VALUE", "T1")
                local bao = {}
                local bag = SL:GetMetaValue("BAG_DATA")
                if str ~= "" then
                     bao = SL:JsonDecode(str)
                end

                for i=1,#bao do
                    if sellZhuangBei.config[bao[i][1]] ~= nil then
                        num  = num + sellZhuangBei.config[bao[i][1]].sell[2]*bao[i][4]
                    end
                end

                for k, v in pairs(bag) do
                    if sellZhuangBei.config[v.Name] ~= nil then
                        num  = num + sellZhuangBei.config[v.Name].sell[2]*v.OverLap
                    end
                end

                bag = SL:GetMetaValue("QUICKUSE_DATA")
                for k, v in pairs(bag) do
                    if sellZhuangBei.config[v.Name] ~= nil then
                        num  = num + sellZhuangBei.config[v.Name].sell[2]*v.OverLap
                    end
                end

                for i=1,#TopIcon.size do
                    local name = SL:GetMetaValue("EQUIPBYPOS", TopIcon.size[i])
                    if sellZhuangBei.config[name] ~= nil then
                        num  = num + sellZhuangBei.config[name].sell[2]
                    end
                end

                count = count + num
                y = y - 30
                _Handle = GUI:Image_Create(_Parent, "bg2", x ,y + 2, "res/public/1900000668.png")
                if _Handle then
                    GUI:setAnchorPoint(_Handle, 0, 0.5)
                end

                _TextHandle = GUI:Text_Create(_Parent, "当前物资", x + 5, y, 16, "#ffff00","当前物资："..num )
                if _TextHandle then
                    GUI:setContentSize(_TextHandle, {width = 230, height = 24 })
                    GUI:setAnchorPoint(_TextHandle, 0, 0.5)
                end

                num =  tonumber(SL:GetMetaValue("SERVER_VALUE", "U17")) or 0
                y = y - 30
                _Handle = GUI:Image_Create(_Parent, "bg3", x ,y + 2, "res/public/1900000668.png")
                if _Handle then
                    GUI:setAnchorPoint(_Handle, 0, 0.5)
                end

                _TextHandle = GUI:Text_Create(_Parent, "本局金币", x + 5, y, 16, "#ffff00","本局金币："..num )
                if _TextHandle then
                    GUI:setContentSize(_TextHandle, {width = 230, height = 24 })
                    GUI:setAnchorPoint(_TextHandle, 0, 0.5)
                end

                count = count + num

                y = y - 30
                _Handle = GUI:Image_Create(_Parent, "bg4", x ,y + 2, "res/public/1900000668.png")
                if _Handle then
                    GUI:setAnchorPoint(_Handle, 0, 0.5)
                end

                _TextHandle = GUI:Text_Create(_Parent, "本局收益", x + 5, y, 16, "#ffff00","本局收益："..count )
                if _TextHandle then
                    GUI:setContentSize(_TextHandle, {width = 230, height = 24 })
                    GUI:setAnchorPoint(_TextHandle, 0, 0.5)
                end

                local curWeight = SL:GetMetaValue("ATT_BY_TYPE", 94) ---SL:GetMetaValue("BW")
                local maxWeight = SL:GetMetaValue("ATT_BY_TYPE", 229)---SL:GetMetaValue("MAXBW")
                local color = "#ffff00"
                if curWeight >= maxWeight then
                    color = "#ff0400"
                end

                y = y - 30
                _Handle = GUI:Image_Create(_Parent, "bg5", x ,y + 2, "res/public/1900000668.png")
                if _Handle then
                    GUI:setAnchorPoint(_Handle, 0, 0.5)
                end

                _TextHandle = GUI:Text_Create(_Parent, "负重", x + 5, y, 16, color,"负重："..curWeight..'/'..maxWeight )
                if _TextHandle then
                    GUI:setContentSize(_TextHandle, {width = 230, height = 24 })
                    GUI:setAnchorPoint(_TextHandle, 0, 0.5)
                end

                y = y - 30
                _Handle = GUI:Image_Create(_Parent, "bg6", x ,y + 2, "res/public/1900000668.png")
                if _Handle then
                    GUI:setAnchorPoint(_Handle, 0, 0.5)
                end

                _TextHandle = GUI:Text_Create(_Parent, "撤离倒计时文字", x + 5, y, 16, "#ffff00","撤离倒计时：" )
                if _TextHandle then
                    GUI:setContentSize(_TextHandle, {width = 230, height = 24 })
                    GUI:setAnchorPoint(_TextHandle, 0, 0.5)
                end

                _TextHandle = GUI:Text_Create(_Parent, "撤离倒计时", x + 5 + 90, y, 16, "#19bd00","" )
                if _TextHandle then
                    GUI:setContentSize(_TextHandle, {width = 230, height = 24 })
                    GUI:setAnchorPoint(_TextHandle, 0, 0.5)
                    if times <= 0 then
                        GUI:Text_setString(_TextHandle, '已结束' )
                    else
                        GUI:Text_COUNTDOWN(_TextHandle, times,function()

                        end,1)
                    end
                end

                y = y - 30
                _Handle = GUI:Image_Create(_Parent, "爆率", x ,y + 2, "res/public/1900000668.png")
                if _Handle then
                    GUI:setAnchorPoint(_Handle, 0, 0.5)
                end

                _TextHandle = GUI:Text_Create(_Parent, "本局爆率", x + 5, y, 16, "#ffff00","本局额外爆率："..(SL:GetMetaValue("ATT_BY_TYPE", 201)).."%")
                if _TextHandle then
                    GUI:setContentSize(_TextHandle, {width = 230, height = 24 })
                    GUI:setAnchorPoint(_TextHandle, 0, 0.5)
                end
            end
        end

        local _ImgHandle = GUI:Image_Create(_GUIHandle, "货币底框",0 , -35, "res/public/icon_paihangbang_05.png")
        if _ImgHandle then
            GUI:setContentSize(_ImgHandle,400,  34)
            --local _TextHandle = GUI:Text_Create(_ImgHandle, "仓库金币", 10, 17, 16, "#ffff00","仓库金币："..(SL:GetMetaValue("MONEY",  1)+SL:GetMetaValue("MONEY",  3)) )
            --if _TextHandle then
            --    GUI:setContentSize(_TextHandle, {width = 230, height = 24 })
            --    GUI:setAnchorPoint(_TextHandle, 0, 0.5)
            --end

            local _TextHandle = GUI:Text_Create(_ImgHandle, "元宝", 30, 17, 16, "#ffff00","元宝："..SL:GetMetaValue("MONEY",  2) )
            if _TextHandle then
                GUI:setContentSize(_TextHandle, {width = 230, height = 24 })
                GUI:setAnchorPoint(_TextHandle, 0, 0.5)
            end
        end
    end
end
--左侧属性栏
function TopIcon.InitTopGold()
    SL:Print("初始化左侧属性栏")
    local _GUIHandle = GUI:Win_FindParent(101)
    if _GUIHandle then
        GUI:removeAllChildren(_GUIHandle)
        SL:Print("初始化左侧属性栏")

    end
end

SL:RegisterLUAEvent(LUA_EVENT_AFKBEGIN, "顶部图标-开始挂机", function()
    local _GUIHandle = GUI:Win_FindParent(107 )
    local _Handle = GUI:GetWindow(_GUIHandle,"icon/自动挂机")
    if _Handle then
        GUI:setVisible(_Handle,false)
    end

    _Handle = GUI:GetWindow(_GUIHandle,"icon/开始挂机")
    if _Handle then
        GUI:setVisible(_Handle,true)
    end
end)

SL:RegisterLUAEvent(LUA_EVENT_AFKEND, "顶部图标-结束挂机", function()
    local _GUIHandle = GUI:Win_FindParent(107)
    local _Handle = GUI:GetWindow(_GUIHandle,"icon/自动挂机")
    if _Handle then
        GUI:setVisible(_Handle,true)
    end

    _Handle = GUI:GetWindow(_GUIHandle,"icon/开始挂机")
    if _Handle then
        GUI:setVisible(_Handle,false)
    end
end)

SL:RegisterLUAEvent(LUA_EVENT_MAINBUFFUPDATE, "buff改变", function(table)
     if table.buffID == 20015  then
         --SL:PrintTable(table)
         TopIcon.fuHuo()
     end
end)

--玩家属性变化时
SL:RegisterLUAEvent('LUA_EVENT_ROLE_PROPERTY_CHANGE', "顶部图标-属性变化", function()
    TopIcon.topInit()
    ---TopIcon.update()
    --TopIcon.topInit()TopIcon.update()
end)

SL:RegisterLUAEvent('LUA_EVENT_SERVER_VALUE_CHANGE', "顶部图标-服务器变量变化", function(data)
    ---SL:release_print("顶部图标  进入服务器变量改变："..SL:JsonEncode(data))
    if SL:GetMetaValue("CURRENT_OPERMODE") == 1 then
        if data.key == "{54}" then
            local _GUIHandle = GUI:Win_FindParent(107 )
            if _GUIHandle then
                local _Handle = GUI:GetWindow(_GUIHandle,"icon/巡航/effect")
                if _Handle then
                    if data.value == "1" then
                        GUI:setVisible(_Handle,true)
                    else
                        GUI:setVisible(_Handle,false)
                    end
                end
            end
        end

    end
end )

Message.RegisterClickMsg("右上图标", TopIcon)

