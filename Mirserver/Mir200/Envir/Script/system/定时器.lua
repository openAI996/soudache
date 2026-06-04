function ontimer1(player)   --1分钟定时器
    lualib:SetVar(player,VarCfg["当日在线时间"],lualib:GetVar(player,VarCfg["当日在线时间"]) + 1)   --当日在线时间
    local num = lualib:GetVar(player,VarCfg["在线时间"])
    lualib:SetVar(player,VarCfg["在线时间"],num + 1)   --在线时间
    if num%10 == 0 then
        zhunBeiZhanDou.daojishi(player)
    end

    if lualib:GetVar(player,VarCfg["封禁时间"]) > 0 then
        changemode(player,10,100)
        lualib:MsgBox(player," 系统公告】：对不起，您的账号已被禁止登录,剩余时间"..lualib:GetVar(player,VarCfg["封禁时间"]).."分钟。")
        lualib:SetVar(player,"U59",lualib:GetVar(player,"U59") - 1)
        return ""
    end

    GameEvent.push(EventCfg.onTimer1,player)
end

function ontimer2(player)
    local r1,r2 = checkhumanstate(player,10)
    if tonumber(lualib:GetVar(player,VarCfg["负重"])) <= tonumber(getconst(player,"<$BW>")) then
        if not r1 then
            makeposion(player,13,65535)
        end
    else
        if r1 then
            makeposion(player,13,0)
        end
    end


    if ServerCache.Players[player].OtherEquip["守护神盾"] ~= nil then
        if os.time() - lualib:GetVar(player,"N$能量护盾CD") > 45 then
            if lualib:GetVar(player,"N$能量护盾") == 0 then
                lualib:SetVar(player,"N$能量护盾",lualib:Level(player)/100*lualib:Hp(player,true))
                playeffect(player,80345,0,0,0,0,0)
            end
        end
    end

    if os.time() - lualib:GetVar(player,"N$调息能量护盾CD") > 5 then
        if lualib:GetVar(player,"N$调息能量护盾") > 0 then
            clearplayeffect(player,80345)
            lualib:SetVar(player,"N$调息能量护盾",0)
        end
    end

    if getbaseinfo(player,48) then
      return  ""
    end

    local hp,mp = 0,0
    if ServerCache.Players[player].OtherEquip["魔血石(1级)"] ~= nil then
        hp,mp = 3,8
    end

    if ServerCache.Players[player].OtherEquip["魔血石(2级)"] ~= nil then
        hp,mp = 6,11
    end

    if ServerCache.Players[player].OtherEquip["魔血石(3级)"] ~= nil then
        hp,mp = 9,15
    end

    if ServerCache.Players[player].OtherEquip["魔血石(4级)"] ~= nil then
        hp,mp = 12,18
    end

    if ServerCache.Players[player].OtherEquip["魔血石(5级)"] ~= nil then
        hp,mp = 15,21
    end

    if hp > 0 or mp > 0 then
        local item = lualib:GetItem(player,12)
        if item ~= "0" then
            local itemID = lualib:GetMakeIndex(player,item)
            local cj = getdura(player,itemID)
            local xx = lualib:GetVar(player,VarCfg["魔血石"])
            local flag = false
            if cj > 0 then
                if lualib:Hp(player,true) ~= lualib:Hp(player,false) then
                    if lualib:GetVar(player,"N$灼烧弱化") == 1 then
                        lualib:AddHp(player,hp/2)
                    else
                        lualib:AddHp(player,hp)
                    end

                    xx = xx + hp
                    flag = true
                end

                if lualib:Mp(player,true) ~= lualib:Mp(player,false) then
                    if lualib:GetVar(player,"N$灼烧弱化") == 1 then
                        lualib:AddMp(player,mp/2)
                    else
                        lualib:AddMp(player,mp)
                    end
                    xx = xx + mp
                    flag = true
                end

                if flag then
                    local d = math.floor(xx/10)
                    if d > 0 then
                        xx = xx - d*10
                        setdura(player,itemID,"-",d)
                        lualib:SetVar(player,VarCfg["魔血石"],xx)
                    else
                        lualib:SetVar(player,VarCfg["魔血石"],xx)
                    end
                end
            else
                delbodyitem(player,12,"耐久为0")
            end
        end
    end

    if ServerCache.Players[player].OtherEquip["调息"] ~= nil then
        if os.time() - ServerCache.Players[player].NumberVars["战斗状态"] > 3 then
            lualib:AddHPEx(player,1)
        end
    end
end

function ontimer3(player)

end

function ontimer4(player)
    if ServerCache.Players[player].OtherEquip["调息"] ~= nil then
        local group = getgroupmember(player)
        if #group ~= 0 then
            local x,y = lualib:X( player), lualib:Y( player)
            for j=1,#group do
                if lualib:X(group[j]) < x + 10 and lualib:Y(group[j]) < y + 10 then
                    lualib:SetVar(group[j],"N$调息能量护盾CD",os.time())
                    lualib:SetVar(group[j],"N$调息能量护盾",0.5*lualib:Hp(player,true))
                    playeffect(group[j],80345,0,0,0,0,0)
                end
            end
        else
            lualib:SetVar(player,"N$调息能量护盾CD",os.time())
            lualib:SetVar(player,"N$调息能量护盾",0.5*lualib:Hp(player,true))
            playeffect(player,80345,0,0,0,0,0)
        end
    end
end


-------------------------------全局定时器---------------------------------------------------------------------------------
function ontimerex1()
    local num = os.time() - getsysvar(VarCfg["拉闸撤离1"])
    if num ==  180  then
        local tablePlayerList = getplayerlst()
        for _, v in ipairs(tablePlayerList) do
            local map,x,y = lualib:GetMapId(v),lualib:X(v),lualib:Y(v)
            if map == "d604" and math.abs(x - 39) <= 3 and math.abs(y - 155) <= 3 then
                lualib:GoHome(v)
            end
        end
    end

    if num == 150 then
        sendmsgnew(globalinfo(0),251,0,"{【蚂蚁洞穴】：/FCOLOR=253}30秒后撤离撤离NPC附近3格可安全撤离",1,5)
        sendmovemsg(globalinfo(0),1,253,0,100,1,"{【蚂蚁洞穴】：/FCOLOR=58}30秒后撤离撤离NPC附近3格可安全撤离")
    end
end