local ui = {}
local _V = function(...) return SL:GetMetaValue(...) end
local FUNCQUEUE = {}
local TAGOBJ = {}

function ui.init(parent, __data__, __update__)
	if __update__ then return ui.update(__data__) end
	-- Create bgk
	local bgk = GUI:Layout_Create(parent, "bgk", 453, 265, 900, 530, false)
	GUI:setAnchorPoint(bgk, 0.50, 0.50)
	GUI:setTouchEnabled(bgk, true)
	GUI:setTag(bgk, 0)

	-- Create list
	local list = GUI:ListView_Create(bgk, "list", 453, 265, 786, 367, 2)
	GUI:ListView_setGravity(list, 5)
	GUI:ListView_setItemsMargin(list, 20)
	GUI:setAnchorPoint(list, 0.50, 0.50)
	GUI:setTouchEnabled(list, true)
	GUI:setTag(list, 0)

	-- Create close
	local close = GUI:Button_Create(bgk, "close", 887, 509, "res/public/cards/close.png")
	GUI:setContentSize(close, 60, 60)
	GUI:setIgnoreContentAdaptWithSize(close, false)
	GUI:Button_setTitleText(close, [[]])
	GUI:Button_setTitleColor(close, "#FFFFFF")
	GUI:Button_setTitleFontSize(close, 18)
	GUI:Button_titleEnableOutline(close, "#000000", 1)
	GUI:setAnchorPoint(close, 0.50, 0.50)
	GUI:setTouchEnabled(close, true)
	GUI:setTag(close, 0)

	-- Create Image_1
	local Image_1 = GUI:Image_Create(bgk, "Image_1", 455, 42, "res/public/cards/zy.png")
	GUI:setAnchorPoint(Image_1, 0.50, 0.50)
	GUI:setTouchEnabled(Image_1, false)
	GUI:setTag(Image_1, 0)

	-- Create Image_2
	local Image_2 = GUI:Image_Create(bgk, "Image_2", 455, 486, "res/public/cards/wo.png")
	GUI:setAnchorPoint(Image_2, 0.50, 0.50)
	GUI:setTouchEnabled(Image_2, false)
	GUI:setTag(Image_2, 0)

	-- Create down
	local down = GUI:ListView_Create(bgk, "down", 471, -26, 786, 45, 2)
	GUI:ListView_setGravity(down, 5)
	GUI:ListView_setItemsMargin(down, 3)
	GUI:setAnchorPoint(down, 0.50, 0.50)
	GUI:setTouchEnabled(down, true)
	GUI:setTag(down, 0)

	-- Create Image_3
	local Image_3 = GUI:Image_Create(bgk, "Image_3", 6, -50, "res/public/cards/1.png")
	GUI:setAnchorPoint(Image_3, 0.00, 0.00)
	GUI:setTouchEnabled(Image_3, false)
	GUI:setTag(Image_3, 0)

	-- Create Image_4
	local Image_4 = GUI:Image_Create(bgk, "Image_4", 865, -50, "res/public/cards/3.png")
	GUI:setAnchorPoint(Image_4, 0.00, 0.00)
	GUI:setTouchEnabled(Image_4, false)
	GUI:setTag(Image_4, 0)

	ui.update(__data__)
	return bgk
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
