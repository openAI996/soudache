math.randomseed(tostring(os.time()):reverse():sub(1, 7))
include("Script/ExtendScript/Util/util.lua")
local click_times = 0

function loadguild(player,guild)
    GameEvent.push(EventCfg.onGuildChange ,player,1)
end

function guildaddmemberafter(player,guild,name)
    GameEvent.push(EventCfg.onGuildChange ,player,2)
end

function guilddelmember(player)
    GameEvent.push(EventCfg.onGuildDelMember,player)
end

function guildclose(player)
    GameEvent.push(EventCfg.onGuildClose ,player)
end
--暴击触发
--function crittrigger(player, victim, damage, skillId)
--
--    return damage
--end
---查看别人装备触发
function lookhuminfo(player, name)
    lualib:SetVar(player,"S$查看别人装备",name)
end

-- 宝宝攻击前
function attackdamagebb(player, victim, attacker, skillId, damage)
    return damage
end

-- 宝宝魔法攻击后
function magicattackpet(player, victim, attacker, skillId)

end

-- 宝宝攻击后
function attackpet(player, victim, attacker, skillId)

end

-- 宝宝受击前
function struckdamagebb(player, attacker, victim, skillId, damage)
    return damage
end

-- 玩家受魔法攻击后
function magicstruck(player, attacker, victim, skillId)

end

-- 宝宝受魔法攻击后
function magicstruckpet(player, attacker, victim, skillId)

end

-- 宝宝受物理攻击后
function struckpet(player, attacker, victim, skillId)

end

--宝宝叛变前
function mobtreachery(player,mon)
   killmonbyobj(player,mon,false,false,false)
end
-- 丢失镖车后触发
function losercar(player, monster)

end

--杀死宝宝触发
function killslave(player, monster)

end

--称号改变
function titlechangedex(player,titleIdx)
    ---print(titleIdx,"称号改变")

end

-- 奔跑触发
function run(player)
    ----chouKa.main(player)
    --if not getbaseinfo(player,48) then
    --    local _data = ServerCache.Players[player].OtherEquip["火墙"]
    --    if _data ~= nil then
    --        if _data.level >= 7 then
    --            local cd = 2
    --            if os.time() - lualib:GetVar(player,"N$火墙CD") > cd then
    --                releasemagic(player,22,1,1,1,0)
    --                lualib:SetVar(player,"N$火墙CD",os.time())
    --            end
    --        end
    --    end
    --end

    --local mapID,x,y = lualib:GetMapId(player),lualib:X(player),lualib:Y(player)
    --local gold = lualib:GetMoneyID( player,{"金币",1})
    --if not lualib:IsMainCity(player) then
    --    for i=1,20 do
    --        local t = {["金币"] = 10000}
    --        gendropitem(mapID,nil,x,y,tbl2json(t),nil,2,1)
    --    end
    --end

    --local mapName = ServerCache.getPlayerNumberVars(player,"当前地图")
    --GameEvent.push(EventCfg.onRun,player,mapName)
    --local now = os.time()
    --if getbaseinfo(player,48) and mapName == "n3" then
    --    if lualib:GetDBVar(VarCfg["激情酷跑开启"]) == 1 then
    --        if now - getplaydef(player,"N$跑酷间隔")  > 2 then
    --            local weight = lualib:Weight(cfg_run_tb)
    --            lualib:AddNeedBindItems(player,cfg_run_tb[weight].give)
    --            lualib:SendMsgGetColor(player,9,"#91ff00|提示：|#00ffd5|您在跑酷过程中获得【"..cfg_run_tb[weight].give[1].."*"..cfg_run_tb[weight].give[2].."】")
    --            setplaydef(player,"N$跑酷间隔",now)
    --            local num = lualib:GetVar(player,"N$天天跑酷奖励")
    --            lualib:SetVar(player,"N$天天跑酷奖励",num+1)
    --            if num + 1 == 10 then
    --                if lualib:GetFlag(player,VarCfg["酷跑活跃度"]) == 0 then
    --                    lualib:SetFlag(player,VarCfg["酷跑活跃度"],1)
    --                    lualib:SendMail(player,1,"跑酷活跃度","参与跑酷获得活动积分！！",{{"活动积分",10}})
    --                end
    --            end
    --        end
    --    end
    --end

end

function dropEnhancedItem(player)
    -- 获取玩家位置
    local mapId = getbaseinfo(player, 3)  -- 当前地图ID
    local x = getbaseinfo(player, 4)      -- 当前X坐标
    local y = getbaseinfo(player, 5)      -- 当前Y坐标

    local bag_item_tb = getbagitems(player)
    for i = 1, #bag_item_tb do
        local num = getiteminfo(player,bag_item_tb[i],5)
        local name = lualib:ItemName(player,bag_item_tb[i])
        local json = getthrowitemly(player,bag_item_tb[i])
        local idx = getiteminfo(player,bag_item_tb[i],1)
        local chiJiu = getdura(player,idx)
        local rule = getitemaddvalue(player,bag_item_tb[i],2,1)
        local var = lualib:GetItemInt(player,bag_item_tb[i],1)
        num = num == 0 and 1 or num
        lualib:DelItemObject(player,bag_item_tb[i])
        if name ~= "天纵钥匙" then
            local t = {[name] = num}
            local list = gendropitem(mapId,nil,x,y,tbl2json(t),json,2,1)
            if var == 0 then
                for j=1,#list do
                    local item = getitembymakeindex(player,list[i])
                    setitemstate(list[i],2,0)
                    setdura(player,item,chiJiu)
                    setitemaddvalue(player,item,2,1,rule)
                    lualib:SetItemInt(player,item,1,var)
                end
            end
        end
    end

    for i = 1,#cheLiDian.size do
        local item = lualib:GetItem(player,cheLiDian.size[i])
        if item ~= "0" then
            local num = getiteminfo(player,item,5)
            local name = lualib:ItemName(player,item)
            local json = getthrowitemly(player,item)
            local idx = getiteminfo(player,item,1)
            local chiJiu = getdura(player,idx)
            local rule = getitemaddvalue(player,item,2,1)
            local var = lualib:GetItemInt(player,item,1)
            num = num == 0 and 1 or num
            lualib:DelItemObject(player,item)

            local t = {[name] = num}
            local list = gendropitem(mapId,nil,x,y,tbl2json(t),json,2,1)
            if var == 0 then
                for j=1,#list do
                    item = getitembymakeindex(player,list[i])
                    setitemstate(list[i],2,0)
                    setdura(player,item,chiJiu)
                    setitemaddvalue(player,item,2,1,rule)
                    lualib:SetItemInt(player,item,1,var)
                end
            end
        end
    end
end

-- 走路触发
function walk(player)
    --if hasbuff(player,10013) then
    --    imprisonment(player)
    --end
    local mapName = ServerCache.Players[player].StringVars["当前地图"]
    GameEvent.push(EventCfg.onRun,player,mapName)
end

-- 升级触发
function playlevelup(player)

    local level = lualib:Level(player)
    GameEvent.push(EventCfg.onPlayLevelUp,player,level)
    --healthspellchanged(player)
end

-- 属性变化时触发
function sendability(player)
    -----GameEvent.push(EventCfg.onLoadAttr, player)
    if ServerCache.getPlayerNumberVars(player,"属性变化") == 1 then
        ServerCache.onUpdatePlayerNumberVars(player,"属性变化",0)
        Stats.load(player)
    end
end

--攻城开始时触发
function castlewarstart()
    repaircastle()
end

--攻城结束时触发
function castlewarend()
    repaircastle()
end

-- 占领沙巴克触发
function getcastle0()

end

-- 获得宝宝触发
function slavebb(player, monster)
end

--拍卖行上架触发
function canpaimaiitem(player)
    if lualib:IsMainCity(player) then
        lualib:SendMsgGetColor(player,9,"#ff0800|该地图无法使用拍卖行!!")
        allowpaimai(player,1)
        return ""
    end

    if  checkkuafu(player) then
        lualib:SendMsgGetColor(player,9,"#e7eb00|跨服禁止拍卖行行为！！")
        allowpaimai(player,1)
        return false
    end
    return  false
end


--拍卖行购买
function buypaimaiitem(player)
    if lualib:IsMainCity(player) then
        lualib:SendMsgGetColor(player,9,"#ff0800|该地图无法使用拍卖行!!")
        allowpaimai(player,1)
        return ""
    end

    if  checkkuafu(player) then
        allowpaimai(player,1)
        lualib:SendMsgGetColor(player,9,"#e7eb00|跨服禁止拍卖行行为！！")
        return false
    end
    return
end

function cangetbackpaimaiitem(player)
    if lualib:IsMainCity(player) then
        lualib:SendMsgGetColor(player,9,"#ff0800|该地图无法使用拍卖行!!")
        allowpaimai(player,1)
        return ""
    end

    if  checkkuafu(player) then
        lualib:SendMsgGetColor(player,9,"#e7eb00|跨服禁止拍卖行行为！！")
        allowpaimai(player,1)
        return false
    end
end

function getpaimaiitem(player)
    if lualib:IsMainCity(player) then
        lualib:SendMsgGetColor(player,9,"#ff0800|该地图无法使用拍卖行!!")
        allowpaimai(player,1)
        return ""
    end

    if  checkkuafu(player) then
        lualib:SendMsgGetColor(player,9,"#e7eb00|跨服禁止拍卖行行为！！")
        allowpaimai(player,1)
        return false
    end
end

function biddingpaimaiitem(player)
    if lualib:IsMainCity(player) then
        lualib:SendMsgGetColor(player,9,"#ff0800|该地图无法使用拍卖行!!")
        allowpaimai(player,1)
        return ""
    end

    if  checkkuafu(player) then
        lualib:SendMsgGetColor(player,9,"#e7eb00|跨服禁止拍卖行行为！！")
        allowpaimai(player,1)
        return false
    end
end

function canbuyshopitem5(player)
end

function dealbefore(player1,player2)
    return false
end

function dropitemfrontex(player,item,itemName,model)
    if model == 0 then
        if not lualib:IsMainCity(player) then
            lualib:SendMsgGetColor(player,9,"#ff0800|该地图无法丢弃物品!!")
            return false
        end
    end
    ---print("itemName = ",itemName)
    return true
end

function dropitemex(player,item,itemName)
    zhunBeiZhanDou.daojishi(player)
end

function dropgoldfront(player)
    lualib:SendMsgGetColor(player,9,"#ff0800|该地图无法丢弃金币!!")
    return false
end

function canshowshopitem1(player)
    if lualib:IsMainCity(player) then
        notallowshow(player,1)
    else
        notallowshow(player,0)
    end
end

function canshowshopitem2(player)
    if lualib:IsMainCity(player) then
        notallowshow(player,1)
    else
        notallowshow(player,0)
    end
end

function canshowshopitem3(player)
    if lualib:IsMainCity(player) then
        notallowshow(player,1)
    else
        notallowshow(player,0)
    end
end

function canshowshopitem4(player)
    if lualib:IsMainCity(player) then
        notallowshow(player,1)
    else
        notallowshow(player,0)
    end
end

function canshowshopitem5(player)
    if lualib:IsMainCity(player) then
        notallowshow(player,1)
    else
        notallowshow(player,0)
    end
end

--货币变化时回调
function moneychange1(player)
    if lualib:IsMainCity(player) then
        local num = querymoney(player,1) - lualib:GetVar(player,VarCfg["进入时金币"])
        if num < 0 then
            num = 0
        end

        lualib:SetVar(player,VarCfg["局内金币"],num)
        zhunBeiZhanDou.daojishi(player)
    end

    if querymoney(player,1) > 3500000000 then
        changemoney(player,1,"-",500000000,"超过35亿自动转换",true)
        lualib:SendMailEx(player,1,"金币超额提示","尊敬的玩家，您的账户元宝超过35亿，系统帮您自动将5亿元宝转化成“500000000金币”。","1#500000000")
        return true
    end
    ----GameEvent.push(EventCfg.onChangeYuanBao,player)
    return true
end
--货币变化时
function moneychange3(player)
    if querymoney(player,3) > 3500000000 then
        changemoney(player,3,"-",500000000,"超过35亿自动转换",true)
        lualib:SendMailEx(player,1,"元宝超额提示","尊敬的玩家，您的账户元宝超过35亿，系统帮您自动将5亿元宝转化成“500000000元宝”。","3#500000000")
        return true
    end
    return true
end

--货币变化时回调
function moneychange21(player)
    if querymoney(player,21) > 3500000000 then
        changemoney(player,21,"-",500000000,"超过35亿自动转换",true)
        lualib:SendMailEx(player,1,"金币超额提示","尊敬的玩家，您的账户元宝超过35亿，系统帮您自动将5亿元宝转化成“500000000元宝”。","21#500000000")
        return true
    end
    GameEvent.push(EventCfg.onChangeYuanBao,player)
    return true
end
--货币变化时
function moneychange22(player)
    if querymoney(player,22) > 3500000000 then
        changemoney(player,22,"-",500000000,"超过35亿自动转换",true)
        lualib:SendMailEx(player,1,"元宝超额提示","尊敬的玩家，您的账户元宝超过35亿，系统帮您自动将5亿元宝转化成“500000000元宝”。","22#500000000")
        return true
    end
    GameEvent.push(EventCfg.onChangeYuanBao,player)
    return true
end

--货币变化时回调
function moneychange23(player)
    if querymoney(player,23) > 3500000000 then
        changemoney(player,1,"-",500000000,"超过35亿自动转换",true)
        lualib:SendMailEx(player,1,"灵符超额提示","尊敬的玩家，您的账户灵符超过35亿，系统帮您自动将5亿灵符转化成“500000000灵符”。","23#500000000")
        return true
    end
    return true
end
--货币变化时
function moneychange24(player)
    if querymoney(player,24) > 3500000000 then
        changemoney(player,24,"-",500000000,"超过35亿自动转换",true)
        lualib:SendMailEx(player,1,"灵符超额提示","尊敬的玩家，您的账户灵符超过35亿，系统帮您自动将5亿灵符转化成“500000000灵符”。","24#500000000")
        return true
    end
    return true
end
--断线重连
function reboxtile()

end

function startautoplaygame(player)
    lualib:SetVar(player,"N$挂机状态",1)
    --stopautoattack(player)
    --lualib:SetVar(player,"N$挂机状态",0)
    GameEvent.push(EventCfg.onAutoPlayGame,player,1)
end

function stopautoplaygame(player)
    lualib:SetVar(player,"N$挂机状态",0)

    GameEvent.push(EventCfg.onAutoPlayGame,player,0)
end

function bindrewechat(player)
    --if lualib:GetVar(player, VarCfg["微信扶持"]) > 0 then
    --    lualib:MsgBox(player,"【注意】：您已经领取了今天的扶持奖励，请明天再来。")
    --    return ""
    --end
    --
    --local bag = getbagblank(player) - 6
    --if bag < 2 then
    --    lualib:MsgBox(player,"【注意】：包裹空间不足，无法领取奖励。")
    --    return ""
    --end
    --
    --if lualib:GetVar(player, VarCfg["微信扶持"]) == 0 then
    --    lualib:SetVar(player, VarCfg["微信扶持"],1)
    --    local tb = welfare.config[5][2]
    --    for i=1,#tb do
    --        if tb[i][1] < 100 then
    --            changemoney(player,tb[i][1],"+",tb[i][3],"每日扶持奖励",true)
    --        else
    --            lualib:AddItem(player,tb[i][2],tb[i][3],307)
    --        end
    --    end
    --    lualib:MsgBox(player,"【提示】：成功领取每日扶持奖励，记得每天都来哟！")
    --    return ""
    --end
end

function bindwechat(player)
    --if lualib:GetVar(player,  VarCfg["微信扶持"]) > 0 then
    --    lualib:MsgBox(player,"【注意】：您已经领取了今天的扶持奖励，请明天再来。")
    --    return ""
    --end
    --
    --lualib:MsgBox(player,"你获取的微信KEY："..getconst(player,"<$WECHATKEY>"))
    --lualib:SetVar(player,"S$公众号验证码",getconst(player,"<$WECHATKEY>"))
    --Message.sendmsg(player, ssrNetMsgCfg.welfare_UpdataResponse,5,0,0,welfare.getTable(player))
end

function auto_action(player)
    tongyong.autoGame(player)
end

function buffchange(player, buffId, group, type)
    --print("buffchange buffId="..buffId.." group="..group.." type="..type)
    if type == 1 then
        GameEvent.push(EventCfg.onAddBuff, player, buffId, group)
    elseif type == 4 then
        GameEvent.push(EventCfg.onDelBuff, player, buffId, group)
    end

    --if buffId == 20015 then
    --    if type == 4 then
    --        lualib:SetVar(player,VarCfg["已用复活次数"] ,0)
    --    end
    --end
end
--PK
function pkpointchanged(player,pk)
    GameEvent.push(EventCfg.onPKChange,player,pk)
end
-- NPC点击触发
function clicknpc(player, npcId)
    lualib:dbg("clicknpc npcId = " ..npcId)
    local servername = getconst(player,"<$SERVERNAME>")
    if string.find(servername,"内部测试")  then
        if lualib:GetVar(player,VarCfg["登录密码"]) ~= "正常登陆" and lualib:GetVar(player,VarCfg["登录密码"]) ~= "管理员" then
            kick(player)
        end
    end

    if npcId == 9999 then
        GMTest.main(player)
    elseif npcId == 10000 then
        moWangMoYi.fenShen(player)
    elseif npcId == 10001 then
        moWangMoYi.moGuan1(player)
    elseif npcId == 10002 then
        moWangMoYi.jinJi(player)
    else
        local _stringScriptCallback = NPC.getCallback(npcId)
        if _stringScriptCallback then
            click(player, _stringScriptCallback,tostring(npcId))
        end
    end
end
--gmbox触发
function usercmd1(player,power)
    local name = lualib:Name(player)
    local account = getconst(player,"<$USERACCOUNT>")
    if power == "youhualong666" then
        print("当前账号："..account)
        if account_tb[account] == 1  then
            setgmlevel(player,10)
            yatools.main(player)
            logact(player,10001,"gm工具使用:"..name..",唯一ID:"..account)
            release_print(name.."使用GM工具,唯一ID:"..account)
        else
            release_print(name.."使用GM工具失败,唯一ID:"..account)
        end
    else
        release_print(name.."使用GM工具失败,唯一ID:"..account)
    end
end

function usercmd2(player)
    if true then
        return ""
    end
end

function tang_ce(player)
    if true then
        return ""
    end

    local str =getconst(player,"<$NPCINPUT(1)>")
    local guid = getplayerbyname(str)

    if guid == nil or guid == "" then
        guid = player
        lualib:MsgBox(player,"玩家不存在或是不在线！！")
        return ""
    end

    lualib:SetVar(player,"N$罗生天的血咒CD",os.time())
    lualib:SendMsgGetColor(player,6,"目标当前所在位置:"..getbaseinfo(guid,45))
    lualib:MsgBox(player,"目标当前所在位置:"..getbaseinfo(guid,45))
    return ""
end
--添加好友触发
function addfriendrequest(player)
    --local rein = tonumber(getbaseinfo(player,39))
    --if rein < 3 then
    --    lualib:MsgBox(player,"【提示】：角色低于3转，无法添加好友，")
    --    return ""
    --end
    return false
end
--行会公告触发
function updateguildnotice(player)
    lualib:MsgBox(player,"【操作失败】：服务器目前禁止编辑修改公告。")
    return false
end
--	聊天触发
function triggerchat(player,sMsg,chat,msgType)
    --print("xsxsxsxsxxs")
    --print(sMsg,chat)
    --if chat ~= 8 and chat ~= 9 then
    --    for i=1,#no_character_tb do
    --        if string.find(sMsg,no_character_tb[i]) then
    --            print(i,no_character_tb[i])
    --            lualib:SendMsgEx(player,9,"该名字含有禁止字符！！")
    --            return false
    --        end
    --    end
    --end

    --if lualib:GetFlag(player,VarCfg["特权"]) == 0 and lualib:Level(player) < 120 then
    --    lualib:SendMsgEx(player,9,"<font color='#ff0000'>【提示】：请先开通特权或120级！！</font>")
    --    return false
    --end

    return true
end

-- 退出游戏触发
function playoffline(player)
    detoxifcation(player,-1)
    setofftimer(player, 1)
    setofftimer(player, 2)
    setofftimer(player, 3)
    setofftimer(player, 4)
    setofftimer(player, 5)
    setofftimer(player, 66)

    if lualib:IsMainCity(player) then
        offlineplay(player,40*60)
    end
end

function playreconnection(player)
    if lualib:IsMainCity(player) then
        offlineplay(player,40*60)
    end
end

--接受网络消息
function handlerequest(player, msgid, arg1, arg2, arg3, sMsg)
    ---release_print("收到客户端的"..msgid.."消息",arg1, arg2, arg3, sMsg)
    if msgid == 3081 then
        if lualib:IsMainCity(player) then
            lualib:SendMsgGetColor(player,9,"#ff0800|该地图无法使用邮件功能!!")
            allowpaimai(player,1)
            return ""
        end
    end

    if msgid == 666 then
        local MsgData = json2tbl(sMsg)
        if MsgData.script == "" or MsgData.script == nil then
            return ""
        end

        if type(MsgData.script) ~= "string" then
            release_print("无效消息" .. type(MsgData.script) .. ")")
            return ""
        end

        if not string.find(MsgData.script,"_") then
            release_print("无效消息" .. type(MsgData.script) .. ")")
            return ""
        end

        if not string.find(MsgData.script,"装备回收") then
            if ServerCache.Players[player].NumberVars["点击CD"] ~= nil then
                if ServerCache.Players[player].NumberVars["点击CD"] + 0.1 > os.clock() then
                    if  ServerCache.Players[player].NumberVars["点击CD"] + 3 < os.clock() then
                        ServerCache.onUpdatePlayerNumberVars(player, "点击CD", os.clock())
                        return ""
                    end
                    return ""
                end
            end

            ServerCache.onUpdatePlayerNumberVars(player, "点击CD", os.clock())
        end

        click(player,MsgData.script,unpack(MsgData.paramList))
    else
        release_print("客户端收到非法消息："..msgid.." 来自玩家："..lualib:Name(player))
        kick(player)
    end
end

--寻路开启dropgoldfront
function findpathbegin(player)
    local x = getconst(player, "<$ToPointX>")
    local y = getconst(player, "<$ToPointY>")
    if getgmlevel(player) == 10 then
       mapmove(player,getbaseinfo(player,3),x,y,1)
    end
    lualib:SetVar(player,VarCfg["自动寻路坐标"],tbl2json({x,y}))
end
--寻路中断
function findpathstop(player)
    lualib:SetVar(player,VarCfg["自动寻路坐标"],"")
    --if lualib:GetVar(player,"N$自动跑酷") == 1 then
    --    if getbaseinfo(player,48) and lualib:GetMapId(player) == "n3" then
    --        gotonow(player,math.random(324,336),math.random(324,336))
    --        ---gotonow(player,math.random(280,300),math.random(382,402))
    --    else
    --        lualib:SetVar(player,"N$自动跑酷",0)
    --    end
    --end
end
--寻路结束
function findpathend(player)
    lualib:SetVar(player,VarCfg["自动寻路坐标"],"")
    --if lualib:GetVar(player,"N$自动跑酷") == 1 then
    --    if getbaseinfo(player,48) and lualib:GetMapId(player) == "n3" then
    --        gotonow(player,math.random(324,336),math.random(324,336))
    --    else
    --        lualib:SetVar(player,"N$自动跑酷",0)
    --    end
    --end
end

local config = {
    ["10039"] = 10,
    ["10040"] = 50,
    ["10041"] = 100,
    ["10042"] = 500,
    ["10043"] = 1000,
    ["10044"] = 10000,
}

function recycling(player)
    local str = getconst(player,"<$RECYITEMS>")
    local recycle_tb = stringToTable(str)
    local num = tonumber(getconst(player,"<$RECYITEMSCNT>"))
    local receive_tb = {
        ["21"] = {"元宝",0},
        ["22"] = {"绑定元宝",0},
    }

    if num > 0 then
        local money = 0
        for k,v in pairs(recycle_tb) do
            if config[k] ~= nil then
                money = money + config[k] * recycle_tb[k]
            end
        end

        local scale = ServerCache.Players[player].NumberVars["回收倍数"]
        if scale > 0 then
            for k,v in pairs(receive_tb) do
                local id = tonumber(k)
                if recycle_tb[k] ~= nil then
                    if id < 100 then
                        local count = math.floor((recycle_tb[k]-money)*(scale))
                        lualib:AddMoneyID(player,{receive_tb[k],count},count,"装备回收倍数")
                    end

                    if money > 0  then
                        if lualib:GetVar(player,"N$积少成多") == 1 then
                            lualib:AddMoneyID(player,{receive_tb[k],0},money * 0.05,"装备回收")
                        end
                    end
                end
            end
        end
    end

    return true
end


function stringToTable(input)
    local result = {}

    for pair in input:gmatch("[^,]+") do
        local key, value = pair:match("(%d+)=(%d+)")
        if key and value then
            result[tostring(key)] = tonumber(value)
        end
    end

    return result
end



----------------------------------机器人---------------------------
--
--function update_right(player)
--    ScreenBtnData.right_up_Icon(player)
--end
------------------------------爆率触发脚本-------------------------------------------------------

function groupaddmember(player)
    GameEvent.push(EventCfg.onGroupChange,player,2)
end

function groupcreate(player)
    lualib:SetVar(player,"N$创建队伍",1)
    GameEvent.push(EventCfg.onGroupChange,player,1)
end

function guildaddmember(player,guild)

end

function groupkillmon(player)

end

function leavegroup(player)
    lualib:SetVar(player,"N$创建队伍",0)
    print("离开队伍")
    GameEvent.push(EventCfg.onGroupChange,player,3)
end

function groupdelmember(player)
    print("踢出队伍")
end

function getexp(player,exp)
    exp = 0
    --local level = lualib:Level(player)
    --if level >= 36 then
    --    return 0
    --end

    return exp
end

function quxiao(player)
    return ""
end

function beginteleport(player,x,y)

    if true then
        return false
    end

    local times = os.time()
    local mapID = lualib:GetMapId(player)
    if special_map_tb["禁止定点传送"][mapID] == 1 then
        lualib:SendMsgGetColor(player,9,"#db1200|当前地图禁止使用定点传送！！！")
        return false
    end

    local cd = 999999
    if ServerCache.Players[player].Equipments[15]  == nil then
        return false
    end

    if item_special_tb.special[15][ServerCache.Players[player].Equipments[15]] == nil then
        return ""
    end

    cd = item_special_tb.special[15][ServerCache.Players[player].Equipments[15]].cd

    if times - lualib:GetVar(player,"N$飞随机cd") < cd  then
        lualib:SendMsgGetColor(player,9 ,"#db1200|传送冷却中，剩余"..(cd - times + lualib:GetVar(player,"N$飞随机cd")).."秒")
        return false
    end

    lualib:SetVar(player,"N$飞随机cd",times)

    return true
end

function go_home(player)
    lualib:GoHome(player)
    return ""
end

function checkdropuseitems(player,where,idx)
    if lualib:Is_Safe(player) then
        return false
    end

    return true
end

function collectmonex(player,idx,monsterName,id)
    if lualib:GetBagNum( player) == 0 then
        lualib:SendMsgGetColor(player,9,"#db1200|背包已满")
        return false
    end
    local times = 10
    if ServerCache.Players[player].OtherEquip["妙手空空"] ~= nil then
        times = 5
    end

    if monsterName == "檀木宝箱" then
        lualib:SetVar(player,"S$檀木宝箱",id)
        showprogressbardlg(player,times,"@caiji_1","正在进行采集,进度%d%.", 1,"@caiji_over")
    end

    if monsterName == "紫铜宝箱" then
        lualib:SetVar(player,"S$紫铜宝箱",id)
        showprogressbardlg(player,times,"@caiji_2","正在进行采集,进度%d%.", 1,"@caiji_over")
    end

    if monsterName == "白银宝箱" then
        lualib:SetVar(player,"S$白银宝箱",id)
        showprogressbardlg(player,times,"@caiji_3","正在进行采集,进度%d%.", 1,"@caiji_over")
    end

    if monsterName == "赤金宝箱" then
        lualib:SetVar(player,"S$赤金宝箱",id)
        showprogressbardlg(player,times,"@caiji_4","正在进行采集,进度%d%.", 1,"@caiji_over")
    end

    if monsterName == "黄金宝箱" then
        lualib:SetVar(player,"S$黄金宝箱",id)
        showprogressbardlg(player,times,"@caiji_5","正在进行采集,进度%d%.", 1,"@caiji_over")
    end

    local data = {is = true}
    GameEvent.push(EventCfg.onCollectMonEx, player, idx, monsterName, id,data)
    return data.is
end

function bufftriggerhpchange(player,buffID,buffGroup,damage,buffHost,mon)
    local data = {damage = damage}
    GameEvent.push(EventCfg.onBuffHpChange,player,buffID,buffGroup,data,buffHost,mon)
    return data.damage
end
--------------------------------采集---------------------------------------
function caiji_1(player)
    if lualib:GetVar(player,"S$檀木宝箱") ~= "" then
        local mon = getmonbyuserid(lualib:GetMapId(player),lualib:GetVar(player,"S$檀木宝箱"))
        if isnotnull(mon) then
            kill(mon,player)
            lualib:SetVar(player,"N$宝箱",1)
            lualib:SetVar(player,"S$檀木宝箱","")
            baoXiang.main(player)
        else
            lualib:SendMsgGetColor(player,9,"#ff0008|采集失败，已经被别人采集")
        end

        lualib:SetVar(player,"S$檀木宝箱","")
    end
end

function caiji_2(player)
    if lualib:GetBagNum( player) == 0 then
        lualib:SetVar(player,"S$紫铜宝箱","")
        lualib:SendMsgGetColor(player,9,"#db1200|背包已满")
        return false
    end

    if lualib:GetVar(player,"S$紫铜宝箱") ~= "" then
        local mon = getmonbyuserid(lualib:GetMapId(player),lualib:GetVar(player,"S$紫铜宝箱"))
        kill(mon,player)
        lualib:SetVar(player,"S$紫铜宝箱","")
    else
        lualib:SendMsgGetColor(player,9,"#ff0008|采集失败，已经被别人采集")
    end
end

function caiji_3(player)
    if lualib:GetBagNum( player) == 0 then
        lualib:SetVar(player,"S$白银宝箱","")
        lualib:SendMsgGetColor(player,9,"#db1200|背包已满")
        return false
    end

    if lualib:GetVar(player,"S$白银宝箱") ~= "" then
        local mon = getmonbyuserid(lualib:GetMapId(player),lualib:GetVar(player,"S$白银宝箱"))
        if isnotnull(mon) then
            kill(mon,player)
            lualib:SetVar(player,"N$宝箱",2)
            lualib:SetVar(player,"S$白银宝箱","")
            baoXiang.main(player)
        else
            lualib:SendMsgGetColor(player,9,"#ff0008|采集失败，已经被别人采集")
        end
    end
end

function caiji_4(player)
    if lualib:GetBagNum( player) == 0 then
        lualib:SetVar(player,"S$赤金宝箱","")
        lualib:SendMsgGetColor(player,9,"#db1200|背包已满")
        return false
    end

    if lualib:GetVar(player,"S$赤金宝箱") ~= "" then
        local mon = getmonbyuserid(lualib:GetMapId(player),lualib:GetVar(player,"S$赤金宝箱"))
        kill(mon,player)
        lualib:SetVar(player,"S$赤金宝箱","")
    end
end

function caiji_5(player)
    if lualib:GetBagNum( player) == 0 then
        lualib:SetVar(player,"S$黄金宝箱","")
        lualib:SendMsgGetColor(player,9,"#db1200|背包已满")
        return false
    end

    if lualib:GetVar(player,"S$黄金宝箱") ~= "" then
        local mon = getmonbyuserid(lualib:GetMapId(player),lualib:GetVar(player,"S$黄金宝箱"))
        if isnotnull(mon) then
            kill(mon)
            lualib:SetVar(player,"N$宝箱",3)
            baoXiang.main(player)
        else
            lualib:SendMsgGetColor(player,9,"#ff0008|采集失败，已经被别人采集")
        end
        lualib:SetVar(player,"S$黄金宝箱","")
    end
end

function caiji_over(player)
    lualib:SetVar(player,"S$檀木宝箱","")
    lualib:SetVar(player,"S$紫铜宝箱","")
    lualib:SetVar(player,"S$白银宝箱","")
    lualib:SetVar(player,"S$赤金宝箱","")
    lualib:SetVar(player,"S$黄金宝箱","")
    lualib:SendMsgGetColor(player,9,"#ff0800|采集中断")
end

--function canreopenbox15(player)
--    local num = lualib:GetVar(player,VarCfg["宝箱1"]) + 1
--    if num >= #baoXiang.config[1] then
--        num = #baoXiang.config[1]
--    end
--
--    if not lualib:CheckNeedItems(player,baoXiang.config[1][num].need) then
--        callscriptex(player,"NOTALLOWOPENBOX",1)
--        return ""
--    end
--
--    lualib:DelNeedItems(player,baoXiang.config[1][num].need,"打开宝箱")
--end
--
--function canreopenbox17(player)
--    local num = lualib:GetVar(player,VarCfg["宝箱2"]) + 1
--    if num >= #baoXiang.config[2] then
--        num = #baoXiang.config[2]
--    end
--
--    if not lualib:CheckNeedItems(player,baoXiang.config[2][num].need) then
--        callscriptex(player,"NOTALLOWOPENBOX",1)
--        return ""
--    end
--
--    lualib:DelNeedItems(player,baoXiang.config[2][num].need,"打开宝箱")
--end
--
--function canreopenbox19(player)
--    local num = lualib:GetVar(player,VarCfg["宝箱3"]) + 1
--    if num >= #baoXiang.config[3] then
--        num = #baoXiang.config[3]
--    end
--
--    if not lualib:CheckNeedItems(player,baoXiang.config[3][num].need) then
--        callscriptex(player,"NOTALLOWOPENBOX",1)
--        return ""
--    end
--
--    lualib:DelNeedItems(player,baoXiang.config[3][num].need,"打开宝箱")
--end

function invitegroup(actor,targetName,targetUserID)
    local list = getgroupmember(actor)
    if #list >= 3 then
        return  false
    end

    return true
end
