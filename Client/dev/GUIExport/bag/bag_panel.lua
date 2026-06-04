local ui = {}
local _V = function(...) return SL:GetMetaValue(...) end
local FUNCQUEUE = {}
local TAGOBJ = {}

function ui.init(parent, __data__, __update__)
	if __update__ then return ui.update(__data__) end
	-- Create Scene
	local Scene = GUI:Node_Create(parent, "Scene", 0, 0)
	GUI:setChineseName(Scene, "背包场景")
	GUI:setTag(Scene, -1)

	-- Create Panel_1
	local Panel_1 = GUI:Layout_Create(Scene, "Panel_1", 98, 340, 568, 469, false)
	GUI:setChineseName(Panel_1, "背包组合框")
	GUI:setAnchorPoint(Panel_1, 0.00, 0.50)
	GUI:setTouchEnabled(Panel_1, false)
	GUI:setTag(Panel_1, 2)
	TAGOBJ["2"] = Panel_1

	-- Create Image_bg
	local Image_bg = GUI:Image_Create(Panel_1, "Image_bg", 284, 235, "res/private/bag_ui/bag_ui_mobile/bg_beibao_01.png")
	GUI:setContentSize(Image_bg, 570, 469)
	GUI:setIgnoreContentAdaptWithSize(Image_bg, false)
	GUI:setChineseName(Image_bg, "背包_背景_图片")
	GUI:setAnchorPoint(Image_bg, 0.50, 0.50)
	GUI:setTouchEnabled(Image_bg, true)
	GUI:setTag(Image_bg, 3)
	TAGOBJ["3"] = Image_bg

	-- Create Button_page1
	local Button_page1 = GUI:Button_Create(Panel_1, "Button_page1", -14, 410, "res/public/1900000641_1.png")
	GUI:Button_loadTexturePressed(Button_page1, "res/public/1900000640_1.png")
	GUI:Button_loadTextureDisabled(Button_page1, "res/public/1900000640_1.png")
	GUI:setContentSize(Button_page1, 34, 92)
	GUI:setIgnoreContentAdaptWithSize(Button_page1, false)
	GUI:Button_setTitleText(Button_page1, [[]])
	GUI:Button_setTitleColor(Button_page1, "#ffffff")
	GUI:Button_setTitleFontSize(Button_page1, 14)
	GUI:Button_titleEnableOutline(Button_page1, "#000000", 1)
	GUI:setChineseName(Button_page1, "背包_第一页_组合框")
	GUI:setAnchorPoint(Button_page1, 0.50, 0.50)
	GUI:setTouchEnabled(Button_page1, false)
	GUI:setTag(Button_page1, -1)

	-- Create PageText
	local PageText = GUI:Text_Create(Button_page1, "PageText", 20, 60, 18, "#ffffff", [[一]])
	GUI:Text_enableOutline(PageText, "#000000", 1)
	GUI:setChineseName(PageText, "背包_第一页_文本")
	GUI:setAnchorPoint(PageText, 0.50, 0.50)
	GUI:setTouchEnabled(PageText, false)
	GUI:setTag(PageText, -1)

	-- Create TouchSize
	local TouchSize = GUI:Layout_Create(Button_page1, "TouchSize", 0, 92, 33, 75, false)
	GUI:setChineseName(TouchSize, "背包_第一页_触摸区域")
	GUI:setAnchorPoint(TouchSize, 0.00, 1.00)
	GUI:setTouchEnabled(TouchSize, true)
	GUI:setTag(TouchSize, -1)

	-- Create Button_page2
	local Button_page2 = GUI:Button_Create(Panel_1, "Button_page2", -14, 334, "res/public/1900000641_1.png")
	GUI:Button_loadTexturePressed(Button_page2, "res/public/1900000640_1.png")
	GUI:Button_loadTextureDisabled(Button_page2, "res/public/1900000640_1.png")
	GUI:setContentSize(Button_page2, 34, 92)
	GUI:setIgnoreContentAdaptWithSize(Button_page2, false)
	GUI:Button_setTitleText(Button_page2, [[]])
	GUI:Button_setTitleColor(Button_page2, "#ffffff")
	GUI:Button_setTitleFontSize(Button_page2, 14)
	GUI:Button_titleEnableOutline(Button_page2, "#000000", 1)
	GUI:setChineseName(Button_page2, "背包_第二页_组合框")
	GUI:setAnchorPoint(Button_page2, 0.50, 0.50)
	GUI:setTouchEnabled(Button_page2, false)
	GUI:setTag(Button_page2, -1)

	-- Create PageText
	PageText = GUI:Text_Create(Button_page2, "PageText", 20, 60, 18, "#ffffff", [[二]])
	GUI:Text_enableOutline(PageText, "#000000", 1)
	GUI:setChineseName(PageText, "背包_第二页_文本")
	GUI:setAnchorPoint(PageText, 0.50, 0.50)
	GUI:setTouchEnabled(PageText, false)
	GUI:setTag(PageText, -1)

	-- Create TouchSize
	TouchSize = GUI:Layout_Create(Button_page2, "TouchSize", 0, 92, 33, 75, false)
	GUI:setChineseName(TouchSize, "背包_第二页_触摸区域")
	GUI:setAnchorPoint(TouchSize, 0.00, 1.00)
	GUI:setTouchEnabled(TouchSize, true)
	GUI:setTag(TouchSize, -1)

	-- Create Button_page3
	local Button_page3 = GUI:Button_Create(Panel_1, "Button_page3", -14, 258, "res/public/1900000641_1.png")
	GUI:Button_loadTexturePressed(Button_page3, "res/public/1900000640_1.png")
	GUI:Button_loadTextureDisabled(Button_page3, "res/public/1900000640_1.png")
	GUI:setContentSize(Button_page3, 34, 92)
	GUI:setIgnoreContentAdaptWithSize(Button_page3, false)
	GUI:Button_setTitleText(Button_page3, [[]])
	GUI:Button_setTitleColor(Button_page3, "#ffffff")
	GUI:Button_setTitleFontSize(Button_page3, 14)
	GUI:Button_titleEnableOutline(Button_page3, "#000000", 1)
	GUI:setChineseName(Button_page3, "背包_第三页_组合框")
	GUI:setAnchorPoint(Button_page3, 0.50, 0.50)
	GUI:setTouchEnabled(Button_page3, false)
	GUI:setTag(Button_page3, -1)

	-- Create PageText
	PageText = GUI:Text_Create(Button_page3, "PageText", 20, 60, 18, "#ffffff", [[三]])
	GUI:Text_enableOutline(PageText, "#000000", 1)
	GUI:setChineseName(PageText, "背包_第三页_文本")
	GUI:setAnchorPoint(PageText, 0.50, 0.50)
	GUI:setTouchEnabled(PageText, false)
	GUI:setTag(PageText, -1)

	-- Create TouchSize
	TouchSize = GUI:Layout_Create(Button_page3, "TouchSize", 0, 92, 33, 75, false)
	GUI:setChineseName(TouchSize, "背包_第三页_触摸区域")
	GUI:setAnchorPoint(TouchSize, 0.00, 1.00)
	GUI:setTouchEnabled(TouchSize, true)
	GUI:setTag(TouchSize, -1)

	-- Create Button_page4
	local Button_page4 = GUI:Button_Create(Panel_1, "Button_page4", -14, 209, "res/public/1900000641_1.png")
	GUI:Button_loadTexturePressed(Button_page4, "res/public/1900000640_1.png")
	GUI:Button_loadTextureDisabled(Button_page4, "res/public/1900000640_1.png")
	GUI:setContentSize(Button_page4, 34, 92)
	GUI:setIgnoreContentAdaptWithSize(Button_page4, false)
	GUI:Button_setTitleText(Button_page4, [[]])
	GUI:Button_setTitleColor(Button_page4, "#ffffff")
	GUI:Button_setTitleFontSize(Button_page4, 14)
	GUI:Button_titleEnableOutline(Button_page4, "#000000", 1)
	GUI:setChineseName(Button_page4, "背包_第四页_组合框")
	GUI:setAnchorPoint(Button_page4, 0.50, 0.50)
	GUI:setTouchEnabled(Button_page4, false)
	GUI:setTag(Button_page4, -1)
	GUI:setVisible(Button_page4, false)

	-- Create PageText
	PageText = GUI:Text_Create(Button_page4, "PageText", 20, 60, 18, "#ffffff", [[四]])
	GUI:Text_enableOutline(PageText, "#000000", 1)
	GUI:setChineseName(PageText, "背包_第四页_文本")
	GUI:setAnchorPoint(PageText, 0.50, 0.50)
	GUI:setTouchEnabled(PageText, false)
	GUI:setTag(PageText, -1)

	-- Create TouchSize
	TouchSize = GUI:Layout_Create(Button_page4, "TouchSize", 0, 92, 33, 75, false)
	GUI:setChineseName(TouchSize, "背包_第四页_触摸区域")
	GUI:setAnchorPoint(TouchSize, 0.00, 1.00)
	GUI:setTouchEnabled(TouchSize, true)
	GUI:setTag(TouchSize, -1)

	-- Create Button_page5
	local Button_page5 = GUI:Button_Create(Panel_1, "Button_page5", -14, 142, "res/public/1900000641_1.png")
	GUI:Button_loadTexturePressed(Button_page5, "res/public/1900000640_1.png")
	GUI:Button_loadTextureDisabled(Button_page5, "res/public/1900000640_1.png")
	GUI:setContentSize(Button_page5, 34, 92)
	GUI:setIgnoreContentAdaptWithSize(Button_page5, false)
	GUI:Button_setTitleText(Button_page5, [[]])
	GUI:Button_setTitleColor(Button_page5, "#ffffff")
	GUI:Button_setTitleFontSize(Button_page5, 14)
	GUI:Button_titleEnableOutline(Button_page5, "#000000", 1)
	GUI:setChineseName(Button_page5, "背包_第五页_组合框")
	GUI:setAnchorPoint(Button_page5, 0.50, 0.50)
	GUI:setTouchEnabled(Button_page5, false)
	GUI:setTag(Button_page5, -1)
	GUI:setVisible(Button_page5, false)

	-- Create PageText
	PageText = GUI:Text_Create(Button_page5, "PageText", 20, 60, 18, "#ffffff", [[五]])
	GUI:Text_enableOutline(PageText, "#000000", 1)
	GUI:setChineseName(PageText, "背包_第五页_文本")
	GUI:setAnchorPoint(PageText, 0.50, 0.50)
	GUI:setTouchEnabled(PageText, false)
	GUI:setTag(PageText, -1)

	-- Create TouchSize
	TouchSize = GUI:Layout_Create(Button_page5, "TouchSize", 0, 92, 33, 75, false)
	GUI:setChineseName(TouchSize, "背包_第五页_触摸区域")
	GUI:setAnchorPoint(TouchSize, 0.00, 1.00)
	GUI:setTouchEnabled(TouchSize, true)
	GUI:setTag(TouchSize, -1)

	-- Create Button_close
	local Button_close = GUI:Button_Create(Panel_1, "Button_close", 540, 428, "res/public/1900000510.png")
	GUI:Button_loadTexturePressed(Button_close, "res/public/1900000511.png")
	GUI:Button_setScale9Slice(Button_close, 9, 8, 15, 13)
	GUI:Button_setTitleText(Button_close, [[]])
	GUI:Button_setTitleColor(Button_close, "#414146")
	GUI:Button_setTitleFontSize(Button_close, 14)
	GUI:Button_titleDisableOutLine(Button_close)
	GUI:setChineseName(Button_close, "背包_关闭按钮")
	GUI:setAnchorPoint(Button_close, 0.00, 0.00)
	GUI:setTouchEnabled(Button_close, true)
	GUI:setTag(Button_close, 8)
	TAGOBJ["8"] = Button_close

	-- Create Image_gold
	local Image_gold = GUI:Image_Create(Panel_1, "Image_gold", 25, 102, "res/private/bag_ui/bag_ui_mobile/1900015220.png")
	GUI:setChineseName(Image_gold, "背包_金币图片")
	GUI:setAnchorPoint(Image_gold, 0.50, 0.50)
	GUI:setTouchEnabled(Image_gold, true)
	GUI:setTag(Image_gold, 5)
	TAGOBJ["5"] = Image_gold

	-- Create Button_store_hero_bag
	local Button_store_hero_bag = GUI:Button_Create(Panel_1, "Button_store_hero_bag", 320, 110, "res/public/1900000652.png")
	GUI:Button_loadTexturePressed(Button_store_hero_bag, "res/public/1900000652_1.png")
	GUI:Button_loadTextureDisabled(Button_store_hero_bag, "res/public/1900000652_1.png")
	GUI:setContentSize(Button_store_hero_bag, 120, 29)
	GUI:setIgnoreContentAdaptWithSize(Button_store_hero_bag, false)
	GUI:Button_setTitleText(Button_store_hero_bag, [[存入英雄背包]])
	GUI:Button_setTitleColor(Button_store_hero_bag, "#ffffff")
	GUI:Button_setTitleFontSize(Button_store_hero_bag, 18)
	GUI:Button_titleEnableOutline(Button_store_hero_bag, "#000000", 1)
	GUI:setChineseName(Button_store_hero_bag, "背包_存入英雄背包_按钮")
	GUI:setAnchorPoint(Button_store_hero_bag, 0.50, 0.50)
	GUI:setTouchEnabled(Button_store_hero_bag, true)
	GUI:setTag(Button_store_hero_bag, 17)
	GUI:setVisible(Button_store_hero_bag, false)
	TAGOBJ["17"] = Button_store_hero_bag

	-- Create ScrollView_items
	local ScrollView_items = GUI:ScrollView_Create(Panel_1, "ScrollView_items", 24, 452, 500, 320, 1)
	GUI:ScrollView_setInnerContainerSize(ScrollView_items, 500.00, 320.00)
	GUI:setChineseName(ScrollView_items, "背包_物品列表")
	GUI:setAnchorPoint(ScrollView_items, 0.00, 1.00)
	GUI:setTouchEnabled(ScrollView_items, true)
	GUI:setTag(ScrollView_items, -1)

	-- Create Panel_addItems
	local Panel_addItems = GUI:Layout_Create(Panel_1, "Panel_addItems", 24, 452, 500, 320, false)
	GUI:setChineseName(Panel_addItems, "背包_添加物品层")
	GUI:setAnchorPoint(Panel_addItems, 0.00, 1.00)
	GUI:setTouchEnabled(Panel_addItems, true)
	GUI:setTag(Panel_addItems, 10)
	TAGOBJ["10"] = Panel_addItems

	-- Create list
	local list = GUI:ListView_Create(Panel_1, "list", 309, 46, 440, 64, 2)
	GUI:ListView_setGravity(list, 5)
	GUI:ListView_setItemsMargin(list, 5)
	GUI:setAnchorPoint(list, 0.50, 0.50)
	GUI:setTouchEnabled(list, true)
	GUI:setTag(list, 0)

	-- Create item_bg_1
	local item_bg_1 = GUI:Image_Create(list, "item_bg_1", 0, 7, "res/public/1900000651.png")
	GUI:setContentSize(item_bg_1, 50, 50)
	GUI:setIgnoreContentAdaptWithSize(item_bg_1, false)
	GUI:setAnchorPoint(item_bg_1, 0.00, 0.00)
	GUI:setTouchEnabled(item_bg_1, false)
	GUI:setTag(item_bg_1, 0)

	-- Create add
	local add = GUI:Button_Create(item_bg_1, "add", 25, 25, "res/public/add.png")
	GUI:Button_setTitleText(add, [[]])
	GUI:Button_setTitleColor(add, "#FFFFFF")
	GUI:Button_setTitleFontSize(add, 18)
	GUI:Button_titleEnableOutline(add, "#000000", 1)
	GUI:setAnchorPoint(add, 0.50, 0.50)
	GUI:setTouchEnabled(add, true)
	GUI:setTag(add, 0)

	-- Create item_bg_2
	local item_bg_2 = GUI:Image_Create(list, "item_bg_2", 55, 7, "res/public/1900000651.png")
	GUI:setContentSize(item_bg_2, 50, 50)
	GUI:setIgnoreContentAdaptWithSize(item_bg_2, false)
	GUI:setAnchorPoint(item_bg_2, 0.00, 0.00)
	GUI:setTouchEnabled(item_bg_2, false)
	GUI:setTag(item_bg_2, 0)

	-- Create add
	add = GUI:Button_Create(item_bg_2, "add", 25, 25, "res/public/add.png")
	GUI:Button_setTitleText(add, [[]])
	GUI:Button_setTitleColor(add, "#FFFFFF")
	GUI:Button_setTitleFontSize(add, 18)
	GUI:Button_titleEnableOutline(add, "#000000", 1)
	GUI:setAnchorPoint(add, 0.50, 0.50)
	GUI:setTouchEnabled(add, true)
	GUI:setTag(add, 0)

	-- Create item_bg_3
	local item_bg_3 = GUI:Image_Create(list, "item_bg_3", 110, 7, "res/public/1900000651.png")
	GUI:setContentSize(item_bg_3, 50, 50)
	GUI:setIgnoreContentAdaptWithSize(item_bg_3, false)
	GUI:setAnchorPoint(item_bg_3, 0.00, 0.00)
	GUI:setTouchEnabled(item_bg_3, false)
	GUI:setTag(item_bg_3, 0)

	-- Create add
	add = GUI:Button_Create(item_bg_3, "add", 25, 25, "res/public/add.png")
	GUI:Button_setTitleText(add, [[]])
	GUI:Button_setTitleColor(add, "#FFFFFF")
	GUI:Button_setTitleFontSize(add, 18)
	GUI:Button_titleEnableOutline(add, "#000000", 1)
	GUI:setAnchorPoint(add, 0.50, 0.50)
	GUI:setTouchEnabled(add, true)
	GUI:setTag(add, 0)

	-- Create item_bg_4
	local item_bg_4 = GUI:Image_Create(list, "item_bg_4", 165, 7, "res/public/1900000651.png")
	GUI:setContentSize(item_bg_4, 50, 50)
	GUI:setIgnoreContentAdaptWithSize(item_bg_4, false)
	GUI:setAnchorPoint(item_bg_4, 0.00, 0.00)
	GUI:setTouchEnabled(item_bg_4, false)
	GUI:setTag(item_bg_4, 0)

	-- Create add
	add = GUI:Button_Create(item_bg_4, "add", 25, 25, "res/public/add.png")
	GUI:Button_setTitleText(add, [[]])
	GUI:Button_setTitleColor(add, "#FFFFFF")
	GUI:Button_setTitleFontSize(add, 18)
	GUI:Button_titleEnableOutline(add, "#000000", 1)
	GUI:setAnchorPoint(add, 0.50, 0.50)
	GUI:setTouchEnabled(add, true)
	GUI:setTag(add, 0)

	-- Create item_bg_5
	local item_bg_5 = GUI:Image_Create(list, "item_bg_5", 220, 7, "res/public/1900000651.png")
	GUI:setContentSize(item_bg_5, 50, 50)
	GUI:setIgnoreContentAdaptWithSize(item_bg_5, false)
	GUI:setAnchorPoint(item_bg_5, 0.00, 0.00)
	GUI:setTouchEnabled(item_bg_5, false)
	GUI:setTag(item_bg_5, 0)

	-- Create add
	add = GUI:Button_Create(item_bg_5, "add", 25, 25, "res/public/add.png")
	GUI:Button_setTitleText(add, [[]])
	GUI:Button_setTitleColor(add, "#FFFFFF")
	GUI:Button_setTitleFontSize(add, 18)
	GUI:Button_titleEnableOutline(add, "#000000", 1)
	GUI:setAnchorPoint(add, 0.50, 0.50)
	GUI:setTouchEnabled(add, true)
	GUI:setTag(add, 0)

	-- Create item_bg_6
	local item_bg_6 = GUI:Image_Create(list, "item_bg_6", 275, 7, "res/public/1900000651.png")
	GUI:setContentSize(item_bg_6, 50, 50)
	GUI:setIgnoreContentAdaptWithSize(item_bg_6, false)
	GUI:setAnchorPoint(item_bg_6, 0.00, 0.00)
	GUI:setTouchEnabled(item_bg_6, false)
	GUI:setTag(item_bg_6, 0)

	-- Create add
	add = GUI:Button_Create(item_bg_6, "add", 25, 25, "res/public/add.png")
	GUI:Button_setTitleText(add, [[]])
	GUI:Button_setTitleColor(add, "#FFFFFF")
	GUI:Button_setTitleFontSize(add, 18)
	GUI:Button_titleEnableOutline(add, "#000000", 1)
	GUI:setAnchorPoint(add, 0.50, 0.50)
	GUI:setTouchEnabled(add, true)
	GUI:setTag(add, 0)

	-- Create item_bg_7
	local item_bg_7 = GUI:Image_Create(list, "item_bg_7", 330, 7, "res/public/1900000651.png")
	GUI:setContentSize(item_bg_7, 50, 50)
	GUI:setIgnoreContentAdaptWithSize(item_bg_7, false)
	GUI:setAnchorPoint(item_bg_7, 0.00, 0.00)
	GUI:setTouchEnabled(item_bg_7, false)
	GUI:setTag(item_bg_7, 0)

	-- Create add
	add = GUI:Button_Create(item_bg_7, "add", 25, 25, "res/public/add.png")
	GUI:Button_setTitleText(add, [[]])
	GUI:Button_setTitleColor(add, "#FFFFFF")
	GUI:Button_setTitleFontSize(add, 18)
	GUI:Button_titleEnableOutline(add, "#000000", 1)
	GUI:setAnchorPoint(add, 0.50, 0.50)
	GUI:setTouchEnabled(add, true)
	GUI:setTag(add, 0)

	-- Create item_bg_8
	local item_bg_8 = GUI:Image_Create(list, "item_bg_8", 385, 7, "res/public/1900000651.png")
	GUI:setContentSize(item_bg_8, 50, 50)
	GUI:setIgnoreContentAdaptWithSize(item_bg_8, false)
	GUI:setAnchorPoint(item_bg_8, 0.00, 0.00)
	GUI:setTouchEnabled(item_bg_8, false)
	GUI:setTag(item_bg_8, 0)

	-- Create add
	add = GUI:Button_Create(item_bg_8, "add", 25, 25, "res/public/add.png")
	GUI:Button_setTitleText(add, [[]])
	GUI:Button_setTitleColor(add, "#FFFFFF")
	GUI:Button_setTitleFontSize(add, 18)
	GUI:Button_titleEnableOutline(add, "#000000", 1)
	GUI:setAnchorPoint(add, 0.50, 0.50)
	GUI:setTouchEnabled(add, true)
	GUI:setTag(add, 0)

	-- Create Text_1
	local Text_1 = GUI:Text_Create(Panel_1, "Text_1", 77, 50, 18, "#00ff00", [[   安全箱]])
	GUI:Text_setFontName(Text_1, "fonts/font10.ttf")
	GUI:setIgnoreContentAdaptWithSize(Text_1, false)
	GUI:Text_setTextAreaSize(Text_1, 20, 100)
	GUI:Text_enableOutline(Text_1, "#000000", 2)
	GUI:setAnchorPoint(Text_1, 0.50, 0.50)
	GUI:setTouchEnabled(Text_1, false)
	GUI:setTag(Text_1, 0)

	-- Create Button_1
	local Button_1 = GUI:Button_Create(Panel_1, "Button_1", 324, 111, "res/public/1900001022.png")
	GUI:Button_setTitleText(Button_1, [[整 理]])
	GUI:Button_setTitleColor(Button_1, "#FFFFFF")
	GUI:Button_setTitleFontSize(Button_1, 18)
	GUI:Button_titleEnableOutline(Button_1, "#000000", 1)
	GUI:setAnchorPoint(Button_1, 0.50, 0.50)
	GUI:setTouchEnabled(Button_1, true)
	GUI:setTag(Button_1, 0)

	-- Create Button_2
	local Button_2 = GUI:Button_Create(Panel_1, "Button_2", 431, 111, "res/public/1900001022.png")
	GUI:Button_setTitleText(Button_2, [[仓 库]])
	GUI:Button_setTitleColor(Button_2, "#FFFFFF")
	GUI:Button_setTitleFontSize(Button_2, 18)
	GUI:Button_titleEnableOutline(Button_2, "#000000", 1)
	GUI:setAnchorPoint(Button_2, 0.50, 0.50)
	GUI:setTouchEnabled(Button_2, true)
	GUI:setTag(Button_2, 0)

	ui.update(__data__)
	return Scene
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
