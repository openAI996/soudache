
function killmon(player,monster)
    if not isnotnull(monster) then
        return
    end

    if not isnotnull(player) then
        return
    end

    local monsterName = lualib:MobName(monster,0)
    local mapName = getbaseinfo(player,3)
    GameEvent.push(EventCfg.onKillMon, player,monster,monsterName,mapName)
    return ""
end

function onkillmob(player,monster)

end