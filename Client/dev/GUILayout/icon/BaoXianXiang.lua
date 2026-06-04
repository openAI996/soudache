anQuanXiang = {}
anQuanXiang.Name = "anQuanXiangFrame"
anQuanXiang.no = {
    ["天纵钥匙碎片"] = 1,
    ["天纵钥匙"] = 1,
    ["沃玛套装卷轴(1级)"] = 1,
    ["祖玛套装卷轴(2级)"] = 1,
    ["赤月套装卷轴(3级)"] = 1,
    --["魔血石(1级)"] = 1,
    --["魔血石(2级)"] = 1,
    --["魔血石(3级)"] = 1,
    --["魔血石(4级)"] = 1,
    --["魔血石(5级)"] = 1,
}

function anQuanXiang.receiveMessage(msgData)
    anQuanXiang.data = msgData
    anQuanXiang.item = {}
    anQuanXiang.num = {}
    for i=1,#anQuanXiang.data.var do
        anQuanXiang.item[i] = anQuanXiang.data.var[i][1]
        anQuanXiang.num[i] = anQuanXiang.data.var[i][4]
    end
    anQuanXiang.page = 0
    anQuanXiang.bagShow = 0
    --SL:PrintTable(SL:GetMetaValue("BAG_DATA"))
    --SL:PrintTable(SL:GetMetaValue("QUICKUSE_DATA"))
    anQuanXiang.main()
end

function anQuanXiang.main()
    --local bag = SL:GetMetaValue("BAG_DATA")
    --for k, v in pairs(bag) do
    --    SL:IntoDropBagItem(v)
    --end
    ---SL:IntoDropBagItem(itemData)

    local num = anQuanXiang.data.num
    local _GUIHandle = GUI:GetWindow(Bag.Table.Panel,"list")
    if _GUIHandle then
        GUI:removeAllChildren(_GUIHandle)
        local max = 8
        if max < num then
            max = num
        end

        for i=1,max do
            local item_bg_1 = GUI:Image_Create(_GUIHandle, "item_bg_"..i, 0, 7, "res/public/1900000651.png")
            GUI:setContentSize(item_bg_1, 50, 50)
            GUI:setIgnoreContentAdaptWithSize(item_bg_1, false)
            GUI:setAnchorPoint(item_bg_1, 0.00, 0.00)
            GUI:setTouchEnabled(item_bg_1, false)
            GUI:setTag(item_bg_1, 0)

            if i > num then
                local lock = GUI:Image_Create(item_bg_1, "lock", 25, 25, "res/public/icon_tyzys_01.png")
                GUI:setAnchorPoint(lock, 0.50, 0.50)
            else
                if anQuanXiang.item[i] == 0 then
                    local add = GUI:Button_Create(item_bg_1, "add", 25, 25, "res/public/add.png")
                    GUI:setAnchorPoint(add, 0.50, 0.50)
                    GUI:setTouchEnabled(add, true)
                    GUI:setTag(add, 0)
                    GUI:addOnClickEvent(add, function()
                        ---SL:Print("点击了添加",SL:GetMetaValue("MAP_ID"))
                        if SL:GetMetaValue("MAP_ID") == "3" then
                            SL:ShowSystemTips("当前地图不可存入！！")
                            return ""
                        end
                        anQuanXiang.bagShow = i
                        anQuanXiang.page = 0
                        anQuanXiang.ShowBagUI()
                    end)
                else
                    local _itemHandle = GUI:ItemShow_Create(item_bg_1, "item", 25, 25, {index = SL:GetMetaValue("ITEM_INDEX_BY_NAME", anQuanXiang.item[i]) , count = anQuanXiang.data.var[i][4], look = true, bgVisible = false})
                    if _itemHandle  then
                        GUI:setTouchEnabled(_itemHandle, true)
                        GUI:setAnchorPoint(_itemHandle, 0.50, 0.50)
                        GUI:ItemShow_addDoubleEvent(_itemHandle,function()
                            SL:SubmitForm("安全箱_change",i)
                        end)
                    end
                end
            end
        end
    end

    if anQuanXiang.bagShow > 0 then
        anQuanXiang.bagShow = 0
        anQuanXiang.ShowBagUI()
    else
        local _Handle = GUI:GetWindow(Bag.Table.Panel,"bag")
        if _Handle then
            GUI:removeFromParent(_Handle)
        end
    end
end

function anQuanXiang.update()
    local num = anQuanXiang.data.num
    local _GUIHandle = GUI:GetWindow(Bag.Table.Panel,"list")
    if _GUIHandle then
        local max = 8
        if max < num then
            max = num
        end

        for i=1,max do
            local item_bg_1 = GUI:GetWindow(_GUIHandle,"item_bg_"..i)
            if item_bg_1 then
                GUI:removeAllChildren(item_bg_1)

                if i > num then
                    local lock = GUI:Image_Create(item_bg_1, "lock", 25, 25, "res/public/icon_tyzys_01.png")
                    GUI:setAnchorPoint(lock, 0.50, 0.50)
                else
                    if anQuanXiang.item[i] == 0 then
                        local add = GUI:Button_Create(item_bg_1, "add", 25, 25, "res/public/add.png")
                        GUI:setAnchorPoint(add, 0.50, 0.50)
                        GUI:setTouchEnabled(add, true)
                        GUI:setTag(add, 0)
                        GUI:addOnClickEvent(add, function()
                            anQuanXiang.bagShow = i
                            anQuanXiang.page = 0
                            anQuanXiang.ShowBagUI()
                        end)
                    else
                        local _itemHandle = GUI:ItemShow_Create(item_bg_1, "item", 25, 25, {index = SL:GetMetaValue("ITEM_INDEX_BY_NAME", anQuanXiang.item[i]) , count = anQuanXiang.num[i], look = true, bgVisible = false})
                        if _itemHandle  then
                            GUI:setTouchEnabled(_itemHandle, true)
                            GUI:setAnchorPoint(_itemHandle, 0.50, 0.50)
                            GUI:ItemShow_addDoubleEvent(_itemHandle,function()
                                SL:SubmitForm("安全箱_change",i)
                            end)
                        end
                    end
                end
            end
        end

        if anQuanXiang.bagShow > 0 then
            anQuanXiang.bagShow = 0
            anQuanXiang.ShowBagUI()
        else
            local _Handle = GUI:GetWindow(Bag.Table.Panel,"bag")
            if _Handle then
                GUI:removeFromParent(_Handle)
            end
        end
    end
end

------展示背包内容
function anQuanXiang.ShowBagUI()
    local _Parent = Bag.Table.Panel
    if _Parent then
        local pos = GUI:getContentSize(_Parent)
        local _GUIHandle = GUI:GetWindow(_Parent,"bag")
        if _GUIHandle then
            GUI:removeFromParent(_GUIHandle)
        end

        GUI:LoadExport(_Parent,"icon/XuanZheUI.lua")

        _GUIHandle = GUI:GetWindow(_Parent,"bag")
        if _GUIHandle then
            GUI:setAnchorPoint(_GUIHandle,0.5,0.5)
            GUI:setPosition(_GUIHandle,pos.width/2,pos.height/2)
            GUI:addOnClickEvent(_GUIHandle, function()
                anQuanXiang.bagShow = 0
                anQuanXiang.main()
            end )
        end

        local itemData = anQuanXiang.getBagData()
        local _Handle = GUI:GetWindow(_Parent,"bag/close")
        if _Handle then
            GUI:addOnClickEvent(_Handle, function()
                anQuanXiang.bagShow = 0
                anQuanXiang.main()
            end )
        end

        _GUIHandle = GUI:GetWindow(_Parent,"bag/Layout")
        if _GUIHandle then
            GUI:removeAllChildren(_GUIHandle)
            local Layout = GUI:Layout_Create(_GUIHandle, "bag_Layout", 0,0, 300, math.ceil(#itemData/5)*70, false)
            if Layout then
                GUI:setAnchorPoint(Layout, 0, 0)
                GUI:setTouchEnabled(Layout, false)

                GUI:setTag(Layout, 0)
                for i = 1,#itemData do
                    local x,y = 15 + (i-1)%5*75, math.ceil(#itemData/5)*70 - math.floor((i-1)/5)*70 - 70
                    _Handle = GUI:Image_Create(Layout, "bag_"..i, x, y, "res/public/item.png")
                    GUI:setTouchEnabled(_Handle, false)
                    GUI:setTag(_Handle, 0)

                    pos = GUI:getContentSize(_Handle)
                    local _itemHandle = GUI:ItemShow_Create(_Handle, "item", pos.width/2, pos.height/2, {itemData = itemData[i], index = itemData[i].Index,look=true, disShowCount = false, notShowEquipRedMask = true})
                    if _itemHandle  then
                        GUI:setTouchEnabled(_itemHandle,true)
                        GUI:setAnchorPoint(_itemHandle, 0.50, 0.50)
                        pos = GUI:getContentSize(_itemHandle)
                        if anQuanXiang.page == i  then
                            _Handle = GUI:Image_Create(_itemHandle, "check", pos.width/2, pos.height/2, "res/public/1900000678_2.png")
                            if _Handle then
                                GUI:setAnchorPoint(_Handle, 0.50, 0.50)
                            end
                        end

                        GUI:addOnClickEvent(_itemHandle,function()
                            _Handle = GUI:GetWindow(_Parent,"bag/Layout/bag_Layout/bag_"..anQuanXiang.page.."/item/check")
                            if _Handle then
                                GUI:removeFromParent(_Handle)
                            end

                            _Handle = GUI:GetWindow(_Parent,"bag/Layout/bag_Layout/bag_"..i.."/item")
                            if _Handle then
                                pos = GUI:getContentSize(_Handle)
                                local check = GUI:Image_Create(_Handle, "check", pos.width/2, pos.height/2, "res/public/1900000678_2.png")
                                if check then
                                    GUI:setAnchorPoint(check, 0.50, 0.50)
                                end
                            end

                            anQuanXiang.page = i
                        end)

                        GUI:ItemShow_addDoubleEvent(_itemHandle,function()
                            _Handle = GUI:GetWindow(_Parent,"bag/Layout/bag_Layout/bag_"..anQuanXiang.page.."/item/check")
                            if _Handle then
                                GUI:removeFromParent(_Handle)
                            end

                            _Handle = GUI:GetWindow(_Parent,"bag/Layout/bag_Layout/bag_"..i.."/item")
                            if _Handle then
                                pos = GUI:getContentSize(_Handle)
                                local check = GUI:Image_Create(_Handle, "check", pos.width/2, pos.height/2, "res/public/1900000678_2.png")
                                if check then
                                    GUI:setAnchorPoint(check, 0.50, 0.50)
                                end
                            end

                            anQuanXiang.page = i
                        end)
                    end
                end
            end
        end

        _Handle = GUI:GetWindow(_Parent,"bag/button")
        if _Handle then
            GUI:addOnClickEvent(_Handle, function()
                if anQuanXiang.page == 0 then
                    SL:ShowSystemTips("请选择道具！！")
                    return ""
                end

                if anQuanXiang.no[itemData[anQuanXiang.page].Name] ~= nil then
                    SL:ShowSystemTips("该道具无法放入安全箱！！")
                    return ""
                end

                anQuanXiang.item[anQuanXiang.bagShow] = itemData[anQuanXiang.page].Name
                anQuanXiang.num[anQuanXiang.bagShow] = itemData[anQuanXiang.page].OverLap
                SL:SubmitForm("安全箱_click",itemData[anQuanXiang.page].MakeIndex,anQuanXiang.bagShow)
                anQuanXiang.page = 0
                anQuanXiang.bagShow = 0
                anQuanXiang.update()
            end)
        end
    end
end

function anQuanXiang.getBagData()
    local data = {}
    local bag = SL:GetMetaValue("BAG_DATA")

    for k, v in pairs(bag) do
        if anQuanXiang.no[v.Name] == nil then
            table.insert(data, v)
        end
    end

    bag = SL:GetMetaValue("QUICKUSE_DATA")
    for k, v in pairs(bag) do
        if anQuanXiang.no[v.Name] == nil then
            table.insert(data, v)
        end
    end
    return data
end

function anQuanXiang.syncData(msgData)
    anQuanXiang.data = msgData
    anQuanXiang.item = {}
    for i=1,#anQuanXiang.data.var do
        anQuanXiang.item[i] = anQuanXiang.data.var[i][1]
    end
    anQuanXiang.update()
end


Message.RegisterClickMsg("安全箱", anQuanXiang)