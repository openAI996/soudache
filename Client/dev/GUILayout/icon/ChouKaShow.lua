chouKaShow = {}
chouKaShow.Name = "chouKaShowFrame"
chouKaShow.config = SL:Require("GUILayout/cfgcsv/cfg_ChouKa",true)

function chouKaShow.receiveMessage(msgData)
    chouKaShow.data = chouKaShow.sortCard(msgData.card)
    chouKaShow.max = msgData.max
    chouKaShow.suit = msgData.suit
    chouKaShow.main()
end

function chouKaShow.main()
    local _GUIHandle = GUI:GetWindow(nil,chouKaShow.Name)
    if _GUIHandle ~= nil then
        GUI:Win_Close(_GUIHandle)
        return ""
    end

    local _Parent = GUI:Win_Create(chouKaShow.Name, 0,0 , screen_W, screen_H, true, false, true, true)
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
        GUI:setOpacity(_ImgHandle, 150)
        GUI:addOnClickEvent(_ImgHandle, function()
            chouKaShow.close()
        end)
    end

    GUI:LoadExport(_ImgHandle,"icon/ChouKaZhangShiUI.lua")
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
            chouKaShow.close()
        end)
    end

    chouKaShow.update()
end

function chouKaShow.update()
    local isWin32 = SL:GetMetaValue("WINPLAYMODE")
    local x,y = 0,0
    local config,var = chouKaShow.getConfig(),chouKaShow.data
    local pos,_GUIHandle,_Handle = {},nil,nil

    local _Parent = GUI:GetWindow(nil,chouKaShow.Name.."/mask/bgk")
    if _Parent then
        _GUIHandle = GUI:GetWindow(_Parent,"list")
        if _GUIHandle then
            GUI:removeAllChildren(_GUIHandle)
            for i=1,chouKaShow.max do
                if  var[i] ~= nil and var[i] ~= 0 then
                    local id = config[config[tostring(var[i])].group].id
                    local Panel = GUI:Image_Create(_GUIHandle, "Panel_"..i, 250, 100, "res/public/cards/card/"..id..".png")
                    GUI:setAnchorPoint(Panel, 0.50, 0.50)
                    GUI:setTouchEnabled(Panel, true)
                    GUI:setTag(Panel, 0)

                    if config[config[tostring(var[i])].group].group ~= nil then
                        _Handle = GUI:Button_Create(Panel, "tips", 190, 310 - 153 - 33, "res/public/cards/tips.png")
                        GUI:setAnchorPoint(_Handle, 0.50, 0.50)
                        GUI:setTouchEnabled(_Handle, true)
                        GUI:addOnClickEvent(_Handle,function(_Handle)
                            pos = GUI:getTouchEndPosition(_Handle)
                            local f = config[config[tostring(var[i])].group].group
                            local tips = "{"..chouKa.show[f][1].name..":/FCOLOR=249}\\"

                            for j=1,#chouKa.show[f] do
                                if chouKaShow.suit[f] >= chouKa.show[f][j].need then
                                    tips = tips .. "{"..chouKa.show[f][j].tips.."/FCOLOR=250}\\"
                                else
                                    tips = tips .. "{"..chouKa.show[f][j].tips.."/FCOLOR=249}\\"
                                end
                            end

                            local data = {width = 1136, str = tips, worldPos = pos, anchorPoint = {x = 0, y = 0}}
                            SL:OpenCommonDescTipsPop(data)
                        end)
                    end
                else
                    local Panel = GUI:Image_Create(_GUIHandle, "Panel_"..i, 250, 100, "res/public/cards/card/no.png")
                    GUI:setAnchorPoint(Panel, 0.50, 0.50)
                    GUI:setTouchEnabled(Panel, true)
                    GUI:setTag(Panel, 0)
                end


            end
        end

        _GUIHandle = GUI:GetWindow(_Parent,"down")
        if _GUIHandle then
            local _t = chouKaShow.getGroupSort(chouKaShow.data)
            for i=1,#_t do
                local num = _t[i]
                local Panel = GUI:Image_Create(_GUIHandle, "Panel_"..i, 100, 100, "res/public/cards/list"..num..".png")
                GUI:setTouchEnabled(Panel, true)
                GUI:addOnClickEvent(Panel,function(_GUIHandle)
                    num = _t[i]
                    pos = GUI:getTouchEndPosition(_GUIHandle)
                    local tips = "{羁绊：/FCOLOR=161}{"..chouKa.show[num][1].name.."/FCOLOR=249}\\"
                    tips = tips .. "{符文：/FCOLOR=161}" .. chouKaShow.getGroupNameTips(num, chouKaShow.data).."\\"
                    for j=1,#chouKa.show[num] do
                        if chouKaShow.suit[num] >= chouKa.show[num][j].need then
                            tips = tips .. "{"..chouKa.show[num][j].tips.."/FCOLOR=251}\\"
                        else
                            tips = tips .. "{"..chouKa.show[num][j].tips.."/FCOLOR=249}\\"
                        end
                    end

                    local data = {width = 1136, str = tips, worldPos = pos, anchorPoint = {x = 0, y = 0}}
                    SL:OpenCommonDescTipsPop(data)
                end)

                local suitNum = chouKaShow.suit[num] or 0
                local Text = GUI:Text_Create(Panel, "suitNum", 22, 19, 16, "#ffff00", tostring(suitNum))
                if Text then
                    GUI:setAnchorPoint(Text, 0.5, 0.5)
                    GUI:Text_enableOutline(Text, "#000000", 1)
                end

                if chouKaShow.suit[num] > 0 then
                    _Handle = GUI:Image_Create(Panel, "Panel_"..i, 0, 0, "res/public/cards/jh.png")
                end
            end
        end
    end
end

function chouKaShow.getGroupSort(cardIds)
    local hadGroup = {}

    for i = 1, #chouKaShow.config do
        local group = chouKaShow.config[i].group
        local id = chouKaShow.config[i].id

        if group ~= nil and chouKaShow.hasCardId(cardIds, id) then
            hadGroup[group] = 1
        end
    end

    local result = {}

    for group = 1, 11 do
        if hadGroup[group] == 1 then
            result[#result + 1] = group
        end
    end

    for group = 1, 11 do
        if hadGroup[group] ~= 1 then
            result[#result + 1] = group
        end
    end

    return result
end

function chouKaShow.hasCardId(cardIds, cardId)
    if type(cardIds) ~= "table" then
        return false
    end

    for i = 1, #cardIds do
        if cardIds[i] == cardId then
            return true
        end
    end

    return false
end

function chouKaShow.getGroupNameTips(group, cardIds)
    local tips = ""

    for i = 1, #chouKaShow.config do
        if chouKaShow.config[i].group == group then
            local color = 249

            if chouKaShow.hasCardId(cardIds, chouKaShow.config[i].id) then
                color = 251
            end

            tips = tips .. "{"..chouKaShow.config[i].name.."  /FCOLOR="..color.."}"
        end
    end

    return tips
end

function chouKaShow.sortCard(card)
    if type(card) ~= "table" then
        return {}
    end

    local config = chouKaShow.getConfig()
    local list = {}

    for i = 1, #card do
        local cardId = card[i]
        local group = nil

        if cardId ~= nil and cardId ~= 0 and config[tostring(cardId)] ~= nil then
            local index = config[tostring(cardId)].group
            if index ~= nil and config[index] ~= nil then
                group = config[index].group
            end
        end

        list[#list + 1] = {
            id = cardId,
            group = group,
            index = i,
        }
    end

    table.sort(list, function(a, b)
        if a.group == nil and b.group ~= nil then
            return true
        end

        if a.group ~= nil and b.group == nil then
            return false
        end

        if a.group ~= nil and b.group ~= nil and a.group ~= b.group then
            return a.group < b.group
        end

        return a.index < b.index
    end)

    local result = {}
    for i = 1, #list do
        result[i] = list[i].id
    end

    return result
end

function chouKaShow.getConfig()
    local config = SL:CopyData(chouKa.config)

    return config
end

function chouKaShow.close()
    local _Parent = GUI:GetWindow(nil,chouKaShow.Name)
    if _Parent then
        GUI:Win_Close(_Parent)
    end
end

function chouKaShow.syncData(msgData)
    chouKaShow.data = msgData
    chouKaShow.update()
end

Message.RegisterClickMsg("抽卡展示", chouKaShow)