functionOtherEquip = {}

---技能CD计算
function functionOtherEquip.SkillCD(player)
    --local liehuo = 0
    --local kaitian = 0
    --local zuri = 0
    --local shibu = 0
    --local qinglong = 0
    local yeman = 0

    --if liehuo > 0 then
    --    setskilldeccd(player,"烈火剑法","=",0)
    --    setskilldeccd(player,"烈火剑法","-",liehuo)
    --else
    --    setskilldeccd(player,"烈火剑法","=",0)
    --end
    --
    --if kaitian > 0 then
    --    setskilldeccd(player,"开天斩","=",0)
    --    setskilldeccd(player,"开天斩","-",kaitian)
    --else
    --    setskilldeccd(player,"开天斩","=",0)
    --end
    --
    --if zuri > 0 then
    --    setskilldeccd(player,"逐日剑法","=",0)
    --    setskilldeccd(player,"逐日剑法","-",zuri)
    --else
    --    setskilldeccd(player,"逐日剑法","=",0)
    --end
    --
    --if shibu > 0 then
    --    setskilldeccd(player,"十步一杀","=",0)
    --    setskilldeccd(player,"十步一杀","-",shibu)
    --else
    --    setskilldeccd(player,"十步一杀","=",0)
    --end
    --
    --if qinglong > 0 then
    --    setskilldeccd(player,"擒龙手","=",0)
    --    setskilldeccd(player,"擒龙手","-",qinglong)
    --else
    --    setskilldeccd(player,"擒龙手","=",0)
    --end

    --local _t = ServerCache.Players[player].StringVars["技能等级"]
    --if _t ~= nil then
    --    local job = lualib:Job(player)
    --    if job == 1 then
    --        if _t[5] >= 4 then
    --            yeman = 2
    --        elseif _t[5] >= 1 then
    --            yeman = 1
    --        end
    --    end
    --end
    --
    --if yeman > 0 then
    --    setskilldeccd(player,"野蛮冲撞","=",0)
    --    setskilldeccd(player,"野蛮冲撞","-",yeman)
    --else
    --    setskilldeccd(player,"野蛮冲撞","=",0)
    --end
end
---复活触发
local function _onRealive(player)

end
---击杀玩家触发
local function _onKillPlay(player,die)

end
---被杀触发
local function _onPlayDie(player,hiter)

end
---死亡前触发
local function _onNextDie(player,hiter,isplayer,die_tb)
    local times = tonumber(os.time())
end
---穿脱装备触发
local function _onTakeChange(player,item,where,itemName,makeIndex,type)
    ----print(where,itemName,"type = "..type)
    if type == 1 then
        if item_special_tb.element[itemName] ~= nil then
            if getitemaddvalue(player,item,3,1) == 0 then
                setitemaddvalue(player,item,3,1,1)
                if item_special_tb.element[itemName].type == 1 then
                    local value = math.random(item_special_tb.element[itemName].value[1],item_special_tb.element[itemName].value[2])
                    setnewitemvalue(player,where,item_special_tb.element[itemName][1],"=",value*100)
                elseif item_special_tb.element[itemName].type == 2 then
                    local value = math.random(item_special_tb.element[itemName].value[1],item_special_tb.element[itemName].value[2])
                    local random = math.random(1,#item_special_tb.element.random)
                    setnewitemvalue(player,where,item_special_tb.element.random[random],"=",value*100)
                elseif item_special_tb.element[itemName].type == 3 then
                    local tb = lualib:CopyTable(item_special_tb.element.random)
                    for i=1,item_special_tb.element[itemName].num do
                        local value = math.random(item_special_tb.element[itemName].value[i][1],item_special_tb.element[itemName].value[i][2])
                        local key = math.random(1,#tb)
                        setnewitemvalue(player,where,tb[key],"=",value*100)
                        table.remove(tb,key)
                    end
                elseif item_special_tb.element[itemName].type == 4 then
                    local flag = 1
                    local _data  = {key = item_special_tb.element[itemName].key,value = {}}
                    for i=1,#item_special_tb.element[itemName].value do
                        _data.value[i] = math.random(item_special_tb.element[itemName].value[i][1],item_special_tb.element[itemName].value[i][2])
                        if _data.value[i]/item_special_tb.element[itemName].value[i][2] < 0.8 then
                            flag = 0
                        end
                    end

                    lualib:AddCustomAttr(player,item,"[附加属性]",_data,"=",2)
                end
                refreshitem(player,item)
                recalcabilitys(player)
            end
        end
    else

    end
end
---删除buff触发
local function _onDelBuff(player, buffId, grou)
    if buffId == 20015 then
        lualib:SetVar(player,"N$金蝉脱壳护盾",0)
    end

    if buffId == 20011 then
        lualib:SetVar(player,"N$灼烧比例",0)
        lualib:SetVar(player,"N$灼烧弱化",0)
    end
end
---添加buff触发
local function _onAddBuff(player, buffId, grou)
    if buffId == 20015 then
        lualib:SetVar(player,"N$金蝉脱壳护盾",lualib:Hp(player,true)*0.2)
    end


end

local function _onKillMon(player,monster,monsterName,map)

end
---狂暴之力
local function _onRage(player)

end
---升级触发
local function _onPlayLevelUp(player)

end
---登录触发
local function _onLogin(player)
    local times = tonumber(os.time())
    ServerCache.onUpdatePlayerNumberVars(player,"战斗状态",times - 3)
    ---技能CD计算
    functionOtherEquip.SkillCD(player)
end
---释放
---触发
local skill_tb = {
    ["逐日剑法"] = 56,
    ["烈火剑法"] = 26,
    ["开天斩"] = 66,
}
local function _onBeginMagic(player,id,name,target,x,y,magic)

end
---移动触发
local function _onRun(player,mapName)

end
---暴击触发
local function _onCrit(player,target,skillid,times,attackDamage)

end
---PK值变化
local function _onPKChange(player,pk)

end
---转生变化触发
local function _onRein(player)

end
---称号改变
local function _onTitleChange(player,title,type)

end
---装备全部属性
local function _onAllAttrChange(player)
    if ServerCache.Players[player] == nil then
        ServerCache.onInitPlayer(player)
    end

    Stats.attr(player)
end
---控制触发
local function _onControl(player)
    if lualib:Player_IsPlayer(player) then

    end
end
---击杀狂暴玩家触发
local function _onKillRage(player,die)

end
---buff血量变化触发
local function _onBuffHpChange(player,buffID,buffGroup,data,buffHost,mon)
    if buffID == 20011 then
        if mon == nil then
            local bl = lualib:GetVar(player,"N$灼烧比例")
            ----print(bl,"N$灼烧比例xxxxxxx",lualib:Name( player))
            if bl == 0 then
                bl = 1
            end
            ----print(bl,"燃烧比例xxxxxxxx")
            data.damage = -lualib:Hp(player,true) * bl/100
        end
    end

    return data
end
---
local function _onPickUpItemEx(player,item,id,itemName)

end

GameEvent.add(EventCfg.onPickUpItemEx,_onPickUpItemEx,functionOtherEquip,2)
GameEvent.add(EventCfg.onControl,_onControl,functionOtherEquip,2)
GameEvent.add(EventCfg.onPKChange,_onPKChange,functionOtherEquip,2)
GameEvent.add(EventCfg.onTitleChange,_onTitleChange,functionOtherEquip,2)
GameEvent.add(EventCfg.onCrit,_onCrit,functionOtherEquip,2)
GameEvent.add(EventCfg.onRun,_onRun,functionOtherEquip,2)
GameEvent.add(EventCfg.onAllAttrChange,_onAllAttrChange,functionOtherEquip,3)
GameEvent.add(EventCfg.onBeginMagic,_onBeginMagic,functionOtherEquip,2)
GameEvent.add(EventCfg.onBuffHpChange,_onBuffHpChange,functionOtherEquip,2)
GameEvent.add(EventCfg.onRein,_onRein,functionOtherEquip,2)
GameEvent.add(EventCfg.onLogin,_onLogin,functionOtherEquip,10)
GameEvent.add(EventCfg.onLoadQF,_onLogin,functionOtherEquip,2)
GameEvent.add(EventCfg.onPlayLevelUp,_onPlayLevelUp,functionOtherEquip,2)
GameEvent.add(EventCfg.onRage,_onRage,functionOtherEquip,2)
GameEvent.add(EventCfg.onKillRage,_onKillRage,functionOtherEquip,2)
GameEvent.add(EventCfg.onKillMon,_onKillMon,functionOtherEquip,2)
GameEvent.add(EventCfg.onAddBuff,_onAddBuff,functionOtherEquip,2)
GameEvent.add(EventCfg.onDelBuff,_onDelBuff,functionOtherEquip,2)
GameEvent.add(EventCfg.onTakeChange,_onTakeChange,functionOtherEquip,2)
GameEvent.add(EventCfg.onNextDie,_onNextDie,functionOtherEquip,2)
GameEvent.add(EventCfg.onPlayDie,_onPlayDie,functionOtherEquip,2)
GameEvent.add(EventCfg.onKillPlay,_onKillPlay,functionOtherEquip,2)
GameEvent.add(EventCfg.onRealive,_onRealive,functionOtherEquip,2)

Message.RegisterClickMsg("装备其他", functionOtherEquip,2)
setFormAllowFunc("装备其他", {"suit805"})

return functionOtherEquip