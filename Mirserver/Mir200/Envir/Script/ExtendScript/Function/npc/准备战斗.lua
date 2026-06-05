zhunBeiZhanDou = {}
zhunBeiZhanDou.times = {
    60*60,                  --一个循环时间
    jin = 30*60,            --禁止进入时间
    jieshu = 45*60,         --结束时间
}

zhunBeiZhanDou.genCache = include("Script/ExtendScript/cfgcsv/npc/cfg_活动刷怪.lua")
zhunBeiZhanDou.gen = {}

for k, sceneConfig in pairs(zhunBeiZhanDou.genCache) do
    if type(k) == "number" then
        local currentTable = zhunBeiZhanDou.gen
        for num, typeValue in ipairs(sceneConfig.type) do
            if not currentTable[typeValue] then
                currentTable[typeValue] = {}
            end

            currentTable = currentTable[typeValue]
        end

        if sceneConfig.map then
            currentTable.map = sceneConfig.map
        end

        if sceneConfig.x then
            currentTable.x = sceneConfig.x
        end

        if sceneConfig.y then
            currentTable.y = sceneConfig.y
        end

        if sceneConfig.mon then
            currentTable.mon = sceneConfig.mon
        end

        if sceneConfig.random then
            currentTable.random = sceneConfig.random
        end

        if sceneConfig.num then
            currentTable.num = sceneConfig.num
        end

        if sceneConfig.color then
            currentTable.color = sceneConfig.color
        end

        if sceneConfig.chance then
            currentTable.chance = sceneConfig.chance
        end
    end
end

function zhunBeiZhanDou.main(player)
    local start = getsysvar(VarCfg["开服时间"])
    local now = zhunBeiZhanDou.times.jin - (os.time() -  start)%3600
    local str = [[
<Img|width=546|height=200|move=0|reset=1|img=public_win32/bg_npc_01.png|loadDelay=1|esc=1|bg=1>
<Layout|x=545|y=0|width=80|height=80|link=@exit>
<Button|x=546|y=0|pimg=public/1900000511.png|nimg=public/1900000510.png|link=@exit>
<Button|x=215.0|y=104.0|pimg=public/1900000661.png|nimg=public/1900000660.png|size=18|color=1025|text=蜈蚣洞穴|link=@click,准备战斗_click>
<RText|x=17.0|y=20.0|color=255|outline=1|outlinecolor=0|size=16|text=法师可在<"蜈蚣洞穴"/FCOLOR=249>诱惑怪物，作为前期<"开荒"/FCOLOR=250>的宝宝。>
    ]]

    if now < 0 then
        local x = (zhunBeiZhanDou.times[1] -  zhunBeiZhanDou.times.jin) + now
        str = str..[[
        <Text|x=170.0|y=59.0|color=253|size=18|text=下次开启到到计时:>
        <Text|x=90.0|y=59.0|color=250|size=18|text=（已关闭）>
        <TIMETIPS|a=0|x=330.0|y=59.0|color=249|size=18|time=]]..x..[[|count=xx>
        ]]

    else
        str = str..[[
            <Text|x=140.0|y=59.0|color=253|size=18|text=可进入倒计时:>
            <TIMETIPS|a=0|x=256.0|y=59.0|color=250|size=18|time=]]..now..[[|count=xx>
        ]]
    end

    lualib:Say(player, str)
    return ""
end

function zhunBeiZhanDou.click(player)
    if lualib:ItemCount(player,"沃玛套装卷轴(1级)") > 0 then
        lualib:MsgBox(player,'提示：请把背包内的"开荒卷"存仓库在传送')
        return ""
    end

    if lualib:ItemCount(player,"祖玛套装卷轴(2级)") > 0 then
        lualib:MsgBox(player,'提示：请把背包内的"开荒卷"存仓库在传送')
        return ""
    end

    if lualib:ItemCount(player,"赤月套装卷轴(3级)") > 0 then
        lualib:MsgBox(player,'提示：请把背包内的"开荒卷"存仓库在传送')
        return ""
    end

    local start = getsysvar(VarCfg["开服时间"])
    local now = zhunBeiZhanDou.times.jin - (os.time() -  start)%3600
    if now < 0 then
        lualib:SendMsgGetColor(player,9,"#e60800|当前时间已经无法进入地图！")
        return ""
    end

    for i=1,100 do
        if  checkation(i) then
            if getnationmembercount(i) == 0 then
                delnation(i)
            end
        end
    end

    local dao = zhunBeiZhanDou.times.jieshu - (os.time() -  start)%3600
    local camp = lualib:GetDBVar(VarCfg["地图一阵营序号"])
    local list = getgroupmember(player)
    if list == nil then
        lualib:SetVar(player,VarCfg["进入时金币"],lualib:GetMoneyID(player,{"金币"}))
        zhunBeiZhanDou.getGold(player)
        setattackmode(player,4,65535)
        lualib:SetVar(player,VarCfg["进入地图"],1)
        lualib:SetVar(player,VarCfg["赏金猎人"],0)
        if lualib:GetDBVar(VarCfg["高爆局"]) == 1 then
            lualib:MsgBox(player,"本局为高爆局，地图内爆率+30%！")
        end

        chouKa.reset(player)
        lualib:SetVar(player,VarCfg["下地图"],"")
        if lualib:GetVar(player,VarCfg["本轮次数"]) ~= lualib:GetDBVar(VarCfg["第几轮"]) then
            lualib:SetVar(player,VarCfg["本轮次数"],lualib:GetDBVar(VarCfg["第几轮"]))
        end

        --if lualib:ItemCount(player,"天纵钥匙") > 0 then
        --    lualib:DelItem(player,"天纵钥匙",lualib:ItemCount(player,"天纵钥匙"))
        --end
        --
        --if lualib:ItemCount(player,"天纵钥匙碎片") > 0 then
        --    lualib:DelItem(player,"天纵钥匙碎片",lualib:ItemCount(player,"天纵钥匙碎片"))
        --end
        local  gj = lualib:GetVar(player,VarCfg["国家"])
        local flag = true
        if gj > 0 then
            if checknational(player,gj) then
                flag = false
            end
        end

        if flag then
            for i=1,100 do
                if not checkation(i) then
                    createnation(player,i,"国家"..i,3)
                    joinnational(player,i,3)
                    lualib:SetVar(player,VarCfg["国家"],i)
                    break
                end
            end
        end
        lualib:AddHPEx(player,100)
        lualib:AddMPEx(player,100)

        lualib:SetVar(player,"N$组队进入",0)
        lualib:MapMove(player,"d601")
        delaygoto(player,100,"click,准备战斗_daojishi")
    else
        if lualib:GetVar(player,"N$创建队伍")  == 0 then
            zhunBeiZhanDou.setNational(player)
            lualib:MapMove(player,"d601")
            return ""
        end

        zhunBeiZhanDou.setNational(player)

        lualib:MapMove(player,"d601")
        for i=1,#list do
            if lualib:GetMapId(list[i]) == '3' then
                --if lualib:ItemCount(list[i],"天纵钥匙") > 0 then
                --    lualib:DelItem(list[i],"天纵钥匙",lualib:ItemCount(list[i],"天纵钥匙"))
                --end
                --
                --if lualib:ItemCount(list[i],"天纵钥匙碎片") > 0 then
                --    lualib:DelItem(list[i],"天纵钥匙碎片",lualib:ItemCount(list[i],"天纵钥匙碎片"))
                --end

                lualib:SetVar(list[i],VarCfg["进入时金币"],lualib:GetMoneyID(player,{"金币"}))
                setattackmode(list[i],4,65535)
                lualib:SetVar(list[i],VarCfg["进入地图"],1)
                zhunBeiZhanDou.getGold(list[i])
                delaygoto(list[i],200,"click,准备战斗_daojishi")
                if lualib:GetDBVar(VarCfg["高爆局"]) == 1 then
                    lualib:MsgBox(list[i],"本局为高爆局，地图内爆率+30%！")
                end

                if lualib:GetVar(list[i],VarCfg["本轮次数"]) ~= lualib:GetDBVar(VarCfg["第几轮"]) then
                    lualib:SetVar(list[i],VarCfg["本轮次数"],lualib:GetDBVar(VarCfg["第几轮"]))
                end
                lualib:SetVar(list[i],VarCfg["赏金猎人"],0)
                lualib:SetVar(list[i],VarCfg["下地图"],"")
                chouKa.reset(list[i])
            end
            lualib:AddHPEx(list[i],100)
            lualib:AddMPEx(list[i],100)
        end
        delaygoto(player,100,"click,准备战斗_zudui,".. camp + 1)
    end
    return ""
end

function zhunBeiZhanDou.setNational(player)
    local list = getgroupmember(player)
    local dz = 0
    for i=1,#list do
        if lualib:GetVar(list[i],"N$创建队伍")  == 1 then
            dz = list[i]
        end
    end

    local  gj = lualib:GetVar(dz,VarCfg["国家"])
    local flag = true
    if gj > 0 then
        if checknational(dz,gj) then
            flag = false
        end
    end

    if flag then
        for i=1,100 do
            if not checkation(i) then
                createnation(dz,i,"国家"..i,3)
                gj = i
                break
            end
        end
    end

    for i=1,#list do
        if not checknational(list[i],gj) then
            joinnational(list[i],gj,3)
            lualib:SetVar(list[i],VarCfg["国家"],gj)
        end
    end
end

function zhunBeiZhanDou.getGold(player)
    local gold = 0
    local bag_item_tb = getbagitems(player)
    for i = 1, #bag_item_tb do
        local name = lualib:ItemName(player,bag_item_tb[i])
        local num = getiteminfo(player,bag_item_tb[i],5)
        if num == 0 then
            num = 1
        end

        if sellZhuangBei.config[name] ~= nil then
            gold = gold + sellZhuangBei.config[name].sell[2] * num
        end
    end

    for i = 1,#cheLiDian.size do
        local item = lualib:GetItem(player,cheLiDian.size[i])
        if item ~= "0" then
            local name = lualib:ItemName(player,item)
            if sellZhuangBei.config[name] ~= nil then
                gold = gold + sellZhuangBei.config[name].sell[2]
            end
        end
    end

    local _data = anQuanXiang.getVar(player)
    for i=1,#_data do
        if _data[i][1] ~= 0 then
            local name = _data[i][1]
            if sellZhuangBei.config[name] ~= nil then
                gold = gold + sellZhuangBei.config[name].sell[2]*_data[i][4]
            end
        end
    end
    lualib:SetVar(player,VarCfg["入局物资"],gold)
    return  gold
end

function zhunBeiZhanDou.daojishi(player)
    local start = getsysvar(VarCfg["开服时间"])
    local now = zhunBeiZhanDou.times.jieshu - (os.time() -  start)%3600
    if now < 0 then

    end

    local dao = zhunBeiZhanDou.times.jieshu - (os.time() -  start)%3600

    lualib:ShowFormWithContent(player,"右上图标_topInit",dao)
end

function zhunBeiZhanDou.zudui(player)
    local list = getgroupmember(player)
    if lualib:GetVar(player,"N$创建队伍")  == 0 then
        return ""
    end

    local mapID,x,y = lualib:GetMapId(player),lualib:X(player),lualib:Y(player)
    for i=1,#list do
        if lualib:GetMapId(list[i]) == '3' then
            if list[i] ~= player then
                chouKa.reset(player)
                lualib:MapMove(list[i],mapID,x,y,2)
            end
        end
        lualib:SetVar(list[i],"N$组队进入",1)
    end

    return ""
end

function zhunBeiZhanDou.genMon(page)
    page = page or 1
    local t = zhunBeiZhanDou.gen[page]
    for i=1,#t do
        killmonsters(t[i].map,t[i].mon,0,false)
    end

    for i=1,#t do
        if t[i].chance >= math.random(1,100) then
            local list = genmon(t[i].map,t[i].x,t[i].y,t[i].mon,t[i].random,t[i].num,t[i].color)
        end
    end
end

local function _onEnterMap(player, map, oldmap,x,y)
    if lualib:HasBuff(player,20010) then
        lualib:DelBuff(player,20010)
    end

    if lualib:IsMainCity(player) then
        if lualib:GetDBVar(VarCfg["高爆局"]) == 1 then
            lualib:AddBuff(player,20010)
        end
    end

    if lualib:IsMainCity(player) then
        local num = os.time() - getsysvar(VarCfg["拉闸撤离1"])
        if num <  180  then
            senddelaymsg(player,"%s后拉闸撤离点撤离",10 - num,250,1,"@on",30)
        end
    end
end

GameEvent.add(EventCfg.onEnterMap,_onEnterMap,zhunBeiZhanDou)
Message.RegisterClickMsg("准备战斗", zhunBeiZhanDou)
setFormAllowFunc("准备战斗", {"main","click","daojishi"})
setNpcRangeAllowFunc("准备战斗", {"main","click"}, 10)

return zhunBeiZhanDou