Job_Attr_tb = include("Script/ExtendScript/cfgcsv/npc/cfg_三种职业装备对应属性.lua")

-- 穿触发
function takeonex(player, item, where, itemName, makeIndex)
	--if Job_Attr_tb[itemName] ~= nil then
	--	local job = lualib:Job( player)
	--	lualib:SetItemInt(player,item,1,job)
	--	if job == 1 then
	--		for i=1,#Job_Attr_tb[itemName].zhan do
	--			setitemaddvalue(player,item,1,Job_Attr_tb[itemName].zhan[i][1],Job_Attr_tb[itemName].zhan[i][2])
	--		end
	--	elseif job == 2 then
	--		for i=1,#Job_Attr_tb[itemName].fa do
	--			setitemaddvalue(player,item,1,Job_Attr_tb[itemName].fa[i][1],Job_Attr_tb[itemName].fa[i][2])
	--		end
	--	elseif job == 3 then
	--		for i=1,#Job_Attr_tb[itemName].dao do
	--			setitemaddvalue(player,item,1,Job_Attr_tb[itemName].dao[i][1],Job_Attr_tb[itemName].dao[i][2])
	--		end
	--	end
	--end
	GameEvent.push(EventCfg.onTakeChange,player,item,where,itemName,makeIndex,1)
end
--穿之前
function takeonbeforeex(player,item,where,makeIndex)
	----print("穿装备："..where)
	local itemName = lualib:ItemName(player,item)
	if lualib:CheckKuaFu(player) then
		lualib:SendMsgGetColor(player,9,"#15ff00|跨服禁止穿脱装备,请回本服穿脱！！")
		return false
	end

	return true
end
--脱之前
function takeoffbeforeex(player,item)
	local itemid = getiteminfo(player,item,2)
	local itemName = lualib:ItemName(player,item)
	if disable_take_off_list_tb[itemName] ~= nil then
		lualib:SendMsgGetColor(player,9,"#15ff00|当前装备禁止穿脱！")
		return false
	end

	return true
end
-- 脱触发
function takeoffex(player, item, where, itemName, makeIndex)
	---print("脱装备："..where)
	--if Job_Attr_tb[itemName] ~= nil then
	--	lualib:SetItemInt(player,item,1,0)
	--	for i=1,#Job_Attr_tb[itemName].attr do
	--		setitemaddvalue(player,item,1,Job_Attr_tb[itemName].attr[i][1],0)
	--	end
	--end

	if lualib:CheckKuaFu(player) then

	else
		GameEvent.push(EventCfg.onTakeChange,player,item,where,itemName,makeIndex,2)
	end
end


local suit_tb = {

}
---穿套装触发
function groupitemonex(player,id)
	lualib:SetVar(player,"N$套装",id)
	---print("xxxxxx穿",id,"套装")
	if lualib:GetVar(player,"N$登录触发") == 1 then
		GameEvent.push(EventCfg.onSuitChange,player,id,1)
	end
end
---脱套装触发
function groupitemoffex(player,id)
	lualib:SetVar(player,"N$套装",0)

	----print("xxxxxx脱："..id)
	if lualib:GetVar(player,"N$登录触发") == 1 then
		GameEvent.push(EventCfg.onSuitChange,player,id,2)
	end
end

----道具过期
function itemexpired(player,item,itemName)
	local name = getconst(player,"<$ExpiredItemName>")
end


