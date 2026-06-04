function addbbnumber(self, number)
    local ncount = getbaseinfo(self, 38)
    for i = 0, ncount - 1 do
        local mon = getslavebyindex(self, i)
        if isnotnull(mon) then
            local ncountname = getbaseinfo(mon, 1)
            if ncountname == "三头火龙" then
                setbaseinfo(mon, 50, 2)
            end
            setbaseinfo(mon, 26, 0)
            setbaseinfo(mon, 26, getbaseinfo(mon, 26) + number)
        end
    end
end

function kingdotarget(player, buffid, second)
	local atkmode = getattackmode(player)
	if atkmode == 5 or atkmode == 4 or atkmode == 1 then
		local x = getbaseinfo(player, 4)
		local y = getbaseinfo(player, 5)
		local mapid = getbaseinfo(player, 3)
		local list = getobjectinmap(mapid, x, y, 8, 1);
		local team = getgroupmember(player)
		local guild = getmyguild(player)
		for _, v in ipairs(list) do
			if player ~= v then
				local add = atkmode == 1;
				if atkmode == 4 and team ~= nil then--组队模式
					for _, t in pairs(team) do
						if t == v then
							add = true;
						break end
					end
				elseif atkmode == 5 then--行会模式
					add = tonumber(guild) ~= 0 and guild == getmyguild(v);
				end
				if add then
					addbuff(v, tonumber(buffid), tonumber(second), 1);
				end
			end
		end
	end
end

function wqupgrade(player)

    local offwapon = linkbodyitem(player, 1)           --取得武器物品对象
    local waponobj = getiteminfo(player, offwapon, 2)  --取得武器物品id
    local waponodcValue = getstditematt(waponobj, 4)   --取得武器攻击上限
    local waponomcValue = getstditematt(waponobj, 6)   --取得武器魔法上限
    local waponoscValue = getstditematt(waponobj, 8)   --取得武器道术上限

    local item1 = "黑铁矿(纯度15)"    --矿石1名称
    local item2 = "黑铁矿(纯度20)"    --矿石2名称
    local item3 = "黑铁矿(纯度25)"    --矿石3名称
    local item4 = "黑铁矿(纯度10)"    --矿石4名称

    local itemValue1 = 5     --矿石1贡献值
    local itemValue2 = 25    --矿石2贡献值
    local itemValue3 = 125   --矿石3贡献值
    local itemValue4 = 4     --矿石4贡献值

    local itemdcValue = 0  --首饰累加攻击值
    local itemmcValue = 0  --首饰累加魔法值
    local itemscValue = 0  --首饰累加道术值

    local dwPuritys = 0
    local maxid = ""
    local ncount=getbaseinfo(player,34)  --获得背包物品数量
 
    for i = 0 ,ncount-1 do
        local itemobj   =  getiteminfobyindex(player, i)
        local itemid    =  getiteminfo(player,itemobj,2)    --根据物品对象获得物品ID
        local itemwyid  =  getiteminfo(player,itemobj,1)    --根据物品对象获得物品唯一ID

        local itemname  =  getstditeminfo(itemid,1)         --根据物品对象获得物品名字
        local itemStdMode  =  getstditeminfo(itemid,2)      --根据物品对象获得物品分类
        local itemdc    =  getstditematt(itemid,4)          --根据物品对象获得物品攻击
        local itemmc    =  getstditematt(itemid,6)          --根据物品对象获得物品魔法
        local itemsc    =  getstditematt(itemid,8)          --根据物品对象获得物品道术


        if item1 == itemname or item2 == itemname or item3 == itemname or item4 == itemname then  
            if  itemname == item1 then                              
                 dwPuritys = dwPuritys + itemValue1
            elseif itemname == item2 then
                 dwPuritys = dwPuritys + itemValue2
            elseif itemname == item3 then
                 dwPuritys = dwPuritys + itemValue3  
            elseif itemname == item4 then
                 dwPuritys = dwPuritys + itemValue4  --循环叠加矿石贡献值 
            end
            maxid = maxid..itemwyid..","  
        end

        if dwPuritys > 0 then 
            setplaydef(player, "N$矿石贡献值",dwPuritys) 
        else
            setplaydef(player, "N$矿石贡献值",0) 
        end

        if (itemStdMode >= 19 and itemStdMode <= 24) or (itemStdMode == 26) then
            if itemdc > 0 then
                itemdcValue = itemdcValue + itemdc end
            if itemmc > 0 then
                itemmcValue = itemmcValue + itemmc end
            if itemsc > 0 then
                itemscValue = itemscValue + itemsc end --循环叠加首饰攻魔道值

            maxid = maxid..itemwyid..","  
        end

    end
    
    local  _MaxNum = itemdcValue               --比较背包首饰攻魔道最大值
        if _MaxNum < itemmcValue then 
           _MaxNum = itemmcValue end
        if _MaxNum < itemscValue then 
           _MaxNum = itemscValue end           
 
    if maxid ~= nil then 
        setplaydef(player, "S$背包物品ID",maxid)   --将物品唯一ID进行赋值后做回收物品使用
    end

        if (itemdcValue > 0  or itemmcValue > 0  or itemscValue > 0) and tonumber(offwapon) ~= 0 then  --通过比较最大值赋值武器升级属性
                local _waponMaxNum = ""
                if _MaxNum == itemdcValue then
                    _waponMaxNum = waponodcValue
                    setplaydef(player, "N$升级对应属性",2)
                    setplaydef(player, "S$升级属性名字","攻击")
                elseif  _MaxNum == itemmcValue then
                    _waponMaxNum = waponomcValue
                    setplaydef(player, "N$升级对应属性",3)
                    setplaydef(player, "S$升级属性名字","魔法")
                 elseif  _MaxNum == itemscValue then
                     _waponMaxNum = waponomcValue
                    setplaydef(player, "N$升级对应属性",4)
                    setplaydef(player, "S$升级属性名字","道术")
                end
            setplaydef(player, "N$武器最高属性", _waponMaxNum)   --比较武器攻魔道 取出最大属性赋值N
            setplaydef(player, "N$背包首饰属性", _MaxNum) 
        end

   -- --判断强化概率 暂定公式:最终成功概率 = 当前成功率概 + (当前成功率概 * (当前纯度 / (DurabilityRate * 熔炼次数)) / 10);
    local waponoupgrade = getplaydef(player,"N$武器升级次数")
    local probability = 0

    if waponoupgrade == 0 and dwPuritys > 0 then
        probability = math.floor(8000 + (8000 * (dwPuritys / (30 * 1)) / 10))
    elseif waponoupgrade == 1 and dwPuritys > 0 then
        probability = math.floor(7059 + (7059 * (dwPuritys / (30 * 2)) / 10))
    elseif waponoupgrade == 2 and dwPuritys > 0 then
        probability = math.floor(4737 + (4737 * (dwPuritys / (30 * 3)) / 10))
    elseif waponoupgrade == 3 and dwPuritys > 0 then
        probability = math.floor(2425 + (2425 * (dwPuritys / (30 * 4)) / 10))
    elseif waponoupgrade == 4 and dwPuritys > 0 then
        probability = math.floor(1936 + (1936 * (dwPuritys / (30 * 5)) / 10))
    elseif waponoupgrade == 5 and dwPuritys > 0 then
        probability = math.floor(1000 + (900 * (dwPuritys / (30 * 6)) / 10))
    elseif waponoupgrade == 6 and dwPuritys > 0 then
        probability = math.floor(1000 + (600 * (dwPuritys / (30 * 7)) / 10))
    end
    setplaydef(player, "N$成功几率",probability) 
end

function conversion(player,roletime)
	local gjtime = tonumber(roletime)
	if gjtime <= 0 then
		  setplaydef(player, "S$挂机时间显示","0秒")
		  return
	  end
	local day = math.floor(gjtime / (24 * 60 * 60))
	local hour = math.floor(gjtime % (24 * 60 * 60) / (60 * 60))
	local minute = math.floor(gjtime % (24 * 60 * 60) % (60 * 60) / 60)
	local sec = gjtime % (24 * 60 * 60) % (60 * 60) % 60
  
   local str = ""
	  if day > 0 then
		  str = day .. "天"
	  end
   
	  if hour > 0 then
		  str = str .. hour .. "时"
	  end
   
	  if minute > 0 then
		  str = str .. minute .. "分"
	  end
   
	  if sec > 0 then
		  str = str .. sec .. "秒"
	  end
  
	  setplaydef(player, "S$挂机时间显示",str)
end
  
function delitem(player,delitemid)
    delitembymakeindex(player,delitemid)
end

function baobaomove(player)
    local ncount=getbaseinfo(player,38)
	if ncount > 0 then
		local mon = getslavebyindex(player, 0)
		if isnotnull(mon) then
			local monx=getbaseinfo(mon,4)
			local mony=getbaseinfo(mon,5)
			local playemap=getbaseinfo(player,3)
			local playex=getbaseinfo(player,4)
			local playey=getbaseinfo(player,5)
			mapmove(mon,playemap,playex,playey,0)
			delaygoto(player,100,"rolego,"..playemap..","..monx..","..mony)
		end
	end
end

function rolego(player,playemap,playex,playey)
		mapmove(player,playemap,tonumber(playex),tonumber(playey),0)	
end


local tMon={
	["月灵"] = {["hp"]=1000,["dc"]=55,["maxdc"]=55,["ac"]=125,["maxac"]=125,["mac"]=125,["maxmac"]=125},
	["月灵1"] = {["hp"]=1000,["dc"]=55,["maxdc"]=55,["ac"]=125,["maxac"]=125,["mac"]=125,["maxmac"]=125},
	["玄冰麒麟"] = {["hp"]=1500,["dc"]=55,["maxdc"]=55,["ac"]=180,["maxac"]=180,["mac"]=180,["maxmac"]=180},
	["炽焰麒麟"] = {["hp"]=1250,["dc"]=50,["maxdc"]=50,["ac"]=150,["maxac"]=150,["mac"]=150,["maxmac"]=150},
	["上古玄武"] = {["hp"]=2000,["dc"]=90,["maxdc"]=90,["ac"]=230,["maxac"]=230,["mac"]=230,["maxmac"]=230},
	["上古朱雀"] = {["hp"]=1250,["dc"]=75,["maxdc"]=75,["ac"]=135,["maxac"]=135,["mac"]=135,["maxmac"]=135},
	["上古白虎"] = {["hp"]=1500,["dc"]=100,["maxdc"]=100,["ac"]=160,["maxac"]=160,["mac"]=160,["maxmac"]=160},
	["上古青龙"] = {["hp"]=2250,["dc"]=125,["maxdc"]=125,["ac"]=160,["maxac"]=160,["mac"]=160,["maxmac"]=160},
	["神兽"] = {["hp"]=500,["dc"]=35,["maxdc"]=35,["ac"]=80,["maxac"]=80,["mac"]=80,["maxmac"]=80},
	["神兽1"] = {["hp"]=500,["dc"]=35,["maxdc"]=35,["ac"]=80,["maxac"]=80,["mac"]=80,["maxmac"]=80},
	["圣兽"] = {["hp"]=550,["dc"]=40,["maxdc"]=40,["ac"]=90,["maxac"]=90,["mac"]=90,["maxmac"]=90},
	["圣兽1"] = {["hp"]=550,["dc"]=40,["maxdc"]=40,["ac"]=90,["maxac"]=90,["mac"]=90,["maxmac"]=90},
	["圣兽王"] = {["hp"]=600,["dc"]=45,["maxdc"]=45,["ac"]=95,["maxac"]=95,["mac"]=95,["maxmac"]=95},
	["圣兽王1"] = {["hp"]=600,["dc"]=45,["maxdc"]=45,["ac"]=95,["maxac"]=95,["mac"]=95,["maxmac"]=95},
	["变异圣兽王"] = {["hp"]=600,["dc"]=50,["maxdc"]=50,["ac"]=100,["maxac"]=100,["mac"]=95,["maxmac"]=95},
	["变异圣兽王1"] = {["hp"]=600,["dc"]=50,["maxdc"]=50,["ac"]=100,["maxac"]=100,["mac"]=95,["maxmac"]=95},
	["虎卫"] = {["hp"]=400,["dc"]=30,["maxdc"]=40,["ac"]=20,["maxac"]=20,["mac"]=15,["maxmac"]=15},
	["鹰卫"] = {["hp"]=1500,["dc"]=30,["maxdc"]=50,["ac"]=15,["maxac"]=15,["mac"]=18,["maxmac"]=18},
	["龙卫"] = {["hp"]=800,["dc"]=24,["maxdc"]=36,["ac"]=15,["maxac"]=15,["mac"]=18,["maxmac"]=18},
	["牛魔侍卫"] = {["hp"]=900,["dc"]=42,["maxdc"]=48,["ac"]=22,["maxac"]=22,["mac"]=0,["maxmac"]=0},
	["牛魔法师"] = {["hp"]=810,["dc"]=48,["maxdc"]=48,["ac"]=29,["maxac"]=29,["mac"]=15,["maxmac"]=15},
	["牛魔将军"] = {["hp"]=1000,["dc"]=48,["maxdc"]=48,["ac"]=29,["maxac"]=29,["mac"]=15,["maxmac"]=15},
	["牛魔将军3"] = {["hp"]=990,["dc"]=40,["maxdc"]=44,["ac"]=16,["maxac"]=16,["mac"]=0,["maxmac"]=0},
	["天狼蜘蛛"] = {["hp"]=1275,["dc"]=40,["maxdc"]=62,["ac"]=29,["maxac"]=29,["mac"]=10,["maxmac"]=10},
	["天狼蜘蛛5"] = {["hp"]=855,["dc"]=45,["maxdc"]=64,["ac"]=33,["maxac"]=33,["mac"]=23,["maxmac"]=23},
	["黑锷蜘蛛"] = {["hp"]=2000,["dc"]=36,["maxdc"]=76,["ac"]=41,["maxac"]=41,["mac"]=25,["maxmac"]=25},
	["黑锷蜘蛛3"] = {["hp"]=1200,["dc"]=13,["maxdc"]=57,["ac"]=42,["maxac"]=42,["mac"]=23,["maxmac"]=23},
	["黑锷蜘蛛5"] = {["hp"]=1200,["dc"]=13,["maxdc"]=57,["ac"]=42,["maxac"]=42,["mac"]=23,["maxmac"]=23},
	["魔龙刺蛙"] = {["hp"]=1800,["dc"]=64,["maxdc"]=77,["ac"]=31,["maxac"]=31,["mac"]=15,["maxmac"]=15},
	["兵蚁"] = {["hp"]=6000,["dc"]=100,["maxdc"]=100,["ac"]=105,["maxac"]=105,["mac"]=30,["maxmac"]=30},
	["迷失巡游兵"] = {["hp"]=3800,["dc"]=67,["maxdc"]=67,["ac"]=60,["maxac"]=60,["mac"]=0,["maxmac"]=0},
	["王陵卫士"] = {["hp"]=3750,["dc"]=67,["maxdc"]=78,["ac"]=40,["maxac"]=40,["mac"]=0,["maxmac"]=0},
	["牛魔祭司"] = {["hp"]=1080,["dc"]=47,["maxdc"]=61,["ac"]=30,["maxac"]=30,["mac"]=10,["maxmac"]=10}
}


local leveup={
{
     {["hp"]=1.07,["dc"]=1.05},
     {["hp"]=1.14,["dc"]=1.1},
     {["hp"]=1.21,["dc"]=1.15},
     {["hp"]=1.28,["dc"]=1.2},
     {["hp"]=1.35,["dc"]=1.25},
     {["hp"]=1.42,["dc"]=1.3},
     {["hp"]=1.49,["dc"]=1.4},
	 },
{
	 {["hp"]=1.4,["dc"]=1.1},
     {["hp"]=2,["dc"]=1.2},
     {["hp"]=2.8,["dc"]=1.3},
     {["hp"]=3.8,["dc"]=1.4},
     {["hp"]=5,["dc"]=1.5},
     {["hp"]=6.4,["dc"]=1.6},
     {["hp"]=8,["dc"]=1.7},
}
}

function addbbatt(player)
	if gettcount64() - getplaydef(player,"N$宝宝属性加成CD")  > 500 then
		setplaydef(player,"N$宝宝属性加成CD",gettcount64())
	else
		return true
	end

	local ncount = getbaseinfo(player,38)
	local Addpetmonqsx = getbaseinfo(player,51,247)--宝宝全属性加成
	local Addpetmonhp = getbaseinfo(player,51,242)--宝宝生命值加成
	local Addpetmondc = getbaseinfo(player,51,243)--宝宝攻击加成
	local job = getplaydef(player,"U50")--流派判断
	local myjob = getbaseinfo(player,7)
	local monyd = getplaydef(player,"N$加宝宝移速")--宝宝移速变量
	local mongs = getplaydef(player,"N$加宝宝攻速")--宝宝攻速变量
	local taostz = getplaydef(player,"N$上古圣龙套装")--是否穿戴道士T7套装
	local mon = nil

	if ncount > 0 then
		local monAc = 0    --防御下
		local monMaxAc = 0 --防御上
		local monMac = 0   --魔御下
		local monMaxMac = 0   --魔御上
		local monDc = 0    --攻击下
		local monMaxdc = 0    --攻击上
		local monMaxhp = 0    --最大HP
		local addMonhp =0 --计算升级属性
		local addMonMaxdc = 0
		for i = 0 ,ncount-1 do
			local mon =  getslavebyindex(player, i)
			if isnotnull(mon) then
				local monlv = getslavelevel(mon)
				local monname = getbaseinfo(mon,1,1)

				changemobability(player,mon,1,"=",0,1)
				changemobability(player,mon,2,"=",0,1)
				changemobability(player,mon,3,"=",0,1)
				changemobability(player,mon,4,"=",0,1)
				changemobability(player,mon,5,"=",0,1)
				changemobability(player,mon,6,"=",0,1)
				changemobability(player,mon,11,"=",0,1) 
				changemobability(player,mon,12,"=",0,1) 
				changemobability(player,mon,13,"=",0,1) 
				changemobability(player,mon,14,"=",0,1) --还原宝宝属性

				if monlv > 0 and tMon[monname] ~= nil and monname ~= "三头火龙" then

					 monAc = getbaseinfo(mon,15)    --防御下
					 monMaxAc = getbaseinfo(mon,16) --防御上

					 monMac = getbaseinfo(mon,17)   --魔御下
					 monMaxMac = getbaseinfo(mon,18)   --魔御上

					 monDc = getbaseinfo(mon,19)    --攻击下
					 monMaxdc = getbaseinfo(mon,20)    --攻击上

					 monMaxhp = getbaseinfo(mon,10)    --最大HP
					 
					 addMonhp = math.ceil(tMon[monname]["hp"]*leveup[myjob][monlv]["hp"] - monMaxhp) --计算升级属性
					 addMondc = math.ceil(tMon[monname]["dc"]*leveup[myjob][monlv]["dc"] - monDc)
					 addMonMaxdc = math.ceil(tMon[monname]["maxdc"]*leveup[myjob][monlv]["dc"] - monMaxdc)

				elseif monname == "三头火龙" then
					addMondc = math.ceil(getbaseinfo(player,22)*0.33)
					addMonMaxdc =  math.ceil(getbaseinfo(player,22)*0.33)
					setbaseinfo(mon,50,2)
				end

				if job == 9 then --御灵宝宝享受自身50%道术
					addMondc = math.ceil(addMondc+(getbaseinfo(player,23)*0.5))
					addMonMaxdc =  math.ceil(addMonMaxdc+(getbaseinfo(player,24)*0.5))
				end
				if job == 8 then --道玄宝宝享受自身38%道术
					addMondc = math.ceil(addMondc+(getbaseinfo(player,23)*0.38))
					addMonMaxdc =  math.ceil(addMonMaxdc+(getbaseinfo(player,24)*0.38))
				end
				if job == 7 then --天尊宝宝享受自身33%道术
					addMondc = math.ceil(addMondc+(getbaseinfo(player,23)*0.33))
					addMonMaxdc =  math.ceil(addMonMaxdc+(getbaseinfo(player,24)*0.33))
				end
				
				changemobability(player,mon,5,"+",addMondc,655355)
				changemobability(player,mon,6,"+",addMonMaxdc,655355)
				changemobability(player,mon,11,"+",addMonhp,655355)
			
				local PetmonAc = 0    --防御下
				local PetmonMaxAc = 0 --防御上
				local PetmonMac = 0   --魔御下
				local PetmonMaxMac = 0   --魔御上
				local PetmonDc = 0    --攻击下
				local PetmonMaxdc = 0    --攻击上
				local PetmonMaxhp = 0   --最大HP
			 
				if hasbuff(player,50036) and job == 9 then
					PetmonDc = math.ceil(PetmonDc+(getbaseinfo(mon,19)*0.5))
					PetmonMaxdc = math.ceil(PetmonMaxdc+(getbaseinfo(mon,20)*0.5))
				end	
			
				if Addpetmonqsx > 0 then  -- 全属性加成
					  PetmonAc =  math.ceil(PetmonAc+(getbaseinfo(mon,15)*Addpetmonqsx/100))
					  PetmonMaxAc =  math.ceil(PetmonMaxAc+(getbaseinfo(mon,16)*Addpetmonqsx/100))
					  PetmonMac =  math.ceil(PetmonMac+(getbaseinfo(mon,17)*Addpetmonqsx/100))
					  PetmonMaxMac =  math.ceil(PetmonMaxMac+(getbaseinfo(mon,18)*Addpetmonqsx/100))
					  PetmonDc =  math.ceil(PetmonDc+(getbaseinfo(mon,19)*Addpetmonqsx/100))
					  PetmonMaxdc =  math.ceil(PetmonMaxdc+(getbaseinfo(mon,20)*Addpetmonqsx/100))  
					  PetmonMaxhp =  math.ceil(PetmonMaxhp+(getbaseinfo(mon,10)*Addpetmonqsx/100))
				end
			
				if Addpetmonhp > 0 then -- 血量加成
					PetmonMaxhp = math.ceil(PetmonMaxhp+(getbaseinfo(mon,10)*Addpetmonhp/100))
				end
			
				if Addpetmondc > 0 then  -- 攻击加成
					 PetmonDc = math.ceil(PetmonDc+(getbaseinfo(mon,19)*Addpetmondc/100))
					 PetmonMaxdc = math.ceil(PetmonMaxdc+(getbaseinfo(mon,20)*Addpetmondc/100))
				end			
			
				if taostz > 0 then --将道士的攻击双防转为宝宝
					PetmonAc = math.ceil(PetmonAc+(getbaseinfo(player,15)))
					PetmonMaxAc = math.ceil(PetmonMaxAc+(getbaseinfo(player,16)))
					PetmonMac = math.ceil(PetmonMac+(getbaseinfo(player,17)))
					PetmonMaxMac = math.ceil(PetmonMaxMac+(getbaseinfo(player,18)))
					PetmonDc = math.ceil(PetmonDc+(getbaseinfo(player,19)))
					PetmonMaxdc = math.ceil(PetmonMaxdc+(getbaseinfo(player,20)))
				end
			
				if PetmonAc > 0 then
					changemobability(player,mon,1,"+",PetmonAc,655355) end
				if PetmonMaxAc > 0 then
					changemobability(player,mon,2,"+",PetmonMaxAc,655355) end
				if PetmonMac > 0 then
					changemobability(player,mon,3,"+",PetmonMac,655355) end
				if PetmonMaxMac > 0 then 
					changemobability(player,mon,4,"+",PetmonMaxMac,655355) end
				if PetmonDc > 0 then 
					changemobability(player,mon,5,"+",PetmonDc,655355) end
				if PetmonMaxdc > 0 then
					changemobability(player,mon,6,"+",PetmonMaxdc,655355) end
				if PetmonMaxhp > 0	then
					changemobability(player,mon,11,"+",PetmonMaxhp,655355) end			

			end
			
		if mongs > 0 then
			changemobability(player,mon,13,"+",mongs,655355) end	
		if monyd > 0 then
			changemobability(player,mon,14,"+",monyd,655355) end	
		if myjob == 1 or myjob == 2 then
			local monhphf = 100
			local itemdx = linkbodyitem(player,15) 
			setbaseinfo(mon,26,0)
			if itemdx ~= "0" and itemdx ~= 0 then
				local itemId = tonumber(getiteminfo(player, itemdx, 2))
				local itemname = getstditeminfo(itemId, 1)
				if itemname == "【神】狻猊 " then
					monhphf = monhphf*2
				end
			end
			setbaseinfo(mon,26,getbaseinfo(mon,26)+monhphf)  --宝宝回血速度
		end
	end
end
end

function addbbnumberhp(player)
    local hpncount = getbaseinfo(player, 38)
    for i = 0, hpncount - 1 do
        local monhp = getslavebyindex(player, i)
        if isnotnull(monhp) then
			local monlv = getslavelevel(monhp)
			if monlv > 0 then
           		setbaseinfo(monhp,9,getbaseinfo(monhp, 10))  --召唤宝宝满血
			end
        end
    end
end
