buyZhuangBei = {}
buyZhuangBei.Name = "buyZhuangBeiFrame"
buyZhuangBei.configCache =  SL:Require("GUILayout/cfgcsv/cfg_BuyZhuangBei",true)
buyZhuangBei.config = {}

for k, sceneConfig in pairs(buyZhuangBei.configCache) do
    if type(k) == "number" then
        local currentTable = buyZhuangBei.config
        for num, typeValue in ipairs(sceneConfig.type) do

            if not currentTable[typeValue] then
                currentTable[typeValue] = {}
            end
            
            currentTable = currentTable[typeValue]
        end


        if sceneConfig.item then
            currentTable.item = sceneConfig.item
        end

        currentTable.num = k

        if sceneConfig.buy then
            currentTable.buy = sceneConfig.buy
        end
    end
end

function buyZhuangBei.receiveMessage(msgData)
    buyZhuangBei.var = msgData.var
    buyZhuangBei.page = 1
    buyZhuangBei.sign = 1
    buyZhuangBei.main()
end

function buyZhuangBei.main()
    local _GUIHandle = GUI:GetWindow(nil,buyZhuangBei.Name)
    if _GUIHandle ~= nil then
        GUI:Win_Close(_GUIHandle)
        return ""
    end

    local _Parent = GUI:Win_Create(buyZhuangBei.Name, 0,0 , screen_W, screen_H, true, false, true, true)
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
            buyZhuangBei.close()
        end)
    end

    GUI:LoadExport(_ImgHandle,"icon/BuyUI.lua")

    _GUIHandle = GUI:GetWindow(_ImgHandle,"bag")
    if _GUIHandle then
        GUI:setAnchorPoint(_GUIHandle,0.5,0.5)
        GUI:setPosition(_GUIHandle,screen_W/2,screen_H/2)
    end

    local _Handle = GUI:GetWindow(_GUIHandle,"close")
    if _Handle then
        GUI:addOnClickEvent(_Handle, function()
            buyZhuangBei.close()
        end)
    end

    buyZhuangBei.update()
end

function buyZhuangBei.update()
    local _GUIHandle,_Handle,x,y = nil,nil,0,0
    local _Parent = GUI:GetWindow(nil,buyZhuangBei.Name.."/mask/bag")
    if _Parent then
        local page,sign = buyZhuangBei.page,buyZhuangBei.sign
        local maxPage = math.ceil(#buyZhuangBei.config[page]/4)
        for i=1,#buyZhuangBei.config do
            _Handle = GUI:GetWindow(_Parent,"Panel_1/Button_"..i)
            if _Handle then
                if page == i then
                    GUI:Button_setGrey( _Handle, false)
                else
                    GUI:Button_setGrey( _Handle, true)
                end
                --
                GUI:addOnClickEvent(_Handle, function()
                    buyZhuangBei.page = i
                    buyZhuangBei.sign = 1
                    buyZhuangBei.update()
                end )
            end
        end

        _GUIHandle = GUI:GetWindow(_Parent,"Layout")
        if _GUIHandle then
            GUI:removeAllChildren(_GUIHandle)
            local flag,txt = 0,""
            for i=1,4 do
                flag = (buyZhuangBei.sign - 1)*4 + i
                ---SL:PrintTable(buyZhuangBei.config[page][flag])
                if flag <= #buyZhuangBei.config[page] then
                    txt = buyZhuangBei.config[page][flag].item
                    _Handle = GUI:Image_Create(_GUIHandle, "list_"..i, 319, 292, "res/public/icon_paihangbang_05.png")
                    GUI:setAnchorPoint(_Handle, 0.50, 0.50)
                    GUI:setTouchEnabled(_Handle, false)
                    GUI:setContentSize(_Handle, 400, 72)
                    GUI:setTag(_Handle, 0)
                    local item_data = {}
                    item_data.index = SL:GetMetaValue("ITEM_INDEX_BY_NAME", txt)
                    item_data.look  = true
                    item_data.bgVisible = false
                    item_data.count = 1
                    item_data.color = 250
                    item_data.noMouseTips = false

                    local _ImgHandle = GUI:Image_Create(_Handle, "item_bg",10,4, "res/public/1900000651.png")
                    if _ImgHandle ~= nil then

                    end

                    local pos = GUI:getContentSize(_ImgHandle)
                    local _itemHandle = CL:ItemShow_Create(_ImgHandle, "item", pos.width/2, pos.height/2,0,0, item_data)
                    if _itemHandle  then
                        GUI:setTouchEnabled(_itemHandle,true)
                    end

                    local ScrollText_1 = GUI:ScrollText_Create(_Handle, "name_"..i, 140, 30, 100, 18, "#00fc15", txt, 6)
                    GUI:ScrollText_enableOutline(ScrollText_1, "#000000", 1)
                    GUI:ScrollText_setHorizontalAlignment(ScrollText_1, 0)
                    GUI:setAnchorPoint(ScrollText_1, 0.50, 0.50)
                    GUI:setTouchEnabled(ScrollText_1, true)
                    GUI:setTag(ScrollText_1, 0)

                    local num = CL:ItemCount("金币")
                    local color = "#fffff"
                    if num < buyZhuangBei.config[page][flag].buy[2] then
                        color = "#ff0008"
                    end
                    txt = GUI:Text_Create(_Handle, "xh", 245, 30, 16, color, "价格:"..buyZhuangBei.config[page][flag].buy[2]..""..buyZhuangBei.config[page][flag].buy[1])
                    if txt then
                        GUI:setAnchorPoint(txt, 0.5, 0.5)
                    end

                    local button = GUI:Button_Create(_Handle, "button"..i, 350 , 30, "res/public/1900000679.png")
                    GUI:setAnchorPoint(button, 0.50, 0.5)
                    GUI:setTouchEnabled(button, true)
                    GUI:Button_setTitleFontSize(button, 18)
                    GUI:Button_setTitleText(button, "购  买")
                    GUI:addOnClickEvent(button, function()
                        SL:SubmitForm("买道具_click",buyZhuangBei.config[page][(buyZhuangBei.sign - 1)*4 + i].num)
                    end )
                end
            end
        end

        _Handle = GUI:GetWindow(_Parent,"right")
        if _Handle then
            GUI:addOnClickEvent(_Handle, function()
                if buyZhuangBei.sign >= maxPage then
                    SL:ShowSystemTips("已经是最后一页了！！！")
                    return ""
                end
                buyZhuangBei.sign = buyZhuangBei.sign + 1
                buyZhuangBei.update()
            end )
        end

        _Handle = GUI:GetWindow(_Parent,"left")
        if _Handle then
            GUI:addOnClickEvent(_Handle, function()
                if buyZhuangBei.sign <= 1 then
                    SL:ShowSystemTips("已经是第一页了！！！")
                    return ""
                end
                buyZhuangBei.sign = buyZhuangBei.sign - 1
                buyZhuangBei.update()
            end )
        end

        _Handle = GUI:GetWindow(_Parent,"page")
        if _Handle then
            GUI:Text_setString(_Handle, sign.."/"..maxPage)
        end
    end
end

function buyZhuangBei.close()
    local _Parent = GUI:GetWindow(nil,buyZhuangBei.Name)
    if _Parent then
        GUI:Win_Close(_Parent)
    end
end

function buyZhuangBei.syncData(msgData)
    buyZhuangBei.change()
end

Message.RegisterClickMsg("买道具", buyZhuangBei)




