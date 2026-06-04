--开区时间计算
function start_game()
    if globalinfo(3) > 0 or lualib:GetDBVar(VarCfg["有人进入"]) < 2 then
        return ""
    end

    if checkkuafuserver() then
        return ""
    end

    if getsysvar(VarCfg["开服天数"]) == 0 then
        setsysvar(VarCfg["开服天数"],1)
    end

    local num = lualib:GetDBVar(VarCfg["开服分钟"]) + 1
    lualib:SetDBVar(VarCfg["开服分钟"],num)
    lualib:SetDBVar(VarCfg["活动时间"],os.time())

    if getsysvar(VarCfg["开服时间"]) == 0 then
        setsysvar(VarCfg["开服时间"],tonumber(os.time()))
        lualib:SetDBVar(VarCfg["开服分钟"],0)
    end

    setsysvar(VarCfg["开服时间"],tonumber(os.time()) - getsysvar(VarCfg["开服分钟"])*60)

    num = lualib:GetDBVar(VarCfg["开服分钟"])

    if num ~= 0 then
        if num%60 == 45 then
            sendmsgnew(globalinfo(0),251,0,"{【蚂蚁洞穴】：/FCOLOR=253}蚂蚁洞穴撤离时间结束，所有地图内玩家全部死亡，返回主城。",1,5)
            sendmovemsg(globalinfo(0),1,253,0,100,1,"{【蚂蚁洞穴】：/FCOLOR=58}蚂蚁洞穴撤离时间结束，所有地图内玩家全部死亡，返回主城")
            local tablePlayerList = getplayerlst()
            for _, v in ipairs(tablePlayerList) do
                if  lualib:IsMainCity(v) then
                    lualib:SetVar(v,"N$系统击杀",1)
                    kill(v,"0")
                end
            end

            for i=1,100 do
                if checkation(i) then
                    delnation(i)
                end
            end
        elseif num%60 == 30 then
            sendmsgnew(globalinfo(0),251,0,"{【蚂蚁洞穴】：/FCOLOR=253}蚂蚁洞穴入口关闭，本轮无法在进入地图",1,5)
            sendmovemsg(globalinfo(0),1,253,0,100,1,"{【蚂蚁洞穴】：/FCOLOR=58}蚂蚁洞穴入口关闭，本轮无法在进入地图")
        elseif num%60 == 0 then
            zhunBeiZhanDou.genMon(1)
            lualib:SetDBVar(VarCfg["密室1"],"")
            lualib:SetDBVar(VarCfg["拉闸撤离1"],0)
            if math.random(1,100) < 20 then
                lualib:SetDBVar(VarCfg["高爆局"],1)
            else
                lualib:SetDBVar(VarCfg["高爆局"],0)
            end

            lualib:SetDBVar(VarCfg["地图一阵营序号"],0)
            lualib:SetDBVar(VarCfg["开局时间1"],os.time())
            lualib:SetDBVar(VarCfg["撤离1"],"")
            lualib:SetDBVar(VarCfg["第几轮"],lualib:GetDBVar(VarCfg["第几轮"]) + 1)
            GameEvent.push(EventCfg.onOutputRecord,{start = 1})
            GameEvent.push(EventCfg.onConsumeRecord,{start = 1})
            sendmsgnew(globalinfo(0),251,0,"{【蚂蚁洞穴】：/FCOLOR=253}蚂蚁洞穴入口开放，新一轮游戏已经开始，速速进入地图",1,5)
            sendmovemsg(globalinfo(0),1,253,0,100,1,"{【蚂蚁洞穴】：/FCOLOR=58}蚂蚁洞穴入口开放，新一轮游戏已经开始，速速进入地图")

            for i=1,100 do
                if checkation(i) then
                    delnation(i)
                end
            end

        elseif num%60 == 59 then
            sendmsgnew(globalinfo(0),251,0,"{【蚂蚁洞穴】：/FCOLOR=253}蚂蚁洞穴入口还有1分钟开放，新一轮游戏即将开始，请各位玩家做好准备",1,5)
            sendmovemsg(globalinfo(0),1,253,0,100,1,"{【蚂蚁洞穴】：/FCOLOR=58}蚂蚁洞穴入口还有1分钟开放，新一轮游戏即将开始，请各位玩家做好准备")

            local tablePlayerList = getplayerlst()
            for _, v in ipairs(tablePlayerList) do
                lualib:SendMsgGetColor(v,9,"#ff0400|蜈蚣洞还剩1分钟就要开启了")
                lualib:SendMsgGetColor(v,9,"#11ff00|蜈蚣洞还剩1分钟就要开启了")
            end
        end
    else
        sendmsgnew(globalinfo(0),251,0,"{【蚂蚁洞穴】：/FCOLOR=253}蚂蚁洞穴入口开放，新一轮游戏已经开始，速速进入地图",1,5)
        sendmovemsg(globalinfo(0),1,253,0,100,1,"{【蚂蚁洞穴】：/FCOLOR=58}蚂蚁洞穴入口开放，新一轮游戏已经开始，速速进入地图")
    end
end