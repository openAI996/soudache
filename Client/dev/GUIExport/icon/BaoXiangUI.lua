local ui = {}
local _V = function(...) return SL:GetMetaValue(...) end
local FUNCQUEUE = {}
local TAGOBJ = {}

function ui.init(parent, __data__, __update__)
	if __update__ then return ui.update(__data__) end
	-- Create bgk
	local bgk = GUI:Image_Create(parent, "bgk", -1, 1, "res/public/bg_fubentg_01.png")
	GUI:setAnchorPoint(bgk, 0.00, 0.00)
	GUI:setTouchEnabled(bgk, true)
	GUI:setTag(bgk, 0)

	-- Create close
	local close = GUI:Button_Create(bgk, "close", 567, 344, "res/public/btn_gban_01.png")
	GUI:setContentSize(close, 23, 22)
	GUI:setIgnoreContentAdaptWithSize(close, false)
	GUI:Button_setTitleText(close, [[]])
	GUI:Button_setTitleColor(close, "#FFFFFF")
	GUI:Button_setTitleFontSize(close, 18)
	GUI:Button_titleEnableOutline(close, "#000000", 1)
	GUI:setAnchorPoint(close, 0.50, 0.50)
	GUI:setTouchEnabled(close, true)
	GUI:setTag(close, 0)

	-- Create zhuan
	local zhuan = GUI:Layout_Create(bgk, "zhuan", 57, 8, 479, 292, false)
	GUI:setAnchorPoint(zhuan, 0.00, 0.00)
	GUI:setTouchEnabled(zhuan, false)
	GUI:setTag(zhuan, 0)

	-- Create Image_1
	local Image_1 = GUI:Image_Create(zhuan, "Image_1", 64, 251, "res/public/1900000651.png")
	GUI:setAnchorPoint(Image_1, 0.50, 0.50)
	GUI:setTouchEnabled(Image_1, false)
	GUI:setTag(Image_1, 0)

	-- Create Effect_1
	local Effect_1 = GUI:Effect_Create(Image_1, "Effect_1", 30, 29, 0, 4527, 0, 0, 0, 1)
	GUI:setTag(Effect_1, 0)
	GUI:setVisible(Effect_1, false)

	-- Create Image_2
	local Image_2 = GUI:Image_Create(zhuan, "Image_2", 135, 251, "res/public/1900000651.png")
	GUI:setAnchorPoint(Image_2, 0.50, 0.50)
	GUI:setTouchEnabled(Image_2, false)
	GUI:setTag(Image_2, 0)

	-- Create Effect_1
	Effect_1 = GUI:Effect_Create(Image_2, "Effect_1", 30, 29, 0, 4527, 0, 0, 0, 1)
	GUI:setTag(Effect_1, 0)
	GUI:setVisible(Effect_1, false)

	-- Create Image_3
	local Image_3 = GUI:Image_Create(zhuan, "Image_3", 206, 251, "res/public/1900000651.png")
	GUI:setAnchorPoint(Image_3, 0.50, 0.50)
	GUI:setTouchEnabled(Image_3, false)
	GUI:setTag(Image_3, 0)

	-- Create Effect_1
	Effect_1 = GUI:Effect_Create(Image_3, "Effect_1", 30, 29, 0, 4527, 0, 0, 0, 1)
	GUI:setTag(Effect_1, 0)
	GUI:setVisible(Effect_1, false)

	-- Create Image_4
	local Image_4 = GUI:Image_Create(zhuan, "Image_4", 272, 251, "res/public/1900000651.png")
	GUI:setAnchorPoint(Image_4, 0.50, 0.50)
	GUI:setTouchEnabled(Image_4, false)
	GUI:setTag(Image_4, 0)

	-- Create Effect_1
	Effect_1 = GUI:Effect_Create(Image_4, "Effect_1", 30, 29, 0, 4527, 0, 0, 0, 1)
	GUI:setTag(Effect_1, 0)
	GUI:setVisible(Effect_1, false)

	-- Create Image_5
	local Image_5 = GUI:Image_Create(zhuan, "Image_5", 346, 251, "res/public/1900000651.png")
	GUI:setAnchorPoint(Image_5, 0.50, 0.50)
	GUI:setTouchEnabled(Image_5, false)
	GUI:setTag(Image_5, 0)

	-- Create Effect_1
	Effect_1 = GUI:Effect_Create(Image_5, "Effect_1", 30, 29, 0, 4527, 0, 0, 0, 1)
	GUI:setTag(Effect_1, 0)
	GUI:setVisible(Effect_1, false)

	-- Create Image_6
	local Image_6 = GUI:Image_Create(zhuan, "Image_6", 416, 251, "res/public/1900000651.png")
	GUI:setAnchorPoint(Image_6, 0.50, 0.50)
	GUI:setTouchEnabled(Image_6, false)
	GUI:setTag(Image_6, 0)

	-- Create Effect_1
	Effect_1 = GUI:Effect_Create(Image_6, "Effect_1", 30, 29, 0, 4527, 0, 0, 0, 1)
	GUI:setTag(Effect_1, 0)
	GUI:setVisible(Effect_1, false)

	-- Create Image_7
	local Image_7 = GUI:Image_Create(zhuan, "Image_7", 417, 180, "res/public/1900000651.png")
	GUI:setAnchorPoint(Image_7, 0.50, 0.50)
	GUI:setTouchEnabled(Image_7, false)
	GUI:setTag(Image_7, 0)

	-- Create Effect_1
	Effect_1 = GUI:Effect_Create(Image_7, "Effect_1", 30, 29, 0, 4527, 0, 0, 0, 1)
	GUI:setTag(Effect_1, 0)
	GUI:setVisible(Effect_1, false)

	-- Create Image_8
	local Image_8 = GUI:Image_Create(zhuan, "Image_8", 417, 112, "res/public/1900000651.png")
	GUI:setAnchorPoint(Image_8, 0.50, 0.50)
	GUI:setTouchEnabled(Image_8, false)
	GUI:setTag(Image_8, 0)

	-- Create Effect_1
	Effect_1 = GUI:Effect_Create(Image_8, "Effect_1", 30, 29, 0, 4527, 0, 0, 0, 1)
	GUI:setTag(Effect_1, 0)
	GUI:setVisible(Effect_1, false)

	-- Create Image_9
	local Image_9 = GUI:Image_Create(zhuan, "Image_9", 417, 46, "res/public/1900000651.png")
	GUI:setAnchorPoint(Image_9, 0.50, 0.50)
	GUI:setTouchEnabled(Image_9, false)
	GUI:setTag(Image_9, 0)

	-- Create Effect_1
	Effect_1 = GUI:Effect_Create(Image_9, "Effect_1", 30, 29, 0, 4527, 0, 0, 0, 1)
	GUI:setTag(Effect_1, 0)
	GUI:setVisible(Effect_1, false)

	-- Create Image_10
	local Image_10 = GUI:Image_Create(zhuan, "Image_10", 346, 46, "res/public/1900000651.png")
	GUI:setAnchorPoint(Image_10, 0.50, 0.50)
	GUI:setTouchEnabled(Image_10, false)
	GUI:setTag(Image_10, 0)

	-- Create Effect_1
	Effect_1 = GUI:Effect_Create(Image_10, "Effect_1", 30, 29, 0, 4527, 0, 0, 0, 1)
	GUI:setTag(Effect_1, 0)
	GUI:setVisible(Effect_1, false)

	-- Create Image_11
	local Image_11 = GUI:Image_Create(zhuan, "Image_11", 272, 46, "res/public/1900000651.png")
	GUI:setAnchorPoint(Image_11, 0.50, 0.50)
	GUI:setTouchEnabled(Image_11, false)
	GUI:setTag(Image_11, 0)

	-- Create Effect_1
	Effect_1 = GUI:Effect_Create(Image_11, "Effect_1", 30, 29, 0, 4527, 0, 0, 0, 1)
	GUI:setTag(Effect_1, 0)
	GUI:setVisible(Effect_1, false)

	-- Create Image_12
	local Image_12 = GUI:Image_Create(zhuan, "Image_12", 206, 46, "res/public/1900000651.png")
	GUI:setAnchorPoint(Image_12, 0.50, 0.50)
	GUI:setTouchEnabled(Image_12, false)
	GUI:setTag(Image_12, 0)

	-- Create Effect_1
	Effect_1 = GUI:Effect_Create(Image_12, "Effect_1", 30, 29, 0, 4527, 0, 0, 0, 1)
	GUI:setTag(Effect_1, 0)
	GUI:setVisible(Effect_1, false)

	-- Create Image_13
	local Image_13 = GUI:Image_Create(zhuan, "Image_13", 135, 46, "res/public/1900000651.png")
	GUI:setAnchorPoint(Image_13, 0.50, 0.50)
	GUI:setTouchEnabled(Image_13, false)
	GUI:setTag(Image_13, 0)

	-- Create Effect_1
	Effect_1 = GUI:Effect_Create(Image_13, "Effect_1", 30, 29, 0, 4527, 0, 0, 0, 1)
	GUI:setTag(Effect_1, 0)
	GUI:setVisible(Effect_1, false)

	-- Create Image_14
	local Image_14 = GUI:Image_Create(zhuan, "Image_14", 64, 46, "res/public/1900000651.png")
	GUI:setAnchorPoint(Image_14, 0.50, 0.50)
	GUI:setTouchEnabled(Image_14, false)
	GUI:setTag(Image_14, 0)

	-- Create Effect_1
	Effect_1 = GUI:Effect_Create(Image_14, "Effect_1", 30, 29, 0, 4527, 0, 0, 0, 1)
	GUI:setTag(Effect_1, 0)
	GUI:setVisible(Effect_1, false)

	-- Create Image_15
	local Image_15 = GUI:Image_Create(zhuan, "Image_15", 64, 112, "res/public/1900000651.png")
	GUI:setAnchorPoint(Image_15, 0.50, 0.50)
	GUI:setTouchEnabled(Image_15, false)
	GUI:setTag(Image_15, 0)

	-- Create Effect_1
	Effect_1 = GUI:Effect_Create(Image_15, "Effect_1", 30, 29, 0, 4527, 0, 0, 0, 1)
	GUI:setTag(Effect_1, 0)
	GUI:setVisible(Effect_1, false)

	-- Create Image_16
	local Image_16 = GUI:Image_Create(zhuan, "Image_16", 64, 180, "res/public/1900000651.png")
	GUI:setAnchorPoint(Image_16, 0.50, 0.50)
	GUI:setTouchEnabled(Image_16, false)
	GUI:setTag(Image_16, 0)

	-- Create Effect_1
	Effect_1 = GUI:Effect_Create(Image_16, "Effect_1", 30, 29, 0, 4527, 0, 0, 0, 1)
	GUI:setTag(Effect_1, 0)
	GUI:setVisible(Effect_1, false)

	-- Create Button
	local Button = GUI:Button_Create(bgk, "Button", 296, 162, "res/public/1900000680.png")
	GUI:Button_setTitleText(Button, [[抽  取]])
	GUI:Button_setTitleColor(Button, "#10ff00")
	GUI:Button_setTitleFontSize(Button, 20)
	GUI:Button_setTitleFontName(Button, "fonts/font140.ttf")
	GUI:Button_titleEnableOutline(Button, "#000000", 1)
	GUI:setAnchorPoint(Button, 0.50, 0.50)
	GUI:setTouchEnabled(Button, true)
	GUI:setTag(Button, 0)

	-- Create BmpText_1
	local BmpText_1 = GUI:BmpText_Create(bgk, "BmpText_1", 298, 6, "#00ffe8", [[界面打开后不选，将失去抽奖机会]])
	GUI:Text_setFontSize(BmpText_1, 18)
	GUI:setAnchorPoint(BmpText_1, 0.50, 0.50)
	GUI:setTouchEnabled(BmpText_1, false)
	GUI:setTag(BmpText_1, 0)

	ui.update(__data__)
	return bgk
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
