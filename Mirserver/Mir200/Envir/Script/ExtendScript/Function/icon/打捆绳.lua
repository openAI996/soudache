daKunShen = {}
daKunShen.config = include("Script/ExtendScript/cfgcsv/npc/cfg_打捆绳.lua")
function daKunShen.main(player)
    lualib:ShowFormWithContent(player,"打捆绳_receiveMessage",daKunShen.getData(player))
end

function daKunShen.click(player,page)
    if page < 1 or page > #daKunShen.config then
        return
    end

    local bag_item_tb = getbagitems(player,daKunShen.config[page].item[1],1)
    local count = 0
    for i = 1, #bag_item_tb do
        count = count + 1
    end

    if count < daKunShen.config[page].item[2] then
        lualib:MsgBox(player,"你没有6个不绑定"..daKunShen.config[page].item[1])
        return false
    end

    if not lualib:CheckNeedItems(player,daKunShen.config[page].need) then
        return ""
    end

    lualib:DelNeedItems(player,daKunShen.config[page].need,"打捆药品扣除货币")
    count = 0
    for i = 1, #bag_item_tb do
        count = count + 1
        if count < 7 then
            lualib:DelItemObject(player,bag_item_tb[i])
        else
            break
        end
    end

    lualib:AddNeedItems(player,daKunShen.config[page].give,"打捆药品")
    lualib:SendMsgGetColor(player,9,"#fbff00|打捆成功")
    lualib:ShowFormWithContent(player,"打捆绳_syncData",daKunShen.getData(player))
    return ""
end

function daKunShen.getNum(player)
    local data = {}
    for i=1,#daKunShen.config do
        local bag_item_tb = getbagitems(player,daKunShen.config[i].item[1],1)
        local count = 0
        for j = 1, #bag_item_tb do
            count = count + 1
        end
        data[i] = count
    end

    return data
end

function daKunShen.getData(player)
    local data = {}
    data.var = daKunShen.getNum(player)
    data.config = daKunShen.config
    return data
end

Message.RegisterClickMsg("打捆绳", daKunShen)
setFormAllowFunc("打捆绳", {"main","click"})

return daKunShen