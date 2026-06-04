local ui = {}
local _V = function(...) return SL:GetMetaValue(...) end
local FUNCQUEUE = {}
local TAGOBJ = {}

function ui.init(parent, __data__, __update__)
	if __update__ then return ui.update(__data__) end
	-- Create bag
	local bag = GUI:Layout_Create(parent, "bag", 577, 319, 439, 416, false)
	GUI:setAnchorPoint(bag, 0.50, 0.50)
	GUI:setTouchEnabled(bag, true)
	GUI:setTag(bag, 0)

	-- Create bgk
	local bgk = GUI:Image_Create(bag, "bgk", -1, 1, "res/public/bg_bbgm_01.png")
	GUI:setAnchorPoint(bgk, 0.00, 0.00)
	GUI:setTouchEnabled(bgk, true)
	GUI:setTag(bgk, 0)

	-- Create close
	local close = GUI:Button_Create(bag, "close", 450, 395, "res/public/1900000510.png")
	GUI:setContentSize(close, 26, 42)
	GUI:setIgnoreContentAdaptWithSize(close, false)
	GUI:Button_setTitleText(close, [[]])
	GUI:Button_setTitleColor(close, "#FFFFFF")
	GUI:Button_setTitleFontSize(close, 18)
	GUI:Button_titleEnableOutline(close, "#000000", 1)
	GUI:setAnchorPoint(close, 0.50, 0.50)
	GUI:setTouchEnabled(close, true)
	GUI:setTag(close, 0)

	-- Create Layout
	local Layout = GUI:ListView_Create(bag, "Layout", 219, 248, 400, 300, 1)
	GUI:setAnchorPoint(Layout, 0.50, 0.50)
	GUI:setTouchEnabled(Layout, true)
	GUI:setTag(Layout, 0)

	-- Create button
	local button = GUI:Button_Create(bag, "button", 208, 56, "res/gmbox/1900000679.png")
	GUI:setContentSize(button, 76, 34)
	GUI:setIgnoreContentAdaptWithSize(button, false)
	GUI:Button_setTitleText(button, [[选择]])
	GUI:Button_setTitleColor(button, "#FFFFFF")
	GUI:Button_setTitleFontSize(button, 18)
	GUI:Button_titleEnableOutline(button, "#000000", 1)
	GUI:setAnchorPoint(button, 0.50, 0.50)
	GUI:setTouchEnabled(button, true)
	GUI:setTag(button, 0)

	-- Create Text_1
	local Text_1 = GUI:Text_Create(bag, "Text_1", 331, 58, 18, "#ff0000", [[（双击选择道具）]])
	GUI:Text_setFontName(Text_1, "fonts/font140.ttf")
	GUI:Text_enableOutline(Text_1, "#000000", 1)
	GUI:setAnchorPoint(Text_1, 0.50, 0.50)
	GUI:setTouchEnabled(Text_1, false)
	GUI:setTag(Text_1, 0)

	ui.update(__data__)
	return bag
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
