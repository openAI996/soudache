NPC = {}
NPC.config = include("Script/系统表/cfg_npclist.lua")
local NPC_tableCache = {}
---注册NPC点击触发的函数列表
---@param _stringScript string 表单名称
---@param _stringScriptCallback string 函数回调
function NPC.register(_stringScript, _stringScriptCallback)
    local stringScript = tostring(_stringScript)
    if stringScript == "nil" or stringScript == "" then
        release_print("NPC点击触发事件注册失败，_stringScript为空。")
        return false
    end

    local stringScriptTag = tostring(_stringScriptCallback)
    if stringScriptTag == "nil" or stringScriptTag == "" then
        release_print("NPC点击触发事件注册失败，_stringScriptTag为空。")
        return false
    end

    if NPC_tableCache[stringScript] ~= nil then
        release_print(string.format("NPC点击触发事件注册失败，%s的回调函数%s已注册过。", stringScript, stringScriptTag))
        return false
    end

    NPC_tableCache[stringScript] = _stringScriptCallback
    return true
end

---获取NPC点击触发调用的函数
---@param _stringScript string npcid
function NPC.getCallback(_stringScript)
    local stringScript = tostring(_stringScript)
    if stringScript == "nil" or stringScript == "" then
        release_print("NPC点击触发事件获取失败，_stringScript为空。")
        return nil
    end
    ---print(tostring(_stringScript))
    if NPC_tableCache[stringScript] == nil then
        release_print(string.format("NPC点击触发事件获取失败，%s未注册过。", stringScript))
        return nil
    end
    ----print(NPC_tableCache[stringScript])
    return NPC_tableCache[stringScript]
end


---按脚本名从 NPC 配置表中查找 NPC id，供各功能做 NPC 距离校验
---@param _stringScript string NPC 配置中的 script，例如 "藏品_main"
function NPC.getNpcIdxByScript(_stringScript)
    local stringScript = tostring(_stringScript)
    if stringScript == "nil" or stringScript == "" then
        return nil
    end

    for _,npcConfig in pairs(NPC.config) do
        if npcConfig.script == stringScript then
            return npcConfig.id
        end
    end

    return nil
end
--记载NPC配置
for _,v in pairs(NPC.config) do
    if v.script ~= nil then
        NPC.register(v.id,v.script)
    end
end
