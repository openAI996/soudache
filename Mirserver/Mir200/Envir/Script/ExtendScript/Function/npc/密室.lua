miShi = {}
miShi.config = {
    ["42"] = {{"d601",52,15},{"mishi1",31,9,1} ,id = 1},
    ["43"] = {{"d602",50,155},{"mishi2",31,9,1} ,id = 2},
    ["44"] = {{"d604",40,73},{"mishi3",31,9,1} ,id = 3},
    ["45"] = {{"d603",122,171},{"mishi4",31,9,1} ,id = 4},
    --["46"] = {{"d604",173,124},{"mishi5",31,9,1} ,id = 5},
    --["47"] = {{"d603",75,40},{"mishi6",31,9,1} ,id = 6},
    --["48"] = {{"d603",13,83},{"mishi7",31,9,1} ,id = 7},
    --["49"] = {{"d605",90,103},{"mishi8",31,9,1} ,id = 8},
    ["50"] = {{"mishi1",31,9},{"d601",51,17,1}},
    ["51"] = {{"mishi2",31,9},{"d602",48,157,1}},
    ["52"] = {{"mishi3",31,9},{"d604",40,75,1}},
    ["53"] = {{"mishi4",31,9},{"d603",124,173,1}},
    --["54"] = {{"mishi5",31,9},{"d605",173,122,1}},
    --["55"] = {{"mishi6",31,9},{"d613",74,43,1}},
    --["56"] = {{"mishi7",31,9},{"d618",15,85,1}},
    --["57"] = {{"mishi8",31,9},{"d606",88,104,1}},
}

miShi.map = {
    ["mishi1"] = 1,
    ["mishi2"] = 1,
    ["mishi3"] = 1,
    ["mishi4"] = 1,
    ["mishi5"] = 1,
    ["mishi6"] = 1,
    ["mishi7"] = 1,
    ["mishi8"] = 1,
}

miShi.need = {
    {"ÃÜÊÒÔ¿³×(òÚò¼)",1}
}

function miShi.main(player,npc)
    local t = miShi.config[npc]
    ---print(serialize( t))
    if t == nil then
        return ""
    end

    local map,x,y = lualib:GetMapId(player),lualib:X( player),lualib:Y( player)
    if map ~= t[1][1] then
        return ""
    end

    if (x > t[1][2] + 4) or (x < t[1][2] - 4) or (y > t[1][3] + 4) or (y < t[1][3] - 4) then
        lualib:MsgBox(player,"¾àÀëÌ«Ô¶£¬ÎÞ·¨½øÈë")
        return ""
    end

    if t.id ~= nil then
        local _data = miShi.getVar()
        if _data[t.id] == 1 then
            lualib:MsgBox(player,"±¾ÂÖÒÑ¾­ÓÐÈË½øÈë¸ÃÃÜÊÒÁË£¡£¡")
            return ""
        end

        if not lualib:CheckNeedItems(player,miShi.need[1]) then
            return ""
        end

        lualib:DelNeedItems(player,miShi.need[1],"½øÈëÃÜÊÒ")

        _data[t.id] = 1
        lualib:SetDBVar(VarCfg["ÃÜÊÒ1"],tbl2json(_data))
    end

    lualib:MapMove(player,t[2][1],t[2][2],t[2][3],t[2][4])
    return ""
end

function miShi.getVar()
    local data = {0,0,0,0,0,0,0,0}
    local str = lualib:GetDBVar(VarCfg["ÃÜÊÒ1"])

    if str ~= "" then
        data = json2tbl(str)
    end
    return data
end

function miShi.addbuff(player)
    local map = lualib:GetMapId(player)
    if miShi.map[map] == 1 then
        if not lualib:HasBuff(player,20009) then
            lualib:AddBuff(player,20009)
        end
    end
end

local function _onEnterMap(player, map, oldmap,x,y)
    if miShi.map[map] ~= nil then
        delaygoto(player,100,"click,ÃÜÊÒ_addbuff")
    end
end

GameEvent.add(EventCfg.onEnterMap,_onEnterMap,miShi)
Message.RegisterClickMsg("ÃÜÊÒ", miShi)
setFormAllowFunc("ÃÜÊÒ", {"main","click","change","addbuff"})

return miShi