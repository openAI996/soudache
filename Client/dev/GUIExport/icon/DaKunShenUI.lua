local ui = {}
local _V = function(...) return SL:GetMetaValue(...) end
local FUNCQUEUE = {}
local TAGOBJ = {}

function ui.init(parent, __data__, __update__)
	if __update__ then return ui.update(__data__) end
	-- Create bgk
	local bgk = GUI:Image_Create(parent, "bgk", -1, 1, "res/public/1900000600.png")
	GUI:setAnchorPoint(bgk, 0.00, 0.00)
	GUI:setTouchEnabled(bgk, true)
	GUI:setTag(bgk, 0)

	-- Create close
	local close = GUI:Button_Create(bgk, "close", 462, 157, "res/public/1900000510.png")
	GUI:setContentSize(close, 26, 42)
	GUI:setIgnoreContentAdaptWithSize(close, false)
	GUI:Button_setTitleText(close, [[]])
	GUI:Button_setTitleColor(close, "#FFFFFF")
	GUI:Button_setTitleFontSize(close, 18)
	GUI:Button_titleEnableOutline(close, "#000000", 1)
	GUI:setAnchorPoint(close, 0.50, 0.50)
	GUI:setTouchEnabled(close, true)
	GUI:setTag(close, 0)

	-- Create list
	local list = GUI:ListView_Create(bgk, "list", 13, 10, 426, 156, 2)
	GUI:ListView_setGravity(list, 5)
	GUI:ListView_setItemsMargin(list, 34)
	GUI:setAnchorPoint(list, 0.00, 0.00)
	GUI:setTouchEnabled(list, true)
	GUI:setTag(list, 0)

	-- Create Panel_1
	local Panel_1 = GUI:Layout_Create(list, "Panel_1", 0, 4, 118, 148, false)
	GUI:setAnchorPoint(Panel_1, 0.00, 0.00)
	GUI:setTouchEnabled(Panel_1, false)
	GUI:setTag(Panel_1, 0)

	-- Create button
	local button = GUI:Button_Create(Panel_1, "button", 57, 23, "res/public/1900000653.png")
	GUI:setContentSize(button, 82, 29)
	GUI:setIgnoreContentAdaptWithSize(button, false)
	GUI:Button_setTitleText(button, [[售 卖]])
	GUI:Button_setTitleColor(button, "#FFFFFF")
	GUI:Button_setTitleFontSize(button, 18)
	GUI:Button_titleEnableOutline(button, "#000000", 1)
	GUI:setAnchorPoint(button, 0.50, 0.50)
	GUI:setTouchEnabled(button, true)
	GUI:setTag(button, 0)

	-- Create item
	local item = GUI:Image_Create(Panel_1, "item", 57, 104, "res/public/1900000651.png")
	GUI:setAnchorPoint(item, 0.50, 0.50)
	GUI:setTouchEnabled(item, false)
	GUI:setTag(item, 0)

	-- Create Text_1
	local Text_1 = GUI:Text_Create(Panel_1, "Text_1", 56, 45, 18, "#00ff00", [[文本]])
	GUI:Text_setFontName(Text_1, "fonts/font110.ttf")
	GUI:Text_enableOutline(Text_1, "#000000", 1)
	GUI:setAnchorPoint(Text_1, 0.50, 0.00)
	GUI:setTouchEnabled(Text_1, false)
	GUI:setTag(Text_1, 0)

	-- Create Panel_2
	local Panel_2 = GUI:Layout_Create(list, "Panel_2", 152, 4, 118, 148, false)
	GUI:setAnchorPoint(Panel_2, 0.00, 0.00)
	GUI:setTouchEnabled(Panel_2, false)
	GUI:setTag(Panel_2, 0)

	-- Create button
	button = GUI:Button_Create(Panel_2, "button", 57, 23, "res/public/1900000653.png")
	GUI:setContentSize(button, 82, 29)
	GUI:setIgnoreContentAdaptWithSize(button, false)
	GUI:Button_setTitleText(button, [[售 卖]])
	GUI:Button_setTitleColor(button, "#FFFFFF")
	GUI:Button_setTitleFontSize(button, 18)
	GUI:Button_titleEnableOutline(button, "#000000", 1)
	GUI:setAnchorPoint(button, 0.50, 0.50)
	GUI:setTouchEnabled(button, true)
	GUI:setTag(button, 0)

	-- Create item
	item = GUI:Image_Create(Panel_2, "item", 57, 104, "res/public/1900000651.png")
	GUI:setAnchorPoint(item, 0.50, 0.50)
	GUI:setTouchEnabled(item, false)
	GUI:setTag(item, 0)

	-- Create Text_1
	Text_1 = GUI:Text_Create(Panel_2, "Text_1", 56, 45, 18, "#00ff00", [[文本]])
	GUI:Text_setFontName(Text_1, "fonts/font110.ttf")
	GUI:Text_enableOutline(Text_1, "#000000", 1)
	GUI:setAnchorPoint(Text_1, 0.50, 0.00)
	GUI:setTouchEnabled(Text_1, false)
	GUI:setTag(Text_1, 0)

	-- Create Panel_3
	local Panel_3 = GUI:Layout_Create(list, "Panel_3", 304, 4, 118, 148, false)
	GUI:setAnchorPoint(Panel_3, 0.00, 0.00)
	GUI:setTouchEnabled(Panel_3, false)
	GUI:setTag(Panel_3, 0)

	-- Create button
	button = GUI:Button_Create(Panel_3, "button", 57, 23, "res/public/1900000653.png")
	GUI:setContentSize(button, 82, 29)
	GUI:setIgnoreContentAdaptWithSize(button, false)
	GUI:Button_setTitleText(button, [[售 卖]])
	GUI:Button_setTitleColor(button, "#FFFFFF")
	GUI:Button_setTitleFontSize(button, 18)
	GUI:Button_titleEnableOutline(button, "#000000", 1)
	GUI:setAnchorPoint(button, 0.50, 0.50)
	GUI:setTouchEnabled(button, true)
	GUI:setTag(button, 0)

	-- Create item
	item = GUI:Image_Create(Panel_3, "item", 57, 104, "res/public/1900000651.png")
	GUI:setAnchorPoint(item, 0.50, 0.50)
	GUI:setTouchEnabled(item, false)
	GUI:setTag(item, 0)

	-- Create Text_1
	Text_1 = GUI:Text_Create(Panel_3, "Text_1", 56, 45, 18, "#00ff00", [[文本]])
	GUI:Text_setFontName(Text_1, "fonts/font110.ttf")
	GUI:Text_enableOutline(Text_1, "#000000", 1)
	GUI:setAnchorPoint(Text_1, 0.50, 0.00)
	GUI:setTouchEnabled(Text_1, false)
	GUI:setTag(Text_1, 0)

	ui.update(__data__)
	return bgk
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
