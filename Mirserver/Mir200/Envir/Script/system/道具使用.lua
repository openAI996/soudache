function stdmodefunc2(player,item)   --回城石
    local num = ServerCache.Players[player].NumberVars["战斗状态"] or 0
    local times = os.time() - num
    if times < 3 then
        lualib:SendMsgEx(player,9,"<font color='10801'>提示：</font><font color='#f2ff00'>战斗状态无法回城，剩余"..(3 - times).."秒。</font>")
        return false
    end

    if checkkuafu(player) then
        lualib:GoHome(player)
        ---bfbackcall(3,lualib:UserId(player),"回城石")
        return false
    end

    local mapID = lualib:GetMapId(player)
    if special_map_tb["禁止回城"][mapID] ~= nil then
        lualib:SendMsgEx(player,9,"<font color='10801'>提示：</font><font color='#f2ff00'>当前地图禁止使用回城石。</font>")
        return false
    end

    for k,v in pairs(special_map_tb["副本禁止回城"]) do
        if string.find(mapID , k) ~= nil  then
            lualib:SendMsgEx(player,9,"<font color='10801'>提示：</font><font color='#f2ff00'>当前地图禁止使用回城石。</font>")
            return false
        end
    end

    detoxifcation(player,-1)
    healthspellchanged(player)

    lualib:SendMsgEx(player,7,"使用回城石自动满血满蓝解除异常状态！！！")
    lualib:GoHome(player)
    return false
end

function stdmodefunc1(player,item)   --随机传送石
    local num = ServerCache.Players[player].NumberVars["战斗状态"] or 0
    local times = os.time() - num
    if times < 3 then
        lualib:SendMsgEx(player,9,"<font color='10801'>提示：</font><font color='#f2ff00'>战斗状态无法回城，剩余"..(3 - times).."秒。</font>")
        return false
    end

    local mapName = getbaseinfo(player,3)

    if special_map_tb["禁止随机"][mapName] ~= nil  then
        lualib:SendMsgEx(player,9,"<font color='10801'>提示：</font><font color='#f2ff00'>当前地图禁止使用随机传送。</font>")
        return false
    end
    --for k,v in pairs(special_map_tb["禁止随机"]) do
    --    if string.find(mapName ,k) ~= nil  then
    --        lualib:SendMsgEx(player,9,"<font color='10801'>提示：</font><font color='#f2ff00'>当前地图禁止使用随机传送。</font>")
    --        return false
    --    end
    --end
    ---local mapName = getbaseinfo(player,3)
    if lualib:Hp(player,false) > 0 then
        map(player,mapName)
        return false
    end
    ---showprogressbardlg(player,1,"@suiji_ok","正在进行随机,进度%d%.", 0,"@no")
    return false
end

function suiji_ok(player)
    local mapName = getbaseinfo(player,3)
    if lualib:Hp(player,false) > 0 then
        map(player,mapName)
        return false
    end
end

function stdmodefunc4(player,item)  --超级祝福油
    local equip = linkbodyitem(player,1)
    local luck = getitemaddvalue(player,equip,1,5)
    if equip == "0" then
        lualib:SendMsgEx(player,9,"请佩戴武器！！！")
        return false
    end

    if luck >= 7 then
        lualib:SendMsgEx(player,9,"<font color='#00fff2'>提示：</font><font color='#00ff11'>你已经武器运7了！</font>")
        return false
    end

    setitemaddvalue(player,equip,1,5,luck+1)
    refreshitem(player,equip)
    return true
end

function stdmodefunc5(player,item)   --清洗红名卷
    if getbaseinfo(player,46) == 0 then
        lualib:SendMsgEx(player,9,"<font color='10801'>提示：</font><font color='1072'>没有红名，无需清除。</font>")
        return false
    end
    setbaseinfo(player,46,0)
    lualib:SendMsgEx(player,9,"<font color='10771'>提示：</font><font color='10761'>你已经清除所有ＰＫ值。</font>")
    return true
end

local job_t = {
    [222] = {
        {"沃玛武器(1级)","沃玛武器(1级)"},
        {"沃玛衣服(1级)","沃玛衣服(1级)"},
        {"沃玛项链(1级)","沃玛项链(1级)"},
        {"沃玛手镯(1级)","沃玛手镯(1级)"},
        {"沃玛手镯(1级)","沃玛手镯(1级)"},
        {"沃玛戒指(1级)","沃玛戒指(1级)"},
        {"沃玛戒指(1级)","沃玛戒指(1级)"},
        {"沃玛头盔(1级)","沃玛头盔(1级)"},
        {"沃玛腰带(1级)","沃玛腰带(1级)"},
        {"沃玛鞋子(1级)","沃玛鞋子(1级)"},
        {"魔血石(1级)","魔血石(1级)"},
    },
    [223] = {
        {"祖玛武器(2级)","祖玛武器(2级)"},
        {"祖玛衣服(2级)","祖玛衣服(2级)"},
        {"祖玛项链(2级)","祖玛项链(2级)"},
        {"祖玛手镯(2级)","祖玛手镯(2级)"},
        {"祖玛手镯(2级)","祖玛手镯(2级)"},
        {"祖玛戒指(2级)","祖玛戒指(2级)"},
        {"祖玛戒指(2级)","祖玛戒指(2级)"},
        {"祖玛头盔(2级)","祖玛头盔(2级)"},
        {"祖玛腰带(2级)","祖玛腰带(2级)"},
        {"祖玛鞋子(2级)","祖玛鞋子(2级)"},
        {"魔血石(2级)","魔血石(2级)"},
    },
    [224] = {
        {"赤月武器(3级)","赤月武器(3级)"},
        {"赤月衣服(3级)","赤月衣服(3级)"},
        {"赤月项链(3级)","赤月项链(3级)"},
        {"赤月手镯(3级)","赤月手镯(3级)"},
        {"赤月手镯(3级)","赤月手镯(3级)"},
        {"赤月戒指(3级)","赤月戒指(3级)"},
        {"赤月戒指(3级)","赤月戒指(3级)"},
        {"赤月头盔(3级)","赤月头盔(3级)"},
        {"赤月腰带(3级)","赤月腰带(3级)"},
        {"赤月鞋子(3级)","赤月鞋子(3级)"},
        {"魔血石(3级)","魔血石(3级)"},
    }
}

local  dao_t = {
    "超级护身符",
    "灰色药粉(大量)",
    "黄色药粉(大量)"
}

for k, v in pairs(job_t) do
    _G["stdmodefunc"..k] = function(player,item)
        return give_equip_item(player,item,v)
    end
end

function give_equip_item(player,item,data)   --开荒装备卷轴
    local id = getiteminfo(player,item,2)
    local name = getstditeminfo(id,1)
    local num = getbagitemcount(player,name)
    --if name ~= "开荒装备卷轴" then
    --    print(name.."挂机错误")
    --    return false
    --end

    local job,gender = lualib:Job(player),lualib:Sex(player)
    for i=1,#data do
        local x = lualib:AddItem(player,data[i][gender],1,258,"开荒装备")
        lualib:SetItemInt(player,x,1,1)
    end

    --for i=1,#data.yao do
    --    for j=1,data.yao[i][2] do
    --        local x = lualib:AddItem(player,data.yao[i][1],1,258,"开荒装备")
    --        lualib:SetItemInt(player,x,1,1)
    --    end
    --end

    --if job == 3 then
    --    for i=1,#dao_t do
    --        local x = lualib:AddItem(player,dao_t[i],1,258,"开荒装备")
    --        lualib:SetItemInt(player,x,1,1)
    --    end
    --end

    return true
end

local money_item_tb = {
    [206]={10073,"10金币",  currency = {{"金币",10}},variable={}},
    [207]={10074,"100金币",  currency = {{"金币",100}},variable={}},
    [208]={10075,"1000金币",  currency = {{"金币",1000}},variable={}},
    [209]={10076,"10000金币",  currency = {{"金币",10000}},variable={}},
    [210]={10077,"100000金币",  currency = {{"金币",100000}},variable={}},
    [211]={10078,"金条",  currency = {{"金币",1000000}},variable={}},
    [212]={10079,"金砖",  currency = {{"金条",5}},variable={}},
    [213]={10080,"金盒",  currency = {{"金砖",5}},variable={}},
}

for k, v in pairs(money_item_tb) do
    _G["stdmodefunc"..k] = function(player,item)
        return user_money_item(player,item,v)
    end
end

function user_money_item(player,item,data)
    local id = getiteminfo(player,item,2)
    local name = getstditeminfo(id,1)
    local num = getbagitemcount(player,name)
    if name ~= data[2] then
        --lualib:SendMsgEx(player,9,":使用错误！请联系客服处理！！！")
        return false
    end

    if data.currency[1][1] ~= "金币" then
        if lualib:GetBagNum( player) < 5 then
            lualib:MsgBox(player,'背包不足5格')
            return false
        end
    end

    lualib:DelItem(player,name,num)
    local scale = 1
    if data.currency ~= nil  then
        for i=1,#data.currency do
            if string.find(data.currency[i][1],"绑定") then
                local money = data.currency[i][2]*num
                if string.find(data.currency[i][1],"元宝") then
                    money = money * scale
                end
                lualib:AddBindMoneyID(player,data.currency[i],money,"使用道具"..name)
            else
                local tb = lualib:CopyTable(data.currency[i])
                tb[2] = tb[2]*num
                if tb[1] == "元宝" then
                    tb[2] = tb[2]*scale
                end
                lualib:AddNeedItems(player,tb,"使用道具"..name)
            end
        end
    end

    lualib:SendMsgGetColor(player,9,"#FFFFFF|成功兑换|#F7DE39|"..name.."|#FFFFFF|"..num.."个|#FFFFFF")
    return false
end

local exp_item_tb = {
    [201]={10068,"1千经验卷",  exp = 1000},
    [202]={10069,"1万经验卷",  exp = 10000},
    [203]={10070,"10万经验卷",  exp = 100000},
    [204]={10071,"100万经验卷",  exp = 1000000},
    [205]={10072,"1000万经验卷",  exp = 10000000},
}

for k, v in pairs(exp_item_tb) do
    _G["stdmodefunc"..k] = function(player,item)
        return user_exp_item(player,item,v)
    end
end

function user_exp_item(player,item,data)
    local id = getiteminfo(player,item,2)
    local name = getstditeminfo(id,1)
    local num = getbagitemcount(player,name)
    if name ~= data[2] then
        --lualib:SendMsgEx(player,9,":使用错误！请联系客服处理！！！")
        return false
    end

    lualib:DelItem(player,name,num)
    local exp = num * data.exp
    lualib:AddExp(player,exp)
    lualib:SendMsgGetColor(player,9,"#FFFFFF|使用|#F7DE39|"..name.."|#FFFFFF|"..num.."个|#FFFFFF")
    return false
end

function stdmodefunc218(player,item)
    local id = getiteminfo(player,item,2)
    local name = getstditeminfo(id,1)
    local num = getbagitemcount(player,name)
    if name ~= "召唤强化卷" then
        --lualib:SendMsgEx(player,9,":使用错误！请联系客服处理！！！")
        return false
    end

    local ncount=getbaseinfo(actor,38)
    if ncount<=0 then
        lualib:SendMsgGetColor(player,9,"#FFFFFF|你没有宝宝，无需使用！！！")
        return false
    end

    for i = 0 ,ncount-1 do
        local mon = getslavebyindex(player, i)
        if mon and isnotnull(mon) then
            changeslavelevel(player,mon,"=",7)
        end
    end

    return true
end

function stdmodefunc215(player, item)
    if true then
        return false
    end
    local id = getiteminfo(player,item,2)
    local name = getstditeminfo(id,1)
    local num = getbagitemcount(player,name)
    if name ~= "太阳水捆绳" then
        return false
    end

    local bag_item_tb = getbagitems(player,"强效太阳水",1)
    local count = 0
    for i = 1, #bag_item_tb do
        count = count + 1
        lualib:DelItemObject(player,bag_item_tb[i])
    end

    if count < 6 then
        lualib:MsgBox(player,"你没有6个不绑定强效太阳水")
        return false
    end

    count = 0
    for i = 1, #bag_item_tb do
        count = count + 1
        if count < 7 then
            lualib:DelItemObject(player,bag_item_tb[i])
        else
            break
        end
    end

    ---print(count)

    lualib:AddItem(player,"强效太阳水包",1)
    return true
end

function stdmodefunc216(player, item)
    if true then
        return false
    end

    local id = getiteminfo(player,item,2)
    local name = getstditeminfo(id,1)
    local num = getbagitemcount(player,name)
    if name ~= "雪霜捆药绳" then
        return false
    end

    local bag_item_tb = getbagitems(player,"万年雪霜",1)
    local count = 0
    for i = 1, #bag_item_tb do
        count = count + 1
        lualib:DelItemObject(player,bag_item_tb[i])
    end

    if count < 6 then
        lualib:MsgBox(player,"你没有6个不绑定万年雪霜")
        return false
    end

    for i = 1, #bag_item_tb do
        count = count + 1
        if count < 7 then
            lualib:DelItemObject(player,bag_item_tb[i])
        else
            break
        end
    end

    lualib:AddItem(player,"万年雪霜包",1)
    return true
end

function stdmodefunc217(player, item)
    if true then
        return false
    end

    local id = getiteminfo(player,item,2)
    local name = getstditeminfo(id,1)
    local num = getbagitemcount(player,name)
    if name ~= "疗伤药捆药绳" then
        return false
    end

    local bag_item_tb = getbagitems(player,"疗伤药",1)
    local count = 0
    for i = 1, #bag_item_tb do
        count = count + 1
        lualib:DelItemObject(player,bag_item_tb[i])
    end

    if count < 6 then
        lualib:MsgBox(player,"你没有6个不绑定疗伤药")
        return false
    end

    for i = 1, #bag_item_tb do
        count = count + 1
        if count < 7 then
            lualib:DelItemObject(player,bag_item_tb[i])
        else
            break
        end
    end

    lualib:AddItem(player,"疗伤药包",1)
    return true
end

function stdmodefunc219(player, item)
    daKunShen.main(player)
    return false
end

function stdmodefunc220(player, item)
    local name = lualib:ItemName(player,item)
    local num = lualib:ItemCount(player,name)
    if num < 10 then
        lualib:SendMsgGetColor(player,9,"#FFFFFF|你没有10个"..name.."|#FFFFFF")
    else
        local count = math.floor(num/10)
        lualib:DelItem(player,name,count*10)
        lualib:AddItem(player,"天纵钥匙",count,258,"合成抽卡钥匙")
        lualib:SendMsgGetColor(player,9,"#FFFFFF|成功合成|#F7DE39|"..count.."|#FFFFFF|个天纵钥匙|#FFFFFF")
    end
    return false
end

function stdmodefunc221(player, item)
    chouKa.main(player)
    return false
end

function stdmodefunc225(player, item)
    lualib:SetVar(player,"N$宝箱",1)
    baoXiang.main(player)
    return true
end

function stdmodefunc226(player, item)
    lualib:SetVar(player,"N$宝箱",2)
    baoXiang.main(player)
    return true
end

function stdmodefunc227(player, item)
    lualib:SetVar(player,"N$宝箱",3)
    baoXiang.main(player)
    return true
end
