mengZhongLaoBing = {}
mengZhongLaoBing.configCache = include("Script/ExtendScript/cfgcsv/npc/cfg_盟重老兵.lua")
mengZhongLaoBing.config = {}
for k, sceneConfig in pairs(mengZhongLaoBing.configCache) do
    if type(k) == "number" then
        local currentTable = mengZhongLaoBing.config
        for num, typeValue in ipairs(sceneConfig.type) do
            if not currentTable[typeValue] then
                currentTable[typeValue] = {}
            end

            currentTable = currentTable[typeValue]
        end

        if sceneConfig.name then
            currentTable.name = sceneConfig.name
        end

        if sceneConfig.need then
            currentTable.need = sceneConfig.need
        end

        if sceneConfig.num then
            currentTable.num = sceneConfig.num
        end
    end
end

mengZhongLaoBing.var = {
    "背包格子","仓库格子","负重"
}
function mengZhongLaoBing.main(player)
    mengZhongLaoBing.window(player)
end

function mengZhongLaoBing.window(player,page)
    page = page or 0
    page = tonumber(page)
    local color1,color2,color3  = 250,250,250
    if page == 1 then
        color1 = 249
    elseif page == 2 then
        color2 = 249
    elseif page == 3 then
        color3 = 249
    end

    local str = [[
<Img|x=0.0|y=2.0|width=546|height=210|reset=1|img=public_win32/bg_npc_01.png|move=0|loadDelay=1|esc=1|bg=1>
<Layout|x=545|y=0|width=80|height=80|link=@exit>
<Button|x=543.0|y=3.0|nimg=public/1900000510.png|pimg=public/1900000511.png|link=@exit>
<RText|x=60.0|y=76.0|outlinecolor=0|color=255|outline=1|size=18|text=你好勇士，在这里可以拓展背包仓库等功能！>
<Img|x=72.0|y=63.0|width=400|esc=0|img=public/1900000667_1.png>
<Text|x=60.0|y=106.0|color=255|size=18|text=要试试老夫的手艺吗？>
<Img|x=108.0|y=35.0|img=public/word_sxbt_05.png|esc=0>
<Text|x=217.0|y=30.0|color=251|size=20|text=盟重老兵>
<Img|x=58.0|y=153.0|img=public/btn_npcfh_03.png|esc=0>
<Img|x=362.0|y=153.0|img=public/btn_npcfh_03.png|esc=0>

<Text|x=76.0|y=151.0|color=]]..color2..[[|size=18|text=拓展仓库|link=@click,盟重老兵_window,2>
<Text|x=380.0|y=151.0|color=]]..color3..[[|size=18|text=提升负重|link=@click,盟重老兵_window,3>
    ]]
    ---         <Img|x=210.0|y=153.0|img=public/btn_npcfh_03.png|esc=0>
    ----        <Text|x=76.0|y=151.0|color=]]..color1..[[|size=18|text=拓展背包|link=@click,盟重老兵_window,1>

    local data = mengZhongLaoBing.getData(player)
    if page == 1 then
        local num = data[page] + 1
        local config = mengZhongLaoBing.config[page]
        if num > #config then
            num = #config
        end
        
        str = str .. [[
<Img|x=0.0|y=211.0|esc=0|img=public_win32/bg_npc_01.png>
<Img|x=58.0|y=153.0|esc=0|img=public/btn_npcfh_03.png>
<Img|x=58.0|y=262.0|esc=0|img=public/btn_npcfh_03.png>
<Img|x=58.0|y=333.0|esc=0|img=public/btn_npcfh_03.png>
<Text|x=80.0|y=331.0|color=249|size=20|text=说明：成功提升后，背包格子数量增加1格>
<Text|x=80.0|y=260.0|color=249|size=20|text=拓展背包>
<RText|x=80.0|y=290.0|width=340|height=28|color=255|size=20|text=<当前背包/FCOLOR=249>     <]]..(46+lualib:GetVar(player,VarCfg["背包格子"]))..[[/126/FCOLOR=250>>
<Text|x=168.0|y=260.0|color=255|size=20|text=所需消耗：>
<Button|x=411.0|y=248.0|size=18|mimg=public/1900000660.png|pimg=public/1900000660.png|color=255|nimg=public/1900000660.png|text=确定拓展|link=@click,盟重老兵_click,1>
        ]]

        for i=1,#config[num].need do
            str = str .. [[
<ItemShow|x=]]..(270 + (i-1)*70)..[[|y=235|width=70|height=70|itemid=]]..getstditeminfo(config[num].need[i][1],0)..[[|itemcount=]]..config[num].need[i][2]..[[|showtips=1|bgtype=1>
            ]]
        end
    elseif page == 2 then
        local num = data[page] + 1
        local config = mengZhongLaoBing.config[page]
        if num > #config then
            num = data[page]
        end

        str = str .. [[
<Img|x=0.0|y=211.0|esc=0|img=public_win32/bg_npc_01.png>
<Img|x=58.0|y=153.0|esc=0|img=public/btn_npcfh_03.png>
<Img|x=58.0|y=262.0|esc=0|img=public/btn_npcfh_03.png>
<Img|x=58.0|y=333.0|esc=0|img=public/btn_npcfh_03.png>
<Text|x=80.0|y=331.0|color=249|size=20|text=说明：成功提升后，仓库格子数量增加1格>
<Text|x=80.0|y=260.0|color=249|size=20|text=拓展仓库>
<RText|x=80.0|y=290.0|width=340|height=28|color=255|size=20|text=<当前仓库/FCOLOR=249>     <]]..(40+lualib:GetVar(player,VarCfg["仓库格子"]))..[[/240/FCOLOR=250>>
<Text|x=168.0|y=260.0|color=255|size=20|text=所需消耗：>
<Button|x=411.0|y=248.0|size=18|nimg=public/1900000660.png|text=确定拓展|link=@click,盟重老兵_click,2>
        ]]

        for i=1,#config[num].need do
            str = str .. [[
<ItemShow|x=]]..(270 + (i-1)*70)..[[|y=235|width=70|height=70|itemid=]]..getstditeminfo(config[num].need[i][1],0)..[[|itemcount=]]..config[num].need[i][2]..[[|showtips=1|bgtype=1>
            ]]
        end
    elseif page == 3 then
        local config = mengZhongLaoBing.config[page]
        str = str .. [[
<Img|x=0.0|y=211.0|esc=0|img=public_win32/bg_npc_01.png>
<Img|x=58.0|y=153.0|esc=0|img=public/btn_npcfh_03.png>
<Img|x=58.0|y=262.0|esc=0|img=public/btn_npcfh_03.png>
<Img|x=58.0|y=333.0|esc=0|img=public/btn_npcfh_03.png>
<Text|x=80.0|y=331.0|color=249|size=20|text=说明：成功提升后，背包负重格子数量增加1格>
<Text|x=80.0|y=260.0|color=249|size=20|text=提升负重>
<RText|x=80.0|y=290.0|width=340|height=28|color=255|size=20|text=<背包负重/FCOLOR=249>     <]]..(tonumber(getconst(player,"<$BW>")))..[[/]]..lualib:Attr(player,229)..[[/FCOLOR=250>>
<Text|x=168.0|y=260.0|color=255|size=20|text=所需消耗：>
<Button|x=411.0|y=248.0|size=18|nimg=public/1900000660.png|text=确定提升|link=@click,盟重老兵_click,3>
        ]]

        for i=1,#config[1].need do
            str = str .. [[
<ItemShow|x=]]..(270 + (i-1)*70)..[[|y=235|width=70|height=70|itemid=]]..getstditeminfo(config[1].need[i][1],0)..[[|itemcount=]]..config[1].need[i][2]..[[|showtips=1|bgtype=1>
            ]]
        end
    end

    lualib:Say(player, str)
    return ""
end

function mengZhongLaoBing.click(player,page)
    page = tonumber(page)
    if page < 1 or page > 3 then
        return ""
    end

    local data = mengZhongLaoBing.getData(player)
    local num = data[page] + 1
    if page == 3 then
        num = 1
    end

    local config = mengZhongLaoBing.config[page]
    if page < 3 then
        if num > #config then
            lualib:SendMsgGetColor(player,9,"#eeff00|已经满级了！！！")
            return ""
        end
    end

    if not lualib:CheckNeedItems(player,config[num].need) then
        return ""
    end

    lualib:DelNeedItems(player,config[num].need,"盟重老兵")
    ---lualib:SetVar(player,VarCfg[mengZhongLaoBing.var[1]],config[num].num)
    if page == 1 then
        setbagcount(player,1)
    elseif page == 2 then
        changestorage(player,1)
    elseif page == 3 then
        ---只提升U13保存的基础负重，实际负重由setFuZhong写入229属性
        local fuZhong = tonumber(getplaydef(player,VarCfg["负重"])) or 0
        if fuZhong < 100 then
            fuZhong = 100
        end
        lualib:SetVar(player,VarCfg["负重"],fuZhong + 1)
    end
    mengZhongLaoBing.window(player,page)
    return ""
end

function mengZhongLaoBing.getData(player)
    local data = {}
    data[1] = lualib:GetVar(player,VarCfg["背包格子"])
    data[2] = lualib:GetVar(player,VarCfg["仓库格子"])
    data[3] = lualib:GetVar(player,VarCfg["负重"]) - 100
    if data[3] < 0 then
        lualib:SetVar(player,VarCfg["负重"],100)
        data[3] = 0
    end

    return data
end

Message.RegisterClickMsg("盟重老兵", mengZhongLaoBing)
setFormAllowFunc("盟重老兵", {"main","click","window"})
setNpcRangeAllowFunc("盟重老兵", {"main","click","window"}, 10)

return mengZhongLaoBing