hpMax = {}

function hpMax.main(player)
    local maxhp = getbaseinfo(player,10)
    local maxmp = getbaseinfo(player,12)
    local mapid = getbaseinfo(player,2)
    local x = getbaseinfo(player,4)
    local y = getbaseinfo(player,5)
    if gridattr(mapid,x,y,2) then
        lualib:MsgBox(player,"只有安全区可用")
        return ""
    end
    humanmp(player,"=",maxmp)
    humanhp(player,"=",maxhp,4,0,player)
    lualib:SendMsgEx(player,9,"一键满血成功！")
    return ""
end

Message.RegisterClickMsg("一键满血", hpMax)
setFormAllowFunc("一键满血", {"main"})

return hpMax