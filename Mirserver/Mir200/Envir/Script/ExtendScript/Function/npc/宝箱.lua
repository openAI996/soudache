baoXiang = {}
baoXiang.config = include("Script/ExtendScript/cfgcsv/npc/cfg_开启宝箱.lua")

function baoXiang.main(player)
    local num = lualib:GetVar(player,"N$宝箱")
    if num == 0 then
        lualib:SendMsgGetColor(player,9,"#b60003|没有宝箱可以开启！")
        return ""
    end

    lualib:ShowFormWithContent(player,"宝箱_receiveMessage",baoXiang.getData(player))
end

function baoXiang.click(player)
    local num = lualib:GetVar(player,"N$宝箱")
    if num == 0 then
        lualib:SendMsgGetColor(player,9,"#b60003|没有宝箱可以开启！")
        return ""
    end
    lualib:SetVar(player,"N$宝箱",0)
    local chance = lualib:WeightEx1(baoXiang.config[num].chance)
    lualib:SetVar(player,"N$抽中奖励",chance)
    lualib:SetVar(player,"N$宝箱类型",num)
    lualib:ShowFormWithContent(player,"宝箱_playRotate",chance)
    return ""
end

function baoXiang.give(player)
    local num = lualib:GetVar(player,"N$宝箱类型")
    local chance = lualib:GetVar(player,"N$抽中奖励")
    if num == 0 or chance == 0 then
        lualib:SendMsgGetColor(player,9,"#b60003|请再次点击宝箱！")
        return ""
    end

    if ServerCache.Players[player].OtherEquip["开箱赐福"] ~= nil then
        local group = getgroupmember(player)
        if #group ~= 0 then
            local x,y = lualib:X( player), lualib:Y( player)
            for j=1,#group do
                if lualib:X(group[j]) < x + 20 and lualib:Y(group[j]) < y + 20 then
                    lualib:AddHPEx(group[j],20)
                    playeffect(group[j],30015,0,0,1,0,1)
                end
            end
        else
            lualib:AddHPEx(player,5)
            playeffect(player,30015,0,0,1,0,1)
        end
        lualib:SendBuffMsg(player,"{开箱赐福/FCOLOR=251}BUFF触发：{周围20码内友军回复5%最大生命值/FCOLOR=249}")
    end

    local give = baoXiang.showRed(player,num)
    lualib:SetVar(player,"N$宝箱类型",0)
    lualib:SetVar(player,"N$抽中奖励",0)
    lualib:SetVar(player,"N$大红显示",0)
    lualib:AddNeedItems(player,give[chance],"开宝箱获得物品")
    lualib:SendMsgGetColor(player,9,"#b60003|已获得："..give[chance][1].."*"..give[chance][2])
end

function baoXiang.showRed(player,num)
    local red = lualib:GetVar(player,"N$大红显示")
    local give = lualib:CopyTable(baoXiang.config[num].give)
    if red == 0 then
        red = math.random(1,#baoXiang.config[num].show - 1)
        lualib:SetVar(player,"N$大红显示",red)
    end

    give[baoXiang.config[num].show[1]] = baoXiang.config[num].show[red + 1]
    return give
end

function baoXiang.getData(player)
    local data = {}
    local num = lualib:GetVar(player,"N$宝箱")
    data.give = baoXiang.showRed(player,num)
    data.num =  num
    return data
end

Message.RegisterClickMsg("宝箱", baoXiang)
setFormAllowFunc("宝箱", {"main","click","give"})

return baoXiang