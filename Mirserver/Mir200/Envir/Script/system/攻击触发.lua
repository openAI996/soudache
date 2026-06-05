local functionAttackEquip = include("Script/system/装备攻击触发.lua")
local functionOtherEquip = include("Script/system/装备受击触发.lua")
local skill_tb = {
    [7] = "攻杀剑术技能",
    [12] = "刺杀剑术技能",
    [25] = "半月弯刀技能",
    [26] = "烈火剑法技能",
    [56] = "逐日剑法技能",
    [66] = "开天斩技能",
}

--攻击扣血之后
function attackdamage(player,target,hiter,skillid,damage,model)

    if not isnotnull(target) then
        return damage
    end

    if not isnotnull(hiter) then
        return damage
    end

    local times = tonumber(os.time())
    local flag = 0


    if damage <= 0 then
        return 0
    end

    if isplayer(target) then
        if times - lualib:GetVar(target,"N$无敌") <= 0 then
            return 0
        end

        flag = 1
        damage = attackplayer(hiter,target,skillid,damage,times)
    else
        local monsterName = getbaseinfo(target,1)
        if no_cut_monster_tb["禁止BUFF"][monsterName] ~= nil then
            return damage
        end

        damage = attackmonster(hiter,target,skillid,damage,times,monsterName)
    end

    local num = 0
    if times - lualib:GetVar(player,"N$降低伤害") < 5 then
        damage = damage * 0.85
    end

    --攻击触发派发
    local attackDamage = {damage = damage,stop = false}
    GameEvent.push(EventCfg.onAttackDamage,target,hiter,skillid,attackDamage,times,model,flag)
    damage = attackDamage.damage
    if damage <= 0 then
        return 0
    end

    --装备效果
    if ServerCache.Players and ServerCache.Players[player] then
        local is = true
        if is then
            for k, v in pairs(ServerCache.Players[player].AttackEquip or {}) do
                local cd = lualib:GetVar(hiter,"N$"..k)
                if times - lualib:GetVar(hiter,"N$跨服CD") >= ServerCache.Players[hiter].AttackEquip[k].cd then
                    if times - cd >= ServerCache.Players[hiter].AttackEquip[k].cd then
                        if functionAttackEquip[k] ~= nil then
                            ---print("触发攻击触发装备："..k)
                            damage = functionAttackEquip[k](hiter,target,damage,skillid,model,times,flag,k)
                            if damage <= 0 then
                                return 0
                            end
                        else
                            print("不触发攻击触发装备："..k)
                        end
                    end
                end
            end
        end
    end


    --if ServerCache.Players[player].NumberVars["最终伤害"] > 0 then
    --    damage = damage * (1 + ServerCache.Players[player].NumberVars["最终伤害"]/10000)
    --end

    return damage
end
--攻击怪物
function attackmonster(player,target,skillid,damage,times,monsterName)
    if damage <= 0 then
        return damage
    end

    --if ServerCache.Players[player].NumberVars["刀刀吸血"] > 0 then
    --    humanhp(player,"+",ServerCache.Players[player].NumberVars["刀刀吸血"]/2,4,0,player,0,1)
    --end
    --
    --if no_cut_monster_tb["禁止斩杀"][monsterName] ~= nil then
    --    return damage
    --end
    --
    --if no_cut_monster_tb[monsterName] == 1 then
    --    return damage
    --end
    --



    local num = ServerCache.Players[player].NumberVars["刀刀切割"] or 0
    if num > 0 then
        humanhp(target,"-",num,60,0,player,0,1)
    end

    return damage
end

function attackplayer(player,target,skillid,damage,times)
    local num = ServerCache.Players[player].NumberVars["战斗状态"] or 0
    if os.time() ~= num then
        ServerCache.onUpdatePlayerNumberVars(target,"战斗状态",times)
    end

    if lualib:GetVar(player,"N$套装") > lualib:GetVar(target,"N$套装") then
        damage = damage * 1.2
    elseif lualib:GetVar(player,"N$套装") < lualib:GetVar(target,"N$套装") then
        damage = damage * 0.8
    end

    num = lualib:GetVar(target,"N$能量护盾CD")
    if num > 0 then
        if damage >= num then
            damage = damage - num
            num = 0
            clearplayeffect(player,80345)
            lualib:SetVar(target,"N$能量护盾CD",times)
            lualib:SetVar(target,"N$能量护盾",0)
        else
            damage = 0
            num = num - damage
            lualib:SetVar(target,"N$能量护盾",num)
        end
    end


    if ServerCache.Players[target].StruckEquip["金蝉脱壳"] ~= nil then
        if lualib:HasBuff(target, 20015) then
            num = lualib:GetVar(target,"N$金蝉脱壳护盾")
            if num > damage then
                num = num - damage
                lualib:SetVar(target,"N$金蝉脱壳护盾",num)
                damage = 0
            else
                lualib:SetVar(target,"N$金蝉脱壳护盾",0)
                damage = damage - num
                lualib:DelBuff(target, 20015)
            end
        end
    end

    return damage
end
-- 玩家攻击后
function attack(player, victim, attacker, skillId)
    if not victim then
        return
    end

    return ""
end
--受攻触发
function struck(player,hiter,target,skillid)
    --local now = tonumber(os.time())
    --local mapid = getbaseinfo(hiter, 3)

    return ""
end
--受击前触发
function struckdamage(player,hiter,target,skillid,damage,model)
    if not isnotnull(target) then
        return damage
    end

    if not isnotnull(hiter) then
        return damage
    end
   -- print(lualib:Name(player).."受到攻击伤害:"..damage)
    local times = tonumber(os.time())
    local flag = 0
    if isplayer(hiter) then
        flag = 1
    end

    if ServerCache.Players and ServerCache.Players[player] then
            for k, v in pairs(ServerCache.Players[player].StruckEquip or {}) do
                if times - lualib:GetVar(player,"N$跨服CD") >= ServerCache.Players[player].StruckEquip[k].cd then
                    if times - lualib:GetVar(player,"N$"..k) >= ServerCache.Players[player].StruckEquip[k].cd then
                        if functionOtherEquip[k] ~= nil then
                            ---print("被攻击触发装备："..k)
                            damage = functionOtherEquip[k](hiter,target,damage,skillid,times,flag,k,model)
                            if damage <= 0 then
                                return 0
                            end
                        else
                            print("不触发被攻击触发装备："..k)
                        end
                    end
                end
            end
    end
    damage = math.floor(damage)
    --攻击触发派发
    local attackDamage = {damage = damage,stop = false}
    GameEvent.push(EventCfg.onStruckDamage,player,hiter,skillid,attackDamage,times,flag,model)
    damage = attackDamage.damage
    return damage
end
--暴击触发
function crittrigger(player,target,damage,skillid)
    local now = tonumber(os.time())
    local attackDamage = {damage = damage,stop = false}
    if not isplayer(target) then
        local monsterName = lualib:Name(target)
        if monsterName == "黄金镖车" or monsterName == "普通镖车" then
            return damage
        end
    end

    GameEvent.push(EventCfg.onCrit,player,target,skillid,now,attackDamage)
    ----原初の「诡异的石像」
    return damage
end
--21、25、26、27、30、31
--释放技能时触发
function beginmagic(player,id,name,target,x,y)

    if name == "无敌斩" then
        ---changemode(player,1,2)
        playeffect(player,30017,0,0,1,0,1)
        lualib:SetVar(player,"N$无敌",os.time() + 2)
        rangeharm(player,lualib:X(player),lualib:Y(player),3,0,6,lualib:Attr(player,4)*1.5,0,0,0,100)
    end

    if name == '净化' then
        if lualib:HasBuff(player, 20011) then
            lualib:DelBuff(player, 20011)
        end

        if lualib:HasBuff(player, 20016) then
            lualib:DelBuff(player, 20016)
        end

        if lualib:HasBuff(player, 20017) then
            lualib:DelBuff(player, 20017)
        end

        if lualib:HasBuff(player, 20018) then
            lualib:DelBuff(player, 20018)
        end
    end

    if name == "神圣战甲术" then
        local num = 0
        local suit = ServerCache.getPlayerStringVars(player,"抽卡套装")
        if suit[8] >= 4 then
            num = 10
        elseif suit[8] >= 3 then
            num = 5
        end

        if ServerCache.Players[player].OtherEquip["铁壁光环"] ~= nil then
            num = num + 10
            local group = getgroupmember(player)
            if #group > 0 then
                for j=1,#group do
                    if lualib:X(group[j]) <= x + 3 and lualib:Y(group[j]) <= y + 3 then
                        changehumnewvalue(player,36,num,30)
                    end
                end
            else
                changehumnewvalue(player,36,num,30)
            end
        end
    end

    if name == "群体治疗术" then
        local num = 0
        local suit = ServerCache.getPlayerStringVars(player,"抽卡套装")
        if suit[8] >= 4 then
            num = 2
        else
            num = 1
        end

        if num > 0 then
            lualib:AddHPEx(player,num) 
        end
    end

    if name == "花来" then
        lualib:AddBuff(target,20013,10,1,player,{[232]=50})
    end

    if name == "治疗术" or name == "群体治疗术" then
        local group = getgroupmember(player)
        if #group > 0 then
            for j=1,#group do
                if lualib:X(group[j]) <= x + 3 and lualib:Y(group[j]) <= y + 3 then
                    if lualib:HpEx(group[j]) < 30 then
                        if os.time() - lualib:GetVar(group[j],"N$甘霖CD") >  60 then
                            lualib:AddHPEx(group[j],15)
                            lualib:SetVar(group[j],"N$甘霖CD",os.time())
                        end
                    end
                end
            end
        end
    end

    if name == "召唤圣兽" then
        local count = 1
        if ServerCache.Players[player].OtherEquip["二次召唤"] ~= nil then
            count = count + 1
        end

        local monName,level = "神兽1",1
        local suit = ServerCache.getPlayerStringVars(player,"抽卡套装")
        if suit[11] >= 4 then
            count = count + 4
            level = 5
            monName = "月灵"
        elseif suit[11] >=3 then
            monName = "金甲麒麟"
            level = 5
            count = count + 2
        elseif suit[11] >= 2 then
            level = 5
            count = count + 1
        end

        local ncount=getbaseinfo(player,38)
        local num = 0
        for i = 0 ,ncount-1 do
            local mon = getslavebyindex(player, i)
            if mon and isnotnull(mon) then
                if lualib:Name(mon) == "神兽" or lualib:Name(mon) == "金甲麒麟" or lualib:Name(mon) == "月灵" then
                    num = num + 1
                end
            end
        end

        count = count - num
        if count > 0 then
            for i=1,count do
                local mon = recallmob(player,monName,level,65535)
            end

            chouKa.setBBAttr(player)
        end
    end

    if name == "隐身术" or name == "集体隐身术" then
        local num = 1
        if ServerCache.Players[player].OtherEquip["影遁"] ~= nil then
            num = num + 4
        end
        changemode(player,2,num)
    end

    local magic = {stop = true}
    GameEvent.push(EventCfg.onBeginMagic,player,id,name,target,x,y,magic)

    if not magic.stop then
        return false
    end

    return true
end

function slavebb(player,monster)
    --jiNengShuXing.setBB(player,monster)
end

function canpush(player, target,hiter,skillid)
    local is = 2
    --if skillid == 27 then
    --    local flag = 0
    --    local xunYun = 0
    --    if ServerCache.Players[player].OtherEquip["野蛮冲撞"] ~= nil then
    --        if ServerCache.Players[player].OtherEquip["野蛮冲撞"].level >= 3 then
    --            flag = 1
    --        end
    --
    --        if ServerCache.Players[player].OtherEquip["野蛮冲撞"].level >= 7 then
    --            if  math.random(1,100) < 20 then
    --                xunYun = 1
    --            end
    --        end
    --    end
    --
    --    if lualib:Level( player) == lualib:Level( target) then
    --        if flag == 0 then
    --            is = 0
    --        else
    --            is = 2
    --        end
    --    end
    --
    --    if is == 2 and xunYun == 1 then
    --        makeposion(target,5,2)
    --        lualib:SendBuffMsg(player,"{野蛮冲撞/FCOLOR=251}触发：{眩晕对手./FCOLOR=249}")
    --    end
    --end
    --
    --if skillid == 8 then
    --    if ServerCache.Players[player].OtherEquip["抗拒火环"] ~= nil then
    --        local level = ServerCache.Players[player].OtherEquip["抗拒火环"].level
    --        local t = 0
    --        if level >= 6 then
    --            t = 10
    --        elseif level >= 4 then
    --            t = 7
    --        elseif level >= 2 then
    --            t = 5
    --        elseif level >= 1 then
    --            t = 3
    --        end
    --
    --        if t > 0 then
    --            humanhp(target,"-",lualib:Hp(target,true)*t/100,1,0,player,0,1)
    --        end
    --
    --        if level >= 5 then
    --            if math.random(1,100) < 20 then
    --                makeposion(target,5,2)
    --                lualib:SendBuffMsg(player,"{抗拒火环/FCOLOR=251}触发：{麻痹对手./FCOLOR=249}")
    --            end
    --        end
    --    end
    --end

    return is
end

function statustimeend(player,id)
    if id == 8 then
        if lualib:HasBuff(player,20013) then
            lualib:DelBuff(player,20013)
        end
    end
end
