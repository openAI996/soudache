module ("CL", package.seeall)

--- 用于获取多个children id描述
--- 比如: 背景1,背景2,背景3
--- 则用  lualib:GetConcatArrTbStr(3, "背景", ",")
---@param count number 需要链接的数量
---@param prefix string 每个str的前缀其后缀默认为序号
---@param cat string 连接符 默认为","
function CL:GetConcatArrTbStr(count, prefix, cat)
    local tempTb = {}
    for i=1, count do
        tempTb[i] = prefix..i
    end
    if cat then
        return table.concat(tempTb, cat)
    else
        return table.concat(tempTb, ",")
    end
end

--- 获取客户端类型
--- @return number 1:pc 2:mobile
function CL:GetClientType()
    return SL:GetMetaValue("CURRENT_OPERMODE")
end

--- 设置控件尺寸大小
--- @param obj userdata 控件对象
--- @param width number 宽度
--- @param height number 高度
function CL:WndSetSize(obj, width, height)
    GUI:setContentSize(obj, width, height)
end

--- 强制引导
--- @param obj userdata 控件对象
--- @param parentObj userdata 父控件对象
--- @param desc string 引导描述
function CL:Guide(parentObj, objId, desc)
    local testData
    if objId then
        local childObj = GUI:GetWindow(parentObj, objId)
        testData = {guideWidget = childObj, guideParent = parentObj, guideDesc = desc, isForce = true ,dir = 1}
    else
        testData = {guideWidget = parentObj, guideParent = parentObj, guideDesc = desc, isForce = true ,dir = 1}
    end
    
    local testGuide = ssr.GuideTask.new(testData)
    testGuide:Start()
end

--- 自定义输出
--- @param str string 输出内容
function CL:print(...)
    SL:release_print(...)
end

-- --- 添加红点
-- --- @param obj userdata 控件对象
-- --- @param offsetX number 偏移量X
-- --- @param offsetY number 偏移量Y
-- function CL:AddRedPoint(parentObj, objId, offsetX, offsetY)
--     offsetX = offsetX or 0
--     offsetY = offsetY or 0
--     local offset = { x=offsetX, y=offsetY }
--     if objId then
--         local childObj = GUI:GetWindow(parentObj, objId)
--         if childObj then
--             SL:CreateRedPoint(childObj, offset)
--         end
--     else
--         SL:CreateRedPoint(parentObj, offset)
--     end
-- end

--无限参数调用
function unpack(t, i, n)
    t = t or {}
    i = i or 1
    n = n or #t
    if i <= n then
        return t[i], unpack(t, i + 1, n)
    end
end

function CL:AutoItemShowCenter(_handle,item_tb,x,y,width,itemBgkPath,effect_tb,itemSize,gap)
    local posX = x + (width - (itemSize)*(#item_tb) - gap*(#item_tb-1))/2
    for i=1,#item_tb do
        local item_data = {}
        item_data.index = item_tb[i].id
        item_data.look  = true
        item_data.bgVisible = false
        item_data.count = item_tb[i][2]
        item_data.color = 250
        item_data.noMouseTips = false
        item_data.itemScale = 0.5
        
        local _Handle = GUI:Image_Create(_handle, "scroll_down_item_bgk_"..i,posX,y , itemBgkPath)
        if _Handle ~= nil then
            GUI:setAnchorPoint(_Handle, 0, 1)
            GUI:setContentSize(_Handle, {width = itemSize, height = itemSize})
            --ssr.GUI:setContentSize(_Handle, {width = 210, height = 460})
        end
        local _itemHandle = GUI:ItemShow_Create(_handle, "scroll_down_item_"..i, posX, y, item_data)
        if _itemHandle ~= nil then
            GUI:setAnchorPoint(_itemHandle, 0, 1)
            GUI:setContentSize(_Handle, {width = itemSize, height = itemSize})
        end
        
        local _EffectHandle = GUI:Effect_Create(_handle, "effect"..i, posX+effect_tb[2], y+effect_tb[3], 0, effect_tb[1], 0, 0, 3, 1)
        if _EffectHandle then
            GUI:setScale(_EffectHandle, effect_tb[4])
        end
        posX = posX + itemSize + gap
    end
end
---创建一个物品框自适应居中
---@param _Handle number 父节点
---@param ID string 控件id
---@param x number x坐标
---@param y number y坐标
---@param posX number x偏移量
---@param posY number y偏移量
---@param item_data table 物品数据
---@return number 物品框句柄

function CL:ItemShow_Create(_Handle,ID, x, y, posX, posY, item_data)
    local _itemHandle = nil
    x = x or 0
    y = y or 0

    _itemHandle = GUI:ItemShow_Create(_Handle, ID, x, y, item_data)
    if _itemHandle  then
        GUI:setAnchorPoint(_itemHandle,0.5,0.5)
    end
    --创建一个自适应布局让物品居中
    return _itemHandle
end

---物品data
---@param _Handle number 父节点
---@param ID string 控件id
---@param x number x坐标
---@param y number y坐标
---@param w number 宽
---@param h number 高度
---@param data table 道具数据{id，名字，数量}
---@param path string 道具背景路径
---@param posx number x坐标
---@param posy number y坐标
function CL:ItemData(_GUIHandle,ID,x,y,w,h,data,path)
    local _ItemShowParent = GUI:Layout_Create(_GUIHandle, ID, x, y, w, h)
        if _ItemShowParent then
        local item_tb = data
        for i=1,#item_tb do
            local item_data = {}
            item_data.index = item_tb[i][1]
            item_data.look  = true
            item_data.bgVisible = false
            item_data.count = item_tb[i][3]
            item_data.color = 250
            item_data.noMouseTips = false
            item_data.itemScale = 0.5
            --SL:release_print(CL:ItemCount(item_tb[i][2]))
            local _Handle = GUI:Image_Create(_ItemShowParent, "scroll_down_item_bgk_"..i,0,0 , path)
            if _Handle ~= nil then
            end


            local pos = GUI:getContentSize(_Handle)
            --local _itemHandle = CL:ItemShow_Create(_Handle, "item", pos.width/2, pos.height/2,12,15, item_data)
            --if _itemHandle  then
            --    GUI:setTouchEnabled(_itemHandle,true)
            --end

            local _itemHandle = CL:ItemShow_Create(_Handle, "scroll_down_item_", pos.width/2, pos.height/2,0,0, item_data)
            if _itemHandle  then
                GUI:setTouchEnabled(_itemHandle,true)
            end
        end
    end 
    return _ItemShowParent
end

---添加一个红点
---@param _GUIHandle userdata 控件对象
---@param _numberX number X偏移
---@param _numberY number Y偏移
---@return boolean 是否创建成功
function CL:AddRedPoint(_GUIHandle, _numberX, _numberY)
    if not GUI:Win_IsNotNull(_GUIHandle) then
        SL:release_print("待创建红点的控件为空。")
        return false
    end

    if GUI:GetWindow(_GUIHandle, "红点容器") then
        SL:release_print("待创建红点的控件红点已存在。")
        return false
    end

    local numberX, numberY = tonumber(_numberX) or 0, tonumber(_numberY) or 0
    local _RedPointParent = GUI:Layout_Create(_GUIHandle, "红点容器", numberX, numberY, 20, 20)
    if _RedPointParent then
        local _RedPointGUIHandle = GUI:Image_Create(_RedPointParent, "红点", 0, 0, "res/public/all/red_point.png")
        if _RedPointGUIHandle then
            GUI:setAnchorPoint(_RedPointGUIHandle, 0.5, 0.5)
            GUI:runAction(_RedPointGUIHandle,
                    GUI:ActionRepeatForever(
                            GUI:ActionSequence(
                                    GUI:ActionScaleTo(0.5, 0.5),
                                    GUI:ActionScaleTo(0.5, 1)
                            )
                    )
            )

            -- local _EffectGUIHandle = GUI:Effect_Create(_RedPointGUIHandle, "特效", 0, 20, 0, tonumber(52010), 0, 0, 0, 1)
            -- if _EffectGUIHandle then
            --     GUI:setScale(_EffectGUIHandle, 0.5)
            -- end
        end
    end

    return true
end
---删除红点
---@param _GUIHandle userdata 控件对象
function CL:DelRedPoint(_GUIHandle)
    if _GUIHandle then
        local _Handle = GUI:GetWindow(_GUIHandle, "红点容器")
        if _Handle then
            GUI:removeFromParent(_Handle)
        end
    end

end

---添加一个感叹号
---@param _GUIHandle userdata 控件对象
---@param _numberX number X偏移
---@param _numberY number Y偏移
---@return boolean 是否创建成功
function CL:AddRedPointEx(_GUIHandle, _numberX, _numberY)
    if not GUI:Win_IsNotNull(_GUIHandle) then
        SL:release_print("待创建红点的控件为空。")
        return false
    end

    if GUI:GetWindow(_GUIHandle, "红点容器") then
        SL:release_print("待创建红点的控件红点已存在。")
        return false
    end

    local numberX, numberY = tonumber(_numberX) or 0, tonumber(_numberY) or 0
    local _RedPointParent = GUI:Layout_Create(_GUIHandle, "感叹号容器", numberX, numberY, 20, 20)
    if _RedPointParent then
        local _RedPointGUIHandle = GUI:Image_Create(_RedPointParent, "感叹号", 0, 0, "res/public/all/g.png")
        if _RedPointGUIHandle then
            GUI:setAnchorPoint(_RedPointGUIHandle, 0.5, 0.5)
            GUI:runAction(_RedPointGUIHandle,
                    GUI:ActionRepeatForever(
                            GUI:ActionSequence(
                                    GUI:ActionScaleTo(0.5, 0.5),
                                    GUI:ActionScaleTo(0.5, 1)
                            )
                    )
            )

            -- local _EffectGUIHandle = GUI:Effect_Create(_RedPointGUIHandle, "特效", 0, 20, 0, tonumber(52010), 0, 0, 0, 1)
            -- if _EffectGUIHandle then
            --     GUI:setScale(_EffectGUIHandle, 0.5)
            -- end
        end
    end

    return true
end

---建物品用环形的方式展示，可选择是否转动
---@param _Parent number 父窗口句柄
---@param _ID string 环形物品布局ID
---@param _ItemData table 环形物品数据
---@param _CenterX number 环形物品布局中心点X坐标
---@param _CenterY number 环形物品布局中心点Y坐标
---@param _Radius number 环形物品布局半径
---@param _Angle number 环形物品布局角度
---@param _ItemOffsetX number 环形物品布局偏移X
---@param _ItemOffsetY number 环形物品布局偏移Y
---@param _ItemW number 环形物品布局宽度
---@param _ItemH number 环形物品布局高度
---@param _ItemRes string 环形物品布局背景资源
---@param _playFlag boolean 是否播放动画
function CL.CreateCircleItemShow(_Parent, _ID, _ItemData, _CenterX, _CenterY, _Radius, _Angle, _ItemOffsetX, _ItemOffsetY, _ItemW, _ItemH, _ItemRes, _playFlag)
    local _mainLayout = GUI:Layout_Create(_Parent, _ID, _CenterX, _CenterY, _Radius*2, _Radius*2)
    if _mainLayout then
        GUI:setAnchorPoint(_mainLayout, 0.5, 0.5)
        --GUI:Layout_setBackGroundColor(_mainLayout, "#555555")
        --GUI:Layout_setBackGroundColorType(_mainLayout, 1)
        local _numberINDEX = 1
        local numberAngle = _Angle
        for i=1, #_ItemData do
            local _layoutHandle = GUI:Layout_Create(_mainLayout, "选取容器"..i, 0, 0, _ItemW, _ItemH)
            if _layoutHandle then
                --GUI:Layout_setBackGroundColor(_layoutHandle, "#ff5555")
                --GUI:Layout_setBackGroundColorType(_layoutHandle, 1)
                GUI:setAnchorPoint(_layoutHandle, 0.5, 0.5)
                GUI:Image_Create(_layoutHandle, "物品背景", 0, 0, _ItemRes)
                local setData = {
                    index = _ItemData[i].id,
                    look  = true,
                    count = _ItemData[i][2],
                }
                local _ItemShowHandle = GUI:ItemShow_Create(_layoutHandle, "sItemShow", _ItemOffsetX, _ItemOffsetY, setData)
                --local eHandle = GUI:Effect_Create(_layoutHandle, "播放特效", -6, 82, 0, 7222)
                --if eHandle then
                --    GUI:setScale(eHandle, 1)
                --end
                local numberDegree = math.rad(numberAngle + (_numberINDEX - 1) * 360 / #_ItemData)
                local numberX = _Radius * math.sin(numberDegree) + _Radius
                local numberY = _Radius * math.cos(numberDegree) + _Radius
                if numberX and numberY then
                    GUI:setPosition(_layoutHandle, numberX, numberY)
                end
                _numberINDEX = _numberINDEX + 1
            end
        end
        if _playFlag then
            local function __animTimer(_TimerNode)
                if _mainLayout then
                    local _Parent = _mainLayout
                    if _Parent then
                        _Angle = _Angle + 0.5
                        if _Angle == 360 then
                            _Angle = 0
                        end

                        local _numberINDEX = 1
                        for i=1, #_ItemData do
                            local _GUIHandle = GUI:GetWindow(_Parent, "选取容器" .. i)
                            if _GUIHandle then
                                local numberDegree = math.rad(_Angle + (_numberINDEX - 1) * 360 / #_ItemData)
                                local numberX = _Radius * math.sin(numberDegree) + _Radius
                                local numberY = _Radius * math.cos(numberDegree) + _Radius
                                if numberX and numberY then
                                    GUI:setPosition(_GUIHandle, numberX, numberY)
                                end

                                _numberINDEX = _numberINDEX + 1
                            end
                        end
                    end
                end
            end
            if GUI:WndAddTimer(_Parent, "旋转", 0.001, __animTimer) then

            end
        end
    end
end

---序列化Lua变量
---@param _objectParam any 待序列化的数据
---@return string 序列化完成后的字符串
function CL:Serialize(_objectParam)
    local str = ""

    local TYPE = type(_objectParam)
    if TYPE == "number" then
        str = str .. _objectParam
    elseif TYPE == "boolean" then
        str = str .. tostring(_objectParam)
    elseif TYPE == "string" then
        str = str .. string.format("%q", _objectParam)
    elseif TYPE == "table" then
        str = str .. "{\n"

        for k, v in pairs(_objectParam) do
            str = str .. "[" .. CL:Serialize(k) .. "]=" .. CL:Serialize(v) .. ",\n"
        end

        local metatable = getmetatable(_objectParam)
        if metatable ~= nil and type(metatable.__index) == "table" then
            for k, v in pairs(metatable.__index) do
                str = str .. "[" .. CL:Serialize(k) .. "]=" .. CL:Serialize(v) .. ",\n"
            end
        end

        str = str .. "}"
    elseif TYPE == "nil" then
        return nil
    else
        SL:release_print("can not serialize a " .. TYPE .. " type.")
    end

    return str
end


---反序列化Lua字符串
---@param _stringParam string 待反序列化的字符串
---@return any 反序列化后的数据
function CL:Deserialize(_stringParam)
    local stringParam = tostring(_stringParam)
    local TYPE = type(stringParam)
    if TYPE == "nil" or stringParam == "" then
        return nil
    elseif TYPE == "number" or TYPE == "string" or TYPE == "boolean" then
        stringParam = tostring(stringParam)
    else
        SL:release_print("can not deserialize a " .. TYPE .. " type.")
    end

    stringParam = "return " .. stringParam
    local func = load(stringParam)
    if func == nil then
        return nil
    end

    return func()
end


function CL:GetAttrColorName(tb)
    local color = 250
    local name = ""
    local type = 1
    local tb = attr_score_tb[tb[1]]
    if tb == nil then
        return color,name
    end

    if tb.scolor ~= nil then
        color = tb.scolor
    end

    name = tb.name
    type = tb.type
 
    return color,name,type
end

--将时间戳计算为字符型时间（例：20小时5分10秒）
function CL:CalcStrTime(times,type)
    if type==nil then type=1 end
    local seconds =times%60
    local min = math.floor(times/60)%60
    local hour = math.floor(times/60/60)%24
    local day = math.floor(times/60/60/24)
    ---SL:release_print(min.." "..hour.." "..day)
    if type==1 then
        local str=""
        --if tonumber(seconds) > 0 and tonumber(seconds) < 60 then
        str = ""..seconds.."秒" ..str
        --end
        --if tonumber(min - hour*60)>0 and tonumber(min - hour*60)<60 then
        str = ""..(min).."分"..str
        --end
        --if tonumber(hour - day*24)>0 and tonumber(hour - day*60)<24 then
        str = (hour).."时"..str
        --end
        if tonumber(day) > 0 then
            str = day.."天"..str
        end
        return str
    else
        return day,hour,min,seconds
    end
    return nil
end

--将时间戳转换为字符型时间
function CL:Time2Str(timestamp,symbol)
    if symbol==nil then symbol="/" end
    return os.date("%Y"..symbol.."%m"..symbol.."%d %H:%M:%S", timestamp)
end

---获取控件所有子节点表
---@GUIHandle 控件对象
function CL:GetAllChildren(widget)
    local children = {}  -- 用于存储所有子节点
    -- 获取当前控件的直接子节点
    local directChildren = GUI:getChildren(widget)
    for _, child in ipairs(directChildren) do
        table.insert(children, child)  -- 将直接子节点添加到children表中
        -- 递归调用GetAllChildren函数，获取当前子节点的所有子节点
        local subChildren = CL:GetAllChildren(child)
        -- 将子节点的子节点添加到children表中
        for _, subChild in ipairs(subChildren) do
            table.insert(children, subChild)
        end
    end
    return children  -- 返回所有子节点的表
end
---深拷贝
---@param tab table
function CL:CopyTable(tab)
    function _copy(obj)
        if type(obj) ~= "table" then
            return obj
        end

        local new_table = {}
        for k, v in pairs(obj) do
            new_table[_copy(k)] = _copy(v)
        end

        return setmetatable(new_table, getmetatable(obj))
    end
    return _copy(tab)
end
---获得BUFF剩余时间
--@param buffID buffID
function CL:GetBuffTime(buffID)
    local actorID = SL:GetMetaValue("MAIN_ACTOR_ID")
    local actorBuff = SL:GetMetaValue("ACTOR_BUFF_DATA_BY_ID", actorID, buffID)
    if actorBuff == nil then
        return nil
    end

    return actorBuff.endTime - os.time()
end

---将字符串中的任意字符分成组
---@param _stringParam string 字符串参数
---@return table 字符组
function CL:splitString(_stringParam)
    local tableParam = {}
    local stringMatch = "[%z\1-\127\194-\244][\128-\191]*"
    for i, _ in string.gmatch(_stringParam, stringMatch) do
        table.insert(tableParam, i)
    end

    return tableParam
end

---通用提示
---@param _GUIHandle 父句柄
---@param data 提示数据 {str = {"内容","内容","内容"},x,y,h = 高,w = 宽}
function CL:ShowTips(_GUIHandle,data)
    local size = GUI:getContentSize(_GUIHandle)
    local Panel_1 = GUI:Layout_Create(_GUIHandle, "Panel_1", 0.00, 0.00, size.width , size.height, false)
    GUI:setAnchorPoint(Panel_1, 0.00, 0.00)
    GUI:setTouchEnabled(Panel_1, true)
    GUI:addOnClickEvent(Panel_1, function()
        GUI:removeFromParent(Panel_1)
    end)

    -- Create Panel_1
    local _GUIHandle = GUI:Layout_Create(Panel_1, "Panel_2", data.x , data.y - #data.str * 25 + 25 , data.w, data.h, false)
    GUI:Layout_setBackGroundColorType(_GUIHandle, 1)
    GUI:Layout_setBackGroundColor(_GUIHandle, "#000000")
    GUI:Layout_setBackGroundColorOpacity(_GUIHandle, 255)
    GUI:setAnchorPoint(_GUIHandle, 0.00, 0.00)
    GUI:setOpacity(_GUIHandle, 100)
    GUI:setTouchEnabled(_GUIHandle, true)
    GUI:addOnClickEvent(_GUIHandle, function()
        GUI:removeFromParent(Panel_1)
    end)

    for i=1,#data.str do
        _Handle = GUI:Text_Create(Panel_1, "Text_"..i, data.x + data.w/2, data.y - (i-1)*25 , 20, "#ffffff", data.str[i])
        GUI:Text_setFontName(_Handle, "fonts/font110.ttf")
        if data.center == 1 then
            GUI:setAnchorPoint(_Handle, 0.5, 0.00)
        else
            GUI:setPositionX(_Handle, data.x + 10)
            GUI:setAnchorPoint(_Handle, 0, 0)
        end
        GUI:setTouchEnabled(_Handle, false)
        GUI:setTag(_Handle, 0)
    end

end
---乱序表
---@param table
function CL:RandomTable(table)
    local temp_tb = SL:CopyData(table)
    local len = #temp_tb
    for i=1,len do
        local index = math.random(1,len)
        temp_tb[i],temp_tb[index] = temp_tb[index],temp_tb[i]
    end
    return temp_tb
end

local bindMoney = {
    [21]    =  {name = "元宝",               [0] = {22,"绑定元宝"},           [1] = {21,"元宝"}},
    [22]    =  {name = "绑定元宝",            [0] = {22,"绑定元宝"},           [1] = {21,"元宝"}},
    [1]    =  {name = "金币",                [0] = {3,"绑定金币"},            [1] = {1,"金币"}},
    [3]    =  {name = "绑定金币",             [0] = {3,"绑定金币"},            [1] = {1,"金币"}},
    [23]    =  {name = "灵符",               [0] = {24,"绑定灵符"},           [1] = {23,"灵符"}},
    [24]    =  {name = "绑定灵符",            [0] = {24,"绑定灵符"},           [1] = {23,"灵符"}},
    ["元宝"]    =  {[1] = {22,"绑定元宝"},           [2] = {21,"元宝"}},
    ["绑定元宝"]    =  {[1] = {22,"绑定元宝"},           [2] = {21,"元宝"}},
    ["金币"]    =  {[1] = {3,"绑定金币"},           [2] = {1,"金币"}},
    ["仙晶"]    =  {[1] = {3,"绑定金币"},           [2] = {1,"金币"}},
    ["绑定灵符"]    =  {[1] = {24,"绑定通宝"},          [2] = {23,"通宝"}},
    ["灵符"]    =  {[1] = {24,"绑定通宝"},          [2] = {23,"通宝"}},
}
---获得道具数量
---@param item 道具ID 或 名字
function CL:ItemCount(item)
    local num = 0
    if bindMoney[item] ~= nil then
        for i=1,#bindMoney[item] do
            num = num + SL:GetMetaValue("ITEM_COUNT", bindMoney[item][i][1])
        end
    else
        num = SL:GetMetaValue("ITEM_COUNT", item)
    end
    return num
end

---大数值转化
---@param num number 数值
function CL:numberToBig(num)
    num = tonumber(num)
    local str = num
    if num >= 100000000 then
        str = math.floor(num/100000000).."亿"
    elseif num >= 100000 then
        str = math.floor(num/10000).."万"
    end
    return str
end


---创建称号展示图标
---@param parent userdata 父控件对象
---@param ID string 控件id
---@param x number x
---@param y number y
---@param data table 扩展信息
---@return userdata 称号图标对象
function CL:TitleShow_Create(parent, ID, x, y, data)
    if not ID then
        SL:Print("[GUI ERROR] GUI:TitleShow_Create can't find ID")
        return nil
    end

    if not parent then
        SL:Print("[GUI ERROR] GUI:TitleShow_Create can't find parent", ID)
        return nil
    end

    if SL._DEBUG and parent ~= -1 and parent:getChildByName(ID) then
        SL:Print("[GUI ERROR] GUI:TitleShow_Create ID is exists", ID)
        return nil
    end

    if not data then
        SL:Print("[GUI ERROR] GUI:TitleShow_Create data is nil", ID)
        return nil
    end

    local booleanIsPc = SL:GetMetaValue("IS_PC_PLAY_MODE")
    local widget = GUI:Widget_Create(parent, ID, x - 5, y -5, 60, 60)
    if widget == nil then
        SL:Print("[GUI ERROR] GUI:TitleShow_Create widget create failed", ID)
        return nil
    end

    GUI:setTouchEnabled(widget, true)
    local res = SL:GetMetaValue("TITLE_IMAGE", data.id)
    local _ImageGUIHandle = GUI:Image_Create(widget, "img", 30, 30, res)
    if _ImageGUIHandle then
        GUI:setAnchorPoint(_ImageGUIHandle, 0.5, 0.5)
    end

    if booleanIsPc then
        local function showTips()
            local titleId = data.id
            local time = data.time
            local tableTITLEData = {}
            tableTITLEData.id = titleId
            tableTITLEData.pos = GUI:getWorldPosition(widget)
            tableTITLEData.type = 1
            tableTITLEData.time = time
            SL:OpenTitleTipsUI(tableTITLEData)
        end

        GUI:addMouseMoveEvent(widget,
                {
                    onEnterFunc = function()
                        if not data then
                            return
                        end
                        if not SL:GetMetaValue("TOUCH_STATE") then
                            showTips()
                        end
                    end,
                    onLeaveFunc = function()
                        SL:CloseTitleTipsUI()-- 关闭称号提示界面
                    end
                })
    else
        local function showTips()
            local titleId = data.id
            local time = data.time
            local tableTITLEData = {}
            tableTITLEData.id = titleId
            tableTITLEData.pos = GUI:getWorldPosition(widget)
            tableTITLEData.type = 1
            tableTITLEData.time = time
            SL:OpenTitleTipsUI(tableTITLEData)
        end

        local function delayCallback()
            if widget._doubleState then
                showTips()
                widget._doubleState = false
            end
        end

        widget._doubleState = false
        GUI:addOnClickEvent(widget, function()
            if not widget._doubleState then
                widget._doubleState = true
                SL:scheduleOnce(widget, delayCallback, SLDefine.CLICK_DOUBLE_TIME)
            else
                widget._doubleState = false
            end
        end)
    end

    return widget
end

--- 功能：获取表中的最大值或最小值
--- 参数：
---   tbl - 要处理的表（假设表中元素都是数字）
---   mode - 模式，"max" 表示求最大值，"min" 表示求最小值 不填默认为 "min"
--- 返回值：表中的最大值或最小值，如果表为空则返回 nil
function CL:GetExtremeValue(tbl, mode)
    mode = mode or "min"
    -- 检查表是否为空
    if next(tbl) == nil then
        return nil
    end

    -- 初始化结果变量
    local result

    -- 遍历表中的所有元素
    for _, value in ipairs(tbl) do
        -- 确保元素是数字
        if type(value) == "number" then
            -- 第一次赋值
            if result == nil then
                result = value
            else
                -- 根据模式判断是取大还是取小
                if mode == "max" and value > result then
                    result = value
                elseif mode == "min" and value < result then
                    result = value
                end
            end
        end
    end

    return result
end

return CL