local ui = {}
local _V = function(...) return SL:GetMetaValue(...) end
local FUNCQUEUE = {}
local TAGOBJ = {}

function ui.init(parent, __data__, __update__)
	if __update__ then return ui.update(__data__) end
	-- Create bgk
	local bgk = GUI:Image_Create(parent, "bgk", 435, 262, "res/public/cangpin/bgk.png")
	GUI:setAnchorPoint(bgk, 0.50, 0.50)
	GUI:setTouchEnabled(bgk, true)
	GUI:setTag(bgk, 0)

	-- Create top
	local top = GUI:ListView_Create(bgk, "top", 436, 446, 760, 40, 2)
	GUI:ListView_setGravity(top, 5)
	GUI:ListView_setItemsMargin(top, 6)
	GUI:setAnchorPoint(top, 0.50, 0.50)

	GUI:setTouchEnabled(top, true)
	GUI:setTag(top, 0)

	-- Create close
	local close = GUI:Button_Create(bgk, "close", 842, 488, "res/public/cangpin/close.png")
	GUI:Button_setTitleText(close, [[]])
	GUI:Button_setTitleColor(close, "#ffffff")
	GUI:Button_setTitleFontSize(close, 16)
	GUI:Button_titleEnableOutline(close, "#000000", 1)
	GUI:setAnchorPoint(close, 0.50, 0.50)
	GUI:setTouchEnabled(close, true)
	GUI:setTag(close, 0)

	-- Create qualityList
	local qualityList = GUI:ListView_Create(bgk, "qualityList", 433, 220, 792, 404, 1)
	GUI:ListView_setItemsMargin(qualityList, 5)
	GUI:setAnchorPoint(qualityList, 0.50, 0.50)

	GUI:setTouchEnabled(qualityList, true)
	GUI:setTag(qualityList, 0)

	ui.update(__data__)
	return bgk
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
