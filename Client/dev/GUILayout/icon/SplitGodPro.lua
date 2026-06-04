local SplitGodPro = {}

--[[
# 仅供参考的服务端脚本,放置于QFunction-0.lua
--延时扣血
function humanhpex(actor,monobj)
    humanhp(monobj, "-", 1, 0, 0, actor, 1)
end

--玩家物理攻击后
--Target	    受击对象
--Hiter			攻击对象
--MagicId		技能ID
function attack(actor, Target, Hiter, MagicId)
    if ismon(Target) then
        local cfg_posM = {}
        cfg_posM[1] = getbaseinfo(Target,2)
        local mapID = getbaseinfo(actor,3)
        local x = getbaseinfo(actor,4)
        local y = getbaseinfo(actor,5)
        local mons = getobjectinmap(mapID,x,y,10,2)
        if #mons < 1 then return end
        for i, mon in ipairs(mons or {}) do
            if Target ~= mon then
                cfg_posM[#cfg_posM + 1] = getbaseinfo(mon,2)
                delaygoto(actor,300 * i,"humanhpex,"..mon,0)
            end
        end
        sendluamsg(actor, 999, 0, 0, 23, tbl2json(cfg_posM))
    end
end
]]

-- ======================================================================================================

-- 定义节点池和特效池，以及池的初始大小
local nodePool = {}
local effectPool = {}
local _poolSize = 50

-- 特效ID
local sfxID = 4

-- 初始化资源池函数，接受资源池、创建函数及额外参数
function initializePool(pool, widgetType, ...)
    for i=1,_poolSize do
		local newItem
		if widgetType == 1 then
			newItem = GUI:Node_Create(...)
		elseif widgetType == 2 then
			newItem = GUI:Effect_Create(...)
		end

        if newItem then                 -- 确保对象创建成功
            GUI:addRef(newItem)         -- 添加引用计数
            table.insert(pool, newItem) -- 将新对象插入资源池
        end
    end
end

-- 通用对象获取函数
local function getObjectFromPool(pool, createFunc, ...)
    if #pool > 0 then
        local obj = table.remove(pool) -- 从池中取出对象
        GUI:autoDecRef(obj)           -- 自动管理引用计数
        return obj                   -- 返回对象
    else
        return createFunc(...)       -- 如果池为空，则创建新对象
    end
end

-- 对象回收到池中的通用函数
local function returnObjectToPool(pool, obj)
    GUI:addRef(obj)                  -- 增加对象的引用计数
    GUI:removeFromParent(obj)        -- 从其父节点中移除对象
    table.insert(pool, obj)          -- 将对象放回资源池
end

-- 特定于节点的获取和回收函数
local function getNodeFromPool() return getObjectFromPool(nodePool, 1, -1, "NodePool", 0, 0) end
local function removeAndAddNodePool(node) returnObjectToPool(nodePool, node) end

-- 特定于特效的获取和回收函数
local function getEffectFromPool() return getObjectFromPool(effectPool, 2, -1, "EffectPool", -10, 40, 0, sfxID) end
local function returnEffectToPool(effect) returnObjectToPool(effectPool, effect) end

-- 初始化节点池和特效池
initializePool(nodePool, 1, -1, "NodePool%d", 0, 0)
initializePool(effectPool, 2, -1, "EffectPool%d", -10, 40, 0, sfxID)

-- ======================================================================================================

---- 注册网络消息处理器，用于处理场景播放特效的消息
--SL:RegisterLuaNetMsg(999, function (msgID, p1, p2, p3, data)
--    SplitGodPro:ScenePlayEffectEx(data) -- 接收到消息后调用ScenePlayEffectEx函数
--end)

function SplitGodPro.receiveMessage(data)
	SplitGodPro:ScenePlayEffectEx(data)
end
-- 场景播放特效扩展方法
function SplitGodPro:ScenePlayEffectEx(data)
    ---data = SL:JsonDecode(data) -- 解码接收到的数据
    for i, v in ipairs(data or {}) do
        if v and data[i + 1] then -- 确保当前项和下一个项存在
            SL:ScheduleOnce(function () -- 在延迟后执行动画播放
                self:Animation(v, data[i + 1]) -- 执行自定义的Animation方法
            end,
            0.2 * (i - 1)) -- 延迟时间逐渐增加，每项之间间隔0.2秒
        end
    end

end


function SplitGodPro:Animation(mon1 ,mon2)
	local mon1_cfg = {
		--世界坐标
		posM_x = SL:GetMetaValue("ACTOR_POSITION_X", mon1),
		posM_y = SL:GetMetaValue("ACTOR_POSITION_Y", mon1),
		--地图坐标
		mapM_x = SL:GetMetaValue("ACTOR_MAP_X", mon1),
		mapM_y = SL:GetMetaValue("ACTOR_MAP_Y", mon1),
	}

	local mon2_cfg = {
		--世界坐标
		posM_x = SL:GetMetaValue("ACTOR_POSITION_X", mon2),
		posM_y = SL:GetMetaValue("ACTOR_POSITION_Y", mon2),
		--地图坐标
		mapM_x = SL:GetMetaValue("ACTOR_MAP_X", mon2),
		mapM_y = SL:GetMetaValue("ACTOR_MAP_Y", mon2),
	}

	local x,y = SL:ConvertMapPos2WorldPos(mon2_cfg.mapM_x - mon1_cfg.mapM_x, mon2_cfg.mapM_y - mon1_cfg.mapM_y, true)

	local pos = SL:GetSubPoint(
			GUI:p(mon2_cfg.mapM_x,mon2_cfg.mapM_y),
			GUI:p(mon1_cfg.mapM_x,mon1_cfg.mapM_y)
	)
	local dir = SL:GetPointRotateSelf(pos) + 90
	local parent = GUI:Attach_SceneF()

	SL:Print("=====================")
	SL:Print("世界坐标,怪物2",mon2_cfg.mapM_x,mon2_cfg.mapM_y,"怪物1",mon1_cfg.mapM_x,mon1_cfg.mapM_y)
	SL:Print("地图坐标,怪物2",mon2_cfg.posM_x,mon2_cfg.posM_y,"怪物1",mon1_cfg.posM_x,mon1_cfg.posM_y)
	SL:Print("旋转角度1",dir)
	SL:Print("=====================")

	self.name = self.name and self.name + 1 or 0
	local sfx = GUI:Effect_Create(parent, "effect_1_"..self.name, mon1_cfg.posM_x, mon1_cfg.posM_y, 0, 22, 0, 0, 0, 1)
	GUI:Effect_play(sfx,0, 0, true)
	GUI:setRotation(sfx, dir)

	GUI:runAction(sfx,
			GUI:ActionSequence(
					GUI:ActionMoveBy(0.3, x, y),
					GUI:CallFunc(function ()
						self.name2 = self.name2 and self.name2 + 1 or 0
						local handle = GUI:Effect_Create(parent, "effect_2_"..self.name2, mon2_cfg.posM_x, mon2_cfg.posM_y, 0, 23, 0, 0, 0, 1)
						GUI:Effect_addOnCompleteEvent(handle, function(widget)
							GUI:removeFromParent(widget)
						end)
					end),
					GUI:ActionRemoveSelf()
			)
	)
end

Message.RegisterClickMsg("裂神符", SplitGodPro)
---return SplitGodPro