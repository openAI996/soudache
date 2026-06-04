Awards = {}
Awards.RowMaxCount = 10

local _GUIHandle = 0
local _OffsetX, _OffsetY = 0, 0
local _DeviceSizeX, _DeviceSizeY = SL:GetMetaValue("SCREEN_WIDTH"), SL:GetMetaValue("SCREEN_HEIGHT")
function Awards.OnClose(this)
    _GUIHandle = GUI:GetWindow(nil, "AwardsWindow")
    if nil ~= _GUIHandle then
        GUI:Win_Close(_GUIHandle)
    end
end

function Awards.main(tb)
    _GUIHandle = GUI:GetWindow(nil, "AwardsWindow")
    if nil ~= _GUIHandle then
        GUI:Win_Close(_GUIHandle)
        --return
    end

    Awards.Config = tb

    if Awards.Config == nil then
        GUI:Win_Close(_GUIHandle)
        return
    end
  
    local _Parent = GUI:Win_Create("AwardsWindow", _OffsetX, _OffsetY, _DeviceSizeX, _DeviceSizeY, true, false, true, true, true, Awards.NPC)
    if nil ~= _Parent then
        GUI:setLocalZOrder(_Parent, 999)

        _GUIHandle = GUI:Layout_Create(_Parent, "背景容器", 0, 0, _DeviceSizeX, _DeviceSizeY)
        if nil ~= _GUIHandle then
            GUI:setTouchEnabled(_GUIHandle, true)
            GUI:Layout_setBackGroundColorType(_GUIHandle, 1)
            GUI:Layout_setBackGroundColor(_GUIHandle, "#000000")
            GUI:Layout_setBackGroundColorOpacity(_GUIHandle, 160)
            GUI:addOnClickEvent(_GUIHandle, Awards.OnClose)
        end
        
        _GUIHandle = GUI:Image_Create(_Parent, "背景", _DeviceSizeX / 2, _DeviceSizeY / 2, "res/public/all/gx.png")
        if _GUIHandle then
            GUI:setAnchorPoint(_GUIHandle, 0.5, 0.5)
            GUI:runAction(_GUIHandle,
                    GUI:ActionSequence(
                            GUI:ActionScaleTo(0.01, 0.5),
                            GUI:ActionScaleTo(0.25, 1)
                    )
            )
        end

        local originalTable = SL:CopyData(tb)
        local resultTables = {}
        local remainder = #originalTable % 5
        local firstTable = {}

        -- 创建第一个表，存储余数个元素
        for i = 1, remainder do
            table.insert(firstTable, originalTable[i])
        end
        table.insert(resultTables, firstTable)

        -- 创建其他表，每个表存储 5 个元素
        local index = remainder
        while index < #originalTable do
            local subTable = {}
            for j = 1, 5 do
                if originalTable[index + j] then
                    table.insert(subTable, originalTable[index + j])
                end
            end
            table.insert(resultTables, subTable)
            index = index + 5
        end
        local y = _DeviceSizeY / 2
        y = y + (#resultTables-1) * 83/2
        for i=1,#resultTables do
            local _MainParent = GUI:Layout_Create(_Parent, "展示容器"..i, _DeviceSizeX / 2,  y - (i-1)*83, 600, 184)
            if nil ~= _MainParent then
                GUI:setAnchorPoint(_MainParent, 0.5, 0.5)
                --GUI:Layout_setBackGroundColorType(_MainParent, 1)
                --GUI:Layout_setBackGroundColor(_MainParent, "#00FF00")
                --GUI:Layout_setBackGroundColorOpacity(_MainParent, 120)

                for j = 1,#resultTables[i] do
                    SL:PrintTable(Awards.Config[j][1],Awards.Config[j][2])
                    local item_data = {}
                    item_data.index = SL:GetMetaValue("ITEM_INDEX_BY_NAME",Awards.Config[j][1])
                    item_data.look  = true
                    item_data.bgVisible = false
                    item_data.count = Awards.Config[j][2]
                    item_data.color = 250
                    item_data.noMouseTips = false
                    item_data.itemScale = 0.5
                    local _Handle = GUI:Image_Create(_MainParent, "scroll_down_item_bgk_"..j,0,0 , "res/public/item.png")
                    if _Handle ~= nil then

                    end

                    local pos = GUI:getContentSize(_Handle)

                    local _EffectHandle = GUI:Effect_Create(_Handle, "effect", -22, 99, 0, 62073, 0, 0, 0, 1)
                    if _EffectHandle then
                        GUI:setScale(_EffectHandle, 1)
                        --GUI:setAnchorPoint(_EffectHandle,1,1)
                    end

                    local _itemHandle = GUI:ItemShow_Create(_Handle, "item", pos.width/2, pos.height/2, item_data)
                    if _itemHandle  then
                        GUI:setAnchorPoint(_itemHandle,0.5,0.5)
                    end
                end

                GUI:UserUILayout(_MainParent,
                        {
                            dir = 2,
                            addDir = 2,
                            interval = 0.75,
                            autosize = true,
                            colnum = 2,
                            interval = 0.3,
                            gap = {
                                x = 5,
                                y = 5,
                                l = 5,
                                t = 5,
                            },
                        }
                )
            end
        end
        _GUIHandle = GUI:Text_Create(_Parent, "关闭提示", _DeviceSizeX / 2, 80, 24, "#00FF00", "点击屏幕任意位置即可关闭此界面")
        if _GUIHandle then
            GUI:setAnchorPoint(_GUIHandle, 0.5, 0.5)
            GUI:runAction(_GUIHandle,
                    GUI:ActionSequence(
                            GUI:ActionScaleTo(0.01, 0.5),
                            GUI:ActionScaleTo(0.25, 1)
                    )
            )
        end

        Awards.OnInit(_Parent)
    end
end

function Awards.OnInit(_Parent)
    SL:RegisterWndEvent(_Parent, "AwardsWindow", WND_EVENT_WND_DESTROY, Awards.OnDestroy)
    Awards.WndHandle = _Parent

    GUI:Timeline_DelayTime(_Parent, 3, function()
        Awards.OnClose()
    end)
end

function Awards.OnDestroy(_Parent)
    --Awards = nil
end

Message.RegisterClickMsg("Awaeds", Awards)


