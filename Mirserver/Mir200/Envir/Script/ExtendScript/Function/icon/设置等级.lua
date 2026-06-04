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
    ---U13只保存永久基础负重，实际生效和显示统一走229属性
    local level = tonumber(getplaydef(player,VarCfg["负重"])) or 0
    local job = lualib:Job(player)
    local minLevel = 100
    if sheZhiDengJi.job[job] ~= nil and sheZhiDengJi.job[job][1] ~= nil then
        minLevel = sheZhiDengJi.job[job][1]
    end

    if level < minLevel then
        level = minLevel
        setplaydef(player,VarCfg["负重"],level)
    end

    local attrStr = "3#229#"..level
    if lualib:GetAttrList(player,"负重") ~= attrStr.."|" then
        lualib:AddAttrList(player,"负重","=",attrStr)
    end
end

local function _onLogin(player)
    sheZhiDengJi.setFuZhong(player)
end

GameEvent.add(EventCfg.onLogin,_onLogin,sheZhiDengJi)
Message.RegisterClickMsg("设置等级", sheZhiDengJi)
setFormAllowFunc("设置等级", {"main","click","change","setLevel"})

return sheZhiDengJi