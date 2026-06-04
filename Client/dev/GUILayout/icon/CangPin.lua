CangPin = {}
CangPin.Name = "CangPinFrame"
CangPin.configCache = SL:Require("GUILayout/cfgcsv/cfg_CangPin", true)
CangPin.config = {}
CangPin.page = 1


---把导表配置整理成 type1/type2/type3 三层结构，客户端只用于显示
for k, sceneConfig in pairs(CangPin.configCache) do
    if type(k) == "number" and type(sceneConfig.type) == "table" then
        local currentTable = CangPin.config
        local qualityTable = nil
        for num, typeValue in ipairs(sceneConfig.type) do
            if currentTable[typeValue] == nil then
                currentTable[typeValue] = {}
            end

            currentTable = currentTable[typeValue]
            if num == 2 then
                qualityTable = currentTable
            end
        end

        currentTable.name = sceneConfig.name
        currentTable.attr = sceneConfig.attr
        currentTable.attrName = sceneConfig.attrName
        if sceneConfig.suit ~= nil and qualityTable ~= nil then
            qualityTable.suit = sceneConfig.suit
            qualityTable.suitName = sceneConfig.suitName
        end
    end
end

---服务端打开界面时同步玩家藏品数据
function CangPin.receiveMessage(msgData)
    CangPin.data = msgData or {}
    CangPin.page = CangPin.getValidPage(nil)
    CangPin.main()
end

---创建藏品界面
function CangPin.main()
    local _GUIHandle = GUI:GetWindow(nil, CangPin.Name)
    if _GUIHandle ~= nil then
        GUI:Win_Close(_GUIHandle)
        return ""
    end

    local _Parent = GUI:Win_Create(CangPin.Name, 0, 0, screen_W, screen_H, true, false, true, true)
    if _Parent then
        GUI:Win_SetMainHide(_Parent, false)
        GUI:Win_SetZPanel(_Parent)
        GUI:Win_SetESCClose(_Parent, true)
        GUI:Win_SetSwallowRightMouseTouch(_Parent, true)
    end

    local _ImgHandle = GUI:Layout_Create(_Parent, "mask", 0, 0, screen_W, screen_H)
    if _ImgHandle then
        GUI:setTouchEnabled(_ImgHandle, true)
        GUI:Layout_setBackGroundColorType(_ImgHandle, 1)
        GUI:Layout_setBackGroundColor(_ImgHandle, "#000000")
        GUI:setOpacity(_ImgHandle, 150)
        GUI:addOnClickEvent(_ImgHandle, function()
            CangPin.close()
        end)
    end

    GUI:LoadExport(_ImgHandle, "icon/CangPinUI.lua")
    _GUIHandle = GUI:GetWindow(_ImgHandle, "bgk")
    if _GUIHandle then
        GUI:setAnchorPoint(_GUIHandle, 0.5, 0.5)
        GUI:setPosition(_GUIHandle, screen_W / 2, screen_H / 2)
    end

    local _Handle = GUI:GetWindow(_GUIHandle, "close")
    if _Handle then
        GUI:addOnClickEvent(_Handle, function()
            CangPin.close()
        end)
    end

    CangPin.update()
end

---刷新页签、品质列表、收录状态和属性进度
function CangPin.update()
    local _Parent = GUI:GetWindow(nil, CangPin.Name.."/mask/bgk")
    if _Parent == nil then
        return ""
    end

    CangPin.page = CangPin.getValidPage(CangPin.page)
    CangPin.updateTabs(_Parent)
    CangPin.updateQualityList(_Parent, CangPin.page)
end

---刷新顶部页签选中状态，类型数量从配置自动读取
function CangPin.updateTabs(parent)
    local top = GUI:GetWindow(parent, "top")
    if top == nil then
        return ""
    end

    GUI:removeAllChildren(top)
    local typeList = CangPin.getTypeList()
    for i = 1, #typeList do
        CangPin.createTabButton(top, typeList[i])
    end
end

---创建一个顶部类型页签
function CangPin.createTabButton(parent, type1)
    local state = 1
    if CangPin.page == type1 then
        state = 2
    end

    local button = GUI:Button_Create(parent, "Button_"..type1, 75, 19, "res/public/cangpin/tab_"..type1..state..".png")
    GUI:Button_setTitleText(button, [[]])
    GUI:Button_setTitleColor(button, "#ffffff")
    GUI:Button_setTitleFontSize(button, 16)
    GUI:Button_titleEnableOutline(button, "#000000", 1)
    GUI:setAnchorPoint(button, 0.50, 0.50)
    GUI:setTouchEnabled(button, true)
    GUI:setTag(button, 0)

    local tabIndex = type1
    GUI:addOnClickEvent(button, function()
        CangPin.page = tabIndex
        CangPin.update()
    end)
end

---刷新品质列表，品质数量从当前类型配置自动读取
function CangPin.updateQualityList(parent, type1)
    local qualityList = GUI:GetWindow(parent, "qualityList")
    if qualityList == nil then
        return ""
    end

    GUI:removeAllChildren(qualityList)
    local qualityKeys = CangPin.getQualityList(type1)
    for i = 1, #qualityKeys do
        CangPin.createQualityRow(qualityList, type1, qualityKeys[i])
    end
end

---创建一个品质行
function CangPin.createQualityRow(parent, type1, type2)
    local row = GUI:Layout_Create(parent, "row_"..type2, 398, 48, 796, 96, false)
    GUI:setAnchorPoint(row, 0.50, 0.50)
    GUI:setTouchEnabled(row, false)
    GUI:setTag(row, 0)

    local rowBg = GUI:Image_Create(row, "bg", 0, 0, "res/public/cangpin/list.png")
    GUI:setAnchorPoint(rowBg, 0.00, 0.00)
    GUI:setTouchEnabled(rowBg, false)
    GUI:setTag(rowBg, 0)

    local quality = GUI:Image_Create(row, "quality", 57, 52, "res/public/cangpin/pj_"..type2..".png")
    GUI:setAnchorPoint(quality, 0.50, 0.50)
    GUI:setTouchEnabled(quality, false)
    GUI:setTag(quality, 0)

    local itemList = GUI:ListView_Create(row, "itemList", 367, 50, 526, 94, 2)
    GUI:ListView_setGravity(itemList, 5)
    GUI:ListView_setItemsMargin(itemList, 0)
    GUI:setAnchorPoint(itemList, 0.50, 0.50)
    GUI:setTouchEnabled(itemList, true)
    GUI:setTag(itemList, 0)

    local attr = GUI:Layout_Create(row, "attr", 736, 49, 112, 84, false)
    GUI:setAnchorPoint(attr, 0.50, 0.50)
    GUI:setTouchEnabled(attr, false)
    GUI:setTag(attr, 0)

    CangPin.updateQualityRow(row, type1, type2)
end

---刷新单个品质行
function CangPin.updateQualityRow(row, type1, type2)
    if row == nil then
        return ""
    end

    local itemList = GUI:GetWindow(row, "itemList")
    if itemList then
        GUI:removeAllChildren(itemList)
        local qualityConfig = CangPin.getQualityConfig(type1, type2)
        local itemKeys = CangPin.getItemList(type1, type2)
        if qualityConfig then
            for i = 1, #itemKeys do
                local type3 = itemKeys[i]
                CangPin.createItemCell(itemList, type1, type2, type3, qualityConfig[type3])
            end
        end
    end

    CangPin.updateAttr(row, type1, type2)
end

---创建一个藏品格子
function CangPin.createItemCell(parent, type1, type2, type3, itemConfig)
    local panel = GUI:Layout_Create(parent, "Panel_"..type3, 35, 45, 70, 90, false)
    GUI:setAnchorPoint(panel, 0.50, 0.50)
    GUI:setTouchEnabled(panel, false)
    GUI:setTag(panel, 0)

    local itemBg = GUI:Image_Create(panel, "item_bg", 35, 60, "res/public/cangpin/item.png")
    GUI:setAnchorPoint(itemBg, 0.50, 0.50)
    GUI:setTouchEnabled(itemBg, true)
    GUI:setTag(itemBg, 0)

    local itemData = {}
    itemData.index = SL:GetMetaValue("ITEM_INDEX_BY_NAME", itemConfig.name)
    itemData.look = true
    itemData.bgVisible = false
    itemData.count = 1
    itemData.color = 250
    itemData.noMouseTips = false
    local _itemHandle = CL:ItemShow_Create(itemBg, "item", 27, 27, 0, 0, itemData)
    if _itemHandle then
        GUI:setScale(_itemHandle, 0.8)
        GUI:setTouchEnabled(_itemHandle, true)
    end

    if CangPin.isCollected(type1, type2, type3) then
        local text = GUI:Text_Create(panel, "collected", 35, 15, 16, "#f6e6a7", "已收入")
        if text then
            GUI:Text_enableOutline(text, "#000000", 1)
            GUI:setAnchorPoint(text, 0.50, 0.50)
            GUI:setTouchEnabled(text, false)
            GUI:setTag(text, 0)
        end
    else
        local button = GUI:Button_Create(panel, "button", 35, 15, "res/public/cangpin/btn_shoulu.png")
        GUI:Button_setTitleText(button, [[]])
        GUI:setAnchorPoint(button, 0.50, 0.50)
        GUI:setTouchEnabled(button, true)
        GUI:setTag(button, 0)

        local clickType1 = type1
        local clickType2 = type2
        local clickType3 = type3
        GUI:addOnClickEvent(button, function()
            if CangPin.getItemConfig(clickType1, clickType2, clickType3) == nil then
                return ""
            end

            SL:SubmitForm("藏品_click", clickType1, clickType2, clickType3)
        end)
    end
end

---刷新右侧单件属性、全套属性和进度
function CangPin.updateAttr(row, type1, type2)
    local attrPanel = GUI:GetWindow(row, "attr")
    if attrPanel == nil then
        return ""
    end

    GUI:removeAllChildren(attrPanel)
    local qualityConfig = CangPin.getQualityConfig(type1, type2)
    local itemKeys = CangPin.getItemList(type1, type2)
    local firstItem = nil
    if qualityConfig and itemKeys[1] then
        firstItem = qualityConfig[itemKeys[1]]
    end

    local singleText = "无"
    if firstItem then
        singleText = CangPin.getAttrText(firstItem.attr, firstItem.attrName)
    end

    local suitText = "无"
    if qualityConfig and qualityConfig.suit then
        if qualityConfig.suitName ~= nil and qualityConfig.suitName ~= "" then
            suitText = qualityConfig.suitName
        else
            local attrName = "属性"
            if firstItem and firstItem.attrName then
                attrName = firstItem.attrName
            end
            suitText = CangPin.getAttrText(qualityConfig.suit, attrName)
        end
    end

    local progress = CangPin.getProgress(type1, type2)
    CangPin.createAttrText(attrPanel, "single", 12, 54, "#00ffff", singleText)
    CangPin.createAttrText(attrPanel, "suit", 12, 32, "#00ffff", suitText)
    CangPin.createAttrText(attrPanel, "progress", 12, 10, "#ff3333", progress.count.."/"..progress.max)
end

---创建属性说明文字
function CangPin.createAttrText(parent, name, x, y, color, text)
    local label = GUI:Text_Create(parent, name, x, y, 14, color, text)
    if label then
        GUI:Text_enableOutline(label, "#000000", 1)
        GUI:setAnchorPoint(label, 0.00, 0.50)
        GUI:setTouchEnabled(label, false)
        GUI:setTag(label, 0)
    end
    return label
end

---把属性配置转成界面显示文本
function CangPin.getAttrText(attrConfig, attrName)
    if attrConfig == nil or attrConfig[1] == nil then
        return "无"
    end

    attrName = attrName or "属性"
    local attrId = attrConfig[1][1]
    local value = attrConfig[1][2]
    local unit = ""
    if attrId == 235 then
        unit = "%"
    end

    return attrName.."+"..value..unit
end

---取得当前存在的一级类型列表
function CangPin.getTypeList()
    return CangPin.getNumberKeys(CangPin.config)
end

---取得合法页签，当前页不存在时取配置中的第一个类型
function CangPin.getValidPage(page)
    if CangPin.config[page] then
        return page
    end

    local typeList = CangPin.getTypeList()
    return typeList[1] or 1
end

---取得当前类型下的品质列表
function CangPin.getQualityList(type1)
    if CangPin.config[type1] == nil then
        return {}
    end

    return CangPin.getNumberKeys(CangPin.config[type1])
end

---取得当前品质下的藏品列表
function CangPin.getItemList(type1, type2)
    local qualityConfig = CangPin.getQualityConfig(type1, type2)
    if qualityConfig == nil then
        return {}
    end

    return CangPin.getNumberKeys(qualityConfig)
end

---提取表中的数字键并从小到大排序
function CangPin.getNumberKeys(data)
    local keys = {}
    if type(data) ~= "table" then
        return keys
    end

    for key, _ in pairs(data) do
        if type(key) == "number" then
            keys[#keys + 1] = key
        end
    end

    table.sort(keys, function(a, b)
        return a < b
    end)
    return keys
end

---取得品质配置
function CangPin.getQualityConfig(type1, type2)
    if CangPin.config[type1] == nil then
        return nil
    end

    return CangPin.config[type1][type2]
end

---取得单个藏品配置
function CangPin.getItemConfig(type1, type2, type3)
    local qualityConfig = CangPin.getQualityConfig(type1, type2)
    if qualityConfig == nil then
        return nil
    end

    return qualityConfig[type3]
end

---兼容服务端同步表的数字键和字符串键
function CangPin.getTableValue(data, key)
    if data == nil then
        return nil
    end

    return data[key] or data[tostring(key)]
end

---判断藏品是否已经收录
function CangPin.isCollected(type1, type2, type3)
    local var = CangPin.data and CangPin.data.var or {}
    local typeData = CangPin.getTableValue(var, type1)
    local qualityData = CangPin.getTableValue(typeData, type2)
    return CangPin.getTableValue(qualityData, type3) == 1
end

---取得服务端同步的进度，缺失时使用客户端配置兜底
function CangPin.getProgress(type1, type2)
    local progress = CangPin.data and CangPin.data.progress or {}
    local typeData = CangPin.getTableValue(progress, type1)
    local qualityData = CangPin.getTableValue(typeData, type2)
    if qualityData ~= nil then
        return qualityData
    end

    local max = 0
    local qualityConfig = CangPin.getQualityConfig(type1, type2)
    if qualityConfig then
        local itemKeys = CangPin.getItemList(type1, type2)
        max = #itemKeys
    end

    return {count = 0, max = max}
end

---服务端同步收录状态后刷新界面
function CangPin.syncData(msgData)
    CangPin.data = msgData or {}
    CangPin.update()
end

---关闭藏品界面
function CangPin.close()
    local _Parent = GUI:GetWindow(nil, CangPin.Name)
    if _Parent then
        GUI:Win_Close(_Parent)
    end
end

Message.RegisterClickMsg("藏品", CangPin)