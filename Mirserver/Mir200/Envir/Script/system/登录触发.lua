function login(player)
    ---print("登录出触发sssss")
    local servername = getconst(player,"<$SERVERNAME>")
    if string.find(servername,"内部测试") or string.find(servername,"视频录制（勿进）") or string.find(servername,"Svip测试区") then
        if lualib:GetVar(player,VarCfg["登录密码"]) ~= "正常登陆" and lualib:GetVar(player,VarCfg["登录密码"]) ~= "管理员" then
            miMa.main(player)
            return
        end
    end

    local userID = getbaseinfo(player,2)
    if cfg_ban_tb[userID] == 1 then
        lualib:MsgBox(player," 系统公告】：对不起，您的账号已被禁止登录。")
        lualib:MsgBox(player," 系统公告】：对不起，您的账号已被禁止登录。")
        offlineplay(player,10)
        kick(player)
        return ""
    end

    --合区禁止登录
    if getbaseinfo(player,47) and tonumber(globalinfo(3)) > 0 then
        local account = getconst(player,"<$USERACCOUNT>")
        if account_tb[account] == 1 then
            lualib:SetVar(player,VarCfg["登录记录"],"管理员")--
        else
            lualib:SetVar(player,VarCfg["登录记录"],"禁止")
            lualib:MsgBox(player," 系统公告】：对不起，合区后无法创建新的游戏角色。")
            offlineplay(player,10)
            kick(player)
            return ""
        end
    end

    local num = getsysvar(VarCfg["有人进入"])
    if num < 2 and lualib:GetFlag(player,VarCfg["第一次进入游戏"]) == 0 then
        lualib:SetFlag(player,VarCfg["第一次进入游戏"],1)
        setsysvar(VarCfg["有人进入"],num + 1)
        if num == 1 then
            lualib:SetDBVar(VarCfg["开服分钟"],0)
            lualib:SetDBVar(VarCfg["活动时间"],os.time())
        end
    end

    setgmlevel(player,0)
    local account = getconst(player,"<$USERACCOUNT>")
    if account_tb[account] ~= 1 then
        lualib:SetVar(player,VarCfg["登录记录"],"管理员")
    else
        setgmlevel(player,0)
    end

    lualib:SendMsgGetColor(player,0,"[提示]:欢迎"..lualib:Name(player).. "进入游戏..")
    if lualib:GetVar(player,VarCfg["登录记录"]) == "禁止" then
        lualib:MsgBox(player," 系统公告】：对不起，您的账号已被禁止登录。")
        offlineplay(player,10)
        kick(player)
        return ""
    end

    login_init_variable(player)
    lualib:SetVar(player,"N$登录触发",1)
    ServerCache.onInitPlayer(player)

    --setbaseinfo(player, 33, 0)
    setontimer(player, 1,60,0,1)     --一分钟定时器
    setontimer(player, 2, 1,0,1)    --1秒定时器
    setontimer(player, 3, 5,0,1)
    setontimer(player, 4,30,0,1)

    if lualib:GetVar(player,VarCfg["第一次登陆"]) == 0 then
        delaygoto(player,100,"first_login",1)
    else
        GameEvent.push(EventCfg.onLogin, player)
        ---lualib:GoHome(player)
    end
    lualib:SetFlag(player,VarCfg["特权"],1)
    ------------------------等级锁---------------------------------------------
    setlocklevel(player,1,36)
    ----lualib:AddHPEx(player,100)
    ----lualib:AddMPEx(player,100)
    ----------------------------------等级锁-----------------------------------
    if string.find(servername,"内部测试") or string.find(servername,"视频录制（勿进）") or string.find(servername,"Svip测试区") then
        if lualib:GetVar(player,VarCfg["登录密码"]) ~= "正常登陆" and lualib:GetVar(player,VarCfg["登录密码"]) ~= "管理员" then
            miMa.main(player)
            return
        else
            if account_tb[account] ~= nil then
                setgmlevel(player,10)
            end
        end
    end

    ----print("登录出触发ss2222sss")
    lualib:ShowFormWithContent(player, "右上图标_InitTask")
    genNPC(player)
    return ""
end

function login_init_variable(player)
    local guild = getmyguild(player)        --行会
    if guild ~= "0" then
    end

    iniplayvar(player,"integer","HUMAN","战斗力")
    iniplayvar(player,"integer","HUMAN","天选之人数值")
    iniplayvar(player,"integer","HUMAN","回收是否解绑")
    iniplayvar(player,"integer","HUMAN","是否自动使用")
    iniplayvar(player,"integer","HUMAN","阵营对抗积分")
    iniplayvar(player,"integer","HUMAN","KFSZ1")
    iniplayvar(player,"integer","HUMAN","KFSZ2")
    -----技能cd
end

function first_login(player)
    ServerCache.onUpdatePlayerNumberVars(player, "点击CD", os.clock())
    local list = lualib:AddItem(player,"沃玛套装卷轴(1级)",1,256 + 2)
    lualib:SetItemInt(player,list,1,1)

    list = lualib:AddItem(player,"沃玛套装卷轴(1级)",1,256 + 2)
    lualib:SetItemInt(player,list,1,1)

    list = lualib:AddItem(player,"沃玛套装卷轴(1级)",1,256 + 2)
    lualib:SetItemInt(player,list,1,1)

    refreshbag(player)
    lualib:SetVar(player,VarCfg["第一次登陆"],tonumber(os.time()))
    lualib:SetVar(player,VarCfg["到达大陆"],1)
    ---lualib:SetLevel(player,10)
    lualib:SetVar(player,VarCfg["等级"],1)
    lualib:SetVar(player,VarCfg["安全箱数量"],2)
    lualib:SetVar(player,VarCfg["负重"],40)
    sendmsg(player, 2, '{"Msg":"欢迎新的玛法勇士：“{'..lualib:Name(player)..'|251:0:1}”，{《搜打撤传奇》|250:0:1}有你更加精彩....","FColor":249,"BColor":255,"Type":1,"Time":3,"SendName":"《搜打撤传奇》","SendId":"123"}')
    GameEvent.push(EventCfg.onLogin, player)
    lualib:GoHome(player)
    return ""
end

function power(player)
    local str = ""
    local w = 500
    local h = 500
    str = str .. [[<Img|ay=1|x=-10|y=0|width=]]..w..[[|height=]]..h..[[|img=gmbox/0.png>]]
    str = str .. [[<Img|x=-1000|y=-1000|height=3000|width=3000|bg=1|img=gmbox/1900012572.png>
        <Button|x=]]..(700)..[[|y=200|nimg=public/all/button.png|text=请输入密码|size=18|color=255|link=@@inputstring12>
    ]]
    lualib:Say(player,str)
end

function inputstring12(player)
    local power = lualib:GetVar(player,"S12")
    local num = lualib:GetVar(player,"N$输入密码")
    if power == "lanyueliang" then
        lualib:SetVar(player,VarCfg["登录密码"],"正常登陆")
        close(player)
        login(player)
    else
        lualib:SetVar(player,"N$输入密码",num+1)
        lualib:SendMsgEx(player,9,"密码错误，请重新输入，剩余"..(2-num).."次！！")
        if num == 2 then
            lualib:MsgBox(player,"密码输入错误次数上限，踢出服务器！")
            kick(player)
        end
        return ""
    end
    return ""
end

function genNPC(player)
    if lualib:GetDBVar(VarCfg["是否生成npc"]) > 0 then
        return ""
    end

    local servername =getconst("0","<$SERVERNAME>")
    ---    if servername ~= "内部测试1区" and servername ~= "视频录制（勿进）" and  servername == "Svip测试区" then
    if servername == "内部测试1区" or servername == "视频录制（勿进）" or servername == "Svip测试区" then
        local npcInfo = {
            ["Idx"] =  9999,  -- 自定义NPC的Idx，NPC点击触发时，触发参数会传回Idx值
            ["npcname"] =  "测试npc", -- NPC名称
            ["appr"] =   7,  -- NPC外形效果
            ["script"] =   '',  -- NPC相关脚本名称，表示Envir\Market_def\NewNPC.txt
            ["limit"] = 6553500,
        }

        createnpc("3",332,332,tbl2json(npcInfo))
        lualib:SetDBVar(VarCfg["是否生成npc"],1)
   end
end




