dengJiShiZhe = {}
dengJiShiZhe.config = include("Script/ExtendScript/cfgcsv/npc/cfg_等级使者.lua")

function dengJiShiZhe.main(player)
    dengJiShiZhe.window(player)
end

function dengJiShiZhe.window(player)
    local level = lualib:GetVar(player,VarCfg["等级使者"]) + 1
    local config = dengJiShiZhe.config
    if level > #dengJiShiZhe.config then
        level = #dengJiShiZhe.config
    end

    local str = [[
<Img|x=0.0|y=2.0|width=546|height=220|bg=1|esc=1|move=0|loadDelay=1|img=public_win32/bg_npc_01.png|reset=1>
<Layout|x=545|y=0|width=80|height=80|link=@exit>
<Button|x=543.0|y=3.0|nimg=public/1900000510.png|pimg=public/1900000511.png|link=@exit>
<RText|x=60.0|y=67.0|outline=1|color=255|size=18|outlinecolor=0|text=在这片玛法大陆上只有强者才能立足，唯有勇者才能>
<Img|x=72.0|y=54.0|width=400|img=public/1900000667_1.png|esc=0>
<Text|x=60.0|y=97.0|size=18|color=255|text=突破自我，如果你愿意，老天就让你跨越这道难关，>
<Img|x=108.0|y=31.0|img=public/word_sxbt_05.png|esc=0>
<Text|x=217.0|y=25.0|size=20|color=251|text=等级使者>
<Img|x=59.0|y=171.0|width=15|height=18|img=public/btn_npcfh_03.png|esc=0>
<RText|x=60.0|y=123.0|size=18|color=255|text=<成就自己的传奇... /FCOLOR=255>                 <当前基础等级:/FCOLOR=250>>
<Text|x=390.0|y=123.0|size=18|color=250|text=]]..(lualib:GetVar(player,VarCfg["等级使者"]) + lualib:GetVar(player,VarCfg["等级"]))..[[>
<RText|x=79.0|y=170.0|width=152|height=21|size=18|color=255|text=<提升等级/FCOLOR=249>  <所需消耗/FCOLOR=255>>
<Button|x=423.0|y=158.0|nimg=public/1900000660.png|color=255|text=确定提升|link=@click,等级使者_click>
    ]]

    for i=1,#config[level].need do
        str = str .. [[
<ItemShow|x=]]..(270 + (i-1)*70)..[[|y=145|width=70|height=70|itemid=]]..getstditeminfo(config[level].need[i][1],0)..[[|itemcount=]]..config[level].need[i][2]..[[|showtips=1|bgtype=1>
            ]]
    end

    lualib:Say(player, str)
    return ""
end

function dengJiShiZhe.click(player)
    local level = lualib:GetVar(player,VarCfg["等级使者"]) + 1
    if level > #dengJiShiZhe.config then
        lualib:MsgBox(player,"已经满级了")
        return ""
    end
    local config = dengJiShiZhe.config[level]
    if not lualib:CheckNeedItems(player,config.need) then
        return ""
    end

    lualib:DelNeedItems(player,config.need,"盟重老兵")
    lualib:SetVar(player,VarCfg["等级使者"],config.level)
    sheZhiDengJi.setLevel(player)
    dengJiShiZhe.window(player)
    return ""
end


Message.RegisterClickMsg("等级使者", dengJiShiZhe)
setFormAllowFunc("等级使者", {"main","click","window"})

return dengJiShiZhe