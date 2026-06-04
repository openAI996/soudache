chouKa = {}
chouKa.Name = "chouKaFrame"
chouKa.config = SL:Require("GUILayout/cfgcsv/cfg_ChouKa",true)

chouKa.configCache = SL:Require("GUILayout/cfgcsv/cfg_ChouKaSuit",true)
chouKa.show = {}
for k, sceneConfig in pairs(chouKa.configCache) do
    if type(k) == "number" then
        local currentTable = chouKa.show
        for num, typeValue in ipairs(sceneConfig.type) do
            if not currentTable[typeValue] then
                currentTable[typeValue] = {}
            end

            currentTable = currentTable[typeValue]
        end

        if sceneConfig.name then
            currentTable.name = sceneConfig.name
        end

        if sceneConfig.need then
            currentTable.need = sceneConfig.need
        end

        if sceneConfig.tips then
            currentTable.tips = sceneConfig.tips
        end
    end
end


function chouKa.receiveMessage(msgData)
    chouKa.data = msgData
    chouKa.page = 0
    chouKa.chou =  msgData.update
    chouKa.main()
end

function chouKa.main()
    local _GUIHandle = GUI:GetWindow(nil,chouKa.Name)
    if _GUIHandle ~= nil then
        GUI:Win_Close(_GUIHandle)
        return ""
    end

    local _Parent = GUI:Win_Create(chouKa.Name, 0,0 , screen_W, screen_H, true, false, true, true)
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
        GUI:addOnClickEvent(_ImgHandle, function()
            chouKa.close()
        end)
    end

    GUI:LoadExport(_ImgHandle,"icon/ChouKaUI.lua")
    local pos = {}
    _GUIHandle = GUI:GetWindow(_ImgHandle,"bgk")
    if _GUIHandle then
        pos = GUI:getContentSize(_GUIHandle)
        --GUI:Win_SetDrag(_Parent, _GUIHandle)
        GUI:setAnchorPoint(_GUIHandle,0.5,0.5)
        GUI:setPosition(_GUIHandle,screen_W/2,screen_H/2)
    end

    local _Handle = GUI:GetWindow(_GUIHandle,"close")
    if _Handle then
        GUI:addOnClickEvent(_Handle, function()
            chouKa.close()
        end)
    end

    chouKa.effect = 0
    chouKa.update()
end

function chouKa.update()
    local isWin32 = SL:GetMetaValue("WINPLAYMODE")
    local x,y = 0,0
    local config,var,page,scale = chouKa.getConfig(),chouKa.data.card,chouKa.page,chouKa.data.scale
    local pos,_GUIHandle,_Handle = {},nil,nil
    local _Parent = GUI:GetWindow(nil,chouKa.Name.."/mask/bgk")
    if _Parent then
        _GUIHandle = GUI:GetWindow(_Parent,"card")
        if _GUIHandle then
            GUI:removeAllChildren(_GUIHandle)
            if var == 0 then
                local need = GUI:Text_Create(_GUIHandle, "need", 250, 100, 50, "#dbdbdb", [[没有抽取次数]])
                GUI:Text_setFontName(need, "fonts/font140.ttf")
                GUI:Text_enableOutline(need, "#000000", 1)
                GUI:setAnchorPoint(need, 0.5, 0.5)
                GUI:setTouchEnabled(need, false)
                GUI:setTag(need, 0)
            else
                local _ItemShowParent = GUI:Layout_Create(_GUIHandle, "itemauto_materials", 250, 100, 226, 70)
                if _ItemShowParent then
                    GUI:setAnchorPoint(_ItemShowParent, 0.5, 0.5)
                    for i=1,#var do
                        -- Create Panel_2
                        local Panel = GUI:Layout_Create(_ItemShowParent, "Panel_"..i, 250, 100, 264, 390, false)
                        GUI:setAnchorPoint(Panel, 0.50, 0.50)
                        GUI:setTouchEnabled(Panel, true)
                        GUI:setTag(Panel, 0)
                        -- Create icon
                        local icon = GUI:Image_Create(Panel, "icon", 128, 195, "res/public/cards/card/"..config[config[tostring(var[i])].group].id..".png")
                        GUI:setAnchorPoint(icon, 0.50, 0.50)
                        GUI:setTouchEnabled(icon, true)
                        GUI:setTag(icon, 0)
                        GUI:addOnClickEvent(icon, function()
                            chouKa.page = i
                            chouKa.update()
                        end )

                        local Button_3 = GUI:Button_Create(Panel, "button", 127, -70, "res/public/cards/update.png")
                        GUI:setAnchorPoint(Button_3, 0.50, 0.00)
                        GUI:addOnClickEvent(Button_3, function()
                            if i < 1 or i > 3 then
                                return
                            end

                            SL:SubmitForm("抽卡_changeOneCard",i)
                        end)

                        local num = chouKa.chou[i] + 1
                        local txt = "刷新条件:无要求"
                        local color = "#d2d200"
                        if num <= chouKa.data.max then
                            if chouKa.data.max - #config.basic.need < num then
                                num = num - (chouKa.data.max - #config.basic.need)
                                if config.basic.need[num][2] ~= 0 then
                                    txt = "刷新条件:"..config.basic.need[num][2]  .. config.basic.need[num][1]
                                    if chouKa.data.half == 1 then
                                        txt = "刷新条件:"..config.basic.need[num][2]/2  .. config.basic.need[num][1]
                                    end
                                end
                            end
                        else
                            txt = "没有刷新次数"
                            color = "#d20700"
                        end

                        local jiage = GUI:Text_Create(Panel, "jiage", 131, 0, 18, color, txt)
                        GUI:Text_enableOutline(jiage, "#000000", 1)
                        GUI:setAnchorPoint(jiage, 0.50, 0.50)
                        GUI:setTouchEnabled(jiage, false)
                        GUI:setTag(jiage, 0)

                        if page == i then
                            --local Effect_1 = GUI:Effect_Create(Panel, "Effect_1", 90, 180, 0, 450, 0, 0, 0, 1)
                            --GUI:setScale(Effect_1, 2.00)
                            --GUI:setTag(Effect_1, 0)

                            local Effect_1 = GUI:Image_Create(Panel, "Effect_1", 8, 26, "res/public/cards/select.png")
                            --GUI:setAnchorPoint(Effect_1, 0.50, 0.50)
                            --GUI:setTouchEnabled(Effect_1, true)
                            --GUI:setTag(Effect_1, 0)
                        end

                        if config[config[tostring(var[i])].group].group ~= nil then
                            _Handle = GUI:Button_Create(Panel, "tips", 209, 310 - 153, "res/public/cards/tips.png")
                            GUI:setAnchorPoint(_Handle, 0.50, 0.50)
                            GUI:setTouchEnabled(_Handle, true)
                            GUI:addOnClickEvent(_Handle,function(_Handle)
                                pos = GUI:getTouchEndPosition(_Handle)
                                local f = config[config[tostring(var[i])].group].group
                                local tips = "{"..chouKa.show[f][1].name..":/FCOLOR=249}\\"

                                for j=1,#chouKa.show[f] do
                                    if chouKa.data.suit[f] >= chouKa.show[f][j].need then
                                        tips = tips .. "{"..chouKa.show[f][j].tips.."/FCOLOR=250}\\"
                                    else
                                        tips = tips .. "{"..chouKa.show[f][j].tips.."/FCOLOR=249}\\"
                                    end
                                end

                                local data = {width = 1136, str = tips, worldPos = pos, anchorPoint = {x = 0, y = 0}}
                                SL:OpenCommonDescTipsPop(data)
                            end)
                        end
                    end

                    local flag = 0
                    if chouKa.effect == 0 then
                        flag = 1
                        chouKa.effect = 1
                    end

                    GUI:UserUILayout(_ItemShowParent,
                            {
                                dir = 2,
                                addDir = 2,
                                interval = flag,
                                autosize = true,
                                colnum = 1,
                                gap = {
                                    x = 40,
                                    y = 5,
                                    l = 5,
                                    t = 5,
                                },
                            }
                    )
                end
            end
        end

        _GUIHandle = GUI:GetWindow(_Parent,"show")
        if _GUIHandle then
            _Handle = GUI:GetWindow(_GUIHandle,"num")
            if _Handle then
                GUI:Text_setString(_Handle,"刷新次数:"..chouKa.data.change.."/"..chouKa.data.max)
            end

            _Handle = GUI:GetWindow(_GUIHandle,"need")
            if _Handle then
                local num = chouKa.data.change + 1
                --if num > chouKa.data.max then
                --    num = chouKa.data.max
                --end

                ---local mf = chouKa.data.max - #config.basic.need
                local txt = "刷新条件:无要求"
                if num <= chouKa.data.max then
                    if chouKa.data.max - #config.basic.need < num then
                        num = num - (chouKa.data.max - #config.basic.need)
                        if config.basic.need[num][2] ~= 0 then
                            txt = "刷新条件:"..config.basic.need[num][2]  .. config.basic.need[num][1]
                            if chouKa.data.half == 1 then
                                txt = "刷新条件:"..config.basic.need[num][2]/2  .. config.basic.need[num][1]
                            end
                        end
                    end
                else
                    txt = "无法刷新"
                end

                GUI:Text_setString(_Handle,txt)
            end
        end

        _Handle = GUI:GetWindow(_Parent,"Button_1")
        if _Handle then
            GUI:addOnClickEvent(_Handle, function()
                if var == 0 then
                    SL:ShowSystemTips("<font color='#fffb00'>没有抽卡次数了！！</font>")
                    return
                end
                if page ~= 0 then
                    SL:SubmitForm("抽卡_click",page)
                else
                    SL:ShowSystemTips("<font color='#fffb00'>请选择一个抽卡！！</font>")
                end
            end)
        end

        _Handle = GUI:GetWindow(_Parent,"Button_2")
        if _Handle then
            GUI:addOnClickEvent(_Handle, function()
                SL:SubmitForm("抽卡_updateCards")
            end)
        end

        _Handle = GUI:GetWindow(_Parent,"change")
        if _Handle then
            --GUI:addOnClickEvent(_Handle, function()
            --    SL:SubmitForm("抽卡_show")
            --end)
            GUI:setVisible(_Handle,false)
        end
    end
end

function chouKa.getConfig()
    local config = SL:CopyData(chouKa.config)

    return config
end

function chouKa.close()
    local _Parent = GUI:GetWindow(nil,chouKa.Name)
    if _Parent then
        GUI:Win_Close(_Parent)
    end
end

function chouKa.syncData(msgData)
    chouKa.data = msgData
    chouKa.effect = 1
    chouKa.page = 0
    chouKa.chou = msgData.update
    chouKa.update()
end

Message.RegisterClickMsg("抽卡", chouKa)