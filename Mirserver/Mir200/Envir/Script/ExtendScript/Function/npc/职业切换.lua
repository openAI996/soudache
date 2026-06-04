zhiYeQieHuan = {}

function zhiYeQieHuan.main(player)
    if true then
        return
    end
    zhiYeQieHuan.window(player)
end

function zhiYeQieHuan.window(player)
    local job = lualib:Job(player)
    local config = zhiYeQieHuan.config
    local sex = lualib:Sex(player)
    local str = [[
<Img|width=546|height=286|scale9l=10|scale9b=10|move=0|reset=1|loadDelay=1|scale9t=10|esc=1|img=public/bg_npc_04.jpg|scale9r=10|show=0|bg=1>
<Button|x=546.0|y=1.0|nimg=public/1900000510.png|pimg=public/1900000511.png|link=@exit>
<Img|x=159.0|y=22.0|img=public/101.png|esc=0>
<Img|x=315.0|y=22.0|img=public/102.png|esc=0>
<Text|ax=0.5|ay=0.5|x=264.0|y=31.0|size=18|color=251|text=职业流派>
<Img|x=34.0|y=48.0|img=public/103.png|esc=0>
<RText|x=22.0|y=60.0|size=18|color=255|text=在这里，你可以自由切换职业流派！>
<RText|x=66.0|y=90.0|size=20|color=250|text=战士　　　　　　　法师　　　　　　　道士>
<Img|x=59.0|y=131.0|img=private/monster_belong_netplayer/job_]]..(sex - 1)..[[_0.png|esc=0>
<Img|x=56.0|y=126.0|img=private/monster_belong_netplayer/icon_bg.png|esc=0>
<Img|x=240.0|y=131.0|img=private/monster_belong_netplayer/job_]]..(sex - 1)..[[_1.png|esc=0>
<Img|x=237.0|y=126.0|img=private/monster_belong_netplayer/icon_bg.png|esc=0>
<Img|x=422.0|y=131.0|img=private/monster_belong_netplayer/job_]]..(sex - 1)..[[_2.png|esc=0>
<Img|x=419.0|y=126.0|img=private/monster_belong_netplayer/icon_bg.png|esc=0>

    ]]

    if job == 1 then
        str = str .. [[
<RText|x=64.0|y=205.0|size=20|color=249|text=当前>
<RText|x=64.0|y=227.0|size=20|color=249|text=职业>
<Button|x=235.0|y=211.0|width=60|height=30|nimg=public/1900000611.png|size=18|color=246|text=切换|link=@click,职业切换_click,2>
<Button|x=419.0|y=211.0|width=60|height=30|nimg=public/1900000611.png|size=18|color=246|text=切换|link=@click,职业切换_click,3>
        ]]
    end

    if job == 2 then
        str = str .. [[
<RText|x=235.0|y=205.0|size=20|color=249|text=当前>
<RText|x=235.0|y=227.0|size=20|color=249|text=职业>
<Button|x=55.0|y=211.0|width=60|height=30|nimg=public/1900000611.png|size=18|color=246|text=切换|link=@click,职业切换_click,1>
<Button|x=419.0|y=211.0|width=60|height=30|nimg=public/1900000611.png|size=18|color=246|text=切换|link=@click,职业切换_click,3>
        ]]
    end

    if job == 3 then
        str = str .. [[
<RText|x=419.0|y=205.0|size=20|color=249|text=当前>
<RText|x=419.0|y=227.0|size=20|color=249|text=职业>
<Button|x=55.0|y=211.0|width=60|height=30|nimg=public/1900000611.png|size=18|color=246|text=切换|link=@click,职业切换_click,1>
<Button|x=235.0|y=211.0|width=60|height=30|nimg=public/1900000611.png|size=18|color=246|text=切换|link=@click,职业切换_click,2>
        ]]
    end

    lualib:Say(player, str)
    return ""
end

function zhiYeQieHuan.click(player,page)
    local job = lualib:Job(player)
    page = tonumber(page)
    if job == page then
        lualib:MsgBox(player,"你已经是这个职业了！")
        return ""
    end

    --local start = getsysvar(VarCfg["开服时间"])
    --local now = zhunBeiZhanDou.times.jin - (os.time() -  start)%3600
    --if now < 0 then
    --    lualib:SendMsgGetColor(player,9,"#e60800|当前时间已经无法切换职业！")
    --    return ""
    --end

    for i=1,#cheLiDian.size do
        if lualib:GetItem(player,cheLiDian.size[i]) ~= "0" then
            lualib:MsgBox(player,"请先脱掉所有装备！")
            return ""
        end
    end

    lualib:SetJob(player,page)
    sheZhiDengJi.setLevel(player)
    zhiYeQieHuan.window(player)
    jiNengJingXiu.addAttr(player)
    return ""
end

Message.RegisterClickMsg("职业切换", zhiYeQieHuan)
setFormAllowFunc("职业切换", {"main","click","window"})

return zhiYeQieHuan