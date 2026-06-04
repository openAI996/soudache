local ui = {}
local _V = function(...) return SL:GetMetaValue(...) end
local FUNCQUEUE = {}
local TAGOBJ = {}

function ui.init(parent, __data__, __update__)
	if __update__ then return ui.update(__data__) end
	-- Create bgk
	local bgk = GUI:Image_Create(parent, "bgk", -1, 1, "res/public/1900012700.png")
	GUI:setAnchorPoint(bgk, 0.00, 0.00)
	GUI:setTouchEnabled(bgk, true)
	GUI:setTag(bgk, 0)

	-- Create LoadingBar_1
	local LoadingBar_1 = GUI:ProgressTimer_Create(bgk, "LoadingBar_1", 44, 42, "res/public/1900012703.png")
	GUI:ProgressTimer_setReverseDirection(LoadingBar_1, true)
	GUI:ProgressTimer_setPercentage(LoadingBar_1, 100)
	GUI:setAnchorPoint(LoadingBar_1, 0.50, 0.50)
	GUI:setTag(LoadingBar_1, 0)

	-- Create Panel_1
	local Panel_1 = GUI:Layout_Create(bgk, "Panel_1", 45, 45, 90, 90, false)
	GUI:setAnchorPoint(Panel_1, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_1, true)
	GUI:setTag(Panel_1, 0)

	ui.update(__data__)
	return bgk
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
