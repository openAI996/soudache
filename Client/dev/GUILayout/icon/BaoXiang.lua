baoXiang = {}
baoXiang.Name = "baoXiangFrame"

function baoXiang.receiveMessage(msgData)
    baoXiang.give = msgData.give
    baoXiang.num = msgData.num
    baoXiang.main()
end

function baoXiang.main()
    local _GUIHandle = GUI:GetWindow(nil,baoXiang.Name)
    if _GUIHandle ~= nil then
        GUI:Win_Close(_GUIHandle)
        return ""
    end

    local _Parent = GUI:Win_Create(baoXiang.Name, 0,0 , screen_W, screen_H, true, false, true, true)
    if _Parent then
        GUI:Win_SetMainHide(_Parent,false)
        GUI:Win_SetZPanel(_Parent)
        GUI:Win_SetESCClose(_Parent,true)
        GUI:Win_SetSwallowRightMouseTouch(_Parent, true)
    end

    local _ImgHandle = GUI:Layout_Create(_Parent, "mask", 0, 0,screen_W,screen_H)
    if _ImgHandle then
        GUI:setTouchEnabled(_ImgHandle  , true)
        GUI:Layout_setBackGroundColorType(_ImgHandle, 1)
        GUI:Layout_setBackGroundColor(_ImgHandle, "#000000")
        GUI:setOpacity(_ImgHandle, 150 )
        --GUI:addOnClickEvent(_ImgHandle, function()
        --    baoXiang.close()
        --end)
    end

    GUI:LoadExport(_ImgHandle,"icon/BaoXiangUI.lua")
    local pos = {}
    _GUIHandle = GUI:GetWindow(_ImgHandle,"bgk")
    if _GUIHandle then
        pos = GUI:getContentSize(_GUIHandle)
        GUI:setAnchorPoint(_GUIHandle,0.5,0.5)
        GUI:setPosition(_GUIHandle,screen_W/2,screen_H/2)
    end

    local _Handle = GUI:GetWindow(_GUIHandle,"close")
    if _Handle then
        GUI:addOnClickEvent(_Handle, function()
            baoXiang.close()
        end)
    end

    baoXiang.update()
end

function baoXiang.update()
    local isWin32 = SL:GetMetaValue("WINPLAYMODE")
    local pos,_GUIHandle,_Handle = {},nil,nil
    local _Parent = GUI:GetWindow(nil,baoXiang.Name.."/mask/bgk")
    if _Parent then
        for i=1,#baoXiang.give do
            _GUIHandle = GUI:GetWindow(_Parent,"zhuan/Image_"..i)
            if _GUIHandle then
                pos = GUI:getContentSize(_GUIHandle)
                local item_data = {}
                item_data.index = SL:GetMetaValue("ITEM_INDEX_BY_NAME", baoXiang.give[i][1])
                item_data.look  = true
                item_data.bgVisible = false
                item_data.count = baoXiang.give[i][2]
                item_data.color = 250
                item_data.noMouseTips = false

                local _itemHandle = CL:ItemShow_Create(_GUIHandle, "item", pos.width/2, pos.height/2,0,0, item_data)
                if _itemHandle  then
                    GUI:setTouchEnabled(_itemHandle,true)
                end
            end
        end

        _Handle = GUI:GetWindow(_Parent,"Button")
        if _Handle then
            GUI:addOnClickEvent(_Handle, function()
                SL:SubmitForm("宝箱_click")
            end)
        end
    end
end

---播放转动动画
function baoXiang.playRotate(param)
    local totalItems = 16

    param = param + math.random(2,3) * (totalItems + 1)

    local _Parent = GUI:GetWindow(nil,baoXiang.Name.."/mask/bgk/zhuan")
    if _Parent then
        local _GUIHandle = nil
        for i=1,#baoXiang.give do
            _GUIHandle = GUI:GetWindow(_Parent,"zhuan/Image_"..i.."/Effect_1")
            if _GUIHandle then
                GUI:setVisible(_GUIHandle, false)
            end
        end

        local currentIndex = 0
        local timePoint = 0
        local minDelay = 0.01
        local maxDelay = 0.1
        for i=1,param do
            local nextIndex = currentIndex + 1
            if nextIndex > totalItems then
                nextIndex = 0
            end

            local now = nextIndex - 1
            if nextIndex == 1 then
                now = totalItems
            end

            _GUIHandle = GUI:GetWindow(_Parent,"Image_"..nextIndex.."/Effect_1")
            if _GUIHandle then
                local t = i / param
                local factor = t * t
                local delay = minDelay + (maxDelay - minDelay) * factor
                timePoint = timePoint + delay

                GUI:runAction(_GUIHandle,
                        GUI:ActionSequence(
                                GUI:DelayTime(timePoint),
                                GUI:CallFunc(
                                        function(_GUIHandle)
                                            GUI:setVisible(_GUIHandle, true)
                                            ---SL:Print("上一个控件："..now, "当前控件："..nextIndex)
                                            ---if i < param then
                                                local _Handle = GUI:GetWindow(nil,baoXiang.Name.."/mask/bgk/zhuan/Image_"..now.."/Effect_1")
                                                if _Handle then
                                                    GUI:setVisible(_Handle, false)
                                                end
                                            ---end
                                            if i == param then
                                                SL:Print("xxxxx结束回传")
                                                SL:SubmitForm("宝箱_give")
                                            end
                                        end
                                )
                        )
                )
            end
            currentIndex = nextIndex
        end
    end
end

function baoXiang.close()
    local _Parent = GUI:GetWindow(nil,baoXiang.Name)
    if _Parent then
        GUI:Win_Close(_Parent)
    end
end

function baoXiang.syncData(msgData)
    baoXiang.data = msgData
    baoXiang.skill = msgData.skill
    baoXiang.effect = 0
    baoXiang.page = 0
    baoXiang.update()
end

Message.RegisterClickMsg("宝箱", baoXiang)