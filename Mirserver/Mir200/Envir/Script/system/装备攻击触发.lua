functionAttackEquip = {}

functionAttackEquip["浴血奋战"] = function(player,target,damage,skillid,model,times,flag,name)
    local hp = lualib:HpEx(player)
    if hp <= 90 then
        local g = math.floor((100 - hp)/10)
        if g > 3 then
            g = 3
        end

        damage = damage * (1+g/10)
    end
    return damage
end

functionAttackEquip["巨人杀手"] = function(player,target,damage,skillid,model,times,flag,name)
    if flag == 1 then
        local num = ServerCache.getPlayerNumberVars( target,"人物体型") - ServerCache.getPlayerNumberVars( player,"人物体型")
        local tx = tonumber(lualib:GetVar(player,"$$人物体型")) - tonumber(lualib:GetVar(target,"$$人物体型"))

        if num > 0 then
            damage = damage * num/100 + damage
        end
    end

    return damage
end

functionAttackEquip["处刑官"] = function(player,target,damage,skillid,model,times,flag,name)
    if flag == 1 then
        if lualib:HpEx(target) < 70 then
            damage = damage * 1.15
        end
    end

    return damage
end

functionAttackEquip["致命节奏"] = function(player,target,damage,skillid,model,times,flag,name)
    if model == 1 then
        humanhp(target,"-",damage,1,0,player,0,1)
    end

    return damage
end

--functionAttackEquip["越燃越烈"] = function(player,target,damage,skillid,model,times,flag,name)
--    if flag == 1 then
--        if lualib:HasBuff(target,20011) then
--            damage = damage * 1.2
--        end
--    end
--    return damage
--end

functionAttackEquip["连环斩"] = function(player,target,damage,skillid,model,times,flag,name)
    if ServerCache.getPlayerStringVars(player,"击中角色") ~= target then
        ServerCache.onUpdatePlayerNumberVars(player,"连环时间", times)
        ServerCache.onUpdatePlayerStringVars(player,"击中角色", target)
        ServerCache.onUpdatePlayerNumberVars(player,"连环次数", 1)
    else
        if ServerCache.getPlayerNumberVars(player,"连环时间") - times > 3 then
            ServerCache.onUpdatePlayerNumberVars(player,"连环时间", times)
            ServerCache.onUpdatePlayerNumberVars(player,"连环次数", 1)
        else
            if ServerCache.getPlayerNumberVars(player,"连环次数") == 4 then
                ServerCache.onUpdatePlayerNumberVars(player,"连环时间", times)
                ServerCache.onUpdatePlayerNumberVars(player,"连环次数", 0)
                humanhp(target,"-",damage,1,0,player,0,1)
            else
                ServerCache.onUpdatePlayerNumberVars(player,"连环次数", ServerCache.getPlayerNumberVars(player,"连环次数") + 1)
            end
        end
    end

    return damage
end

functionAttackEquip["星界屏障"] = function(player,target,damage,skillid,model,times,flag,name)
    damage = damage * 0.85
    return damage
end

functionAttackEquip["弱化射线"] = function(player,target,damage,skillid,model,times,flag,name)
    if flag == 1 then
        lualib:SetVar(player,"N$"..name,times)
        lualib:SetVar(player,"N$降低伤害",times)
        lualib:SendBuffMsg(player,"{"..name.."/FCOLOR=251}BUFF触发：{对方伤害降低20%，持续5秒/FCOLOR=249}")
        lualib:SendBuffMsg(target,"{"..name.."/FCOLOR=251}BUFF触发：{伤害降低20%，持续5秒/FCOLOR=249}")
    end

    return damage
end

functionAttackEquip["寒霜"] = function(player,target,damage,skillid,model,times,flag,name)
    if flag == 1 then
        lualib:SetVar(player,"N$"..name,times)
        lualib:AddBuff(target,20013,2,1,player,{[232]=-20})
        lualib:SendBuffMsg(player,"{"..name.."/FCOLOR=251}BUFF触发：{目标移动速度降低20%，持续2秒/FCOLOR=249}")
    end

    return damage
end

functionAttackEquip["肉装重击"] = function(player,target,damage,skillid,model,times,flag,name)
    local hp = lualib:Hp(player,true)
    damage =  damage + hp*0.02
    return damage
end

functionAttackEquip["火苗"] = function(player,target,damage,skillid,model,times,flag,name)
    if flag == 1 then
        local chance = 1500        ---触发概率
        if ServerCache.Players[player].OtherEquip["烈焰"] ~= nil then
            chance = 10000
        end

        if math.random(1,10000) <= chance then
            chouKa.setZhuoSao(player,target)
        end

        if ServerCache.Players[player].OtherEquip["持续升温"] ~= nil then
            if lualib:HasBuff(target,20011) then
                damage = damage * 1.5
            end
        end
    end

    return damage
end

functionAttackEquip["灵魂火符"] = function(player,target,damage,skillid,model,times,flag,name)
    if skillid == 13 then
        if lualib:GetVar(player,"N$火符伤害") ~= 0 then
            damage = lualib:GetVar(player,"N$火符伤害")
        end

        return damage
    end

    local chance = 1500
    if ServerCache.Players[player].OtherEquip["高频火符"] ~= nil then
        chance = 5000
    end

    if math.random(1,10000) <= chance then
        local t = false
        local num = 5
        local scale = 1
        local zs = 0
        local double = false
        local suit = ServerCache.getPlayerStringVars(player,"抽卡套装")--["抽卡套装"]


        if ServerCache.Players[player].OtherEquip["爆裂火符"] ~= nil then
            scale = scale + 0.5
        end

        if ServerCache.Players[player].OtherEquip["灼烧火符"] ~= nil then
            zs = 1
        end

        if ServerCache.Players[player].OtherEquip["双生火符"] ~= nil then
            double = true
        end

        if suit[4] >= 4 then
            scale = scale + 1
            num = num + 5
            t = true
        elseif suit[4] >= 2 then
            scale = scale + 0.5
            num = num + 2
            t = true
        end

        if t then
            if double then
                chouKa.huoFu(player,target,200*scale,zs,num)
            end

            chouKa.huoFu(player,target,200*scale,zs,num)
        else
            lualib:SetVar(player,"N$火符伤害",200*scale)
            if double then
                releasemagic_target(player,13,1,1,target,0)
            end
            releasemagic_target(player,13,1,1,target,0)

            if zs == 1 then
                if flag == 1 then
                    chouKa.setZhuoSao(player,target)
                end
            end
        end
    end

    return damage
end

functionAttackEquip["暴走齿轮"] = function(player,target,damage,skillid,model,times,flag,name)
    if model == 1 then
        if not lualib:HasBuff(player,20013) then
            lualib:AddBuff(player,20013,3,1,player,{[216]=15})
            lualib:SendBuffMsg(player,"{"..name.."/FCOLOR=251}BUFF触发：{攻击速度提升15%，持续3秒/FCOLOR=249}")
        end
    end
    return  damage
end

functionAttackEquip["变羊术"] = function(player,target,damage,skillid,model,times,flag,name)
    if flag == 1 then
        local suit = ServerCache.getPlayerStringVars(player,"抽卡套装")
        local s = 2
        local chance = 2000
        if suit[7] >= 4 then
            s = s + 2
            chance = chance + 2000
        elseif suit[7] >= 3 then
            s = s + 1
            chance = chance + 1000
        end

        if math.random(1,10000) <= chance then
            lualib:AddBuff(target,20016,s,1,player)
            lualib:SetVar(player,VarCfg["控制欲强"],lualib:GetVar(player,VarCfg["控制欲强"]) + 1)
            lualib:SendBuffMsg(player,"{"..name.."/FCOLOR=251}BUFF触发：{变羊，持续"..s.."秒/FCOLOR=249}")
            chouKa.setKillAttr(player)
        end
    end

    return  damage
end

functionAttackEquip["寒冰锁"] = function(player,target,damage,skillid,model,times,flag,name)
    local suit = ServerCache.getPlayerStringVars(player,"抽卡套装")
    local s = 2
    local chance = 2000
    if suit[7] >= 4 then
        s = s + 2
        chance = chance + 2000
    elseif suit[7] >= 3 then
        s = s + 1
        chance = chance + 1000
    end

    if math.random(1,10000) <= chance then
        lualib:AddBuff(target,20017,s,1,player)
        lualib:SetVar(player,VarCfg["控制欲强"],lualib:GetVar(player,VarCfg["控制欲强"]) + 1)
        lualib:SendBuffMsg(player,"{"..name.."/FCOLOR=251}BUFF触发：{冰冻对手，持续"..s.."秒/FCOLOR=249}")
        chouKa.setKillAttr(player)
    end

    return  damage
end

functionAttackEquip["重锤定身"] = function(player,target,damage,skillid,model,times,flag,name)
    if flag == 1 then
        local suit = ServerCache.getPlayerStringVars(player,"抽卡套装")
        local s = 2
        if suit[7] >= 4 then
            s = s + 2
        elseif suit[7] >= 3 then
            s = s + 1
        end

        local num = lualib:GetVar(player,"N$重锤定身次数")
        if num == 4 then
            lualib:AddBuff(target,20018,s,1,player)
            lualib:SetVar(player,VarCfg["控制欲强"],lualib:GetVar(player,VarCfg["控制欲强"]) + 1)
            lualib:SendBuffMsg(player,"{"..name.."/FCOLOR=251}BUFF触发：{眩晕，持续"..s.."秒/FCOLOR=249}")
            chouKa.setKillAttr(player)
            lualib:SetVar(player,"N$重锤定身次数",0)
        else
            lualib:SetVar(player,"N$重锤定身次数",num + 1)
        end
    end

    return  damage
end

functionAttackEquip["亡灵军团"] = function(player,target,damage,skillid,model,times,flag,name)
    if math.random(1,10000) < 500 then
        local ncount=getbaseinfo(player,38)
        local count = 0
        for i = 0 ,ncount-1 do
            local mon = getslavebyindex(player, i)
            if mon and isnotnull(mon) then
                if lualib:Name(mon) == "骷髅战士" then
                    count = count + 1
                end
            end
        end

        if count < 5 then
            local mon = recallmob(player,"骷髅战士",1,65535)
            chouKa.setBBAttr(player)
        end
    end

    return damage
end

functionAttackEquip["幸运骰子"] = function(player,target,damage,skillid,model,times,flag,name)
    if math.random(1,10000) < 500 then
        damage = damage * 2
        model = 1
        lualib:SendBuffMsg(player,"{"..name.."/FCOLOR=251}BUFF触发：{幸运一击，造成200%暴击伤害/FCOLOR=249}")
    elseif math.random(1,10000) < 300 then
        damage = damage * 0.5
        lualib:SendBuffMsg(player,"{"..name.."/FCOLOR=251}BUFF触发：{倒霉一击，造成一半伤害/FCOLOR=249}")
    end

    return damage
end


functionAttackEquip["我小我牛B"] = function(player,target,damage,skillid,model,times,flag,name)
    if flag == 1 then
        local num = ServerCache.getPlayerNumberVars( target,"人物体型") - ServerCache.getPlayerNumberVars( player,"人物体型")
        local tx = tonumber(lualib:GetVar(player,"$$人物体型")) - tonumber(lualib:GetVar(target,"$$人物体型"))

        if num > 0 then
            damage = damage * num/100 + damage
        end
    end

    return damage
end

functionAttackEquip["以小搏大"] = function(player,target,damage,skillid,model,times,flag,name)
    if lualib:HpEx(target) > 50 then
        damage = damage * 1.3
    end
    return damage
end

functionAttackEquip["蚁噬"] = function(player,target,damage,skillid,model,times,flag,name)
    if flag == 1 then
        damage = damage + lualib:Hp(target,true) * 0.01
    end
    return damage
end

functionAttackEquip["专揍大高个"] = function(player,target,damage,skillid,model,times,flag,name)

    return damage
end

functionAttackEquip["小人国"] = function(player,target,damage,skillid,model,times,flag,name)
    if flag == 1 then
        if ServerCache.getPlayerNumberVars( target,"人物体型") < ServerCache.getPlayerNumberVars( player,"人物体型") then
            local suit = ServerCache.getPlayerStringVars(player,"抽卡套装")
            if suit[10] >= 5 then
                damage = damage * 1.3 + lualib:Hp(target,true)*0.03
            elseif suit[10] >= 3 then
                damage = damage * 1.2 + lualib:Hp(target,true)*0.02
            elseif suit[10] >= 2 then
                damage = damage * 1.1 + lualib:Hp(target,true)*0.01
            end
        end
    end
    return damage
end

return functionAttackEquip