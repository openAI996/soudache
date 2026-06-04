math.randomseed(tostring(os.time()):reverse():sub(1, 7))

local function _Includes()
    --三方库
    --json = require("cjson")
    --cjson = require("cjson")
    --include("3rd/log/Logger.lua")
    --引擎表
    -- cfg_store                            = include("QuestDiary/cfgxls/cfg_store")
    -- cfg_att_score                        = include("QuestDiary/cfgxls/cfg_att_score")
    --载入全局cfg
    ---print("登录触发，进来了 util")
    include("Script/ExtendScript/cfgcsv/init.lua")
    --扩展
    include("Script/ExtendScript/Config/ConstCfg.lua")
    include("Script/ExtendScript/Config/ResponseCfg.lua")
    include("Script/ExtendScript/Config/VarCfg.lua")
    include("Script/ExtendScript/Config/ModuleCfg.lua")
    include("Script/ExtendScript/Config/EventCfg.lua")

    ssrResponseCfg  = include("Script/ExtendScript/Config/ResponseCfg.lua")
    --网络
    ssrNetMsgCfg = include("Script/ExtendScript/net/NetMsgCfg.lua")
    include("Script/ExtendScript/net/Message.lua")
    --通用模块
    include("Script/ExtendScript/util/GameEvent.lua")
    --include("Script/ExtendScript/game/Global.lua")
    -- 载入个人常量
    include("Script/ExtendScript/Constant/Constant.lua")
    -- 载入基本工具
    include("Script/ExtendScript/Util/baseUtil.lua")
    -- NPC
    include("Script/ExtendScript/Util/NPC.lua")
    -- 载入自定义函数
    include("Script/ExtendScript/Function/自定义函数.lua")

    --初始化个人模块
    --local filelist = getenvirfilelist()
    --for _, v in ipairs(filelist) do
    --    if string.find(v,"Market_Def\\ExtendScript\\Function") then
    --        local path = string.gsub(v,"\\","/")
    --        include(""..path)
    --    end
    --end.
    include("Script/ExtendScript/Function/通用功能/init.lua")
    include("Script/ExtendScript/Function/icon/init.lua")
    include("Script/ExtendScript/Function/npc/init.lua")
    ---include("Script/ExtendScript/Function/剧情/init.lua")
    include("Script/ExtendScript/Function/跨服/init.lua")
    ---include("Script/ExtendScript/Function/奇遇/init.lua")
    include("Script/ExtendScript/Function/任务/init.lua")
    include("Script/system/init.lua")
    -- gmbox
    include("Script/ExtendScript/GMBOX/yatools.lua")
    local tablePlayerList = getplayerlst()
    for _, v in ipairs(tablePlayerList) do
        if Stats and Stats.load then
            Stats.load(v)
        end
        --GameEvent.push(EventCfg.onLoadAttr, v)
        --take_change(v)
        GameEvent.push(EventCfg.onTimeGift, v,1)
        GameEvent.push(EventCfg.onLoadQF, v)
        --GameEvent.push(EventCfg.onLogin, v)
    end
    GameEvent.push(EventCfg.onSystemCache)
    ---GameEvent.push(EventCfg.onHeiShi)
end

--无限参数调用
function unpack(t, i, n)
    t = t or {}
    i = i or 1
    n = n or #t
    if i <= n then
        return t[i], unpack(t, i + 1, n)
    end
end

--序列化解锁
function _convertIndexToNumber(tb)
    for k, v in pairs(tb) do
        if type(k) == "string" and tonumber(k) then
            tb[tonumber(k)] = v
            tb[k] = nil
        end
        if type(v) == "table" then
            _convertIndexToNumber(v)
        end
    end
end

--客户端消息分发
function response_client(player,msgid,arg1,arg2,arg3,sMsg)
    msgid = tonumber(msgid)
    arg1 = tonumber(arg1)
    arg2 = tonumber(arg2)
    arg3 = tonumber(arg3)
    if msgid == ssrNetMsgCfg.sync then
        ULogin(actor)
        return
    end

    local result, errinfo = pcall(Message.dispatch, player, msgid, arg1, arg2, arg3, sMsg)

    if not result then
        local name = getbaseinfo(player, ConstCfg.gbase.name)
        local msgName = ssrNetMsgCfg[msgid]
        local err = "网络消息派发错误：消息ID="..msgid.."  消息Name="..msgName.."   "
        release_print(name, err, errinfo, arg1, arg2, arg3, sMsg)
    end
    --Message.dispatch(player, tonumber(msgid), tonumber(arg1), tonumber(arg2), tonumber(arg3), sMsg)
    return ""
end

function UIncludes()
    local _,errinfo = pcall(_Includes)
    if errinfo then
        release_print("UIncludes", errinfo)
    end
end

function ULogin(actor, isnewhuman)
    local level = getbaseinfo(actor, ConstCfg.gbase.level)
    lualib:SetVar(actor, VarCfg.N_cur_level, level)
    --个人变量声明
    GameEvent.push(EventCfg.goPlayerVar, actor)
    --第一次登录
    if isnewhuman then GameEvent.push(EventCfg.onNewHuman, actor) end
    --登录
    GameEvent.push(EventCfg.onLogin, actor)
    --登录附加属性
    local loginattrs = {}
    GameEvent.push(EventCfg.onLoginAttr, actor, loginattrs)
    -- LOGDump(loginattrs)
    Player.updateAddr(actor, loginattrs)
    --登录完成
    local logindatas = {}
    GameEvent.push(EventCfg.onLoginEnd, actor, logindatas)
    -- LOGDump(logindatas, "logindatas")
    table.insert(logindatas, {ssrNetMsgCfg.Global_SyncAdmini, getgmlevel(actor)})

    Message.sendmsg(actor, ssrNetMsgCfg.sync, nil, nil, nil, logindatas)
end

--判断成功率:如果成功返回false
--suc_rate:成功率
--ratio:比率
--return:返回true没成功
function FProbabilityHit(suc_rate, ratio)
    ratio = ratio or 100
    local rate = math.random(1, ratio)
    return rate > suc_rate
end

--检查一个对象的范围
function UCheckRange(x, y, range, obj)
    local min_x, max_x = x-range, x+range
    local min_y, max_y = y-range, y+range
    local cur_x, cur_y = getbaseinfo(obj, ConstCfg.gbase.x), getbaseinfo(obj, ConstCfg.gbase.y)

    if (cur_x >= min_x) and (cur_x <= max_x) and
       (cur_y >= min_y) and (cur_y <= max_y) then
        return true
    end
    
    return false
end

--检查自己与npc的距离
function UCheckNPCRange(actor, moduleid, npcidx, range)
    range = range or 10
    local npcobj = getnpcbyindex(npcidx)
    local npc_mapid = getbaseinfo(npcobj, ConstCfg.gbase.mapid)
    local my_mapid = getbaseinfo(actor, ConstCfg.gbase.mapid)
    if npc_mapid ~= my_mapid then return false end

    local npc_x = getbaseinfo(npcobj, ConstCfg.gbase.x)
    local npc_y = getbaseinfo(npcobj, ConstCfg.gbase.y)
    return UCheckRange(npc_x, npc_y, range, actor)
end

--回城
local base_x,base_y = 333,333
function FBackZone(actor)
    mapmove(actor, "3", math.random(base_x - 9, base_x + 9), math.random(base_y - 9, base_y + 9))
end

--飞地图固定随机点
function FMapMove(actor, mapid, x, y, x_ran, y_ran)
    if type(mapid) ~= "string" then mapid = mapid.."" end
    if x and y then
        if x_ran then x = math.random(x-x_ran, x+x_ran) end
        if y_ran then y = math.random(y-y_ran, y+y_ran) end
        mapmove(actor, mapid, x, y)
    else
        map(actor, mapid)
    end
end

--发送公告
local type1str = '{"Msg":"%s","Type":1}'
local type4str = '{"Msg":"%s","Type":5}'
function FSendNotice(actor, noticeid, t, ...)
    local cfg = cfg_announce[noticeid]
    if not cfg then return end
    local str = cfg.Announce
    if t then
        if t.name and actor then
            local name = getbaseinfo(actor, ConstCfg.gbase.name)
            str = string.gsub(str, "%%name", name)
        end

        if t.createname and actor then
            local createname = getbaseinfo(actor, ConstCfg.gbase.name)
            str = string.gsub(str, "%%CreatName", createname)
        end

        if t.targetname then
            str = string.gsub(str, "%%Name", t.targetname)
        end

        if t.map and actor then
            local mapname = getbaseinfo(actor, ConstCfg.gbase.mapid)
            str = string.gsub(str, "%%Map", mapname)
        end

        if t.item then
            str = string.gsub(str, "%%Item", t.item)
        end

        if t.itemid then
            str = string.gsub(str, "%%ItemId", t.itemid)
        end

        if t.x and actor then
            local x = getbaseinfo(actor, ConstCfg.gbase.x)
            str = string.gsub(str, "%%X", x)
        end

        if t.y and actor then
            local y = getbaseinfo(actor, ConstCfg.gbase.y)
            str = string.gsub(str, "%%Y", y)
        end
        if t.day then
            str = string.gsub(str, "%%day", t.day)
        end
        if t.level then
            str = string.gsub(str, "%%level", t.level)
        end

        if t.vip then
            str = string.gsub(str, "%%vip", t.vip)
        end
        if t.hitername and actor then
            str = string.gsub(str, "%%hitername",t.hitername)
        end
    end
    local str = string.format(str, ...)
    --cfg.Region==1:全服 cfg.Region==2:当前地图
    for _,type in ipairs(cfg.Type) do
        local region
        if type == 1 then                           --聊天栏
            local str = string.format(type1str, str)
            if cfg.Region == 1 then
                region = 2
            elseif cfg.Region == 2 then
                region = 4
            end
            sendmsg(actor, region, str)
        elseif type == 2 then                       --聊天上方
            if cfg.Region == 1 then
                region = 0
            elseif cfg.Region == 2 then
                region = 3
            end
            sendtopchatboardmsg(actor, region, 0, 0, 2, str, 1)
        elseif type == 3 then                       --人物头顶
            if cfg.Region == 1 then
                region = 1
            elseif cfg.Region == 2 then
                region = 3
            end
            sendmsgnew(actor, 0, 0, str, region, 3)
        elseif type == 4 then                       --屏幕顶部
            local str = string.format(type4str, str)
            if cfg.Region == 1 then
                region = 2
            elseif cfg.Region == 2 then
                region = 4
            end
            sendmsg(actor, region, str)
        end
    end
end

--发送邮件
function FSendmail(sender, id, ...)
    --LOGWrite("发送邮件id", id)
    local cfg = cfg_mail[id]
    if not cfg then return end
    -- if not cfg.items then return end

    --邮件内容
    local content
    if cfg.content then
        if cfg.parameter then
            content = string.format(cfg.content, ...)
        else
            content = cfg.content
        end
    end
    --邮件物品
    local stritem
    if cfg.items then
        if type(cfg.items) == "table" then
            local items
            for _,item in ipairs(cfg.items) do
                if type(item) == "table" then
                    items = items or {}
                    if item[3] == 1 then item[3] = ConstCfg.binding end
                    table.insert(items, table.concat(item, "#"))
                else
                    stritem = table.concat(cfg.items, "&")
                    break
                end
            end

            if items then stritem = table.concat(items, "&") end
        else
            stritem = cfg.items.."#1"
        end
    end
    --发送
    sendmail(sender, 1, cfg.title, content, stritem)
end

_Includes()