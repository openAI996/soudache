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
	GUI:ListView_setItemsMargin(Layout, 2)
	GUI:setAnchorPoint(Layout, 0.50, 0.50)
	GUI:setTouchEnabled(Layout, true)
	GUI:setTag(Layout, 0)

	-- Create Image_1
	local Image_1 = GUI:Image_Create(Layout, "Image_1", 0, 228, "res/public/icon_paihangbang_05.png")
	GUI:setContentSize(Image_1, 400, 72)
	GUI:setIgnoreContentAdaptWithSize(Image_1, false)
	GUI:setAnchorPoint(Image_1, 0.00, 0.00)
	GUI:setTouchEnabled(Image_1, false)
	GUI:setTag(Image_1, 0)

	-- Create Panel_1
	local Panel_1 = GUI:Layout_Create(bag, "Panel_1", -35, -1, 35, 419, false)
	GUI:setAnchorPoint(Panel_1, 0.00, 0.00)
	GUI:setTouchEnabled(Panel_1, false)
	GUI:setTag(Panel_1, 0)

	-- Create Button_1
	local Button_1 = GUI:Button_Create(Panel_1, "Button_1", 1, 328, "res/public/1900000641_1.png")
	GUI:Button_setTitleText(Button_1, [[]])
	GUI:Button_setTitleColor(Button_1, "#FFFFFF")
	GUI:Button_setTitleFontSize(Button_1, 18)
	GUI:Button_titleEnableOutline(Button_1, "#000000", 1)
	GUI:setAnchorPoint(Button_1, 0.00, 0.00)
	GUI:setTouchEnabled(Button_1, true)
	GUI:setTag(Button_1, 0)

	-- Create Text_1
	local Text_1 = GUI:Text_Create(Button_1, "Text_1", 11, 35, 18, "#ffffff", [[武
器]])
	GUI:Text_enableOutline(Text_1, "#000000", 1)
	GUI:setAnchorPoint(Text_1, 0.00, 0.00)
	GUI:setTouchEnabled(Text_1, false)
	GUI:setTag(Text_1, 0)

	-- Create Button_2
	local Button_2 = GUI:Button_Create(Panel_1, "Button_2", 0, 271, "res/public/1900000641_1.png")
	GUI:Button_setTitleText(Button_2, [[]])
	GUI:Button_setTitleColor(Button_2, "#FFFFFF")
	GUI:Button_setTitleFontSize(Button_2, 18)
	GUI:Button_titleEnableOutline(Button_2, "#000000", 1)
	GUI:setAnchorPoint(Button_2, 0.00, 0.00)
	GUI:setTouchEnabled(Button_2, true)
	GUI:setTag(Button_2, 0)

	-- Create Text_1
	Text_1 = GUI:Text_Create(Button_2, "Text_1", 11, 35, 18, "#ffffff", [[衣
服]])
	GUI:Text_enableOutline(Text_1, "#000000", 1)
	GUI:setAnchorPoint(Text_1, 0.00, 0.00)
	GUI:setTouchEnabled(Text_1, false)
	GUI:setTag(Text_1, 0)

	-- Create Button_3
	local Button_3 = GUI:Button_Create(Panel_1, "Button_3", 0, 211, "res/public/1900000641_1.png")
	GUI:Button_setTitleText(Button_3, [[]])
	GUI:Button_setTitleColor(Button_3, "#FFFFFF")
	GUI:Button_setTitleFontSize(Button_3, 18)
	GUI:Button_titleEnableOutline(Button_3, "#000000", 1)
	GUI:setAnchorPoint(Button_3, 0.00, 0.00)
	GUI:setTouchEnabled(Button_3, true)
	GUI:setTag(Button_3, 0)

	-- Create Text_1
	Text_1 = GUI:Text_Create(Button_3, "Text_1", 11, 35, 18, "#ffffff", [[头
盔]])
	GUI:Text_enableOutline(Text_1, "#000000", 1)
	GUI:setAnchorPoint(Text_1, 0.00, 0.00)
	GUI:setTouchEnabled(Text_1, false)
	GUI:setTag(Text_1, 0)

	-- Create Button_4
	local Button_4 = GUI:Button_Create(Panel_1, "Button_4", 0, 152, "res/public/1900000641_1.png")
	GUI:Button_setTitleText(Button_4, [[]])
	GUI:Button_setTitleColor(Button_4, "#FFFFFF")
	GUI:Button_setTitleFontSize(Button_4, 18)
	GUI:Button_titleEnableOutline(Button_4, "#000000", 1)
	GUI:setAnchorPoint(Button_4, 0.00, 0.00)
	GUI:setTouchEnabled(Button_4, true)
	GUI:setTag(Button_4, 0)

	-- Create Text_1
	Text_1 = GUI:Text_Create(Button_4, "Text_1", 11, 35, 18, "#ffffff", [[项
链]])
	GUI:Text_enableOutline(Text_1, "#000000", 1)
	GUI:setAnchorPoint(Text_1, 0.00, 0.00)
	GUI:setTouchEnabled(Text_1, false)
	GUI:setTag(Text_1, 0)

	-- Create Button_5
	local Button_5 = GUI:Button_Create(Panel_1, "Button_5", 0, 94, "res/public/1900000641_1.png")
	GUI:Button_setTitleText(Button_5, [[]])
	GUI:Button_setTitleColor(Button_5, "#FFFFFF")
	GUI:Button_setTitleFontSize(Button_5, 18)
	GUI:Button_titleEnableOutline(Button_5, "#000000", 1)
	GUI:setAnchorPoint(Button_5, 0.00, 0.00)
	GUI:setTouchEnabled(Button_5, true)
	GUI:setTag(Button_5, 0)

	-- Create Text_1
	Text_1 = GUI:Text_Create(Button_5, "Text_1", 11, 35, 18, "#ffffff", [[手
镯]])
	GUI:Text_enableOutline(Text_1, "#000000", 1)
	GUI:setAnchorPoint(Text_1, 0.00, 0.00)
	GUI:setTouchEnabled(Text_1, false)
	GUI:setTag(Text_1, 0)

	-- Create Button_6
	local Button_6 = GUI:Button_Create(Panel_1, "Button_6", 0, 36, "res/public/1900000641_1.png")
	GUI:Button_setTitleText(Button_6, [[]])
	GUI:Button_setTitleColor(Button_6, "#FFFFFF")
	GUI:Button_setTitleFontSize(Button_6, 18)
	GUI:Button_titleEnableOutline(Button_6, "#000000", 1)
	GUI:setAnchorPoint(Button_6, 0.00, 0.00)
	GUI:setTouchEnabled(Button_6, true)
	GUI:setTag(Button_6, 0)

	-- Create Text_1
	Text_1 = GUI:Text_Create(Button_6, "Text_1", 11, 35, 18, "#ffffff", [[戒
指]])
	GUI:Text_enableOutline(Text_1, "#000000", 1)
	GUI:setAnchorPoint(Text_1, 0.00, 0.00)
	GUI:setTouchEnabled(Text_1, false)
	GUI:setTag(Text_1, 0)

	-- Create Button_7
	local Button_7 = GUI:Button_Create(Panel_1, "Button_7", 0, -19, "res/public/1900000641_1.png")
	GUI:Button_setTitleText(Button_7, [[]])
	GUI:Button_setTitleColor(Button_7, "#FFFFFF")
	GUI:Button_setTitleFontSize(Button_7, 18)
	GUI:Button_titleEnableOutline(Button_7, "#000000", 1)
	GUI:setAnchorPoint(Button_7, 0.00, 0.00)
	GUI:setTouchEnabled(Button_7, true)
	GUI:setTag(Button_7, 0)

	-- Create Text_1
	Text_1 = GUI:Text_Create(Button_7, "Text_1", 11, 35, 18, "#ffffff", [[药
品]])
	GUI:Text_enableOutline(Text_1, "#000000", 1)
	GUI:setAnchorPoint(Text_1, 0.00, 0.00)
	GUI:setTouchEnabled(Text_1, false)
	GUI:setTag(Text_1, 0)

	-- Create page
	local page = GUI:Text_Create(bag, "page", 219, 56, 18, "#00ff00", [[10/10]])
	GUI:Text_enableOutline(page, "#000000", 1)
	GUI:setAnchorPoint(page, 0.50, 0.50)
	GUI:setTouchEnabled(page, false)
	GUI:setTag(page, 0)

	-- Create left
	local left = GUI:Button_Create(bag, "left", 137, 40, "res/public/btn_fanye_01.png")
	GUI:Button_setTitleText(left, [[]])
	GUI:Button_setTitleColor(left, "#FFFFFF")
	GUI:Button_setTitleFontSize(left, 18)
	GUI:Button_titleEnableOutline(left, "#000000", 1)
	GUI:setAnchorPoint(left, 0.00, 0.00)
	GUI:setTouchEnabled(left, true)
	GUI:setTag(left, 0)

	-- Create right
	local right = GUI:Button_Create(bag, "right", 264, 40, "res/public/btn_fanye_02.png")
	GUI:Button_setTitleText(right, [[]])
	GUI:Button_setTitleColor(right, "#FFFFFF")
	GUI:Button_setTitleFontSize(right, 18)
	GUI:Button_titleEnableOutline(right, "#000000", 1)
	GUI:setAnchorPoint(right, 0.00, 0.00)
	GUI:setTouchEnabled(right, true)
	GUI:setTag(right, 0)

	ui.update(__data__)
	return bag
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
