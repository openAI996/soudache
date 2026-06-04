GMTest = {}
GMTest_tb = include("Script/ExtendScript/cfgcsv/icon/cfg_GM测试.lua")
function GMTest.main(player)
    say(player,GMTest.updateLayout(player))
end

function GMTest.updateLayout(player)
    local h = 551
    local w = 854
    local str =  [[
        <Img|layerid=gift|ay=1|x=-10|y=0|width=]]..w..[[|height=]]..h..[[|loadDelay=0|esc=1|show=4|move=1|hideMain=0|bg=1|img=gmbox/1900000610.png>
        <Button|x=]]..(w-70)..[[|y=22|nimg=public/all/close.png|size=18|color=255|link=@exit>
        <Text|x=150|y=350|size=30|color=254|text=三种充值只能领取一种 请按需选择>

    ]]

    local servername =getconst(player,"<$SERVERNAME>")
    if servername == "内部测试1区" or servername == "视频录制（勿进）" or servername == "Svip测试区" then
        for i=1,#GMTest_tb do
            local x = 150 +(i-1)%3*200
            local y = 100 +  math.floor((i-1)/3)*50
            if i==7 or  i == 8 or i == 9 then
                if i == (#GMTest_tb - 1) then
                    str = str..[[<Button|x=]]..(x)..[[|y=]]..(y)..[[|nimg=gmbox/1900000679.png|size=18|color=255|text=]]..GMTest_tb[i][1]..[[|link=@@inputstring62(输入需要充值的金额：)>]]
                elseif i == #GMTest_tb then
                    str = str..[[<Button|x=]]..(x)..[[|y=]]..(y)..[[|nimg=gmbox/1900000679.png|size=18|color=255|text=]]..GMTest_tb[i][1]..[[|link=@@inputstring63(输入需要刷的道具：名字#数量)>]]
                else
                    str = str..[[<Button|x=]]..(x)..[[|y=]]..(y)..[[|nimg=gmbox/1900000679.png|size=18|color=255|text=]]..GMTest_tb[i][1]..[[|link=@gm_test_click,]]..i..[[>]]
                end
            end
        end
    else
        for i=1,#GMTest_tb do
            local x = 150 +(i-1)%3*200
            local y = 100 +  math.floor((i-1)/3)*50
            if i==7 or  i == 8 or i == 9 then
                if i == (#GMTest_tb - 1) then
                    str = str..[[<Button|x=]]..(x)..[[|y=]]..(y)..[[|nimg=gmbox/1900000679.png|size=18|color=255|text=]]..GMTest_tb[i][1]..[[|link=@@inputstring62(输入需要充值的金额：)>]]
                elseif i == #GMTest_tb then
                    str = str..[[<Button|x=]]..(x)..[[|y=]]..(y)..[[|nimg=gmbox/1900000679.png|size=18|color=255|text=]]..GMTest_tb[i][1]..[[|link=@@inputstring63(输入需要刷的道具：名字#数量)>]]
                else
                    str = str..[[<Button|x=]]..(x)..[[|y=]]..(y)..[[|nimg=gmbox/1900000679.png|size=18|color=255|text=]]..GMTest_tb[i][1]..[[|link=@gm_test_click,]]..i..[[>]]
                end
            end
        end
        --for i=1,#GMTest_tb do
        --    local x = 150 +(i-1)%3*200
        --    local y = 100 +  math.floor((i-1)/3)*50
        --    if i==7 or  i == 8 or i == 9 or i==12 or i==13 then
        --        if i == (#GMTest_tb - 1) then
        --            str = str..[[<Button|x=]]..(x)..[[|y=]]..(y)..[[|nimg=gmbox/1900000679.png|size=18|color=255|text=]]..GMTest_tb[i][1]..[[|link=@@inputstring62(输入需要充值的金额：)>]]
        --        elseif i == #GMTest_tb then
        --            str = str..[[<Button|x=]]..(x)..[[|y=]]..(y)..[[|nimg=gmbox/1900000679.png|size=18|color=255|text=]]..GMTest_tb[i][1]..[[|link=@@inputstring63(输入需要刷的道具：名字#数量)>]]
        --        else
        --            str = str..[[<Button|x=]]..(x)..[[|y=]]..(y)..[[|nimg=gmbox/1900000679.png|size=18|color=255|text=]]..GMTest_tb[i][1]..[[|link=@gm_test_click,]]..i..[[>]]
        --        end
        --    end
        --end
    end

    return str
end

function inputstring62(player)
    local servername =getconst(player,"<$SERVERNAME>")
    if servername ~= "内部测试1区" and servername ~= "视频录制（勿进）" and  servername ~= "Svip测试区" then

        return ""
    end

    local str = lualib:GetVar(player,"S62")
    local num = tonumber(str)

    local _data = GMTest_tb[#GMTest_tb - 1]
    for i=1,#_data.huobi do
        local huobi = _data.huobi[i]
        changemoney(player,huobi.id,"+",huobi[1]*num,"测试模拟充值",true)
    end

    recharge(player,num,0,_data.id)
    return ""
end

function inputstring63(player)
    local servername =getconst(player,"<$SERVERNAME>")
    if servername ~= "内部测试1区" and servername ~= "视频录制（勿进）" and  servername ~= "Svip测试区" then
        return ""
    end

    local str = lualib:GetVar(player,"S63")
    local tb = string.split(str,"#")
    if #tb ~= 2 then
        lualib:SendMsgGetColor(player,9,"#ff0000|请输入道具数量！！！")
        return ""
    end

    if not lualib:AddItem(player,tb[1],tonumber(tb[2])) then
        lualib:SendMsgGetColor(player,9,"#ff0000|道具添加失败！！！")
        return ""
    end
    return ""
end


function gm_test_click(player,param)
    local servername =getconst(player,"<$SERVERNAME>")
    if servername ~= "内部测试1区" and servername ~= "视频录制（勿进）" and  servername ~= "Svip测试区" then
        return ""
    end

    if lualib:GetFlag(player,VarCfg["充值测试"]) == 1 then
        lualib:SendMsgGetColor(player,9,"#ff0000|只能领取一次！！！")
        return ""
    end
    local num = tonumber(param)
    if num == 7 then
        lualib:SetFlag(player,VarCfg["充值测试"],1)
        local money = 10
        local _data = GMTest_tb[#GMTest_tb - 1]
        for i=1,#_data.huobi do
            local huobi = _data.huobi[i]
            changemoney(player,huobi.id,"+",huobi[1]*money,"测试模拟充值",true)
        end

        recharge(player,money,0,_data.id)

        lualib:DelNeedItems(player,jieBang.config[1].need,"解绑特权")
        lualib:SendMail(player,1,"解绑特权","解绑特权奖励内容",jieBang.config[1].give)
        lualib:SetFlag(player,VarCfg["特权"],1)
        lualib:AddTitle(player,jieBang.config[1].title)
        setplayvar(player,"HUMAN","回收是否解绑",1,1)
        ServerCache.onUpdatePlayerNumberVars(player, "解绑特权",1)
        TimerGift.SetIcon(player,1)
        lualib:MsgBox(player,"提示：你已经成功开通解绑特权！")

        -------------------------------------------成就系统开始---------------------------------------------------
        local t = chengJiuXiTong.getVar(player)
        if t[2][5][7] == 0 then
            t[2][5][7] = 1
            lualib:SetVar(player,VarCfg["成就系统"],tbl2json(t))
            lualib:MsgBox(player,"<font color='#00ff40'>恭喜你，获得隐藏成就：</font><font color='#eeff00'>"..chengJiuXiTong.config[2][5][7]["name"].."</font>")
        end
        -------------------------------------------成就系统结束---------------------------------------------------
        return ""
    end

    if num == 8 then
        lualib:SetFlag(player,VarCfg["充值测试"],1)
        local money = 1212
        local _data = GMTest_tb[#GMTest_tb - 1]
        for i=1,#_data.huobi do
            local huobi = _data.huobi[i]
            changemoney(player,huobi.id,"+",huobi[1]*money,"测试模拟充值",true)
        end

        recharge(player,money,0,_data.id)

        lualib:DelNeedItems(player,jieBang.config[1].need,"解绑特权")
        lualib:SendMail(player,1,"解绑特权","解绑特权奖励内容",jieBang.config[1].give)
        lualib:SetFlag(player,VarCfg["特权"],1)
        lualib:AddTitle(player,jieBang.config[1].title)
        setplayvar(player,"HUMAN","回收是否解绑",1,1)
        ServerCache.onUpdatePlayerNumberVars(player, "解绑特权",1)
        TimerGift.SetIcon(player,1)
        lualib:MsgBox(player,"提示：你已经成功开通解绑特权！")

        -------------------------------------------成就系统开始---------------------------------------------------
        local t = chengJiuXiTong.getVar(player)
        if t[2][5][7] == 0 then
            t[2][5][7] = 1
            lualib:SetVar(player,VarCfg["成就系统"],tbl2json(t))
            lualib:MsgBox(player,"<font color='#00ff40'>恭喜你，获得隐藏成就：</font><font color='#eeff00'>"..chengJiuXiTong.config[2][5][7]["name"].."</font>")
        end
        -------------------------------------------成就系统结束---------------------------------------------------
        return ""
    end

    if num == 9 then
        lualib:SetFlag(player,VarCfg["充值测试"],1)
        local money = 5186
        local _data = GMTest_tb[#GMTest_tb - 1]
        for i=1,#_data.huobi do
            local huobi = _data.huobi[i]
            changemoney(player,huobi.id,"+",huobi[1]*money,"测试模拟充值",true)
        end

        recharge(player,money,0,_data.id)

        lualib:DelNeedItems(player,jieBang.config[1].need,"解绑特权")
        lualib:SendMail(player,1,"解绑特权","解绑特权奖励内容",jieBang.config[1].give)
        lualib:SetFlag(player,VarCfg["特权"],1)
        lualib:AddTitle(player,jieBang.config[1].title)
        setplayvar(player,"HUMAN","回收是否解绑",1,1)
        ServerCache.onUpdatePlayerNumberVars(player, "解绑特权",1)
        TimerGift.SetIcon(player,1)
        lualib:MsgBox(player,"提示：你已经成功开通解绑特权！")

        -------------------------------------------成就系统开始---------------------------------------------------
        local t = chengJiuXiTong.getVar(player)
        if t[2][5][7] == 0 then
            t[2][5][7] = 1
            lualib:SetVar(player,VarCfg["成就系统"],tbl2json(t))
            lualib:MsgBox(player,"<font color='#00ff40'>恭喜你，获得隐藏成就：</font><font color='#eeff00'>"..chengJiuXiTong.config[2][5][7]["name"].."</font>")
        end
        -------------------------------------------成就系统结束---------------------------------------------------
        return ""
    end

    --if num == 1 then
    --    if lualib:GetFlag(player,VarCfg["特权"]) == 1 then
    --        lualib:SendMsgGetColor(player,9,"#ff0000|你已经成功开通解绑特权！！！")
    --        return ""
    --    end
    --    lualib:AddTitle(player,jieBang.config[1].title)
    --    local tb = lualib:CopyTable(jieBang.config[1].give[1])
    --    tb[1] = '绑定元宝'
    --    lualib:SendMail(player,1,"解绑特权","解绑特权奖励内容",{tb})
    --    lualib:SetFlag(player,VarCfg["特权"],1)
    --    setplayvar(player,"HUMAN","回收是否解绑",1,1)
    --    ServerCache.onUpdatePlayerNumberVars(player, "解绑特权",1)
    --    TimerGift.SetIcon(player,1)
    --    lualib:MsgBox(player,"提示：你已经成功开通解绑特权！")
    --elseif num == 2 then
    --    if lualib:GetFlag(player,VarCfg["首充礼包"]) == 1 then
    --        lualib:SendMsgGetColor(player,9,"#ff0000|已经领取过首充礼包了！！！")
    --        return ""
    --    end
    --    lualib:SendMail(player,1,"首充礼包","首充礼包奖励内容",shouChong.config.basic.mail)
    --    lualib:AddTitle(player,shouChong.config.basic.title)
    --    lualib:SetFlag(player,VarCfg["首充礼包"],1)
    --    TimerGift.SetIcon(player,1)
    --    lualib:SendMsgEx(player,9,"<font color='#00ff40'>首充礼包领取成功！！！</font>")
    --elseif num == 3 then
    --    changemoney(player,21,"+",100000000,"测试npc",true)
    --elseif num == 4 then
    --    changemoney(player,23,"+",100000000,"测试npc",true)
    --elseif num == 5 then
    --    local bag_item_tb = getbagitems(player)
    --    for i = 1, #bag_item_tb do
    --        lualib:DelItemObject(player,bag_item_tb[i])
    --    end
    --    lualib:SendMsgEx(player,9,"<font color='#00fff2'>提示：</font><font color='#00ff11'>清空背包！！！</font>")
    --elseif GMTest_tb[num].item ~= nil thenmj
    --    for i=1,#GMTest_tb[num].item do
    --        lualib:AddItem(player,GMTest_tb[num].item[i][1],GMTest_tb[num].item[i][2])
    --    end
    --    lualib:SendMsgEx(player,9,"<font color='#00fff2'>提示：</font><font color='#00ff11'>补发成功！！！</font>")
    --elseif num == 7 then
    --    if lualib:GetVar(player,VarCfg["每日礼包"]) == 1 then
    --        lualib:SendMsgGetColor(player,9,"#ff0000|已经领取过每日礼包了！！！")
    --        return ""
    --    end
    --    lualib:SetVar(player,VarCfg["每日礼包"],1)
    --    lualib:AddTitle(player,"日享特权")
    --    riChong.checkTimes(player,1)
    --    lualib:SendMail(player,3,"每日礼包奖励","每日礼包奖励",riChong.config.basic.mail)
    --    lualib:MsgBox(player,"恭喜你获得日享福利，请在邮件查收！")
    --    lualib:SendMsgGetColor(player,9,"#2bff00|成功领取日享礼包！！！")
    --elseif num == 10 then
    --    setgmlevel(player,10)
    --    lualib:SendMsgEx(player,9,"<font color='#00ff40'>欢迎回来，管理员！</font>")
    --    --gmexecute(player,"2")
    --    --gmexecute(player,"3")
    --end
    return ""
end

Message.RegisterClickMsg("GM测试", GMTest)
setFormAllowFunc("GM测试", {"main","click"})

return GMTest
