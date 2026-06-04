local cjson = require("cjson")
screen_W = SL:GetMetaValue("SCREEN_WIDTH")
screen_H = SL:GetMetaValue("SCREEN_HEIGHT")
cfg_Level = SL:Require("GUILayout/cfgcsv/cfg_Level",true)
cfg_Map = SL:Require("GUILayout/cfgcsv/cfg_DiTu",true)
cfg_Job_Equip_Attr = SL:Require("GUILayout/cfgcsv/cfg_Job_Equip_Attr",true)

---加载其他配置表格
function SL:RequireOtherCfg(path)
    return SL:Require("功能杂项配置/" .. path)
end
---加载官方表格
function SL:RequireGameCfg(path)
    return SL:Require("game_config/" .. path)
end

function SL:SubmitForm(msgName,...)
    local content = {}

    if msgName == nil then
        return false
    end

    content.script = msgName
    content.paramList = {}
    local arg = {...}
    for i=1, #arg do
        content.paramList[i] = arg[i]
    end

    SL:SendLuaNetMsg(666, 0, 0, 0, SL:JsonEncode(content,false))
end



--function SL:HPUnit(hp, pointBit)
--    pointBit = pointBit or 2  -- 默认保留两位小数
--    local unit = ""
--    local displayHp = hp
--
--    if hp >= 1e8 then
--        unit = "亿"  -- 过亿单位
--        displayHp = hp / 1e8
--    elseif hp >= 1e4 then
--        unit = "万"  -- 万单位
--        displayHp = hp / 1e4
--    end
--
--    --displayHp = string.format("%." .. pointBit .. "f", displayHp)  -- 格式化显示小数点后指定位数的小数
--
--    --if hp > 0 then
--    --    unit = unit .. "兆亿"
--    --end
--    return displayHp .. unit
--end

---加载信息（The Code Style is ZYY.）
function ERROR_PROMPT(errInfo)
    if errInfo then
        SL:release_print("---------------------error--------------------")
        SL:release_print("----------------------error--------------------")
        SL:release_print("-----------------------error--------------------")
        SL:release_print("------------------------error--------------------")
        SL:release_print(errInfo)
        SL:release_print("------------------------error--------------------")
        SL:release_print("-----------------------error--------------------")
        SL:release_print("----------------------error--------------------")
        SL:release_print("---------------------error--------------------")
    end
end

local function init()
    SL:release_print("GUIUtil init")
    SL:Require("GUILayout/Message",true)
    SL:Require("GUILayout/NpcClientConvert",true)
    SL:Require("GUILayout/common/CLFunc",true)
    SL:Require("GUILayout/common/Awards",true)
    SL:Require("GUILayout/common/TopIcon",true)
    SL:Require("GUILayout/common/RedPoint",true)
    SL:Require("GUILayout/common/BubbleTips",true)
    ---SL:Require("GUILayout/common/GMBox",true)

    --SL:Require("GUILayout/cfgcsv/init",true)
    SL:Require("GUILayout/icon/init",true)
    --SL:Require("GUILayout/npc/init",true)
    --SL:Require("GUILayout/juqing/init",true)
    --SL:Require("GUILayout/kuafu/init",true)

    --FeiJianSKill.initMainActor()
    SL:release_print("加载结束")
    ----SL:SetMetaValue("DROPITEM_FLY_WORLD_POSITION", 200, 200)
    SL:ScheduleOnce(function()
        BubbleTips.init()
    end, 0.5)
    --SL:Require("GUILayout/shijian/init",true)
end

local result, errorInfo = pcall(init)
if not result then
    ERROR_PROMPT(errorInfo)
end

--------------------------↓↓↓Ctrl+U重载前端脚本↓↓↓--------------------------
local listener = cc.EventListenerKeyboard:create()
local eventDispatcher = cc.Director:getInstance():getEventDispatcher()
local keycodeFunc = {
    {
        -- reload lua files
        keycode = { cc.KeyCode.KEY_CTRL, cc.KeyCode.KEY_TAB},
        func = function()
            local ID = SL:GetMetaValue("SERVER_NAME")
            ---if ID == "工具测试服3区" then
                eventDispatcher:removeEventListener(listener)

                local _Parent = GUI:Attach_Parent()
                SL:release_print(type(_Parent), "重新启动winUI")

                --清理lua加载缓存
                for k, _ in pairs(package.loaded) do
                    if string.find(k, "GUILayout") or string.find(k, "GUIExport") then
                        package.loaded[k] = nil
                        _G[k] = nil
                    end
                end
                --重新启动
                require("GUILayout/GUIUtil")
                SL:SubmitForm("时间礼包_SetIcon")
            ---end
        end
    },
    {
        keycode = { cc.KeyCode.KEY_CTRL, cc.KeyCode.KEY_Z},
        func = function()
            global.Facade:sendNotification(global.NoticeTable.AFKEnd)
        end
    },
}

local inputKeyCode = {}
local function compareKeyCode(k1, k2)
    return (table.concat(k1, "+") == table.concat(k2, "+"))
end

local function calcEvent()
    for _, v in ipairs(keycodeFunc) do
        if compareKeyCode(inputKeyCode, v.keycode) then
            v.func()
            break
        end
    end
end

local function pressed_callback(keycode, evt)
    table.insert(inputKeyCode, keycode)
    calcEvent()
end

local function released_callback(keycode, evt)
    for k, v in pairs(inputKeyCode) do
        if v == keycode then
            table.remove(inputKeyCode, k)
        end
    end
end

listener:registerScriptHandler(pressed_callback, cc.Handler.EVENT_KEYBOARD_PRESSED)
listener:registerScriptHandler(released_callback, cc.Handler.EVENT_KEYBOARD_RELEASED)
eventDispatcher:addEventListenerWithFixedPriority(listener, 1)
--------------------------↑↑↑Ctrl+U重载前端脚本↑↑↑--------------------------
--buff刷新时间
SL:RegisterLUAEvent(LUA_EVENT_MAINBUFFUPDATE, "buff更新", function(table)
    -- if table.buffID == 10018 or table.buffID == 10019 or table.buffID == 10020 or table.buffID == 10002 then
    --     buffupdate()
    -- end
end)

SL:RegisterLUAEvent(LUA_EVENT_TAKE_ON_EQUIP, "穿装备更新", function(table)
    if table.isSuccess then
        if table.pos == 1 or table.pos == 0 then
            dressUpdate()
        end
        --ClientCache.Artifact()
    end
end)

SL:RegisterLUAEvent(LUA_EVENT_TAKE_OFF_EQUIP, "脱装备更新", function(table)
    if table.isSuccess then
        if table.pos == 1 or table.pos == 0 then
            dressUpdate()
        end
    end
end)


function dressUpdate()
    --Bag.Artifact()
end
--运动时候的特效
SL:RegisterLUAEvent('LUA_EVENT_PLAYER_ACTION_BEGIN', "run", function(data)

end)

--地图改变
SL:RegisterLUAEvent('LUA_EVENT_MAPINFOCHANGE', "切换地图", function(data)
    local mapName = SL:GetMetaValue("MAP_NAME")
    local _Handle = GUI:Attach_UITop()
    if _Handle then
        local nameList = CL:splitString(mapName)
        for i=1, #nameList do
            if GUI:GetWindow(_Handle,"mapName"..i) then
                GUI:removeFromParent(GUI:GetWindow(_Handle,"mapName"..i))
            end

            local Text_1 = GUI:Text_Create(_Handle, "mapName"..i, 0, screen_H-50, 60, "#000000", nameList[i])
            GUI:Text_setFontName(Text_1, "fonts/font140.ttf")
            GUI:setAnchorPoint(Text_1, 0.5, 0.5)
            GUI:setTouchEnabled(Text_1, false)
            GUI:setTag(Text_1, 0)
            GUI:Text_enableOutline(Text_1, "#ffffff", 1)
            GUI:runAction(Text_1,
                    GUI:ActionSequence(
                            GUI:ActionFadeOut(0),
                            GUI:DelayTime(i*0.1),
                            GUI:ActionEaseExponentialOut(
                                    GUI:ActionSpawn(
                                            GUI:ActionMoveBy(0.3,screen_W/2+(i*60)-(60*#nameList)/2, 0),
                                            GUI:ActionFadeIn(0.3)
                                    )

                            ),
                            GUI:DelayTime(0.5+(#nameList-i)*0.1),
                            GUI:ActionFadeOut(0.5),
                            GUI:CallFunc(function(_Handle)
                                GUI:removeChildByName(_Handle, "mapName"..i)
                            end)
                    )
            )
        end
    end

    if fuWuQiChuShiHua then
        BubbleTips.init()
        TopIcon.topInit()
        ----zhuangBeiTuJian.iconRedPoint()
    end

    local _GUIHandle = MainAssist._ui.Image_24
    if _GUIHandle then
        _Handle = GUI:GetWindow(_GUIHandle, "怪物掉落")
        if _Handle then
            GUI:removeFromParent(_Handle)
        end
    end
    TopIcon.topInit()
    GUI:Win_CloseAll()
end)

SL:RegisterLUAEvent(LUA_EVENT_ACTOR_OUT_OF_VIEW, "目标归属改变", function(data)
    ---SL:PrintTable(data)
    ----SL:Print(monsterID , data.id,"改变--",tostring(monsterID == data.id))
    if monsterID == data.id then
        local _GUIHandle = MainAssist._ui.Image_24 -----GUI:Attach_LeftTop()
        if _GUIHandle then
            local _Handle = GUI:GetWindow(_GUIHandle, "怪物掉落")
            if _Handle then
                GUI:removeFromParent(_Handle)
            end
        end
    end
end )

SL:RegisterLUAEvent(LUA_EVENT_TARGET_CAHNGE, "目标改变", function(actorID)
    ----SL:PrintTable(actorID)
    -- if table.buffID == 10018 or table.buffID == 10019 or table.buffID == 10020 or table.buffID == 10002 then
    --     buffupdate()
    -- en
    --local _GUIHandle = MainAssist._ui.Image_24 -----GUI:Attach_LeftTop()
    --if _GUIHandle then
    --    local _Handle = GUI:GetWindow(_GUIHandle, "怪物掉落")
    --    if _Handle then
    --        GUI:removeFromParent(_Handle)
    --    end
    --end
    --
    --
    --if SL:GetMetaValue("ACTOR_IS_MONSTER", actorID) then
    --    local name = SL:GetMetaValue("ACTOR_NAME", actorID)
    --    if cfg_DiaoLuo[name] ~= nil then
    --        monsterID = actorID
    --        _GUIHandle = MainAssist._ui.Image_24
    --        if _GUIHandle then
    --            local _ImgHandle = GUI:Image_Create(_GUIHandle, "怪物掉落",20, 0, "xx.png")
    --            if _ImgHandle then
    --                GUI:LoadExport(_ImgHandle,"icon/DiaoLuoUI.lua")
    --                local _Handle = GUI:GetWindow(_ImgHandle, "bgk/name")
    --                if _Handle then
    --                    GUI:Text_setString(_Handle, name)
    --                end
    --
    --                local _Parent = GUI:GetWindow(_ImgHandle, "bgk/item")
    --                if _Parent then
    --                    local item_tb = cfg_DiaoLuo[name].item
    --
    --                    for j=1,#item_tb do
    --                        local item_data = {}
    --                        item_data.index = SL:GetMetaValue("ITEM_INDEX_BY_NAME", item_tb[j])
    --                        item_data.look  = true
    --                        item_data.bgVisible = false
    --                        item_data.count = 1
    --                        item_data.color = 250
    --                        item_data.noMouseTips = false
    --                        ---item_data.itemScale = 0.5
    --                        _Handle = GUI:Image_Create(_Parent, "scroll_down_item_bgk_"..j,0,10 , "res/public/item.png")
    --                        if _Handle ~= nil then
    --                            ---GUI:setScale(_Handle, 0.8)
    --                        end
    --
    --                        local pos = GUI:getContentSize(_Handle)
    --                        local _itemHandle = CL:ItemShow_Create(_Handle, "item", pos.width/2, pos.height/2,0,0, item_data)
    --                        if _itemHandle  then
    --                            GUI:setTouchEnabled(_itemHandle,true)
    --                        end
    --                    end
    --                end
    --            end
    --        end
    --    end
    --end
end)


-----------修改怪物血量位置
local Cfg_monster = {
    --[1195] = {
    --    boIsBoss = 1
    --}
}

CUS_HUD_OFFSET_1 = cc.p(-71, 53)
CUS_OFFSET_BG_1 = cc.p(-63, 60)
CUS_BOSS_HP_BG_SPRITE_ID = 20000
CUS_BOSS_HP_SPRITE_ID = 20001
function global.actorRefreshController:OnCreateHUDBar(data)
    local actorID = data.actorID
    local actor = global.actorManager:GetActor(actorID)
    if not actorID or not actor then
        return false
    end
    --SL:Print("xxxs=---ssx-")
    --SL:PrintTable(actor:GetTypeIndex())
    -- HUD for actor
    local hpSpriteID = global.MMO.HP_SPRITE_ID
    if actor:IsPlayer() and actor:IsMainPlayer() and SL:GetMetaValue("GAME_DATA", "hight_main_player_hp") == 1 then
        hpSpriteID = global.MMO.HP_MAIN_SPRITE_ID
    end

    local bg_offset = global.MMO.HUD_OFFSET_BG_1
    local hud_offset = global.MMO.HUD_OFFSET_1
    local hp_bg_sprite_id = global.MMO.HP_BG_SPRITE_ID
    if actor:IsMonster() then --and actor:IsBoss()
        local cfg = Cfg_monster[actor:GetTypeIndex()]
        if cfg and cfg.boIsBoss == 1 then
            bg_offset = CUS_HUD_OFFSET_1
            hud_offset = CUS_OFFSET_BG_1
            hp_bg_sprite_id = CUS_BOSS_HP_BG_SPRITE_ID
            hpSpriteID = CUS_BOSS_HP_SPRITE_ID
        end
    end

    local hpBorder                          = global.HUDManager:CreateHUDBar(actorID, global.MMO.HUD_SPRITE_HP_BG,
            bg_offset, hp_bg_sprite_id)
    local hpBar                             = global.HUDManager:CreateHUDBar(actorID, global.MMO.HUD_SPRITE_HP,
            hud_offset, hpSpriteID)
    actor.mHUDUI[global.MMO.HUDHPUI_BAR]    = hpBar
    actor.mHUDUI[global.MMO.HUDHPUI_BORDER] = hpBorder
    local HP                                = actor:GetHP()
    local maxHP                             = actor:GetMaxHP()

    local percent                           = HP / maxHP

    if global.ConstantConfig.showFewHp == 1 and not actor:GetValueByKey(global.MMO.HUD_BAR_SHOW_FULL_HP) then
        local HeroPropertyProxy = global.Facade:retrieveProxy(global.ProxyTable.HeroPropertyProxy)
        local heroActor         = HeroPropertyProxy:GetHeroActor()
        local mainPlayer        = global.gamePlayerController:GetMainPlayer()
        if actor ~= heroActor and actor ~= mainPlayer then
            percent = 1
        end
    end

    global.HUDManager:SetHUDBarPercent(hpBar, percent)

    -- HUD MP for actor
    local mpBorder                          = global.HUDManager:CreateHUDBar(actorID, global.MMO.HUD_SPRITE_MP_BG,
            global.MMO.HUD_OFFSET_BG_2, global.MMO.HP_BG_SPRITE_ID)
    local mpBar                             = global.HUDManager:CreateHUDBar(actorID, global.MMO.HUD_SPRITE_MP,
            global.MMO.HUD_OFFSET_2, global.MMO.MP_SPRITE_ID)
    actor.mHUDUI[global.MMO.HUDMPUI_BAR]    = mpBar
    actor.mHUDUI[global.MMO.HUDMPUI_BORDER] = mpBorder
    local MP                                = actor:GetMP()
    local maxMP                             = actor:GetMaxMP()
    local percent                           = MP / maxMP
    global.HUDManager:SetHUDBarPercent(mpBar, percent)

    -- HUD NG for actor
    local ngBorder                          = global.HUDManager:CreateHUDBar(actorID, global.MMO.HUD_SPRITE_NG_BG,
            global.MMO.HUD_OFFSET_BG_3, global.MMO.HP_BG_SPRITE_ID)
    local ngBar                             = global.HUDManager:CreateHUDBar(actorID, global.MMO.HUD_SPRITE_NG,
            global.MMO.HUD_OFFSET_3, global.MMO.NG_SPRITE_ID)
    actor.mHUDUI[global.MMO.HUDNGUI_BAR]    = ngBar
    actor.mHUDUI[global.MMO.HUDNGUI_BORDER] = ngBorder
    if actor.GetForce and actor.GetMaxForce then
        local force    = actor:GetForce()
        local maxForce = actor:GetMaxForce()
        local percent  = maxForce == 0 and 0 or (force / maxForce)
        global.HUDManager:SetHUDBarPercent(ngBar, percent)
    end

    -- 刷新坐标
    local position = actor:getPosition()
    actor:setPosition(position.x, position.y)

    global.Facade:sendNotification(global.NoticeTable.RefreshActorSceneOptions, actor)
end