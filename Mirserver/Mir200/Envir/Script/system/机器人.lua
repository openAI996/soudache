--机器人 每小时提示
function hour_tips()

end

--机器人是否攻城
function castle_start()
    print("开始攻城-------------------------------------")
    if not lualib:GetCastle() then
        return ""
    end

    if lualib:GetDBVar(VarCfg["只开启一次本服攻城"]) == 1 and lualib:GetDBVar(VarCfg["今日是否攻城"]) == 0 then
        if checkkuafuconnect() then
            print("机器人通知跨服攻城开始")
            lualib:SetDBVar(VarCfg["跨服攻沙开启"],1)
            local tablePlayerList = getplayerlst()
            for _, v in ipairs(tablePlayerList) do
                kuaFuHuoDong.goActivity(v,4)
            end
            bfbackcall(3,"0","提示开始攻城")
            print("机器人通知跨服攻城结束")
        end
        return ""
    else
        addattacksabakall()
        sendmsgnew(globalinfo(0),58,0,"【沙巴克公告】：攻城已经开始，速度占领皇宫！",1,5)
        sendmovemsg(globalinfo(0),0,254,0,400,1,"【沙巴克公告】：攻城已经开始，速度占领皇宫！只有参与攻城才能获得奖励。")
    end
end
--机器人是否结束攻城
function castle_end()
    if not lualib:GetCastle() then
        return ""
    end

    if lualib:GetDBVar(VarCfg["只开启一次本服攻城"]) == 1 and lualib:GetDBVar(VarCfg["今日是否攻城"]) == 0 then
        ------------------------------发放奖励
        if lualib:GetDBVar(VarCfg["跨服攻沙开启"]) == 1 then
            lualib:SetDBVar(VarCfg["跨服攻沙开启"],0)
            bfbackcall(3,"0","结束跨服攻城")
        end
        return ""
    end

    sendmsgnew(globalinfo(0),58,0,"<【沙巴克公告】/FCOLOR=58>：攻城已经结束，稍后可以领取攻城奖励！",1,5)
end
--机器人攻城提示
function castle_tips()
    print("今日是否攻城")
    if not lualib:GetCastle() then
        print("今日不是攻城")
        return ""
    end

    if tonumber(globalinfo(3)) == 0 then
        print("是否攻城：没有合区.")
        return false
    end

    print("今日是攻城")
    if lualib:GetDBVar(VarCfg["只开启一次本服攻城"]) == 1 and lualib:GetDBVar(VarCfg["今日是否攻城"]) == 0 then
        if checkkuafuconnect() then
            print("机器人通知跨服攻城")
            clearhumcustvar("*","KFSZ1")
            bfbackcall(3,"0","通知跨服攻城")
            sendmsgnew(globalinfo(0),255,0,"<【跨服沙巴克公告】/FCOLOR=250>：今晚20点准点开启跨服攻城，21点攻城结束！！",1,5)
            sendmovemsg(globalinfo(0),1,253,0,100,1,"<【跨服沙巴克公告】/FCOLOR=250>：今晚20点准点开启跨服攻城，21点攻城结束！！")
            logact("0",10005,"跨服攻城")
        end
        return ""
    else
        local h = lualib:GetNumConst(globalinfo(0),"<$HOUR>")
        if h < 20 then
            bfbackcall(3,"0","通知跨服本服攻城")
            --tdummy(3,"*",200)
            lualib:dbg("攻城提示")
            addattacksabakall()
            sendmsgnew(globalinfo(0),255,0,"<【沙巴克公告】/FCOLOR=250>：今晚20点准点开启攻城，21点攻城结束！！",1,5)
            sendmovemsg(globalinfo(0),1,253,0,100,1,"<【沙巴克公告】/FCOLOR=250>：今晚20点准点开启攻城，21点攻城结束！！")
            logact("0",10005,"本服攻城")
        end
    end
end

function castle_init()
    if tonumber(globalinfo(3)) == 0 then
        lualib:SetDBVar(VarCfg["今日是否攻城"],0)
        lualib:SetDBVar(VarCfg["只开启一次本服攻城"],0)
        return false
    end
end

function day_clear()
    --第二天
    if getsysvar(VarCfg["开服天数"]) >= 1 then
        setsysvar(VarCfg["开服天数"],getsysvar(VarCfg["开服天数"])+1)
    end

    lualib:SetDBVar(VarCfg["阵营对抗红方"],0)
    lualib:SetDBVar(VarCfg["阵营对抗蓝方"],0)

    lualib:SetDBVar(VarCfg["今日是否攻城"],0)

    local tablePlayerList = getplayerlst()
    for _, player in ipairs(tablePlayerList) do
        lualib:SetVar(player,VarCfg["跨服押镖次数"],0)
        TimerGift.SetIcon(player,1)
        local name = "日进斗金"
        if ServerCache.Players[player].OtherEquip[name] ~= nil then
            lualib:DelAttrList(player,name)

            local random = lualib:GetVar(player,VarCfg["日进斗金"])
            if random == 0 then
                random = math.random(5,15)
                lualib:SetVar(player,VarCfg["日进斗金"],random)
            end

            lualib:AddAttrList(player,name,"=","3#207#"..(random*100))
            lualib:SendMsgGetColor(player,9,"#11ff00|日进斗金：|#f6ff00|获得"..random.."%回收增益")
        end
    end

    lualib:SetDBVar(VarCfg["今日是否跨服攻城"],0)
    clearhumcustvar("*","阵营对抗积分")
    clearhumcustvar("*","KFSZ1")
    clearhumcustvar("*","KFSZ2")
    lualib:SetDBVar(VarCfg["跨服胜利方奖励领取"] ,0)
    lualib:SetDBVar(VarCfg["阵营对抗红方"],0)
    lualib:SetDBVar(VarCfg["阵营对抗蓝方"],0)
    if tonumber(globalinfo(3)) == 0 then
        lualib:SetDBVar(VarCfg["今日是否攻城"],0)
        lualib:SetDBVar(VarCfg["只开启一次本服攻城"],0)
    end
end

function castle_receive()
    if not checkkuafuserver() then
        return ""
    end

    lualib:SetDBVar(VarCfg["跨服攻沙开启"],0)
    local castle = castleinfo(2)
    if castle == "" or castle == nil or castle == "0" then
        return ""
    end

    kfbackcall(10,"0",castle)
end

function chengjiu_3()
    local tablePlayerList = getplayerlst()
    for _, v in ipairs(tablePlayerList) do
        chengJiuXiTong.chengjiu_3(v)
    end
end
