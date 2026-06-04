sheZhiDengJi = {}
sheZhiDengJi.config = include("Script/ExtendScript/cfgcsv/npc/cfg_升级等级.lua")

function sheZhiDengJi.setLevel(player)
    changeexp(player,"=",0)
    local level = lualib:GetVar(player,VarCfg["等级"]) + lualib:Attr(player,250) + lualib:GetVar(player,VarCfg["等级使者"])
    if level == 0 then
        level = 1
    end

    ----print("当前等级：",lualib:GetVar(player,VarCfg["等级"]) , lualib:Attr(player,250) , lualib:GetVar(player,VarCfg["等级使者"]))
    lualib:SetLevel(player,level)

    ---clearskill(player) --清空技能
    for i=1,#anQuanXiang.level do
        if level >= i then
            if anQuanXiang.level[i].type ~= nil then
                for j=1,#anQuanXiang.level[i].type do
                    if getskillinfo(player,anQuanXiang.level[i].type[j],1) == nil then
                        addskill(player,anQuanXiang.level[i].type[j],3)
                    end
                end
            end
        else
            if anQuanXiang.level[i].type ~= nil then
                for j=1,#anQuanXiang.level[i].type do
                    if getskillinfo(player,anQuanXiang.level[i].type[j],1) ~= nil then
                        delskill(player,anQuanXiang.level[i].type[j])
                    end
                end
            end
        end
    end
    chouKa.setCache(player)
end

sheZhiDengJi.job = {
    {100},
    {100},
    {100}
}

function sheZhiDengJi.setFuZhong(player)
    local level = lualib:GetVar(player,VarCfg["负重"])
    local job = lualib:Job(player)
    if level < sheZhiDengJi.job[job][1] then
        lualib:SetVar(player,VarCfg["负重"],sheZhiDengJi.job[job][1])
        lualib:AddAttrList(player,"负重","=","3#229#"..sheZhiDengJi.job[job][1])
    end

    local txt = lualib:GetAttrList(player,"负重")
    level = lualib:GetVar(player,VarCfg["负重"])
    if txt ~= "3#229#"..(level).."|" then
        lualib:AddAttrList(player,"负重","=","3#229#"..(level))
    end
end

local function _onLogin(player)
    sheZhiDengJi.setFuZhong(player)
end

GameEvent.add(EventCfg.onLogin,_onLogin,sheZhiDengJi)
Message.RegisterClickMsg("设置等级", sheZhiDengJi)
setFormAllowFunc("设置等级", {"main","click","change","setLevel"})

return sheZhiDengJi