local ui = {}
local _V = function(...) return SL:GetMetaValue(...) end
local FUNCQUEUE = {}
local TAGOBJ = {}

function ui.init(parent, __data__, __update__)
	if __update__ then return ui.update(__data__) end
	-- Create Scene
	local Scene = GUI:Node_Create(parent, "Scene", 0, 0)
	GUI:setChineseName(Scene, "宝箱场景")
	GUI:setTag(Scene, -1)

	-- Create Panel_1
	local Panel_1 = GUI:Layout_Create(Scene, "Panel_1", 568, 320, 1136, 640, false)
	GUI:setChineseName(Panel_1, "宝箱场景_组合")
	GUI:setAnchorPoint(Panel_1, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_1, false)
	GUI:setTag(Panel_1, 2)
	TAGOBJ["2"] = Panel_1

	-- Create Panel_main
	local Panel_main = GUI:Layout_Create(Panel_1, "Panel_main", 568, 400, 363, 376, false)
	GUI:setChineseName(Panel_main, "宝箱_组合")
	GUI:setAnchorPoint(Panel_main, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_main, false)
	GUI:setTag(Panel_main, 49)
	TAGOBJ["49"] = Panel_main

	-- Create Button_close
	local Button_close = GUI:Button_Create(Panel_main, "Button_close", 280, 270, "res/public/btn_gban_01.png")
	GUI:Button_loadTexturePressed(Button_close, "res/public/btn_gban_02.png")
	GUI:Button_setScale9Slice(Button_close, 8, 7, 7, 8)
	GUI:Button_setTitleText(Button_close, [[]])
	GUI:Button_setTitleColor(Button_close, "#414146")
	GUI:Button_setTitleFontSize(Button_close, 14)
	GUI:Button_titleDisableOutLine(Button_close)
	GUI:setChineseName(Button_close, "宝箱_关闭_按钮")
	GUI:setAnchorPoint(Button_close, 0.50, 0.50)
	GUI:setTouchEnabled(Button_close, true)
	GUI:setTag(Button_close, 8)
	TAGOBJ["8"] = Button_close

	-- Create Image_bg
	local Image_bg = GUI:Image_Create(Panel_main, "Image_bg", 181, 188, "res/private/treasure_box/000510.png")
	GUI:setChineseName(Image_bg, "宝箱_背景图")
	GUI:setAnchorPoint(Image_bg, 0.50, 0.50)
	GUI:setScale(Image_bg, 0.90)
	GUI:setTouchEnabled(Image_bg, true)
	GUI:setTag(Image_bg, 3)
	TAGOBJ["3"] = Image_bg

	-- Create Node_bg
	local Node_bg = GUI:Node_Create(Panel_main, "Node_bg", 181, 194)
	GUI:setChineseName(Node_bg, "宝箱_奖品节点")
	GUI:setTag(Node_bg, 124)
	TAGOBJ["124"] = Node_bg

	-- Create Image_0
	local Image_0 = GUI:Image_Create(Node_bg, "Image_0", 0, 0, "res/private/treasure_box/000513.png")
	GUI:setChineseName(Image_0, "宝箱_中奖_背景图")
	GUI:setAnchorPoint(Image_0, 0.50, 0.50)
	GUI:setTouchEnabled(Image_0, false)
	GUI:setTag(Image_0, 37)
	TAGOBJ["37"] = Image_0

	-- Create Image_1
	local Image_1 = GUI:Image_Create(Node_bg, "Image_1", -55, 50, "res/private/treasure_box/000514.png")
	GUI:setChineseName(Image_1, "宝箱_1号奖品_背景图")
	GUI:setAnchorPoint(Image_1, 0.50, 0.50)
	GUI:setTouchEnabled(Image_1, false)
	GUI:setTag(Image_1, 62)
	TAGOBJ["62"] = Image_1

	-- Create Image_2
	local Image_2 = GUI:Image_Create(Node_bg, "Image_2", 0, 50, "res/private/treasure_box/000514.png")
	GUI:setChineseName(Image_2, "宝箱_2号奖品_背景图")
	GUI:setAnchorPoint(Image_2, 0.50, 0.50)
	GUI:setTouchEnabled(Image_2, false)
	GUI:setTag(Image_2, 63)
	TAGOBJ["63"] = Image_2

	-- Create Image_3
	local Image_3 = GUI:Image_Create(Node_bg, "Image_3", 55, 50, "res/private/treasure_box/000514.png")
	GUI:setChineseName(Image_3, "宝箱_3号奖品_背景图")
	GUI:setAnchorPoint(Image_3, 0.50, 0.50)
	GUI:setTouchEnabled(Image_3, false)
	GUI:setTag(Image_3, 64)
	TAGOBJ["64"] = Image_3

	-- Create Image_4
	local Image_4 = GUI:Image_Create(Node_bg, "Image_4", 55, 0, "res/private/treasure_box/000514.png")
	GUI:setChineseName(Image_4, "宝箱_4号奖品_背景图")
	GUI:setAnchorPoint(Image_4, 0.50, 0.50)
	GUI:setTouchEnabled(Image_4, false)
	GUI:setTag(Image_4, 65)
	TAGOBJ["65"] = Image_4

	-- Create Image_5
	local Image_5 = GUI:Image_Create(Node_bg, "Image_5", 55, -50, "res/private/treasure_box/000514.png")
	GUI:setChineseName(Image_5, "宝箱_5号奖品_背景图")
	GUI:setAnchorPoint(Image_5, 0.50, 0.50)
	GUI:setTouchEnabled(Image_5, false)
	GUI:setTag(Image_5, 66)
	TAGOBJ["66"] = Image_5

	-- Create Image_6
	local Image_6 = GUI:Image_Create(Node_bg, "Image_6", 0, -50, "res/private/treasure_box/000514.png")
	GUI:setChineseName(Image_6, "宝箱_6号奖品_背景图")
	GUI:setAnchorPoint(Image_6, 0.50, 0.50)
	GUI:setTouchEnabled(Image_6, false)
	GUI:setTag(Image_6, 67)
	TAGOBJ["67"] = Image_6

	-- Create Image_7
	local Image_7 = GUI:Image_Create(Node_bg, "Image_7", -55, -50, "res/private/treasure_box/000514.png")
	GUI:setChineseName(Image_7, "宝箱_7号奖品_背景图")
	GUI:setAnchorPoint(Image_7, 0.50, 0.50)
	GUI:setTouchEnabled(Image_7, false)
	GUI:setTag(Image_7, 68)
	TAGOBJ["68"] = Image_7

	-- Create Image_8
	local Image_8 = GUI:Image_Create(Node_bg, "Image_8", -55, 0, "res/private/treasure_box/000514.png")
	GUI:setChineseName(Image_8, "宝箱_8号奖品_背景图")
	GUI:setAnchorPoint(Image_8, 0.50, 0.50)
	GUI:setTouchEnabled(Image_8, false)
	GUI:setTag(Image_8, 69)
	TAGOBJ["69"] = Image_8

	-- Create Node_icon
	local Node_icon = GUI:Node_Create(Panel_main, "Node_icon", 181, 195)
	GUI:setChineseName(Node_icon, "宝箱_图标节点")
	GUI:setTag(Node_icon, 121)
	TAGOBJ["121"] = Node_icon

	-- Create Node_1
	local Node_1 = GUI:Node_Create(Node_icon, "Node_1", -55, 50)
	GUI:setChineseName(Node_1, "宝箱_1号奖品_图标节点")
	GUI:setTag(Node_1, 40)
	TAGOBJ["40"] = Node_1

	-- Create Node_2
	local Node_2 = GUI:Node_Create(Node_icon, "Node_2", 0, 50)
	GUI:setChineseName(Node_2, "宝箱_2号奖品_图标节点")
	GUI:setTag(Node_2, 41)
	TAGOBJ["41"] = Node_2

	-- Create Node_3
	local Node_3 = GUI:Node_Create(Node_icon, "Node_3", 55, 50)
	GUI:setChineseName(Node_3, "宝箱_3号奖品_图标节点")
	GUI:setTag(Node_3, 42)
	TAGOBJ["42"] = Node_3

	-- Create Node_4
	local Node_4 = GUI:Node_Create(Node_icon, "Node_4", 55, 0)
	GUI:setChineseName(Node_4, "宝箱_4号奖品_图标节点")
	GUI:setTag(Node_4, 43)
	TAGOBJ["43"] = Node_4

	-- Create Node_5
	local Node_5 = GUI:Node_Create(Node_icon, "Node_5", 55, -50)
	GUI:setChineseName(Node_5, "宝箱_5号奖品_图标节点")
	GUI:setTag(Node_5, 44)
	TAGOBJ["44"] = Node_5

	-- Create Node_6
	local Node_6 = GUI:Node_Create(Node_icon, "Node_6", 0, -50)
	GUI:setChineseName(Node_6, "宝箱_6号奖品_图标节点")
	GUI:setTag(Node_6, 45)
	TAGOBJ["45"] = Node_6

	-- Create Node_7
	local Node_7 = GUI:Node_Create(Node_icon, "Node_7", -55, -50)
	GUI:setChineseName(Node_7, "宝箱_7号奖品_图标节点")
	GUI:setTag(Node_7, 46)
	TAGOBJ["46"] = Node_7

	-- Create Node_8
	local Node_8 = GUI:Node_Create(Node_icon, "Node_8", -55, 0)
	GUI:setChineseName(Node_8, "宝箱_8号奖品_图标节点")
	GUI:setTag(Node_8, 47)
	TAGOBJ["47"] = Node_8

	-- Create Node_0
	local Node_0 = GUI:Node_Create(Node_icon, "Node_0", 0, 0)
	GUI:setChineseName(Node_0, "宝箱_中奖节点")
	GUI:setTag(Node_0, 48)
	TAGOBJ["48"] = Node_0

	-- Create Node_anim
	local Node_anim = GUI:Node_Create(Panel_main, "Node_anim", 181, 195)
	GUI:setChineseName(Node_anim, "宝箱_特效组合")
	GUI:setTag(Node_anim, 42)
	TAGOBJ["42"] = Node_anim

	-- Create Node_pos1
	local Node_pos1 = GUI:Node_Create(Node_anim, "Node_pos1", -55, 50)
	GUI:setChineseName(Node_pos1, "宝箱_1号奖品中奖位置节点")
	GUI:setTag(Node_pos1, 45)
	TAGOBJ["45"] = Node_pos1

	-- Create Panel_cover1
	local Panel_cover1 = GUI:Layout_Create(Node_pos1, "Panel_cover1", 0, 0, 40, 37, false)
	GUI:setChineseName(Panel_cover1, "宝箱_1号中奖")
	GUI:setAnchorPoint(Panel_cover1, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_cover1, true)
	GUI:setTag(Panel_cover1, 53)
	GUI:setVisible(Panel_cover1, false)
	TAGOBJ["53"] = Panel_cover1

	-- Create Node_pos2
	local Node_pos2 = GUI:Node_Create(Node_anim, "Node_pos2", 0, 50)
	GUI:setChineseName(Node_pos2, "宝箱_2号奖品中奖位置节点")
	GUI:setTag(Node_pos2, 46)
	TAGOBJ["46"] = Node_pos2

	-- Create Panel_cover2
	local Panel_cover2 = GUI:Layout_Create(Node_pos2, "Panel_cover2", 0, 0, 40, 37, false)
	GUI:setChineseName(Panel_cover2, "宝箱_2号中奖")
	GUI:setAnchorPoint(Panel_cover2, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_cover2, true)
	GUI:setTag(Panel_cover2, 54)
	GUI:setVisible(Panel_cover2, false)
	TAGOBJ["54"] = Panel_cover2

	-- Create Node_pos3
	local Node_pos3 = GUI:Node_Create(Node_anim, "Node_pos3", 55, 50)
	GUI:setChineseName(Node_pos3, "宝箱_3号奖品中奖位置节点")
	GUI:setTag(Node_pos3, 47)
	TAGOBJ["47"] = Node_pos3

	-- Create Panel_cover3
	local Panel_cover3 = GUI:Layout_Create(Node_pos3, "Panel_cover3", 0, 0, 40, 37, false)
	GUI:setChineseName(Panel_cover3, "宝箱_3号中奖")
	GUI:setAnchorPoint(Panel_cover3, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_cover3, true)
	GUI:setTag(Panel_cover3, 55)
	GUI:setVisible(Panel_cover3, false)
	TAGOBJ["55"] = Panel_cover3

	-- Create Node_pos4
	local Node_pos4 = GUI:Node_Create(Node_anim, "Node_pos4", 55, 0)
	GUI:setChineseName(Node_pos4, "宝箱_4号奖品中奖位置节点")
	GUI:setTag(Node_pos4, 48)
	TAGOBJ["48"] = Node_pos4

	-- Create Panel_cover4
	local Panel_cover4 = GUI:Layout_Create(Node_pos4, "Panel_cover4", 0, 0, 40, 37, false)
	GUI:setChineseName(Panel_cover4, "宝箱_4号中奖")
	GUI:setAnchorPoint(Panel_cover4, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_cover4, true)
	GUI:setTag(Panel_cover4, 56)
	GUI:setVisible(Panel_cover4, false)
	TAGOBJ["56"] = Panel_cover4

	-- Create Node_pos5
	local Node_pos5 = GUI:Node_Create(Node_anim, "Node_pos5", 55, -50)
	GUI:setChineseName(Node_pos5, "宝箱_5号奖品中奖位置节点")
	GUI:setTag(Node_pos5, 49)
	TAGOBJ["49"] = Node_pos5

	-- Create Panel_cover5
	local Panel_cover5 = GUI:Layout_Create(Node_pos5, "Panel_cover5", 0, 0, 40, 37, false)
	GUI:setChineseName(Panel_cover5, "宝箱_5号中奖")
	GUI:setAnchorPoint(Panel_cover5, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_cover5, true)
	GUI:setTag(Panel_cover5, 57)
	GUI:setVisible(Panel_cover5, false)
	TAGOBJ["57"] = Panel_cover5

	-- Create Node_pos6
	local Node_pos6 = GUI:Node_Create(Node_anim, "Node_pos6", 0, -50)
	GUI:setChineseName(Node_pos6, "宝箱_6号奖品中奖位置节点")
	GUI:setTag(Node_pos6, 50)
	TAGOBJ["50"] = Node_pos6

	-- Create Panel_cover6
	local Panel_cover6 = GUI:Layout_Create(Node_pos6, "Panel_cover6", 0, 0, 40, 37, false)
	GUI:setChineseName(Panel_cover6, "宝箱_6号中奖")
	GUI:setAnchorPoint(Panel_cover6, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_cover6, true)
	GUI:setTag(Panel_cover6, 58)
	GUI:setVisible(Panel_cover6, false)
	TAGOBJ["58"] = Panel_cover6

	-- Create Node_pos7
	local Node_pos7 = GUI:Node_Create(Node_anim, "Node_pos7", -55, -50)
	GUI:setChineseName(Node_pos7, "宝箱_7号奖品中奖位置节点")
	GUI:setTag(Node_pos7, 51)
	TAGOBJ["51"] = Node_pos7

	-- Create Panel_cover7
	local Panel_cover7 = GUI:Layout_Create(Node_pos7, "Panel_cover7", 0, 0, 40, 37, false)
	GUI:setChineseName(Panel_cover7, "宝箱_7号中奖")
	GUI:setAnchorPoint(Panel_cover7, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_cover7, true)
	GUI:setTag(Panel_cover7, 59)
	GUI:setVisible(Panel_cover7, false)
	TAGOBJ["59"] = Panel_cover7

	-- Create Node_pos8
	local Node_pos8 = GUI:Node_Create(Node_anim, "Node_pos8", -55, 0)
	GUI:setChineseName(Node_pos8, "宝箱_8号奖品中奖位置节点")
	GUI:setTag(Node_pos8, 52)
	TAGOBJ["52"] = Node_pos8

	-- Create Panel_cover8
	local Panel_cover8 = GUI:Layout_Create(Node_pos8, "Panel_cover8", 0, 0, 40, 37, false)
	GUI:setChineseName(Panel_cover8, "宝箱_8号中奖")
	GUI:setAnchorPoint(Panel_cover8, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_cover8, true)
	GUI:setTag(Panel_cover8, 60)
	GUI:setVisible(Panel_cover8, false)
	TAGOBJ["60"] = Panel_cover8

	-- Create Node_pos0
	local Node_pos0 = GUI:Node_Create(Node_anim, "Node_pos0", 0, 0)
	GUI:setChineseName(Node_pos0, "宝箱_当前中奖位置节点")
	GUI:setTag(Node_pos0, 75)
	TAGOBJ["75"] = Node_pos0

	-- Create Panel_cover0
	local Panel_cover0 = GUI:Layout_Create(Node_pos0, "Panel_cover0", 0, 0, 52, 48, false)
	GUI:setChineseName(Panel_cover0, "宝箱_当前中奖")
	GUI:setAnchorPoint(Panel_cover0, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_cover0, true)
	GUI:setTag(Panel_cover0, 76)
	GUI:setVisible(Panel_cover0, false)
	TAGOBJ["76"] = Panel_cover0

	-- Create Button_open
	local Button_open = GUI:Button_Create(Panel_main, "Button_open", 182, 85, "res/public/1900000660.png")
	GUI:Button_loadTexturePressed(Button_open, "res/public/1900000661.png")
	GUI:Button_loadTextureDisabled(Button_open, "Default/Button_Disable.png")
	GUI:Button_setScale9Slice(Button_open, 35, 36, 13, 14)
	GUI:setContentSize(Button_open, 56, 26)
	GUI:setIgnoreContentAdaptWithSize(Button_open, false)
	GUI:Button_setTitleText(Button_open, [[摇一摇]])
	GUI:Button_setTitleColor(Button_open, "#00fb00")
	GUI:Button_setTitleFontSize(Button_open, 15)
	GUI:Button_titleEnableOutline(Button_open, "#000000", 1)
	GUI:setChineseName(Button_open, "宝箱_抽奖_按钮")
	GUI:setAnchorPoint(Button_open, 0.50, 0.50)
	GUI:setTouchEnabled(Button_open, true)
	GUI:setTag(Button_open, 77)
	TAGOBJ["77"] = Button_open

	-- Create Node_btn
	local Node_btn = GUI:Node_Create(Panel_main, "Node_btn", 181, 109)
	GUI:setChineseName(Node_btn, "宝箱_按钮特效_节点")
	GUI:setTag(Node_btn, 92)
	TAGOBJ["92"] = Node_btn

	ui.update(__data__)
	return Scene
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
