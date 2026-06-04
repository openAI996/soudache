Stats = {}

function Stats.load(player)
    ----print(lualib:Name(player),"xxx重载属性")
    Stats.power(player)             --神力
    Stats.drop_probability(player)  --掉落概率
    Stats.revive(player)            --复活
    Stats.attr(player)              --自定义特殊属性
    Stats.levelname(player)         --称谓
    Stats.xiShou(player)            --伤害吸收
    Stats.speed(player)             --移动速度
    Stats.skillpower(player)        --技能威力
    ---delaygoto(player,100,"jiazaishuxing")
end

----战斗力
function Stats.zhanDouLi(player)

end
------神力
function Stats.power(player)
    local power = 100               --神力
    local power_spurious =  100 + lualib:Attr(player,203)/100    --假神力

    ServerCache.onUpdatePlayerNumberVars(player, "神力", power_spurious)
    --转生神力
    powerrate(player,power_spurious,99999)
    return ""
end
---爆率加载
function Stats.drop_probability(player)
    local drop =  lualib:Attr(player,201)/100 * (1 + lualib:Attr(player,202)/10000) + 100
    local drop_real = drop

    ServerCache.onUpdatePlayerNumberVars(player, "爆率", drop)
    setbaseinfo(player,43,drop_real)
    return ""
end
---复活
function Stats.revive(player)
    --复活
    local revive = lualib:Attr(player,233)
    ServerCache.onUpdatePlayerNumberVars(player, "复活", revive)

    local po = lualib:Attr(player,209)
    ServerCache.onUpdatePlayerNumberVars(player, "破复活几率", po)
    return revive
end
---伤害吸收
function Stats.xiShou(player)
    local xiShou = lualib:Attr(player,204)
    if xiShou > 60 then
        xiShou = 60
    end
    xiShou = math.floor(xiShou*0.95)
    setsuckdamage(player,"=",xiShou*10,1)
    return ""
end
---自定义特殊属性
function Stats.attr(player)
    --攻速计算
    local speed = math.floor(lualib:Attr(player,216))
    ServerCache.onUpdatePlayerNumberVars(player, "攻速", speed)
    changespeedex(player,2,speed)

    speed = math.floor(lualib:Attr(player,251))
    changespeedex(player,3,speed)

    local qiege = lualib:Attr(player, 211)
    ServerCache.onUpdatePlayerNumberVars(player, "刀刀切割", qiege)

    local name = "战意昂扬"
    if ServerCache.Players[player].OtherEquip[name] ~= nil then
        local num = math.floor(lualib:Attr(player,1)*0.03)
        if num > 0 then
            local txt = lualib:GetAttrList(player,name)
            if txt ~= "3#4#"..(num).."|" then             --切割待换
                lualib:AddAttrList(player,name,"=","3#4#"..(num))
            end
        else
            if lualib:GetAttrList(player,name) ~= "" then
                lualib:DelAttrList(player,name)
            end
        end
    else
        if lualib:GetAttrList(player,name) ~= "" then
            lualib:DelAttrList(player,name)
        end
    end

    name = "唯快不破"
    if ServerCache.Players[player].OtherEquip[name] ~= nil then
        local num = math.floor(lualib:Attr(player,216)*0.5)
        if num > 0 then
            local txt = lualib:GetAttrList(player,name)
            if txt ~= "3#25#"..(num).."|" then             --切割待换
                lualib:AddAttrList(player,name,"=","3#25#"..(num))
            end
        else
            if lualib:GetAttrList(player,name) ~= "" then
                lualib:DelAttrList(player,name)
            end
        end
    else
        if lualib:GetAttrList(player,name) ~= "" then
            lualib:DelAttrList(player,name)
        end
    end

    sheZhiDengJi.setFuZhong(player)
    return ""
end
---技能威力
function Stats.skillpower(player)
    local skillpower = lualib:Attr(player, 238)     --攻杀剑术
    setmagicpower(player,"攻杀剑术",skillpower/100,1)
    skillpower = lualib:Attr(player, 239)     --刺杀剑术
    setmagicpower(player,"刺杀剑术",skillpower/100,1)
    skillpower = lualib:Attr(player, 240)     --半月弯刀
    setmagicpower(player,"半月弯刀",skillpower/100,1)
    skillpower = lualib:Attr(player, 241)     --烈火剑法
    setmagicpower(player,"烈火剑法",skillpower/100,1)
    skillpower = lualib:Attr(player, 242)     --逐日剑法
    setmagicpower(player,"逐日剑法",skillpower/100,1)
    skillpower = lualib:Attr(player, 243)     --开天斩
    setmagicpower(player,"开天斩",skillpower/100,1)
    skillpower = lualib:Attr(player, 253)
    setmagicpower(player,"火墙",skillpower/100,1)
    skillpower = lualib:Attr(player, 254)
    setmagicpower(player,"灵魂火符",skillpower/100,1)
    skillpower = lualib:Attr(player, 256)
    setmagicpower(player,"雷电术",skillpower/100,1)
    skillpower = lualib:Attr(player, 257)
    setmagicpower(player,"野蛮冲撞",skillpower/100,1)
    skillpower = lualib:Attr(player, 258)
    setmagicpower(player,"大火球",skillpower/100,1)
    skillpower = lualib:Attr(player, 259)
    setmagicpower(player,"冰咆哮",skillpower/100,1)
    skillpower = lualib:Attr(player, 251)
    setmagicpower(player,"施毒术",skillpower/100,1)
    --
    skillpower = lualib:Attr(player, 244)     --攻杀剑术防御
    setmagicdefpower(player,"开天斩",skillpower/100,1)
    skillpower = lualib:Attr(player, 245)     --刺杀剑术防御
    setmagicdefpower(player,"刺杀剑术",skillpower/100,1)
    skillpower = lualib:Attr(player, 246)     --半月弯刀防御
    setmagicdefpower(player,"半月弯刀",skillpower/100,1)
    skillpower = lualib:Attr(player, 247)     --烈火剑法防御
    setmagicdefpower(player,"烈火剑法",skillpower/100,1)
    skillpower = lualib:Attr(player, 248)     --逐日剑法防御
    setmagicdefpower(player,"逐日剑法",skillpower/100,1)
    skillpower = lualib:Attr(player, 249)     --开天斩防御
    setmagicdefpower(player,"开天斩",skillpower/100,1)
    skillpower = lualib:Attr(player, 255)
    setmagicdefpower(player,"火墙",skillpower/100,1)
    skillpower = lualib:Attr(player, 256)
    setmagicdefpower(player,"灵魂火符",skillpower/100,1)
end
---加载称谓
function Stats.levelname(player)
    local str = "\\★★搜打撤传奇★★\\"
    local rein = lualib:ReinLevel(player)
    local kill = lualib:GetVar(player,VarCfg["杀人次数"])
    local die = lualib:GetVar(player,VarCfg["被杀次数"])
    if rein > 0 then
        str = str.."★★转生≦"..rein.."≥★★\\"
    end

    if kill > 0 then
        str = str.."★杀人数量:["..kill.."]★\\"
    end
    if die > 0 then
        str = str.."★死亡数量:["..die.."]★"
    end

    setranklevelname(player,"%s"..str)
end
---移动速度
function Stats.speed(player)
    local speed = lualib:Attr(player,232)
    changespeedex(player,1,speed,65535)
    return ""
end

local function _onAddBuff(player,buff)
    if lualib:GetVar(player,"N$服务端缓存") == 1 then
        ServerCache.onUpdatePlayerNumberVars(player,"属性变化",1)
    end
end
--
local function _onDelBuff(player,buff)
    if lualib:GetVar(player,"N$服务端缓存") == 1 then
        ServerCache.onUpdatePlayerNumberVars(player,"属性变化",1)
    end
end
----
local function _onLogin(player)
    Stats.load(player)
end
----
local function _onTitleChange(player,title,type)
    Stats.load(player)
end
----
local function _onTakeChange(player,item,where,itemName,makeIndex,type)
    Stats.load(player)
end

function Stats.onCheckAttr(player)
    Stats.power(player)             --神力
    Stats.drop_probability(player)  --掉落概率
    Stats.revive(player)            --复活
    Stats.attr(player)               --自定义特殊属性
    Stats.speed(player)             --移动速度
    Stats.skillpower(player)        --技能威力
end

GameEvent.add(EventCfg.onTakeChange,_onTakeChange,Stats,2)
GameEvent.add(EventCfg.onTitleChange,_onTitleChange,Stats,2)
GameEvent.add(EventCfg.onAddBuff,_onAddBuff,Stats,2)
GameEvent.add(EventCfg.onDelBuff,_onDelBuff,Stats,2)
GameEvent.add(EventCfg.onLevelName,Stats.levelname,Stats,2)
GameEvent.add(EventCfg.onLogin,_onLogin,Stats,1)
GameEvent.add(EventCfg.onLoadAttr, Stats.load, Stats,2)

return Stats