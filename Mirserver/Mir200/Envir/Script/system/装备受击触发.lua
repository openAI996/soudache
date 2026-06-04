functionStruckEquip = {}

functionStruckEquip["铁骨"] = function(hiter,player,damage,skillid,times,flag,name,model)
    if model == 1 then
        damage = damage * 0.8
    end
    return damage
end

functionStruckEquip["金蝉脱壳"] = function(hiter,player,damage,skillid,times,flag,name,model)
    if lualib:HpEx(player) < 35 then
        lualib:SetVar(player,"N$"..name,times)
        lualib:AddBuff(player, 20015,3)
        lualib:SetVar(player,"N$金蝉脱壳护盾",lualib:Hp( player,true)*0.2)

    end
    --if lualib:HasBuff(player, 20015) then
    --    local num = lualib:GetVar(player,"N$金蝉脱壳护盾")
    --    if num > damage then
    --        num = num - damage
    --        lualib:SetVar(player,"N$金蝉脱壳护盾",num)
    --        damage = 0
    --    else
    --        lualib:SetVar(player,"N$金蝉脱壳护盾",0)
    --        damage = damage - num
    --        lualib:DelBuff(player, 20015)
    --    end
    --end

    return damage
end

---狠狠推开
functionStruckEquip["烈焰震退"] = function(hiter,player,damage,skillid,times,flag,name,model)
    if lualib:HpEx( player) < 35 then
        local suit = ServerCache.getPlayerStringVars(player,"抽卡套装")
        local s = 2
        if suit[7] >= 4 then
            s = 4
        elseif suit[7] >= 3 then
            s = 3
        end

        lualib:SetVar(player,"N$"..name,times)
        local list = getmapmon(lualib:GetMapId(player),"*",lualib:X( player),lualib:Y(player),3)
        for i=1,#list do
            makeposion(list[i],13,s)
            ---changemobability(player,list[i],14,"-",40,s)
        end

        list = getobjectinmap(lualib:GetMapId(player),lualib:X( player),lualib:Y(player),3,1)
        for i=1,#list do
            if list[i] ~= player then
                lualib:AddBuff(list[i],20013,s,1,player,{[232]=-40})
            end
        end

        playeffect(player,462,0,0,1,0,1)
        rangeharm(player,lualib:X(player),lualib:Y(player),3,0,1,3,0,0,0,100)
        lualib:SendBuffMsg(player,"{"..name.."/FCOLOR=251}BUFF触发：{对方移动速度降低40%，持续2秒/FCOLOR=249}")
        lualib:SetVar(player,VarCfg["控制欲强"],lualib:GetVar(player,VarCfg["控制欲强"])+1)
        chouKa.setKillAttr(player)
    end

    return damage
end

functionStruckEquip["绝境逢生"] = function(hiter,player,damage,skillid,times,flag,name,model)
    if lualib:HpEx( player) < 35 then
        lualib:SetVar(player,"N$"..name,times)
        lualib:AddBuff(player,20015,3)
        lualib:AddBuff(player,20013,3,1,player,{[232]=30})
        lualib:SendBuffMsg(player,"{"..name.."/FCOLOR=251}BUFF触发：{移动速度提高30%，获得20%最大生命护盾，持续3秒/FCOLOR=249}")
    end

    return damage
end

functionStruckEquip["铁甲觉醒"] = function(hiter,player,damage,skillid,times,flag,name,model)
    local num = lualib:GetVar(player,VarCfg["铁甲觉醒"]) + damage

    lualib:SetVar(player,VarCfg["铁甲觉醒"],num)

    if math.floor(num/1000) > math.floor(ServerCache.getPlayerNumberVars(player,"铁甲觉醒")/1000) then
        chouKa.tieJia(player)
    end

    ServerCache.onUpdatePlayerNumberVars(player,"铁甲觉醒",num)
    return damage
end

functionStruckEquip["金钟罩"] = function(hiter,player,damage,skillid,times,flag,name,model)
    if math.random(1,10000) < 200 then
        lualib:SetVar(player,"N$"..name,times)
        playeffect(player,30017,0,0,1,0,1)
        lualib:SetVar(player,"N$无敌",os.time() + 2)
        lualib:SendBuffMsg(player,"{"..name.."/FCOLOR=251}BUFF触发：{无敌2秒/FCOLOR=249}")
    end
    return damage
end

return functionStruckEquip
