local ui = {}
local _V = function(...) return SL:GetMetaValue(...) end
local FUNCQUEUE = {}
local TAGOBJ = {}

function ui.init(parent, __data__, __update__)
	if __update__ then return ui.update(__data__) end
	-- Create bgk
	local bgk = GUI:Image_Create(parent, "bgk", -1, 1, "res/public/bg_bbgm_01.png")
	GUI:setAnchorPoint(bgk, 0.00, 0.00)
	GUI:setTouchEnabled(bgk, true)
	GUI:setTag(bgk, 0)

	-- Create close
	local close = GUI:Button_Create(bgk, "close", 450, 395, "res/public/1900000510.png")
	GUI:setContentSize(close, 26, 42)
	GUI:setIgnoreContentAdaptWithSize(close, false)
	GUI:Button_setTitleText(close, [[]])
	GUI:Button_setTitleColor(close, "#FFFFFF")
	GUI:Button_setTitleFontSize(close, 18)
	GUI:Button_titleEnableOutline(close, "#000000", 1)
	GUI:setAnchorPoint(close, 0.50, 0.50)
	GUI:setTouchEnabled(close, true)
	GUI:setTag(close, 0)

	-- Create ListView
	local ListView = GUI:ListView_Create(bgk, "ListView", 219, 248, 400, 280, 1)
	GUI:setAnchorPoint(ListView, 0.50, 0.50)
	GUI:setTouchEnabled(ListView, true)
	GUI:setTag(ListView, 0)

	-- Create button
	local button = GUI:Button_Create(bgk, "button", 345, 74, "res/public/1900000652.png")
	GUI:setContentSize(button, 82, 29)
	GUI:setIgnoreContentAdaptWithSize(button, false)
	GUI:Button_setTitleText(button, [[售 卖]])
	GUI:Button_setTitleColor(button, "#FFFFFF")
	GUI:Button_setTitleFontSize(button, 18)
	GUI:Button_titleEnableOutline(button, "#000000", 1)
	GUI:setAnchorPoint(button, 0.50, 0.50)
	GUI:setTouchEnabled(button, true)
	GUI:setTag(button, 0)

	-- Create all
	local all = GUI:Button_Create(bgk, "all", 345, 39, "res/public/1900000652.png")
	GUI:setContentSize(all, 82, 29)
	GUI:setIgnoreContentAdaptWithSize(all, false)
	GUI:Button_setTitleText(all, [[一键全选]])
	GUI:Button_setTitleColor(all, "#FFFFFF")
	GUI:Button_setTitleFontSize(all, 16)
	GUI:Button_titleEnableOutline(all, "#000000", 1)
	GUI:setAnchorPoint(all, 0.50, 0.50)
	GUI:setTouchEnabled(all, true)
	GUI:setTag(all, 0)

	-- Create jiage
	local jiage = GUI:Text_Create(bgk, "jiage", 61, 72, 18, "#ffffff", [[回收金币：]])
	GUI:Text_setFontName(jiage, "fonts/font140.ttf")
	GUI:Text_enableOutline(jiage, "#000000", 1)
	GUI:setAnchorPoint(jiage, 0.00, 0.50)
	GUI:setTouchEnabled(jiage, false)
	GUI:setTag(jiage, 0)

	-- Create bind
	local bind = GUI:Text_Create(bgk, "bind", 61, 41, 18, "#ffffff", [[绑定金币：]])
	GUI:Text_setFontName(bind, "fonts/font140.ttf")
	GUI:Text_enableOutline(bind, "#000000", 1)
	GUI:setAnchorPoint(bind, 0.00, 0.50)
	GUI:setTouchEnabled(bind, false)
	GUI:setTag(bind, 0)

	-- Create Button_1
	local Button_1 = GUI:Button_Create(bgk, "Button_1", -33, 325, "res/public/1900000640_1.png")
	GUI:Button_setTitleText(Button_1, [[]])
	GUI:Button_setTitleColor(Button_1, "#FFFFFF")
	GUI:Button_setTitleFontSize(Button_1, 18)
	GUI:Button_titleEnableOutline(Button_1, "#000000", 1)
	GUI:setAnchorPoint(Button_1, 0.00, 0.00)
	GUI:setTouchEnabled(Button_1, true)
	GUI:setTag(Button_1, 0)

	-- Create Text_1
	local Text_1 = GUI:Text_Create(Button_1, "Text_1", 10, 33, 18, "#ffffff", [[背
包]])
	GUI:Text_enableOutline(Text_1, "#000000", 1)
	GUI:setAnchorPoint(Text_1, 0.00, 0.00)
	GUI:setTouchEnabled(Text_1, false)
	GUI:setTag(Text_1, 0)

	-- Create Button_2
	local Button_2 = GUI:Button_Create(bgk, "Button_2", -33, 259, "res/public/1900000640_1.png")
	GUI:Button_setTitleText(Button_2, [[]])
	GUI:Button_setTitleColor(Button_2, "#FFFFFF")
	GUI:Button_setTitleFontSize(Button_2, 18)
	GUI:Button_titleEnableOutline(Button_2, "#000000", 1)
	GUI:setAnchorPoint(Button_2, 0.00, 0.00)
	GUI:setTouchEnabled(Button_2, true)
	GUI:setTag(Button_2, 0)

	-- Create Text_1
	Text_1 = GUI:Text_Create(Button_2, "Text_1", 10, 33, 18, "#ffffff", [[仓
库]])
	GUI:Text_enableOutline(Text_1, "#000000", 1)
	GUI:setAnchorPoint(Text_1, 0.00, 0.00)
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
