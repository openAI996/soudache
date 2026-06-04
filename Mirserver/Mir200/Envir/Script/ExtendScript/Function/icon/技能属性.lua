jiNengShuXing = {}
jiNengShuXing.configCache = include("Script/ExtendScript/cfgcsv/npc/cfg_技能对应属性.lua")
jiNengShuXing.config = {}
for k, sceneConfig in pairs(jiNengShuXing.configCache) do
    if type(k) == "number" then
        local currentTable = jiNengShuXing.config
        for num, typeValue in ipairs(sceneConfig.type) do
            if not currentTable[typeValue] then
                currentTable[typeValue] = {}
            end

            currentTable = currentTable[typeValue]
            if num == 2 then
                if sceneConfig.skillID then
                    currentTable.id = sceneConfig.skillID
                    currentTable.name = sceneConfig.skill
                end
            end
        end

        if sceneConfig.attr then
            currentTable.attr = sceneConfig.attr
        end

        if sceneConfig.desc then
            currentTable.desc = sceneConfig.desc
        end
    end
end

function jiNengShuXing.onLogin(player)
    --local job = lualib:Job(player)
    --local config = jiNengShuXing.config[job]
    --local skillLevel = chouKa.getSkill(player)
    --local attr = {}
    --for i=1,#config do
    --    if skillLevel[i] > 0 then
    --        if config[i][skillLevel[i]].attr ~= nil then
    --            for j=1,#config[i][skillLevel[i]].attr do
    --                attr[config[i][skillLevel[i]].attr[j][1]] = (attr[config[i][skillLevel[i]].attr[j][1]] or 0 ) + config[i][skillLevel[i]].attr[j][2]
    --            end
    --        end
    --    end
    --end
    --
    --local _t = ServerCache.Players[player].OtherEquip["魔法盾"]
    --if _t ~= nil then
    --    local level = _t.level
    --    if getskillinfo(player,31,1) ~= nil then
    --        if level >= 6 then
    --            setskillinfo(player,31,1,6)
    --        elseif level >= 4 then
    --            setskillinfo(player,31,1,5)
    --        elseif level >= 3 then
    --            setskillinfo(player,31,1,4)
    --        elseif level >= 2 then
    --            setskillinfo(player,31,1,3)
    --        elseif level >= 1 then
    --            setskillinfo(player,31,1,2)
    --        end
    --    end
    --end
    --
    --_t = ServerCache.Players[player].OtherEquip["魔法盾"]
    --if _t ~= nil then
    --    local level = _t.level
    --    if getskillinfo(player,8,1) ~= nil then
    --        if level >= 3 then
    --            setskillinfo(player,8,1,3)
    --        end
    --    end
    --end
    --
    --lualib:AddAttrList(player,"技能属性","=",lualib:BuffAttrList2Str(attr))
    ---Stats.skillpower(player)
end

function jiNengShuXing.setBB(player,monster)
    --if lualib:Job(player) == 2 then
    --    local _t = ServerCache.Players[player].OtherEquip["诱惑之光"]
    --    if _t ~= nil then
    --        local level = _t.level
    --        if level >= 6 then
    --            changemobability(player,monster,13,"=",20,65535)
    --            changemobability(player,monster,14,"=",20,65535)
    --        elseif level >= 2 then
    --            changemobability(player,monster,13,"=",10,65535)
    --            changemobability(player,monster,14,"=",10,65535)
    --        elseif level >= 1 then
    --            changemobability(player,monster,13,"=",5,65535)
    --            changemobability(player,monster,14,"=",5,65535)
    --        else
    --            changemobability(player,monster,13,"=",0,65535)
    --            changemobability(player,monster,14,"=",0,65535)
    --        end
    --
    --        if level >= 7 then
    --            changeslavelevel(player,monster,7)
    --        elseif level >= 5 then
    --            changeslavelevel(player,monster,5)
    --        elseif level >= 3 then
    --            changeslavelevel(player,monster,3)
    --        end
    --    end
    --end
end

Message.RegisterClickMsg("技能属性", jiNengShuXing)
setFormAllowFunc("技能属性", {"main","click"})

return jiNengShuXing