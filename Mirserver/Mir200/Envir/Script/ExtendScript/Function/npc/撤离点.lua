cheLiDian = {}
cheLiDian.size = {
    0,1,2,3,4,5,6,7,8,9,10,11,12
}

--cheLiDian.kill = {
--        ["邪恶钳虫"] =  {1 ,kill = 15,desc = "精英怪"},
--        ["邪恶钳虫1"] = {1 ,kill = 15,desc = "精英怪"},
--        ["邪恶钳虫2"] = {1 ,kill = 15,desc = "精英怪"},
--        ["邪恶钳虫3"] = {1 ,kill = 15,desc = "精英怪"},
--        ["邪恶钳虫4"] = {1 ,kill = 15,desc = "精英怪"},
--        ["邪恶钳虫5"] = {1 ,kill = 15,desc = "精英怪"},
--        ["邪恶钳虫6"] = {1 ,kill = 15,desc = "精英怪"},
--        ["邪恶钳虫7"] = {1 ,kill = 15,desc = "精英怪"},
--        ["邪恶钳虫8"] = {1 ,kill = 15,desc = "精英怪"},
--        ["触龙神1"] = {2 ,kill = 3,desc = "BOSS"},
--        ["触龙神2"] = {2 ,kill = 3,desc = "BOSS"},
--        ["触龙神3"] = {2 ,kill = 3,desc = "BOSS"},
--        ["触龙神4"] = {2 ,kill = 3,desc = "BOSS"},
--        ["触龙神5"] = {2 ,kill = 3,desc = "BOSS"},
--        ["触龙神6"] = {2 ,kill = 3,desc = "BOSS"},
--        ["触龙神7"] = {2 ,kill = 3,desc = "BOSS"},
--        ["触龙神8"] = {2 ,kill = 3,desc = "BOSS"},
--        ["触龙神"] = {2 ,kill = 3,desc = "BOSS"},
--        ["虹魔教主"] = {2 ,kill = 3,desc = "BOSS"},
--        ["魔龙教主"] = {2 ,kill = 3,desc = "BOSS"},
--        ["尸王1"] = {2 ,kill = 3,desc = "BOSS"},
--        ["尸王"] = {2 ,kill = 3,desc = "BOSS"},
--        ["沃玛教主"] = {2 ,kill = 3,desc = "BOSS"},
--        ["沃玛教主2"] = {2 ,kill = 3,desc = "BOSS"},
--        ["虹魔教主"] = {2 ,kill = 3,desc = "BOSS"},
--        ["虹魔教主3"] = {2 ,kill = 3,desc = "BOSS"},
--        ["赤月恶魔"] = {2 ,kill = 3,desc = "BOSS"},
--        ["赤月恶魔4"] = {2 ,kill = 3,desc = "BOSS"},
--        ["牛魔王"] = {2 ,kill = 3,desc = "BOSS"},
--        ["牛魔王5"] = {2 ,kill = 3,desc = "BOSS"},
--        ["黄泉教主"] = {2 ,kill = 3,desc = "BOSS"},
--        ["黄泉教主6"] = {2 ,kill = 3,desc = "BOSS"},
--        ["魔龙教主"] = {2 ,kill = 3,desc = "BOSS"},
--        ["魔龙教主7"] = {2 ,kill = 3,desc = "BOSS"},
--        ["不朽尸王1"] = {2 ,kill = 3,desc = "BOSS"},
--        ["不朽尸王"] = {2 ,kill = 3,desc = "BOSS"},
--        ["暗之触龙神8"] = {2 ,kill = 3,desc = "BOSS"},
--        ["暗之触龙神"] = {2 ,kill = 3,desc = "BOSS"},
--        ["暗之虹魔教主3"] = {2 ,kill = 3,desc = "BOSS"},
--        ["暗之虹魔教主"] = {2 ,kill = 3,desc = "BOSS"},
--        ["赤月恶魔4"] = {2 ,kill = 3,desc = "BOSS"},
--        ["赤月恶魔"] = {2 ,kill = 3,desc = "BOSS"},
--        ["暗之牛魔王5"] = {2 ,kill = 3,desc = "BOSS"},
--        ["暗之牛魔王"] = {2 ,kill = 3,desc = "BOSS"},
--        ["黄泉教主6"] = {2 ,kill = 3,desc = "BOSS"},
--        ["黄泉教主"] = {2 ,kill = 3,desc = "BOSS"},
--        ["暗之黄泉教主6"] = {2 ,kill = 3,desc = "BOSS"},
--        ["暗之黄泉教主"] = {2 ,kill = 3,desc = "BOSS"},
--        ["暗之魔龙教主7"] = {2 ,kill = 3,desc = "BOSS"},
--        ["暗之魔龙教主"] = {2 ,kill = 3,desc = "BOSS"},
--}
----撤离点7
function cheLiDian.main(player)
    local map,x,y = lualib:GetMapId(player),lualib:X( player),lualib:Y( player)
    if map ~= "d603" then
        return ""
    end

    if os.time() - lualib:GetDBVar(VarCfg["开局时间1"]) < 30*60 then
        lualib:MsgBox(player,"游戏开始后30分钟才可安全撤离！")
        return ""
    end

    if (x > 91 + 4) or (x < 91 - 4) or (y > 145 + 4) or (y < 145 - 4) then
        lualib:MsgBox(player,"距离太远，无法撤离")
        return ""
    end

    lualib:SetVar(player,"N$撤离7",1)
    showprogressbardlg(player,10,"@cheli_ok","正在进行撤离,进度%d%.", 0,"@no")
    return ""
end

function cheli_ok(player)
    local map,x,y = lualib:GetMapId(player),lualib:X( player),lualib:Y( player)
    if map ~= "d603" then
        return ""
    end

    if (x > 91 + 4) or (x < 91 - 4) or (y > 145 + 4) or (y < 145 - 4) then
        lualib:MsgBox(player,"距离太远，无法撤离")
        return ""
    end

    if lualib:GetVar(player,"N$撤离7") < 1 then
        lualib:MsgBox(player,'没有撤离进度条！')
        return ""
    end


    lualib:GoHome( player)
    local gold = cheLiDian.getGold(player)

    lualib:MsgBox(player,"撤离成功\\\\<font color='#efef00'>              本局收益金币："..gold.."</font>")
    return ''
end
----撤离点1   清空背包撤离
function cheLiDian.anQuan(player)
    local _t = cheLiDian.getVar()
    if _t[2] >= 5 then
        lualib:MsgBox(player,"该撤离点，已经撤离5人，无法撤离！！")
        return ""
    end

    lualib:MsgBox(player,"撤离会清空背包，是否撤离？<font color='#ff00ff'>可撤离（"..(5-_t[2]).."/5）</font>","@click,撤离点_clearBag","@no")
    return ""
end

function cheLiDian.clearBag(player)
    local map,x,y = lualib:GetMapId(player),lualib:X( player),lualib:Y( player)
    if map ~= "d602" then
        return ""
    end

    if (x > 189 + 4) or (x < 189 - 4) or (y > 142 + 4) or (y < 142 - 4) then
        lualib:MsgBox(player,"距离太远，无法撤离")
        return ""
    end

    local _t = cheLiDian.getVar()
    if _t[2] >= 5 then
        lualib:MsgBox(player,"该撤离点，本局已经无法撤离！！")
        return ""
    end

    lualib:SetVar(player,"N$撤离1",1)
    showprogressbardlg(player,10,"@cheli_beibao","正在进行撤离,进度%d%", 0,"@no")
    return ""
end

function cheli_beibao(player)
    local _t = cheLiDian.getVar()
    if _t[2] >= 5 then
        lualib:MsgBox(player,"该撤离点已经撤离5人,无法撤离！！！")
        return ""
    end


    if lualib:GetVar(player,"N$撤离1") < 1 then
        lualib:MsgBox(player,'没有走撤离进度条！')
        return ""
    end

    local map,x,y = lualib:GetMapId(player),lualib:X( player),lualib:Y( player)
    if map ~= "d602" then
        return ""
    end

    if (x > 189 + 4) or (x < 189 - 4) or (y > 142 + 4) or (y < 142 - 4) then
        lualib:MsgBox(player,"距离太远，无法撤离")
        return ""
    end

    local bag = getbagitems(player)
    for i = 1, #bag do
        lualib:DelItemObject(player,bag[i])
    end


    _t[2] = _t[2] + 1
    lualib:SetDBVar(VarCfg["撤离1"],tbl2json(_t))
    local gold = cheLiDian.getGold(player)
    lualib:GoHome( player)
    lualib:MsgBox(player,"撤离成功\\\\<font color='#efef00'>              本局收益金币："..gold.."</font>")
    return ""
end
----撤离点6    金币撤离
function cheLiDian.tiaoJian(player)
    local map,x,y = lualib:GetMapId(player),lualib:X( player),lualib:Y( player)
    if map ~= "d613" then
        return ""
    end

    local _t = cheLiDian.getVar()
    if _t[5] >= 5 then
        lualib:MsgBox(player,"该撤离点已经撤离5人,无法撤离！！！")
        return ""
    end

    if not lualib:CheckNeedItemsNoTip(player,{'金币',300000}) then
        lualib:MsgBox(player,"不足300000金币！<font color='#ff00ff'>可撤离（"..(5-_t[5]).."/5）</font>")
        return ""
    end

    if (x > 48 + 4) or (x < 48 - 4) or (y > 8 + 4) or (y < 8 - 4) then
        lualib:MsgBox(player,"距离太远，无法撤离")
        return ""
    end

    lualib:SetVar(player,"N$撤离6",1)
    showprogressbardlg(player,10,"@cheli_tiaojian","正在进行撤离,进度%d%.", 0,"@no")
    return ""
end

function cheli_tiaojian(player)
    local map,x,y = lualib:GetMapId(player),lualib:X( player),lualib:Y( player)
    if map ~= "d613" then
        return ""
    end

    local _t = cheLiDian.getVar()
    if _t[5] >= 5 then
        lualib:MsgBox(player,"该撤离点已经撤离5人,无法撤离！！！")
        return ""
    end

    if (x > 48 + 4) or (x < 48 - 4) or (y > 8 + 4) or (y < 8 - 4) then
        lualib:MsgBox(player,"距离太远，无法撤离")
        return ""
    end

    if lualib:GetVar(player,"N$撤离6") < 1 then
        lualib:MsgBox(player,'没有走撤离进度条！')
        return ""
    end

    if not lualib:CheckNeedItems(player,{'金币',300000}) then
        return ""
    end

    lualib:DelNeedItems(player,{'金币',300000},"条件撤离，扣除金币")

    _t[5] = _t[5] + 1
    lualib:SetDBVar(VarCfg["撤离1"],tbl2json(_t))
    local gold = cheLiDian.getGold(player)
    lualib:GoHome( player)
    lualib:MsgBox(player,"撤离成功\\\\<font color='#efef00'>              本局收益金币："..gold.."</font>")
    return ""
end
---撤离点2  击杀精英怪撤离
function cheLiDian.cheLi2(player)
    local map,x,y = lualib:GetMapId(player),lualib:X( player),lualib:Y( player)
    if map ~= "d604" then
        return ""
    end

    if (x > 39 + 4) or (x < 39 - 4) or (y > 155 + 4) or (y < 155 - 4) then
        lualib:MsgBox(player,"距离太远，无法撤离")
        return ""
    end

    local _t1 = cheLiDian.getVar()
    if _t1[2] >= 5 then
        lualib:MsgBox(player,"该撤离点已经撤离5人,无法撤离！！")
        return ""
    end

    local _t2 = cheLiDian.getData(player)
    if _t2[1] < 15 then
        lualib:MsgBox(player,"击杀15只精英怪，才可从这里撤离！<font color='#f6ff00'>当前击杀（".._t2[1].."/15）</font>,<font color='#ff00ff'>可撤离（"..(5-_t1[2]).."/5）</font>")
        return ""
    end

    lualib:SetVar(player,"N$撤离点2",1)
    showprogressbardlg(player,10,"@cheli_2_ok","正在进行撤离,进度%d%.", 0,"@no")
    return ""
end

function cheli_2_ok(player)
    local map,x,y = lualib:GetMapId(player),lualib:X( player),lualib:Y( player)
    if map ~= "d604" then
        return ""
    end

    if (x > 39 + 4) or (x < 39 - 4) or (y > 155 + 4) or (y < 155 - 4) then
        lualib:MsgBox(player,"距离太远，无法撤离")
        return ""
    end

    local _t1 = cheLiDian.getVar()
    if _t1[2] >= 5 then
        lualib:MsgBox(player,"该撤离点已经撤离5人,无法撤离！！")
        return ""
    end

    local _t = cheLiDian.getData(player)
    if _t[1] < 15 then
        lualib:MsgBox(player,"击杀15只精英怪，才可从这里撤离！")
        return ""
    end

    if lualib:GetVar(player,"N$撤离点2") < 1 then
        lualib:MsgBox(player,'没有撤离进度条！')
        return ""
    end

    _t1[2] = _t1[2] + 1
    lualib:SetDBVar(VarCfg["撤离1"],tbl2json(_t))

    local gold = cheLiDian.getGold(player)
    lualib:GoHome( player)
    lualib:MsgBox(player,"撤离成功\\\\<font color='#efef00'>              本局收益金币："..gold.."</font>")
    return ""
end
---撤离点3  负重撤离
function cheLiDian.cheLi3(player)
    local map,x,y = lualib:GetMapId(player),lualib:X( player),lualib:Y( player)
    if map ~= "d603" then
        return ""
    end

    if (x > 91 + 4) or (x < 91 - 4) or (y > 144 + 4) or (y < 144 - 4) then
        lualib:MsgBox(player,"距离太远，无法撤离")
        return ""
    end

    local _t = cheLiDian.getVar()
    if _t[3] >= 5 then
        lualib:MsgBox(player,"该撤离点已经撤离5人,无法撤离！！")
        return ""
    end

    if tonumber(getconst(player,"<$BW>"))/tonumber(lualib:GetVar(player,VarCfg["负重"])) > 0.5 then
        lualib:MsgBox(player,"背包负重超过50%，无法撤离")
        return ""
    end

    lualib:SetVar(player,"N$撤离点3",1)
    showprogressbardlg(player,10,"@cheli_3_ok","正在进行撤离,进度%d%.", 0,"@no")
    return ""
end

function cheli_3_ok(player)
    local map,x,y = lualib:GetMapId(player),lualib:X( player),lualib:Y( player)
    if map ~= "d603" then
        return ""
    end

    if (x > 91 + 4) or (x < 91 - 4) or (y > 144 + 4) or (y < 144 - 4) then
        lualib:MsgBox(player,"距离太远，无法撤离")
        return ""
    end

    if tonumber(getconst(player,"<$BW>"))/tonumber(lualib:GetVar(player,VarCfg["负重"])) > 0.5 then
        lualib:MsgBox(player,"背包负重超过50%，无法撤离")
        return ""
    end

    local _t = cheLiDian.getVar()
    if _t[3] >= 5 then
        lualib:MsgBox(player,"该撤离点已经撤离5人,无法撤离！！！")
        return ""
    end

    if lualib:GetVar(player,"N$撤离点3") < 1 then
        lualib:MsgBox(player,'没有撤离进度条！')
        return ""
    end

    _t[3] = _t[3] + 1
    lualib:SetDBVar(VarCfg["撤离1"],tbl2json(_t))

    local gold = cheLiDian.getGold(player)
    lualib:GoHome( player)
    lualib:MsgBox(player,"撤离成功\\\\<font color='#efef00'>              本局收益金币："..gold.."</font>")
end
---撤离点4  杀BOSS撤离
function cheLiDian.cheLi4(player)
    local map,x,y = lualib:GetMapId(player),lualib:X( player),lualib:Y( player)
    if map ~= "d605" then
        return ""
    end

    if (x > 42 + 4) or (x < 42 - 4) or (y > 19 + 4) or (y < 19 - 4) then
        lualib:MsgBox(player,"距离太远，无法撤离")
        return ""
    end

    local _t1 = cheLiDian.getVar()
    if _t1[4] >= 5 then
        lualib:MsgBox(player,"该撤离点已经撤离5人,无法撤离！！")
        return ""
    end

    local _t2 = cheLiDian.getData(player)
    if _t2[2] < 3 then
        lualib:MsgBox(player,"击杀3只BOSS，才可从这里撤离！<font color='#f6ff00'>当前击杀（".._t2[2].."/3）</font>,<font color='#ff00ff'>可撤离（"..(5-_t1[4]).."/5）</font>")
        return ""
    end

    lualib:SetVar(player,"N$撤离点4",1)
    showprogressbardlg(player,10,"@cheli_4_ok","正在进行撤离,进度%d%.", 0,"@no")
    return ""
end

function cheli_4_ok(player)
    local map,x,y = lualib:GetMapId(player),lualib:X( player),lualib:Y( player)
    if map ~= "d605" then
        return ""
    end

    if (x > 42 + 4) or (x < 42 - 4) or (y > 19 + 4) or (y < 19 - 4) then
        lualib:MsgBox(player,"距离太远，无法撤离")
        return ""
    end

    local _t = cheLiDian.getVar()
    if _t[4] >= 5 then
        lualib:MsgBox(player,"该撤离点，本局已经无法撤离！！")
        return ""
    end

    local _t1 = cheLiDian.getData(player)
    if _t1[2] < 3 then
        lualib:MsgBox(player,"击杀3只BOSS，才可从这里撤离！")
        return ""
    end

    if lualib:GetVar(player,"N$撤离点4") < 1 then
        lualib:MsgBox(player,'没有撤离进度条！')
        return ""
    end

    _t[4] = _t[4] + 1
    lualib:SetDBVar(VarCfg["撤离1"],tbl2json(_t))

    local gold = cheLiDian.getGold(player)
    lualib:GoHome( player)
    lualib:MsgBox(player,"撤离成功\\\\<font color='#efef00'>              本局收益金币："..gold.."</font>")
end
---撤离点5 击玩家撤离
function cheLiDian.cheLi5(player)
    local map,x,y = lualib:GetMapId(player),lualib:X( player),lualib:Y( player)
    if map ~= "d618" then
        return ""
    end

    if (x > 98 + 4) or (x < 98 - 4) or (y > 108 + 4) or (y < 108 - 4) then
        lualib:MsgBox(player,"距离太远，无法撤离")
        return ""
    end

    local _t1 = cheLiDian.getVar()
    if _t1[6] >= 5 then
        lualib:MsgBox(player,"该撤离点已经撤离5人,无法撤离！！")
        return ""
    end

    local _t2 = cheLiDian.getData(player)
    if _t2[3] < 3 then
        lualib:MsgBox(player,"击杀3个玩家，才可从这里撤离！<font color='#f6ff00'>当前击杀（".._t2[3].."/3）</font>,<font color='#ff00ff'>可撤离（"..(5-_t1[6]).."/5）</font>")
        return ""
    end

    lualib:SetVar(player,"N$撤离点5",1)
    showprogressbardlg(player,10,"@cheli_5_ok","正在进行撤离,进度%d%.", 0,"@no")
    return ""
end

function cheli_5_ok(player)
    local map,x,y = lualib:GetMapId(player),lualib:X( player),lualib:Y( player)
    if map ~= "d618" then
        return ""
    end

    if (x > 98 + 4) or (x < 98 - 4) or (y > 108 + 4) or (y < 108 - 4) then
        lualib:MsgBox(player,"距离太远，无法撤离")
        return ""
    end

    local _t = cheLiDian.getVar()
    if _t[6] >= 5 then
        lualib:MsgBox(player,"该撤离点已经撤离5人,无法撤离！！")
        return ""
    end

    local _t1 = cheLiDian.getData(player)
    if _t1[3] < 3 then
        lualib:MsgBox(player,"击杀3三个玩家，才可从这里撤离！")
        return ""
    end

    if lualib:GetVar(player,"N$撤离点5") < 1 then
        lualib:MsgBox(player,'没有撤离进度条！')
        return ""
    end

    _t[6] = _t[6] + 1
    lualib:SetDBVar(VarCfg["撤离1"],tbl2json(_t))
    local gold = cheLiDian.getGold(player)
    lualib:GoHome( player)
    lualib:MsgBox(player,"撤离成功\\\\<font color='#efef00'>              本局收益金币："..gold.."</font>")
end

---拉闸撤离
function cheLiDian.laZha(player)
    local map,x,y = lualib:GetMapId(player),lualib:X(player),lualib:Y(player)
    if map ~= "d604" or math.abs(x - 39) > 3 or math.abs(y - 155) > 3 then
        lualib:MsgBox(player,"距离拉闸点太远了！！")
        return ""
    end

    local str = [[
<Img|width=546|height=200|move=0|reset=1|img=public_win32/bg_npc_01.png|loadDelay=1|esc=1|bg=1>
<Layout|x=545|y=0|width=80|height=80|link=@exit>
<Button|x=546|y=0|pimg=public/1900000511.png|nimg=public/1900000510.png|link=@exit>
<Button|x=215.0|y=104.0|pimg=public/1900000661.png|nimg=public/1900000660.png|size=18|color=1025|text=拉闸撤离|link=@click,撤离点_laZhaOk>
<RText|x=80|y=30.0|color=255|outline=1|outlinecolor=0|size=16|text=本局可进行一次<"拉闸撤离"/FCOLOR=249>点击之后<"3分钟后"/FCOLOR=250>>
<RText|x=80|y=60.0|color=255|outline=1|outlinecolor=0|size=16|text=，所有人在npc附近3格内可安全撤离。>
    ]]

    local start = getsysvar(VarCfg["拉闸撤离1"])
    local now = 180 - (os.time() -  start)
    if now < 0 then
        str = str..[[
        <Text|x=150.0|y=159.0|color=253|size=18|text=拉闸倒计时:>
        ]]

        if getsysvar(VarCfg["拉闸撤离1"])  >  lualib:GetDBVar(VarCfg["开局时间1"]) + 3*180  then
            str = str..[[
                <Text|x=250.0|y=159.0|color=250|size=18|text=已结束>
            ]]
        else
            str = str..[[
                <Text|x=250.0|y=159.0|color=251|size=18|text=未拉闸>
            ]]
        end
    else
        str = str..[[
            <Text|x=150.0|y=159.0|color=253|size=18|text=拉闸倒计时:>
            <TIMETIPS|x=250.0|y=159.0|color=250|size=18|time=]]..now..[[|count=xx>
        ]]
    end

    lualib:Say(player,str)
    return ""
end

function cheLiDian.laZhaOk(player)
    if getsysvar(VarCfg["拉闸撤离1"])  >  lualib:GetDBVar(VarCfg["开局时间1"])  then
        lualib:MsgBox(player,"本局已经拉闸过了")
        return ""
    end

    local map,x,y = lualib:GetMapId(player),lualib:X(player),lualib:Y(player)
    if map ~= "d604" or math.abs(x - 39) > 3 or math.abs(y - 155) > 3 then
        lualib:MsgBox(player,"距离拉闸点太远了！！")
        return ""
    end

    lualib:SetDBVar(VarCfg["拉闸撤离1"],os.time())
    sendmsgnew(globalinfo(0),251,0,"{【蚂蚁洞穴】：/FCOLOR=253}拉闸撤离已经开始，3分钟后撤离撤离NPC附近3格可安全撤离",1,5)
    sendmovemsg(globalinfo(0),1,253,0,100,1,"{【蚂蚁洞穴】：/FCOLOR=58}拉闸撤离已经开始，3分钟后撤离撤离NPC附近3格可安全撤离")
    local tablePlayerList = getplayerlst()
    for _, v in ipairs(tablePlayerList) do
        senddelaymsg(v,"%s后拉闸撤离点撤离",180,250,1,"@on",0)
    end
    cheLiDian.laZha(player)
end
---获得本局撤离
function cheLiDian.getVar()
    local _data = {0,0,0,0,0,0,0}
    local str = lualib:GetDBVar(VarCfg["撤离1"])
    if str ~= "" then
        _data = json2tbl(str)
    end
    return _data
end
---获得本局金币
function cheLiDian.getGold(player)
    local gold = lualib:GetVar(player,VarCfg["局内金币"]) - lualib:GetVar(player,VarCfg["入局物资"])
    local bag_item_tb = getbagitems(player)
    for i = 1, #bag_item_tb do
        local name = lualib:ItemName(player,bag_item_tb[i])
        local num = getiteminfo(player,bag_item_tb[i],5)
        if num == 0 then
            num = 1
        end

        if sellZhuangBei.config[name] ~= nil then
            gold = gold + sellZhuangBei.config[name].sell[2] * num
        end
    end

    for i = 1,#cheLiDian.size do
        local item = lualib:GetItem(player,cheLiDian.size[i])
        if item ~= "0" then
            local name = lualib:ItemName(player,item)
            if sellZhuangBei.config[name] ~= nil then
                gold = gold + sellZhuangBei.config[name].sell[2]
            end
        end
    end

    local _data = anQuanXiang.getVar(player)
    for i=1,#_data do
        if _data[i][1] ~= 0 then
            local name = _data[i][1]
            if sellZhuangBei.config[name] ~= nil then
                gold = gold + sellZhuangBei.config[name].sell[2]*_data[i][4]
            end
        end
    end

    return  gold
end
---获得本局撤离数据
function cheLiDian.getData(player)
    local _data = {0,0,0}
    local str = lualib:GetVar(player,VarCfg["可撤离数据"])
    if str ~= "" then
        _data = json2tbl(str)
    end
    return _data
end
---杀怪触发
local function _onKillMon(player,monster,monsterName,mapName)
    --if cheLiDian.kill[monsterName] ~= nil then
    --    local _data = cheLiDian.getData(player)
    --    local num = cheLiDian.kill[monsterName][1]
    --    if cheLiDian.kill[monsterName].kill > _data[num] then
    --        _data[num] = _data[num] + 1
    --        lualib:SendMsgGetColor(player,9,"#fbff00|击杀".._data[num].."/"..cheLiDian.kill[monsterName].kill..cheLiDian.kill[monsterName].desc)
    --        lualib:SetVar(player,VarCfg["可撤离数据"],tbl2json(_data))
    --    end
    --end
end
---杀人触发
local function _onKillPlay(player,die)
    if lualib:IsMainCity(player) then
        local _data = cheLiDian.getData(player)
        if _data[3] < 3 then
            _data[3] = _data[3] + 1
            lualib:SendMsgGetColor(player,9,"#fbff00|击杀".._data[3].."个玩家")
            lualib:SetVar(player,VarCfg["可撤离数据"],tbl2json(_data))
        end
    end
end

GameEvent.add(EventCfg.onKillPlay,_onKillPlay,cheLiDian)
GameEvent.add(EventCfg.onKillMon,_onKillMon,cheLiDian)
Message.RegisterClickMsg("撤离点", cheLiDian)
setFormAllowFunc("撤离点", {"main","click","tiaoJian","anQuan","clearBag","cheLi2","cheLi3","cheLi4","cheLi5","laZha","laZhaOk"})

return cheLiDian