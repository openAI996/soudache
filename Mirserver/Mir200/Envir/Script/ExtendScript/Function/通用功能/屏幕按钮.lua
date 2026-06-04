ScreenBtnData = {
}

function ScreenBtnData.init(player)
    local cType = tonumber(getconst(player,"<$CLIENTFLAG>"))
    local posX, posY = 0, 0
    local str = ""
    if cType == 2 then
        str = str  .."<Layout|id=221|x=-60|color=x|y=-130.0|width=60|height=60>"  --背包
        addbutton(player, 107,1, str)
        ---setpickitemtobag(player,107,221)
        ---str = [[<Button|x=190|y=-215|nimg=public/1900000611.png|size=16|color=250|text=测试功能|link=@click,基础功能通用_CeShi>]]
        ---addbutton(player, 108, 999, str)
        --callscriptex(player,"PLAYMAGICBALLEFFECT",0,31,100,-1,0,1,2+10,-7+18.5,94)
        --callscriptex(player,"PLAYMAGICBALLEFFECT",0,31,100,-1,1,1,-1,-7+18.5,94)
        --callscriptex(player,"PLAYMAGICBALLEFFECT",0,30,200,-1,2,1,-5,0,92.5)
    else
        ---str = "<Button|x=247|y=5|nimg=private/player_best_rings_ui/2.png|tips=打开印记|link=@click,基础功能通用_YinJi>"
        ---addbutton(player, 3, 2, str)
        --callscriptex(player,"PLAYMAGICBALLEFFECT",0,30,100,-1,0,1,20,-9,92)
        --callscriptex(player,"PLAYMAGICBALLEFFECT",0,30,100,-1,1,1,0,-7,92)
        --callscriptex(player,"PLAYMAGICBALLEFFECT",0,30,200,-1,2,1,17,-13,100)
        ------addbutton(player, 104,63, str)

        str = str  .."<Layout|id=221|x=-120|color=x|y=-177.0|width=30|height=30>"  --背包
        addbutton(player, 104,1, str)
        ---setpickitemtobag(player,104,221)
    end

end

--点击背包
function click_package(player,param)
    local num = tonumber(param)
    if num == 1 then
        if lualib:GetVar(player,"N$消息过滤") == 1 then
            callscriptex(player,"FILTERGLOBALMSG",0)
            lualib:SetVar(player,"N$消息过滤",0)
            lualib:SendMsgEx(player,9,"全服过滤已经关闭！！")
        else
            callscriptex(player,"FILTERGLOBALMSG",1)
            lualib:SetVar(player,"N$消息过滤",1)
            lualib:SendMsgEx(player,9,"全服过滤已经开启！！")
        end
    elseif num == 2 then
        refreshbag(player)
    elseif num == 3 then
        openstorage(player)
    elseif num == 4 then
        recycle.main(player)
    elseif num == 5 then
        openhyperlink(player,5,0)
    end
end

--打开游戏界面
function open_game_ui(player,param)
    local num = tonumber(param)
    --if num == 666 then
    --    openpaimaiguanzhu(player)
    --    return
    --end

    if num == 1 then
        --角色
        repairall(player)
        openhyperlink(player,1,0)
        --if lualib:GetVar(player,"N$查看三十六重天") == 1 then
        --    lualib:ShowFormWithContent(player,"角色界面_addGuide")
        --end
    elseif num == 32 then
        --排行榜
        --if globalinfo(3) == 0 then
        --    lualib:MsgBox(player,"合区后开始排行榜功能！！")
        --    return ""
        --end
        openhyperlink(player,32,2)
        openhyperlink(player,32,1,1)
    elseif num == 8 then
        if callcheckscriptex(player,"ISDUPMODE") then
            lualib:MsgBox(player,"请找一个空位置，不能与别人站在一起。")
            return ""
        end

        if getbaseinfo(player,48) then
            lualib:MsgBox(player,"摆摊只能在安全区使用。")
            return ""
        end
        openhyperlink(player,8,0)
    else
        openhyperlink(player,num,0)
    end
end

GameEvent.add(EventCfg.onLogin,ScreenBtnData.init,ScreenBtnData,3)
return ScreenBtnData