local ui = {}
local _V = function(...) return SL:GetMetaValue(...) end
local FUNCQUEUE = {}
local TAGOBJ = {}

function ui.init(parent, __data__, __update__)
	if __update__ then return ui.update(__data__) end
	-- Create bgk
	local bgk = GUI:Layout_Create(parent, "bgk", 4, 1, 900, 530, false)
	GUI:Layout_setBackGroundImage(bgk, "res/public/check.png")
	GUI:setAnchorPoint(bgk, 0.00, 0.00)
	GUI:setTouchEnabled(bgk, true)
	GUI:setTag(bgk, 0)

	-- Create Button_1
	local Button_1 = GUI:Button_Create(bgk, "Button_1", 446, 9, "res/public/cards/button.png")
	GUI:setContentSize(Button_1, 158, 58)
	GUI:setIgnoreContentAdaptWithSize(Button_1, false)
	GUI:Button_setTitleText(Button_1, [[]])
	GUI:Button_setTitleColor(Button_1, "#FFFFFF")
	GUI:Button_setTitleFontSize(Button_1, 18)
	GUI:Button_setTitleFontName(Button_1, "fonts/font140.ttf")
	GUI:Button_titleEnableOutline(Button_1, "#000000", 1)
	GUI:setAnchorPoint(Button_1, 0.50, 0.50)
	GUI:setTouchEnabled(Button_1, true)
	GUI:setTag(Button_1, 0)

	-- Create Button_2
	local Button_2 = GUI:Button_Create(bgk, "Button_2", 583, 35, "res/public/1900000679.png")
	GUI:setContentSize(Button_2, 76, 33)
	GUI:setIgnoreContentAdaptWithSize(Button_2, false)
	GUI:Button_setTitleText(Button_2, [[刷 新]])
	GUI:Button_setTitleColor(Button_2, "#FFFFFF")
	GUI:Button_setTitleFontSize(Button_2, 18)
	GUI:Button_setTitleFontName(Button_2, "fonts/font140.ttf")
	GUI:Button_titleEnableOutline(Button_2, "#000000", 1)
	GUI:setAnchorPoint(Button_2, 0.50, 0.50)
	GUI:setTouchEnabled(Button_2, true)
	GUI:setTag(Button_2, 0)
	GUI:setVisible(Button_2, false)

	-- Create close
	local close = GUI:Button_Create(bgk, "close", 897, 526, "res/public/cards/close.png")
	GUI:setContentSize(close, 60, 60)
	GUI:setIgnoreContentAdaptWithSize(close, false)
	GUI:Button_setTitleText(close, [[]])
	GUI:Button_setTitleColor(close, "#FFFFFF")
	GUI:Button_setTitleFontSize(close, 18)
	GUI:Button_titleEnableOutline(close, "#000000", 1)
	GUI:setAnchorPoint(close, 0.50, 0.50)
	GUI:setTouchEnabled(close, true)
	GUI:setTag(close, 0)

	-- Create show
	local show = GUI:Image_Create(bgk, "show", 449, 82, "res/public/qianneng/chou/l.png")
	GUI:setContentSize(show, 570, 50)
	GUI:setIgnoreContentAdaptWithSize(show, false)
	GUI:setAnchorPoint(show, 0.50, 0.50)
	GUI:setTouchEnabled(show, false)
	GUI:setTag(show, 0)
	GUI:setVisible(show, false)

	-- Create num
	local num = GUI:Text_Create(show, "num", 164, 23, 22, "#00ff00", [[刷新次数:1]])
	GUI:Text_setFontName(num, "fonts/font140.ttf")
	GUI:Text_enableOutline(num, "#000000", 1)
	GUI:setAnchorPoint(num, 0.00, 0.50)
	GUI:setTouchEnabled(num, false)
	GUI:setTag(num, 0)

	-- Create need
	local need = GUI:Text_Create(show, "need", 347, 23, 22, "#00ff00", [[刷新条件:10]])
	GUI:Text_setFontName(need, "fonts/font140.ttf")
	GUI:Text_enableOutline(need, "#000000", 1)
	GUI:setAnchorPoint(need, 0.00, 0.50)
	GUI:setTouchEnabled(need, false)
	GUI:setTag(need, 0)

	-- Create card
	local card = GUI:Layout_Create(bgk, "card", 451, 321, 500, 200, false)
	GUI:setAnchorPoint(card, 0.50, 0.50)
	GUI:setTouchEnabled(card, false)
	GUI:setTag(card, 0)

	-- Create Panel_1
	local Panel_1 = GUI:Layout_Create(card, "Panel_1", -40, 100, 264, 390, false)
	GUI:setAnchorPoint(Panel_1, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_1, false)
	GUI:setTag(Panel_1, 0)

	-- Create icon
	local icon = GUI:Image_Create(Panel_1, "icon", 132, 195, "res/public_win32/1900000666.png")
	GUI:setAnchorPoint(icon, 0.50, 0.50)
	GUI:setTouchEnabled(icon, false)
	GUI:setTag(icon, 0)

	-- Create Button_3
	local Button_3 = GUI:Button_Create(icon, "Button_3", 209, 310, "res/public/1900001024.png")
	GUI:Button_setTitleText(Button_3, [[]])
	GUI:Button_setTitleColor(Button_3, "#FFFFFF")
	GUI:Button_setTitleFontSize(Button_3, 18)
	GUI:Button_titleEnableOutline(Button_3, "#000000", 1)
	GUI:setAnchorPoint(Button_3, 0.50, 0.50)
	GUI:setTouchEnabled(Button_3, true)
	GUI:setTag(Button_3, 0)

	-- Create name
	local name = GUI:Text_Create(Panel_1, "name", 129, 308, 18, "#ffff00", [[文本]])
	GUI:Text_setFontName(name, "fonts/font140.ttf")
	GUI:Text_enableOutline(name, "#000000", 1)
	GUI:setAnchorPoint(name, 0.50, 0.00)
	GUI:setTouchEnabled(name, false)
	GUI:setTag(name, 0)

	-- Create desc
	local desc = GUI:Text_Create(Panel_1, "desc", 132, 163, 18, "#ffffff", [[文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本]])
	GUI:Text_setFontName(desc, "fonts/font140.ttf")
	GUI:setIgnoreContentAdaptWithSize(desc, false)
	GUI:Text_setTextAreaSize(desc, 200, 150)
	GUI:Text_enableOutline(desc, "#000000", 1)
	GUI:setAnchorPoint(desc, 0.50, 0.50)
	GUI:setTouchEnabled(desc, false)
	GUI:setTag(desc, 0)

	-- Create Button
	local Button = GUI:Button_Create(Panel_1, "Button", 133, 104, "res/public/1900000652.png")
	GUI:setContentSize(Button, 82, 29)
	GUI:setIgnoreContentAdaptWithSize(Button, false)
	GUI:Button_setTitleText(Button, [[刷新]])
	GUI:Button_setTitleColor(Button, "#FFFFFF")
	GUI:Button_setTitleFontSize(Button, 16)
	GUI:Button_titleEnableOutline(Button, "#000000", 1)
	GUI:setAnchorPoint(Button, 0.50, 0.50)
	GUI:setTouchEnabled(Button, true)
	GUI:setTag(Button, 0)

	-- Create jiage
	local jiage = GUI:Text_Create(Panel_1, "jiage", 131, 62, 18, "#ffffff", [[文本]])
	GUI:Text_enableOutline(jiage, "#000000", 1)
	GUI:setAnchorPoint(jiage, 0.50, 0.50)
	GUI:setTouchEnabled(jiage, false)
	GUI:setTag(jiage, 0)

	-- Create Panel_2
	local Panel_2 = GUI:Layout_Create(card, "Panel_2", 250, 100, 264, 390, false)
	GUI:setAnchorPoint(Panel_2, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_2, false)
	GUI:setTag(Panel_2, 0)

	-- Create icon
	icon = GUI:Image_Create(Panel_2, "icon", 132, 195, "res/public_win32/1900000666.png")
	GUI:setAnchorPoint(icon, 0.50, 0.50)
	GUI:setTouchEnabled(icon, false)
	GUI:setTag(icon, 0)

	-- Create Panel_3
	local Panel_3 = GUI:Layout_Create(card, "Panel_3", 540, 100, 264, 390, false)
	GUI:setAnchorPoint(Panel_3, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_3, false)
	GUI:setTag(Panel_3, 0)

	-- Create icon
	icon = GUI:Image_Create(Panel_3, "icon", 132, 195, "res/public_win32/1900000666.png")
	GUI:setAnchorPoint(icon, 0.50, 0.50)
	GUI:setTouchEnabled(icon, false)
	GUI:setTag(icon, 0)

	ui.update(__data__)
	return bgk
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
