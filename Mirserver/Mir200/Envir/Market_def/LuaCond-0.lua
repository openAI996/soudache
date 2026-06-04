function isselfpeople(player, name)
	local res = atkmode == 1;
	local target = getplayerbyname(name);
	if target ~= nil then
		local atkmode = getattackmode(player);
		if atkmode == 4 then--组队模式
			local team = getgroupmember(player);
			if team ~= nil then
				for _, v in pairs(team) do
					if target == v then
						res = true;
					break end
				end
			end
		elseif atkmode == 5 then--行会模式
			local guild = getmyguild(player)
			res = tonumber(guild) ~= 0 and guild == getmyguild(target);
		end
	end
	return res;
end

function getmonbuff(player,buffid,buffcs)
	local buffid = tonumber(buffid)
	local buffcs = tonumber(buffcs)
	local monname = getbaseinfo(player,67)
	local num= 0
	if isnotnull(monname) then
			if not getbaseinfo(monname,-1) and hasbuff(monname,buffid) then
				num=getbuffinfo(monname,buffid,1)	
			end
	end
	return num == buffcs ;
end

function checkmonbuff(player,buffid,buffcs)
	local buffid = tonumber(buffid)
	local buffcs = tonumber(buffcs)
	local monname = getbaseinfo(player,67)
	local num= 0
	if isnotnull(monname) then
			if not getbaseinfo(monname,-1) and hasbuff(monname,buffid) then
				num=getbuffinfo(monname,buffid,1)	
			end
	end
	if num < buffcs then
	return true ;
	else
	return false ;
	end
end