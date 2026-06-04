daKunSheng = {}
daKunSheng.Name = "daKunShengFrame"

function daKunSheng.receiveMessage(msgData)
    daKunSheng.data = msgData
    daKunSheng.page = 1
    daKunSheng.main()
end

function daKunSheng.main()
    local _GUIHandle = GUI:GetWindow(nil,daKunSheng.Name)
    if _GUIHandle ~= nil then
        GUI:Win_Close(_GUIHandle)
        return ""
    end

    local _Parent = GUI:Win_Create(daKunSheng.Name, 0,0 , screen_W, screen_H, true, false, true, true)
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
        GUI:Layout_setBackGroundColor(_ImgHandle, "#1f1f1f")
        GUI:setOpacity(_ImgHandle, 150)
        GUI:addOnClickEvent(_ImgHandle, function()
            daKunSheng.close()
        end)
    end

    GUI:LoadExport(_ImgHandle,"icon/DaKunShenUI.lua")

    _GUIHandle = GUI:GetWindow(_ImgHandle,"bgk")
    if _GUIHandle then
        GUI:setAnchorPoint(_GUIHandle,0.5,0.5)
        GUI:setPosition(_GUIHandle,screen_W/2,screen_H/2)
    end

    local _Handle = GUI:GetWindow(_GUIHandle,"close")
    if _Handle then
        GUI:addOnClickEvent(_Handle, function()
            daKunSheng.close()
        end)
    end

    local config = daKunSheng.data.config
   _Parent = GUI:GetWindow(nil,daKunSheng.Name.."/mask/bgk")
    if _Parent then
        _GUIHandle = GUI:GetWindow(_Parent,"list")
        if _GUIHandle then
            GUI:removeAllChildren(_GUIHandle)
            for i=1,#config do
                _Handle = GUI:Layout_Create(_GUIHandle, "Panel_"..i, 0, 4, 118, 148, false)
                if _Handle then
                    GUI:setAnchorPoint(_Handle, 0.00, 0.00)
                    GUI:setTouchEnabled(_Handle, false)
                    GUI:setTag(_Handle, 0)
                end
            end
        end
    end

    daKunSheng.update()
end

function daKunSheng.update()
    local _GUIHandle,_Handle,x,y = nil,nil,0,0
    local config = daKunSheng.data.config
    local var = daKunSheng.getData()
    local _Parent = GUI:GetWindow(nil,daKunSheng.Name.."/mask/bgk")
    if _Parent then
        _GUIHandle = GUI:GetWindow(_Parent,"list")
        if _GUIHandle then
            for i=1,#config do
                _Handle = GUI:GetWindow(_GUIHandle, "Panel_"..i)
                if _Handle then
                    GUI:removeAllChildren(_Handle)
                    local button = GUI:Button_Create(_Handle, "button", 57, 23, "res/public/1900000653.png")
                    GUI:setContentSize(button, 82, 29)
                    GUI:setIgnoreContentAdaptWithSize(button, false)
                    GUI:Button_setTitleText(button, [[打 捆]])
                    GUI:Button_setTitleColor(button, "#FFFFFF")
                    GUI:Button_setTitleFontSize(button, 18)
                    GUI:Button_titleEnableOutline(button, "#000000", 1)
                    GUI:setAnchorPoint(button, 0.50, 0.50)
                    GUI:setTouchEnabled(button, true)
                    GUI:setTag(button, 0)
                    GUI:addOnClickEvent(button, function()
                        if var[i] >= config[i].item[2] then
                            SL:SubmitForm("打捆绳_click",i)
                        else
                            SL:ShowSystemTips('物品不足无法打捆')
                        end

                    end )

                    local item = GUI:Image_Create(_Handle, "item", 57, 104, "res/public/1900000651.png")
                    GUI:setAnchorPoint(item, 0.50, 0.50)
                    GUI:setTouchEnabled(item, false)
                    GUI:setTag(item, 0)

                    local item_data = {}
                    item_data.index = SL:GetMetaValue("ITEM_INDEX_BY_NAME", config[i].item[1])
                    item_data.look  = true
                    item_data.bgVisible = false
                    item_data.count = 1
                    item_data.color = 250
                    item_data.noMouseTips = false
                    local pos = GUI:getContentSize(item)
                    local _itemHandle = CL:ItemShow_Create(item, "item", pos.width/2, pos.height/2,0,0, item_data)
                    if _itemHandle  then
                        GUI:setTouchEnabled(_itemHandle,true)
                    end

                    local color = "#FF0000"
                    if var[i] >= config[i].item[2] then
                        color =  "#00ff00"
                    end

                    local txt = GUI:Text_Create(item, "num_"..i, pos.width/2 + 10, 10, 20, color, config[i].item[2])
                    if txt then
                        GUI:Text_enableOutline(txt, "#000000", 2)
                        GUI:setAnchorPoint(txt,0,0.5)
                    end

                    color = "#FF0000"
                    if CL:ItemCount(config[i].need[1]) >= config[i].need[2] then
                        color =  "#00ff00"
                    end

                    local Text_1 = GUI:Text_Create(_Handle, "Text_1", 56, 45, 14, color, "需求："..config[i].need[2]..config[i].need[1])
                    GUI:Text_enableOutline(Text_1, "#000000", 1)
                    GUI:setAnchorPoint(Text_1, 0.50, 0.00)
                    GUI:setTouchEnabled(Text_1, false)
                    GUI:setTag(Text_1, 0)
                end
            end
        end
    end
    daKunSheng.getData()
end

---SL:GetMetaValue("ITEM_IS_BIND", itemData)
function daKunSheng.getData()
    local data = {}
    local bag = SL:GetMetaValue("BAG_DATA")

    for i=1,#daKunSheng.data.config do
        data[i] = 0
    end

    for k, v in pairs(bag) do
        if not SL:GetMetaValue("ITEM_IS_BIND", v) then
            for i=1,#daKunSheng.data.config do
                if v.Name == daKunSheng.data.config[i].item[1] then
                    data[i] = data[i] + 1
                end
            end
        end
    end

    return data
end

function daKunSheng.close()
    local _Parent = GUI:GetWindow(nil,daKunSheng.Name)
    if _Parent then
        GUI:Win_Close(_Parent)
    end
end

function daKunSheng.syncData(msgData)
    daKunSheng.data = msgData
    daKunSheng.update()
end

Message.RegisterClickMsg("打捆绳", daKunSheng)




