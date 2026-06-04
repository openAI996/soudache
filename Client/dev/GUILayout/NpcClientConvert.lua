---@class 服务端打开界面的覆盖效果
NpcClientConvert = {

}

NpcClientConvert.config = {
    childrenList = {},
    GUIHandle = nil,
    ["ccui.Text"] = {
        _funcRefer = "dealTextHandle",
        ["字体1"] = {fontName="fonts/font10.ttf" },
        ["字体1"] = {fontName="fonts/t1.ttf" },
        ["字体8"] = {fontName="fonts/font80.ttf" },
        ["字体11"] = {fontName="fonts/font110.ttf" },
        ["字体12"] = {fontName="fonts/font120.ttf" },
        ["字体14"] = {fontName="fonts/font140.ttf" },
        ["字体15"] = {fontName="fonts/font150.ttf" },
        ["字体17"] = {fontName="fonts/font170.ttf" },
        ["字体18"] = {fontName="fonts/yrdzst.ttf" },
    },
    ["ccui.Layout"] = {

    },
    ["ccui.ImageView"] = {
       
    },
    ["ccui.LoadingBar"] = {

    },
    ["ccui.TextAtlas"] = {
        _funcRefer = "dealTextAtlasHandle",
        ["滚动数字"] = {},
    },
    ["ccui.Button"] = {
        
    },
}

--------------------------↓↓↓NPC界面打开↓↓↓--------------------------
SL:RegisterLUAEvent(LUA_EVENT_NPCLAYER_OPENSTATUS, "opennpc", function(status)
    local NPCLayerMediator = global.Facade:retrieveMediator("NPCLayerMediator")
    if NPCLayerMediator and NPCLayerMediator._layer then
        --GUI:runAction(NPCLayerMediator._layer,
        --        GUI:ActionSequence(
        --                GUI:ActionFadeIn(1)
        --        )
        --
        --)

        ---GUI:Timeline_FadeOut(NPCLayerMediator._layer, 0, nil)
        ---GUI:Timeline_FadeIn(NPCLayerMediator._layer, 0.5, nil)
        ---GUI:Timeline_Window2(NPCLayerMediator._layer)
        NpcClientConvert.config.childrenList = CL:GetAllChildren(NPCLayerMediator._layer)
        ---控件处理分发
        for _,v in pairs(NpcClientConvert.config.childrenList) do
            if GUI:getName(v) == "关闭弹窗" then
                GUI:Timeline_StopAll(NPCLayerMediator._layer)
            end
            
        end
        NpcClientConvert.init()
    end
end)

function NpcClientConvert.init()
    local NPCLayerMediator = global.Facade:retrieveMediator("NPCLayerMediator")
    if NPCLayerMediator and NPCLayerMediator._layer then
        NpcClientConvert.config.childrenList = CL:GetAllChildren(NPCLayerMediator._layer)
        ---控件处理分发
        for _,v in pairs(NpcClientConvert.config.childrenList) do

            local target = NpcClientConvert.config[tolua.type(v)]
            if target then
                local _funcRefer = target._funcRefer
                if _funcRefer then
                    local split = SL:Split(GUI:getName(v), "_")
                    local _data = target[split[1]]
                    if target[split[1]] then
                        NpcClientConvert[_funcRefer](v, _data)
                    end
                end
            end

        end
    end
end

---处理Text控件
function NpcClientConvert.dealTextHandle(_handle, _data)
    if _data.fontName then
        GUI:Text_setFontName(_handle, _data.fontName)
    end
end

---处理通用艺术字文本
function NpcClientConvert.dealTextAtlasHandle(_handle)
    local targetNum = tonumber(GUI:TextAtlas_getString(_handle))
    local function AnIsNumber(value)
        if value then
            local match = string.match(value, '^%d+$')
            if match then
                return true
            end
        end
        return false
    end

    if not AnIsNumber(targetNum) then
        return
    end
    
    local count = 0
    local incNum = targetNum/20
    GUI:runAction(_handle, GUI:ActionRepeatForever(
            GUI:ActionSequence(
                    GUI:DelayTime(0.033),
                    GUI:CallFunc(
                            function()
                                count = count + incNum
                                if count > targetNum then
                                    count = targetNum
                                    GUI:stopAllActions(_handle)
                                end
                                GUI:TextAtlas_setString(_handle, tostring(math.floor(count)))
                            end
                    )
            )
    ))
end
--npc对话
function NpcClientConvert.npcDialogue(data)
    local _Parent = SL:GetMetaValue("ACTOR_MOUNT_NODE", data[1])
    GUI:setScale(_Parent,0.73)

    local _ImgHandle = GUI:Layout_Create(_Parent, "Image_bg", 0, 100,50,50)
    if _ImgHandle then
        GUI:setTouchEnabled(_ImgHandle  , true)
        GUI:Layout_setBackGroundColorType(_ImgHandle, 1)
        GUI:Layout_setBackGroundColor(_ImgHandle, "#11ff00")
        GUI:setOpacity(_ImgHandle, 150)
    end

    local _TextHandle = GUI:Text_Create(_Parent, "tips", 30, 100, 16, "#41ffb7", data[2])
    if _TextHandle then
        GUI:setAnchorPoint(_TextHandle, 0.5, 0)
        GUI:Text_setTextHorizontalAlignment(_TextHandle, 1)
        GUI:setContentSize(_TextHandle, { width = 130, height = 50 })
    end
end

function NpcClientConvert.closeDrop()
    local _GUIHandle = MainAssist._ui.Image_24
    if _GUIHandle then
        local _Handle = GUI:GetWindow(_GUIHandle, "怪物掉落")
        if _Handle then
            GUI:removeFromParent(_Handle)
        end
    end
end

function NpcClientConvert.closeMiniMap()
    SL:CloseMiniMap()
    GUI:Win_CloseAll()
end

Message.RegisterClickMsg("NPC打开", NpcClientConvert)