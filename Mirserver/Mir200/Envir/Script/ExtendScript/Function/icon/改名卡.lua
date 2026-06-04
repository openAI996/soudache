changename = {}

function changename.main(player)
    local w = 550
    local h = 265
    local str = [[
        <Layout|x=-500|y=-500|width=2000|height=2000|link=@exit>
        <Img|x=-93.0|y=-17.0|width=450|height=181|scaler=10|esc=1|show=4|scalel=10|scaleb=10|scalet=10|reset=0|img=public/1900000600.png|move=1|bg=1|layerid=hmdd_1>
        <Layout|x=329.0|y=-35.0|width=80|height=80|link=@exit>
        <Button|x=357.0|y=-16.0|nimg=public/1900000510.png|pimg=public/1900000511.png|link=@exit>
        <Text|x=45.0|y=73.0|size=18|outline=1|color=250|text=点击确认改名，开始改名>
        <Text|x=33.0|y=111.0|size=18|outline=1|color=250|text=改名成功后，消耗8w灵符>
        <Button|x=89.0|y=24.0|color=255|nimg=public/1900000612.png|size=18|text=改名|link=@@InputString50(请输入新的名称)>
    ]]
    lualib:Say(player,str)
    return ""
end

--function inputstring49(player)
--    if checkkuafuconnect() then
--        return ""
--    end
--    local str = lualib:GetVar(player,"S49")
--    local num = tonumber(queryhumnameexist(player,str))
--    --字符串是否含有其他字符
--    for i=1,#no_character_tb do
--        if string.find(str,no_character_tb[i]) then
--            lualib:SendMsgEx(player,9,"该名字含有禁止字符！！")
--            return ""
--        end
--    end
--
--    if #str > 16 and #str < 4 then
--        lualib:SendMsgEx(player,9,"名字不能超过8个字小于2个字！！")
--        return ""
--    end
--
--    if num == 0 then
--        lualib:SendMsgEx(player,9,"该名字可以使用！！")
--        return ""
--    elseif num == 5 then
--        lualib:SendMsgEx(player,9,"改名字长度不符合要求！！")
--        return ""
--    else
--        lualib:SendMsgEx(player,9,"该名字不可用！！")
--        return ""
--    end
--    return ""
--end

function inputstring50(player)
    if checkkuafu(player) then
        return ""
    end

    local mapName = getbaseinfo(player,3)
    if string.find(mapName,lualib:Name(player)) then
        lualib:SendMsgEx(player,9,"<font color='10801'>提示：</font><font color='#f2ff00'>当前地图禁止改名。</font>")
        return false
    end

    local str = lualib:GetVar(player,"S50")

    for i=1,#no_character_tb do
        if string.find(str,no_character_tb[i]) then
            lualib:SendMsgEx(player,9,"对不起，角色“名称”涉嫌违规，无法使用！！")
            return ""
        end
    end

    local num = tonumber(changehumname(player,str))
    if num == 0 then
        lualib:MsgBox(player,"恭喜你改名成功！！")
    elseif num == 5 then
        lualib:SendMsgEx(player,9,"改名字长度不符合要求！！")
        return ""
    elseif num == 7 then
        lualib:SendMsgEx(player,9,"改名失败！！")
        return ""
    else
        lualib:SendMsgEx(player,9,"该名字不可用！！")
        return ""
    end

    local t = {"灵符",80000}
    if not lualib:CheckNeedItems(player,t) then
        return ""
    end
    lualib:DelNeedItems(player,t,"改名卡扣除灵符")


    close(player)
    return ""
end

Message.RegisterClickMsg("改名卡", changename)
setFormAllowFunc("改名卡", {"main","click"})

return changename