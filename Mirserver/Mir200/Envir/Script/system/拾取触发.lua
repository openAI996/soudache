local config = {
    [0] = "禁止扔",
    [1] = "禁止交易",
    --[2] = "禁止存",
   -- [3] = "禁止修",
    [4] = "禁止出售",
    --[5] = "禁止爆出",
    [6] = "丢弃消失",
    --[7] = "死亡必爆(死亡爆出来后，该属性就会删除，在捡起来戴上，就没有死亡必爆了)",
    [8] = "禁止摆摊或上架拍卖行",
    [21] = "爆出消失[引擎64_24.03.14新增]",
}

-- 拾取前触发
function pickupitemfrontex(player, item)
    --if lualib:GetFlag(player,VarCfg["特权"]) == 0  then
    --    for i, v in pairs(config) do
    --        setitemstate(item,i,1)
    --    end
    --end

    return true
end

-- 捡取触发
function pickupitemex(player, item)
    local now = tonumber(os.time())
    local id = getiteminfo(player,item,2)
    local name = lualib:ItemName(player,item)
    GameEvent.push(EventCfg.onPickUpItemEx,player,item,id,name)
end

--添加背包触发
function addbag(player,item)
    local r1,r2 = checkhumanstate(player,10)
    if lualib:Attr(player,229) <= tonumber(getconst(player,"<$BW>")) then
        if not r1 then
            makeposion(player,13,65535)
        end
    else
        if r1 then
            makeposion(player,13,0)
        end
    end

    if ServerCache.Players[player].OtherEquip["聚宝成锋"] ~= nil then
        local num = cheLiDian.getGold(player)
        if num > 10000 then
            local x = math.floor(num/10000)
            local txt = lualib:GetVar(player,"N$".."聚宝成锋")
            ----print(num,txt,"聚宝成锋")
            if x ~= txt then
                lualib:AddAttrList(player,"聚宝成锋","=","3#1#"..(10*x).."|3#4#"..x)
            end
        end
    end
end

--掉落物品触发
function mondropitemex(player,item,monster,x,y)
    local id = getiteminfo(player,item,2)
    local name = getstditeminfo(id,1)

    GameEvent.push(EventCfg.onMonDropItemEx,player,item,name,id,monster,x,y)
    return true
end