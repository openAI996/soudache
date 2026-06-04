-- 玩家死亡触发
function killplay(player, die)
    if not isnotnull(die) or die == "0" then
        return
    end

    if not isnotnull(player) or player == "0" then
        return
    end

    if lualib:Name(player) == lualib:Name(die) then
        return
    end

    GameEvent.push(EventCfg.onKillPlay,player,die)
    lualib:SetVar(die,VarCfg["被杀次数"],lualib:GetVar(die,VarCfg["被杀次数"]) + 1)
    GameEvent.push(EventCfg.onLevelName,player)
end

function playdie(player, hiter)
    if not isnotnull(player) or player == "0" then
        return
    end

    if not lualib:Player_IsPlayer(hiter) then
        close(player)
        goldDrop(player)
        lualib:ShowFormWithContent(player,"NPC打开_closeMiniMap")
        showprogressbardlg(player,3,"@city_revive","复活进度条..",0,0,"")
        return ""
    end

    if hiter == "0" or not isnotnull(hiter) then
        close(player)
        goldDrop(player)
        lualib:ShowFormWithContent(player,"NPC打开_closeMiniMap")
        showprogressbardlg(player,3,"@city_revive","复活进度条..",0,0,"")
        return ""
    end

    if lualib:Name(player) == lualib:Name(hiter) then
        close(player)
        goldDrop(player)
        lualib:ShowFormWithContent(player,"NPC打开_closeMiniMap")
        showprogressbardlg(player,3,"@city_revive","复活进度条..",0,0,"")
        return
    end

    if isplayer(hiter) then
        lualib:SetVar(hiter,VarCfg["杀人次数"],lualib:GetVar(hiter,VarCfg["杀人次数"]) + 1)
        GameEvent.push(EventCfg.onLevelName,hiter)
    end

    if lualib:Name(player) ~= lualib:Name(hiter) and lualib:Name(hiter) ~= ""  then
        if lualib:GetVar(player,"N$系统击杀") == 0 then
            if isplayer(hiter) then
                sendmsg(player,2,'{"Msg":"<font color=\'#FFFFFF\'>玩家：神秘人 在 '..getbaseinfo(player,45)..getbaseinfo(player,4)..": 把 "..lualib:Name(player).." 干掉了！"..'</font>","Type":0,"BColor":0}')
            else
                lualib:SendMail(player,1,"被击杀","怪物  "..getbaseinfo(hiter,1).."  击杀了你","")
                sendmsg(player,2,'{"Msg":"<font color=\'#FFFFFF\'>怪物：'..lualib:Name(hiter)..' 在 '..getbaseinfo(player,45)..getbaseinfo(player,4)..":"..getbaseinfo(player,5).. " 把 "..lualib:Name(player).." 干掉了！"..'</font>","Type":0,"BColor":0}')
            end
        else
            lualib:SetVar(player,"N$系统击杀",0)
        end
    end

    GameEvent.push(EventCfg.onPlayDie,player,hiter)
end

function goldDrop(player)
    local mapID,x,y = lualib:GetMapId(player),lualib:X(player),lualib:Y(player)
    local gold = lualib:GetVar(player,VarCfg["局内金币"])
    if lualib:IsMainCity(player) then
        if gold > 0 then
            local t = {["金币"] = 10000}
            if gold < 10000 then
                t = {["金币"] = gold}
                gendropitem(mapID,nil,x,y,tbl2json(t),nil,2,1)
            else
                for i=1,36 do
                    t = {["金币"] = math.floor(gold/36)}
                    gendropitem(mapID,nil,x,y,tbl2json(t),nil,2,1)
                end
            end
            lualib:DelNeedItems(player,{"金币",gold},"死亡全爆")
        end
        dropEnhancedItem(player)
    end
end

function nextdie(player,hiter,isplayer)
    if hiter == "0" or not isnotnull(hiter) then
        close(player)
        goldDrop(player)
        showprogressbardlg(player,3,"@city_revive","复活进度条..",0,0,"")
        return
    end

    local num = Stats.revive(player)
    local times = 100 --复活时间
    local flag = 0
    local hp = 100
    local now = os.time()
    local shiYong = lualib:GetVar(player,VarCfg["已用复活次数"])
    --破复活
    local poFuHuo = 0           --破复活次数
    local id = ServerCache.Players[player].Equipments[115]
    local poFuHuoJiLv = 0
    if item_special_tb.special[115][id] ~= nil then
        local _data = item_special_tb.special[115][id]
        times = _data.hp
    end

    if flag == 0 and num > 0 and not lualib:HasBuff(player,20015) then
        if math.random(1,100) <= poFuHuoJiLv then
            poFuHuo = 1
            lualib:SendMsgGetColor(player,9,"#00ffea|成功破复活！！")
        end

        if num > (shiYong + poFuHuo) then
            flag = 1
            sendcentermsg(player,250 ,0 ,"复活触发！", 0, 2)
        end

        if now - lualib:GetVar(player,VarCfg["复活倒计时"]) >= times then
            if num - shiYong - poFuHuo - 1 <= 0 then
                lualib:SetVar(player,VarCfg["复活倒计时"],now)
                lualib:SetVar(player,VarCfg["已用复活次数"] ,num)
                lualib:AddBuff(player,20015,times,1,player,{})
            else
                lualib:SetVar(player,VarCfg["已用复活次数"] ,lualib:GetVar(player,VarCfg["已用复活次数"]) + 1)
            end
        end
    end

    if flag == 0 then
        local die_tb = {flag = flag,hp}
        die_tb.hp = hp
        GameEvent.push(EventCfg.onNextDie,player,hiter,isplayer,die_tb)
        flag = die_tb.flag
        hp = die_tb.hp
    end

    lualib:ShowFormWithContent(player,"NPC打开_closeMiniMap")
    -----结束
    if flag == 1 then
        lualib:Realive(player)        --复活
        lualib:SetHpEx(player,hp)
        lualib:SetMpEx(player,100)
        changemode(player,1,1)
        healthspellchanged(player)
        playeffect(player,30017,0,0,1,0,0)
        return ""
    else
        goldDrop(player)
        close(player)
        showprogressbardlg(player,3,"@city_revive","复活进度条..",0,0,"")
    end
    return ""
end

function city_revive(player)
    lualib:SetVar(player,"N$原地复活次数",0)
    lualib:Realive(player)        --复活
    cleardelaygoto(player)        --清除延迟跳转
    detoxifcation(player,-1)      --解毒
    lualib:GoHome(player)
    lualib:SetHpEx(player,100)
    healthspellchanged(player)
    return ""
end

function revival(player)
    return false
end

function revival_window(player)
    local str = [[
    <Img|x=-1000|y=-1000|width=4000|height=4000|img=public/all/shadow.png>
    <Img|ay=1|loadDelay=0|esc=0|hideMain=1|img=public/bg_npc_01.png|show=4|move=0|bg=1|reload=1>
    <Button|x=137.0|y=120.0|size=18|color=253|nimg=public/1900000612.png|text=500灵符复活|link=@revival_now>
    <Button|x=323.0|y=120.0|size=18|color=255|nimg=public/1900000612.png|text=回城复活|link=@city_revive>
    <COUNTDOWN|x=651|y=364|time=3|color=250|count=1|size=20|link=@city_revive>
    <RText|x=55.0|y=56.0|size=18|color=255|text=背包专属<凰后手绢/FCOLOR=70>触发，可以消耗<500灵符/FCOLOR=250>原地复活？>
    ]]

    lualib:Say(player,str,1)
end

function revival_now(player)
    local need = {"灵符",100}
    if not lualib:CheckNeedItems(player,need) then
        return ""
    end

    lualib:DelNeedItems(player,need,"复活扣除灵符")
    lualib:SetVar(player,VarCfg["灵符复活CD"],os.time())
    lualib:Realive(player)
    cleardelaygoto(player)  --清除延迟跳转
    detoxifcation(player,-1)   --解毒
    lualib:SetHpEx(player,100)
    healthspellchanged(player)
end