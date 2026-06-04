xiaDiTu = {}
xiaDiTu.config = {
    ["26"] = {{"d601",149,55},{"d602",108,91,1}},
    ["27"] = {{"d602",110,88},{"d601",152,58,1}},
    ["28"] = {{"d602",177,33},{"d604",146,136,1}},
    ["29"] = {{"d604",149,133},{"d602",180,36,1}},
    ["30"] = {{"d604",155,37},{"d603",186,80,1}},
    ["31"] = {{"d603",187,80},{"d604",153,40,1}},
    ["32"] = {{"d603",41,194},{"d605",171,63,1}},
    ["33"] = {{"d605",173,60},{"d603",39,197,1}},
    ["34"] = {{"d605",42,124},{"d613",10,53,1}},
    ["35"] = {{"d613",8,51},{"d605",45,127,1}},
    ["36"] = {{"d613",12,14},{"d618",51,24,1}},
    ["37"] = {{"d618",53,21},{"d613",15,17,1}},
    ["38"] = {{"d618",159,173},{"d606",12,28,1}},
    ["39"] = {{"d606",9,25},{"d618",157,175,1}},
}

function xiaDiTu.main(player,npc)
    local t = xiaDiTu.config[npc]
    if t == nil then
        return ""
    end

    local map,x,y = lualib:GetMapId(player),lualib:X( player),lualib:Y( player)
    if map ~= t[1][1] then
        return ""
    end

    if (x > t[1][2] + 4) or (x < t[1][2] - 4) or (y > t[1][3] + 4) or (y < t[1][3] - 4) then
        lualib:MsgBox(player,"距离太远，无法进入")
        return ""
    end

    lualib:MapMove(player,t[2][1],t[2][2],t[2][3],t[2][4])
    return ""
end

Message.RegisterClickMsg("下地图", xiaDiTu)
setFormAllowFunc("下地图", {"main","click","change"})

return xiaDiTu


