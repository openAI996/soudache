jiNengJingXiu = {}
---jiNengJingXiu.config = include("Script/ExtendScript/cfgcsv/npc/cfg_技能精修.lua")
jiNengJingXiu.icon = {
    {
        {"10096",name = "刺杀剑术",
         need = {{"金币",10000},{"书页",10}}
        },
        {"10097",name = "半月弯刀",
         need = {{"金币",10000},{"书页",10}}
        },
        {"10098",name = "野蛮冲撞",
         need = {{"金币",10000},{"书页",10}}
        },
        {"10099",name = "烈火剑法",
         need = {{"金币",10000},{"书页",10}}
        },
    },
    {
        {"10100",name = "诱惑之光",
         need = {{"金币",10000},{"书页",10}}
        },
        {"10101",name = "雷电术",
         need = {{"金币",10000},{"书页",10}}
        },
        {"10102",name = "火墙",
         need = {{"金币",10000},{"书页",10}}
        },
        {"10103",name = "冰咆哮",
         need = {{"金币",10000},{"书页",10}}
        },
    },
    {
        {"10104",name = "施毒术",
         need = {{"金币",10000},{"书页",10}}
        },
        {"10105",name = "灵魂火符",
         need = {{"金币",10000},{"书页",10}}
        },
        {"10106",name = "召唤骷髅",
         need = {{"金币",10000},{"书页",10}}
        },
        {"10107",name = "幽灵盾",
         need = {{"金币",10000},{"书页",10}}
        },
        {"10108",name = "神圣战甲术",
         need = {{"金币",10000},{"书页",10}}
        },
        {"10109",name = "召唤神兽",
         need = {{"金币",10000},{"书页",10}}
        },
    },
}

function jiNengJingXiu.main(player)
    jiNengJingXiu.window(player)
end

function jiNengJingXiu.window(player)
    local job = lualib:Job(player)
    local level = lualib:GetVar(player,VarCfg["精修等级"])
    local str = [[
<Img|x=0.0|y=2.0|width=546|height=220|img=public_win32/bg_npc_01.png|bg=1|esc=1|move=0|loadDelay=1|reset=1>
<Layout|x=545|y=0|width=80|height=80|link=@exit>
<Button|x=543.0|y=3.0|nimg=public/1900000510.png|pimg=public/1900000511.png|link=@exit>
<RText|x=33.0|y=67.0|outline=1|color=255|outlinecolor=0|size=18|text=在玛法大陆的修行之路上，等级的突破只有基础，>
<Img|x=72.0|y=54.0|width=400|img=public/1900000667_1.png|esc=0>
<Text|x=33.0|y=97.0|color=255|size=18|text=真正的强者更注重对武学与魔法的极致雕琢>
<Img|x=108.0|y=31.0|img=public/word_sxbt_05.png|esc=0>
<Text|x=217.0|y=25.0|color=251|size=20|text=技能强化>
    ]]
    local grey = 0
    for i=1,#jiNengJingXiu.icon[job] do
        if level >= i then
            grey = 0
        else
            grey = 1
        end

        str = str .. [[
                <Img|x=]]..(31 + (i-1)*100)..[[|y=125.0|width=63|height=63|img=public/1900000651_2.png|esc=0>
                <ItemShow|x=]]..(29 + (i-1)*100)..[[|y=124.0|width=70|height=70|itemcount=1|showtips=1|itemname=]]..jiNengJingXiu.icon[job][i].name..[[|bgtype=0|grey=]]..grey..[[|link=@click,技能精修_ok,]]..i..[[>
            ]]
        if i < #jiNengJingXiu.icon[job] then
            str = str .. [[
                <Frames|x=]]..(98 + (i-1)*100)..[[|y=153.0|width=30|height=10|speed=15|loop=-1|prefix=public/jinengqianghua/1_|suffix=.png|count=10|grey=]]..grey..[[>
            ]]
        end

        if level + 1 == i then
            str = str .. [[
                <Effect|x=]]..(64 + (i-1)*100)..[[|y=159.0|scale=1|speed=1|dir=5|effectid=4004|effecttype=0|act=0>
            ]]
        end
    end

    lualib:Say(player, str)
    return ""
end

function jiNengJingXiu.ok(player,page)
    page = tonumber(page)
    local str = ""
    local level = lualib:GetVar(player,VarCfg["精修等级"]) + 1
    local job = lualib:Job(player)
    if level > #jiNengJingXiu.icon[job] then
        lualib:MsgBox(player,"该技能已经精修过了！！")
        return ""
    end

    for i=1,#jiNengJingXiu.icon[job][level].need do
        str = str .. jiNengJingXiu.icon[job][level].need[i][2] .. "" .. jiNengJingXiu.icon[job][level].need[i][1]
        if i < #jiNengJingXiu.icon[job][level].need then
            str = str .. " + "
        end
    end

    lualib:MsgBox(player,"精修需要："..str,"@click,技能精修_click,"..page,"@no")
end

function jiNengJingXiu.click(player)
    local level = lualib:GetVar(player,VarCfg["精修等级"]) + 1
    local job = lualib:Job(player)
    if level > #jiNengJingXiu.icon[job] then
        lualib:MsgBox(player,"该技能已经精修过了！！")
        return ""
    end

    if not lualib:CheckNeedItems(player,jiNengJingXiu.icon[job][level].need) then
        return ""
    end

    lualib:DelNeedItems(player,jiNengJingXiu.icon[job][level].need,"技能精修")

    lualib:SetVar(player,VarCfg["精修等级"],level)
    lualib:MsgBox(player,"技能精修成功！！")
    jiNengJingXiu.window(player)
    return ""
end

function jiNengJingXiu.addAttr(player)
    local job = lualib:Job(player)
    local level = lualib:GetVar(player,VarCfg["精修等级"])
    lualib:DelAttrList(player,"技能精修1")
    lualib:DelAttrList(player,"技能精修2")
    lualib:DelAttrList(player,"技能精修3")
    lualib:DelAttrList(player,"技能精修4")
    lualib:DelAttrList(player,"技能精修5")

    if job == 1 then
        if level >= 1 then
            lualib:AddAttrList(player,"技能精修1","3#216#1|3#3#3|3#4#5")
        end

        if level >= 2 then
            lualib:AddAttrList(player,"技能精修2","3#240#20")
        end
    elseif job == 2 then
        if level >= 3 then
            lualib:AddAttrList(player,"技能精修3","3#253#10")
        end
    elseif job == 3 then
        if level >= 2 then
            lualib:AddAttrList(player,"技能精修3","3#253#10")
        end

        if level >= 4 then
            lualib:AddAttrList(player,"技能精修4","3#11#2|3#12#5")
        end

        if level >= 5 then
            lualib:AddAttrList(player,"技能精修5","3#9#2|3#10#5")
        end
    end
end

--local function _onLogin(player)
--    if lualib:GetVar(player,VarCfg["精修等级"]) >= 1 then
--        jiNengJingXiu.addAttr(player)
--    end
--end
--
--GameEvent.add(EventCfg.onLogin,_onLogin,jiNengJingXiu)
Message.RegisterClickMsg("技能精修", jiNengJingXiu)
setFormAllowFunc("技能精修", {"main","click","window","ok"})

return jiNengJingXiu