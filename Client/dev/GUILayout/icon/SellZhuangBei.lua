sellZhuangBei = {}

sellZhuangBei.Name = "sellZhuangBeiFrame"
sellZhuangBei.config =  SL:Require("GUILayout/cfgcsv/cfg_SellZhuangBei",true)
sellZhuangBei.no = {
    ["魔血石(1级)"] = 1,
    ["魔血石(2级)"] = 1,
    ["魔血石(3级)"] = 1,
    ["魔血石(4级)"] = 1,
    ["魔血石(5级)"] = 1,
    ["魔血石(6级)"] = 1,
}

function sellZhuangBei.receiveMessage(msgData)
    sellZhuangBei.cangKu = msgData
    sellZhuangBei.data = {}
    sellZhuangBei.name = {}
    sellZhuangBei.page = 1
    sellZhuangBei.main()
end

function sellZhuangBei.main()
    local _GUIHandle = GUI:GetWindow(nil,sellZhuangBei.Name)
    if _GUIHandle ~= nil then
        GUI:Win_Close(_GUIHandle)
        return ""
    end

    local _Parent = GUI:Win_Create(sellZhuangBei.Name, 0,0 , screen_W, screen_H, true, false, true, true)
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
            sellZhuangBei.close()
        end)
    end

    GUI:LoadExport(_ImgHandle,"icon/SellUI.lua")

    _GUIHandle = GUI:GetWindow(_ImgHandle,"bgk")
    if _GUIHandle then
        GUI:setAnchorPoint(_GUIHandle,0.5,0.5)
        GUI:setPosition(_GUIHandle,screen_W/2,screen_H/2)
    end

    local _Handle = GUI:GetWindow(_GUIHandle,"close")
    if _Handle then
        GUI:addOnClickEvent(_Handle, function()
            sellZhuangBei.close()
        end)
    end



    sellZhuangBei.update()
end

function sellZhuangBei.update()
    local _Parent = GUI:GetWindow(nil,sellZhuangBei.Name.."/mask/bgk/ListView")
    if _Parent then
        local _Handle,x,y,num = nil,0,0
        local bag = sellZhuangBei.getBag()
        if sellZhuangBei.page == 2 then
            bag = sellZhuangBei.getCangKu()
        end
        local flag = 0
        for k, v in pairs(bag) do
            flag = flag + 1
        end

        local h = math.ceil(flag/5)*70 + 30
        if h < 300 then
            h = 300
        end

        GUI:removeAllChildren(_Parent)
        local list = GUI:Layout_Create(_Parent, "list", 367, 283, 400, h, false)
        GUI:setAnchorPoint(list, 0.50, 0.50)
        GUI:setTouchEnabled(list, false)
        GUI:setTag(list, 0)

        for i=1,4 do
            for j=1,5 do
                num,x,y = (i-1) * 5 + j ,40 + (j-1)*80, h - (i-1)*70 - 70
                _Handle = GUI:Image_Create(list, "bag_"..num, x, y, "res/public/1900000651.png")
                GUI:setAnchorPoint(_Handle, 0.50, 0)
                GUI:setTouchEnabled(_Handle, false)
                GUI:setTag(_Handle, 0)
            end
        end

        flag = 0
        for k, v in pairs(bag) do
            flag = flag + 1
            if flag > 20 then
                x,y = 40 + ((flag-1)%5)*80, h - (math.floor((flag-1)/5))*70 - 80
                _Handle = GUI:Image_Create(list, "bag_"..flag, x, y, "res/public/1900000651.png")
                GUI:setAnchorPoint(_Handle, 0.50, 0)
                GUI:setTouchEnabled(_Handle, false)
                GUI:setTag(_Handle, 0)
            end

            local setData = v
            _Handle = GUI:GetWindow(list, "bag_"..flag)
            local pos = GUI:getContentSize(_Handle)
            local _itemHandle = GUI:ItemShow_Create(_Handle, "item", pos.width/2, pos.height/2, {itemData = setData, index = setData.Index, disShowCount = false, notShowEquipRedMask = true})
            if _itemHandle  then
                GUI:setTouchEnabled(_itemHandle,true)
                GUI:setAnchorPoint(_itemHandle, 0.50, 0.50)
                GUI:ItemShow_addReplaceClickEvent(_itemHandle,function()
                    if sellZhuangBei.data[tostring(k)] ~= nil then
                        sellZhuangBei.data[tostring(k)] = nil
                        GUI:ItemShow_setItemShowChooseState(_itemHandle, false)
                    else
                        sellZhuangBei.data[tostring(k)] = v
                        GUI:ItemShow_setItemShowChooseState(_itemHandle, true)
                    end
                end)

                GUI:addOnClickEvent(_itemHandle,function()
                    local count = v.OverLap
                    if sellZhuangBei.data[tostring(k)] ~= nil then
                        sellZhuangBei.data[tostring(k)] = nil
                        --if sellZhuangBei.name[setData.Name] == count then
                        --    sellZhuangBei.name[setData.Name] = nil
                        --else
                        --    sellZhuangBei.name[setData.Name] = sellZhuangBei.name[setData.Name] - count
                        --end

                        GUI:ItemShow_setItemShowChooseState(_itemHandle, false)

                        local _GUIHandle = GUI:GetWindow(nil,sellZhuangBei.Name.."/mask/bgk/jiage")
                        if _GUIHandle  then
                            local txt = "回收金币："
                            num = 0
                            for k1, v1 in pairs(sellZhuangBei.data) do
                                local value = SL:GetMetaValue("ITEM_CUSTOM_ATTR",v1.MakeIndex)
                                flag = true
                                if value ~= nil then
                                    local tb = SL:JsonDecode(value)

                                    if tb.I1 ~= nil then
                                        if tb.I1 == 1 then
                                            flag =  false
                                        end
                                    end
                                end

                                if flag then
                                    num = num + sellZhuangBei.config[v1.Name].sell[2]
                                end
                            end
                            txt = txt..num..""
                            GUI:Text_setString(_GUIHandle,txt)
                        end

                        _GUIHandle = GUI:GetWindow(nil,sellZhuangBei.Name.."/mask/bgk/bind")
                        if _GUIHandle  then
                            local txt = "绑定金币："
                            num = 0
                            for k1, v1 in pairs(sellZhuangBei.data) do
                                local value = SL:GetMetaValue("ITEM_CUSTOM_ATTR",v1.MakeIndex)
                                flag = true
                                if value ~= nil then
                                    local tb = SL:JsonDecode(value)

                                    if tb.I1 ~= nil then
                                        if tb.I1 == 1 then
                                            flag =  false
                                        end
                                    end
                                end

                                if not flag then
                                    num = num + sellZhuangBei.config[v1.Name].sell[2]
                                end
                            end

                            txt = txt..num..""
                            GUI:Text_setString(_GUIHandle,txt)
                        end
                    else
                        sellZhuangBei.data[tostring(k)] = v
                        --if sellZhuangBei.name[setData.Name] ~= nil then
                        --    sellZhuangBei.name[setData.Name] = sellZhuangBei.name[setData.Name] + count
                        --else
                        --    sellZhuangBei.name[setData.Name] = count
                        --end

                        GUI:ItemShow_setItemShowChooseState(_itemHandle, true)
                        local _GUIHandle = GUI:GetWindow(nil,sellZhuangBei.Name.."/mask/bgk/jiage")
                        if _GUIHandle  then
                            local txt = "出售金币："
                            num = 0

                            for k1, v1 in pairs(sellZhuangBei.data) do
                                local value = SL:GetMetaValue("ITEM_CUSTOM_ATTR",v1.MakeIndex)
                                flag = true
                                if value ~= nil then
                                    local tb = SL:JsonDecode(value)
                                    if tb.I1 ~= nil then
                                        if tb.I1 == 1 then
                                            flag =  false
                                        end
                                    end
                                end

                                if flag then
                                    num = num + sellZhuangBei.config[v1.Name].sell[2]
                                end
                            end
                            txt = txt..num..""
                            GUI:Text_setString(_GUIHandle,txt)
                        end

                        _GUIHandle = GUI:GetWindow(nil,sellZhuangBei.Name.."/mask/bgk/bind")
                        if _GUIHandle  then
                            local txt = "绑定金币："
                            num = 0
                            for k1, v1 in pairs(sellZhuangBei.data) do
                                local value = SL:GetMetaValue("ITEM_CUSTOM_ATTR",v1.MakeIndex)
                                flag = true
                                if value ~= nil then
                                    local tb = SL:JsonDecode(value)

                                    if tb.I1 ~= nil then
                                        if tb.I1 == 1 then
                                            flag =  false
                                        end
                                    end
                                end

                                if not flag then
                                    num = num + sellZhuangBei.config[v1.Name].sell[2]
                                end
                            end
                            txt = txt..num..""
                            GUI:Text_setString(_GUIHandle,txt)
                        end
                    end
                end)
            end
        end
    end

    local _GUIHandle = GUI:GetWindow(nil,sellZhuangBei.Name.."/mask/bgk/button")
    if _GUIHandle  then
        GUI:addOnClickEvent(_GUIHandle,function()
            local data = {}
            data.str = "是否出售物品？"
            data.btnType = 2
            data.showEdit = false
            data.callback = function(atype)
                if atype == 1 then
                    local _t = {}
                    for k,v in pairs(sellZhuangBei.data) do
                        _t[k] = 1
                    end

                    SL:SubmitForm("卖道具_click",_t,sellZhuangBei.page)
                end
            end

            SL:OpenCommonTipsPop(data)
        end)
    end

    _GUIHandle = GUI:GetWindow(nil,sellZhuangBei.Name.."/mask/bgk/all")
    if _GUIHandle  then
        GUI:addOnClickEvent(_GUIHandle,function()
            local bag = sellZhuangBei.getBag()
            local flag = 0
            for k, v in pairs(bag) do
                if sellZhuangBei.data[tostring(k)] == nil then
                    sellZhuangBei.data[tostring(k)] = v
                end

                flag = flag + 1
                local _Handle = GUI:GetWindow(_Parent,"list/bag_"..flag.."/item")
                if _Handle  then
                    GUI:ItemShow_setItemShowChooseState(_Handle, true)
                end
            end

            _GUIHandle = GUI:GetWindow(nil,sellZhuangBei.Name.."/mask/bgk/jiage")
            if _GUIHandle  then
                local txt = "回收金币："
                local num = 0
                for k1, v1 in pairs(sellZhuangBei.data) do
                    local value = SL:GetMetaValue("ITEM_CUSTOM_ATTR",v1.MakeIndex)
                    flag = true
                    if value ~= nil then
                        local tb = SL:JsonDecode(value)

                        if tb.I1 ~= nil then
                            if tb.I1 == 1 then
                                flag =  false
                            end
                        end
                    end

                    if flag then
                        num = num + sellZhuangBei.config[v1.Name].sell[2]
                    end
                end
                txt = txt..num..""
                GUI:Text_setString(_GUIHandle,txt)
            end

            _GUIHandle = GUI:GetWindow(nil,sellZhuangBei.Name.."/mask/bgk/bind")
            if _GUIHandle  then
                local txt = "绑定金币："
                local num = 0
                for k1, v1 in pairs(sellZhuangBei.data) do
                    local value = SL:GetMetaValue("ITEM_CUSTOM_ATTR",v1.MakeIndex)
                    flag = true
                    if value ~= nil then
                        local tb = SL:JsonDecode(value)

                        if tb.I1 ~= nil then
                            if tb.I1 == 1 then
                                flag =  false
                            end
                        end
                    end

                    if not flag then
                        num = num + sellZhuangBei.config[v1.Name].sell[2]
                    end
                end

                txt = txt..num..""
                GUI:Text_setString(_GUIHandle,txt)
            end
        end)
    end

    _GUIHandle = GUI:GetWindow(nil,sellZhuangBei.Name.."/mask/bgk/jiage")
    if _GUIHandle  then
        local txt = "回收金币："
        local num = 0

        local flag = true
        for k1, v1 in pairs(sellZhuangBei.data) do
            local value = SL:GetMetaValue("ITEM_CUSTOM_ATTR",v1.MakeIndex)
            flag = true
            if value ~= nil then
                local tb = SL:JsonDecode(value)

                if tb.I1 ~= nil then
                    if tb.I1 == 1 then
                        flag =  false
                    end
                end
            end

            if flag then
                num = num + sellZhuangBei.config[v1.Name].sell[2]
            end
        end

        txt = txt..num..""
        GUI:Text_setString(_GUIHandle,txt)
    end


    _GUIHandle = GUI:GetWindow(nil,sellZhuangBei.Name.."/mask/bgk/bind")
    if _GUIHandle  then
        local txt = "绑定金币："
        local num = 0
        local flag = true
        for k1, v1 in pairs(sellZhuangBei.data) do
            local value = SL:GetMetaValue("ITEM_CUSTOM_ATTR",v1.MakeIndex)
            flag = true
            if value ~= nil then
                local tb = SL:JsonDecode(value)

                if tb.I1 ~= nil then
                    if tb.I1 == 1 then
                        flag =  false
                    end
                end
            end

            if not flag then
                num = num + sellZhuangBei.config[v1.Name].sell[2]
            end
        end
        txt = txt..num..""
        GUI:Text_setString(_GUIHandle,txt)
    end

    _GUIHandle = GUI:GetWindow(nil,sellZhuangBei.Name.."/mask/bgk")
    if _GUIHandle then
        for i=1,2 do
            local _Handle = GUI:GetWindow(_GUIHandle,"Button_"..i)
            if _Handle then
                if i == sellZhuangBei.page then
                    GUI:Button_setGrey(_Handle,false)
                else
                    GUI:Button_setGrey(_Handle,true)
                end
                GUI:addOnClickEvent(_Handle,function()
                    sellZhuangBei.page = i
                    sellZhuangBei.data = {}
                    sellZhuangBei.name = {}
                    sellZhuangBei.update()
                end)
            end
        end
    end
end

function sellZhuangBei.getBag()
    local bag = SL:GetMetaValue("BAG_DATA")
    local data = {}
    local flag = true
    for k, v in pairs(bag) do
        flag = true

        if flag then
            if sellZhuangBei.config[v.Name] ~= nil then
                SL:Print(sellZhuangBei.no[v.Name],v.Name)
                if sellZhuangBei.no[v.Name] == nil then
                    data[k] = v
                end
            end
        end
    end

    bag = SL:GetMetaValue("QUICKUSE_DATA")
    for k, v in pairs(bag) do
        flag = true
        if flag then
            if sellZhuangBei.config[v.Name] ~= nil then
                if sellZhuangBei.no[v.Name] == nil then
                    data[v.MakeIndex] = v
                end
            end
        end
    end

    return data
end

function sellZhuangBei.getCangKu()
    local data = {}
    for i=1,#sellZhuangBei.cangKu do
        data[sellZhuangBei.cangKu[i]] = SL:GetMetaValue("STORAGE_DATA_BY_MAKEINDEX", sellZhuangBei.cangKu[i])
    end

    return data
end

function sellZhuangBei.close()
    local _Parent = GUI:GetWindow(nil,sellZhuangBei.Name)
    if _Parent then
        GUI:Win_Close(_Parent)
    end
end

function sellZhuangBei.syncData(msgData)
    sellZhuangBei.data = {}
    sellZhuangBei.name = {}
    sellZhuangBei.cangKu = msgData
    sellZhuangBei.update()
end

Message.RegisterClickMsg("卖道具", sellZhuangBei)
