buyZhuangBei = {}
buyZhuangBei.config = include("Script/ExtendScript/cfgcsv/npc/cfg_买装备价格.lua")

function buyZhuangBei.main(player)
    lualib:ShowFormWithContent(player,"买道具_receiveMessage",buyZhuangBei.getData(player))
    return ""
end

function buyZhuangBei.click(player,page)
    local bind = 0
    if buyZhuangBei.config[page] == nil then
        return ""
    end

    if lualib:IsMainCity(player) then
        lualib:MsgBox(player,"地图内禁止使用")
        return ""
    end

    if not lualib:CheckNeedItems(player,buyZhuangBei.config[page].buy) then
        return ""
    end

    if lualib:GetMoneyEx(player,{"绑定金币",1}) > 0 then
        bind = 258
    end

    lualib:DelNeedItems(player,buyZhuangBei.config[page].buy,"购买基础装备")
    local item =  lualib:AddItem(player,buyZhuangBei.config[page].item,1,bind,"购买基础装备")
    if bind > 0 then
        lualib:SetItemInt(player,item,1,1)
    end

    lualib:SendMsgGetColor(player,9,"#f6ff00|购买“"..buyZhuangBei.config[page].item.."”成功！")
    return ''
end

function buyZhuangBei.getData(player)
    local data = {}
    return data
end

Message.RegisterClickMsg("买道具", buyZhuangBei)
setFormAllowFunc("买道具", {"main","click","change"})
setNpcRangeAllowFunc("买道具", {"main","click","change"}, 10)

return buyZhuangBei