sellZhuangBei = {}
sellZhuangBei.config = include("Script/ExtendScript/cfgcsv/npc/cfg_卖装备价格.lua")
sellZhuangBei.no = {
    ["魔血石(1级)"] = 1,
    ["魔血石(2级)"] = 1,
    ["魔血石(3级)"] = 1,
    ["魔血石(4级)"] = 1,
    ["魔血石(5级)"] = 1,
    ["魔血石(6级)"] = 1,
}

function sellZhuangBei.main(player)
    lualib:ShowFormWithContent(player,"卖道具_receiveMessage",sellZhuangBei.getData(player))
    return ""
end

function sellZhuangBei.click(player,data,page)
    if lualib:IsMainCity(player) then
        lualib:MsgBox(player,"地图内禁止使用")
        return ""
    end

    if not data then
        return ""
    end

    if type(data) ~= "table" then
        lualib:MsgBox(player,"请选择需要售卖的物品！")
        return ""
    end

    if next(data) == nil then
        lualib:MsgBox(player,"请选择需要售卖的物品！")
        return ""
    end

    if page == 1 then
        for k, v in pairs(data) do
            if not hasitem(player,k,1) then
                lualib:MsgBox(player,"有物品不存在！！")
                return ""
            end

            local item = getitembymakeindex(player,k)

            local name = lualib:ItemName(player, item)
            if sellZhuangBei.config[name] == nil then
                lualib:MsgBox(player,"有物品无法售卖！！")
                return ""
            end

            if sellZhuangBei.no[name] ~= nil then
                lualib:MsgBox(player,"魔血石无法售卖！！")
                return ""
            end

            --if lualib:GetItemInt(player,item,1) == 1 then
            --    lualib:MsgBox(player,lualib:ItemName(player, item).."为开荒装备，无法售卖！！！")
            --    return ""
            --end
        end

        local count,bindCount = 0,0
        for k, v in pairs(data) do
            local item = getitembymakeindex(player,k)
            local num = getiteminfo(player,item,5)
            if num == 0 then
                num = 1
            end

            local name = lualib:ItemName(player, item)
            if lualib:GetItemInt(player,item,1) == 1 then
                bindCount = bindCount + num*sellZhuangBei.config[name].sell[2]
            else
                count = count + num*sellZhuangBei.config[name].sell[2]
            end
            delitembymakeindex(player,k)
        end
        if count > 0 then
            lualib:AddNeedItems(player,{"金币",count},"卖道具")
        end

        if bindCount > 0 then
            lualib:AddNeedItems(player,{"绑定金币",bindCount},"卖道具")
        end

        local str = ""
        if count > 0 then
            str = str..count.."金币   "
        end

        if bindCount > 0 then
            str = str..bindCount.."绑定金币"
        end
        lualib:SendMsgGetColor(player,9,"#00ff11|售卖："..(str))
        --lualib:SendMsgGetColor(player,9,"#00ff11|售卖："..(count + bindCount).."金币")
    else
        for k, v in pairs(data) do
            if not hasitem(player,k) then
                lualib:MsgBox(player,"有物品不存在！！")
                return ""
            end

            local item = 1
            local list = getstorageitems(player)
            for i=1,#list do
                if getiteminfo(player,list[i],1) == tonumber(k) then
                    item = list[i]
                end
            end

            if item == 1 then
                lualib:MsgBox(player,"有物品不存在！！")
                return ""
            end

            local name = lualib:ItemName(player, item)
            if sellZhuangBei.config[name] == nil then
                lualib:MsgBox(player,"有物品无法售卖！！")
                return ""
            end

            if sellZhuangBei.no[name] ~= nil then
                lualib:MsgBox(player,"魔血石无法售卖！！")
                return ""
            end

            --if lualib:GetItemInt(player,item,1) == 1 then
            --    lualib:MsgBox(player,lualib:ItemName(player, item).."为开荒装备，无法售卖！！！")
            --    return ""
            --end
        end

        local count,bindCount = 0,0
        for k, v in pairs(data) do
            local item = 1
            local list = getstorageitems(player)
            for i=1,#list do
                if getiteminfo(player,list[i],1) == tonumber(k) then
                    item = list[i]
                end
            end

            if item == 1 then
                lualib:MsgBox(player,"有物品不存在！！")
                return ""
            end

            local num = getiteminfo(player,item,5)
            if num == 0 then
                num = 1
            end

            local name = lualib:ItemName(player, item)
            if lualib:GetItemInt(player,item,1) == 1 then
                bindCount = bindCount + num*sellZhuangBei.config[name].sell[2]
            else
                count = count + num*sellZhuangBei.config[name].sell[2]
            end

            ----count = count + num*sellZhuangBei.config[name].sell[2]
            delstorageitem(player,k)
        end
        if count > 0 then
            lualib:AddNeedItems(player,{"金币",count},"卖道具")
        end

        if bindCount > 0 then
            lualib:AddNeedItems(player,{"绑定金币",bindCount},"卖道具")
        end
        ---lualib:AddNeedItems(player,{"金币",count},"卖道具")
        local str = ""
        if count > 0 then
            str = str..count.."金币   "
        end

        if bindCount > 0 then
            str = str..bindCount.."绑定金币"
        end
        lualib:SendMsgGetColor(player,9,"#00ff11|售卖："..(str))
    end
    lualib:ShowFormWithContent(player,"卖道具_syncData",sellZhuangBei.getData(player))
    return ""
end

function sellZhuangBei.getData(player)
    local data = {}
    local bag = getstorageitems(player)
    for k, v in pairs(bag) do
        if lualib:GetItemInt(player,v,1) == 0 then
            data[#data + 1] = getiteminfo(player,v,1)
        end
    end

    return data
end

Message.RegisterClickMsg("卖道具", sellZhuangBei)
setFormAllowFunc("卖道具", {"main","click"})
setNpcRangeAllowFunc("卖道具", {"main","click"}, 10)

return sellZhuangBei