chanChuXiaoHao = {}

-- 获取当前时间字符串，用于每轮开始时写入记录时间
local function _nowTime()
    return os.date("%Y-%m-%d %H:%M:%S", os.time())
end

-- 获取当前第几轮，作为产出/消耗JSON表的key
local function _getRound()
    return tostring(lualib:GetDBVar(VarCfg["第几轮"]))
end

-- 读取指定A变量中的JSON表，读取失败或为空时返回空表
function chanChuXiaoHao.getJson(var)
    local data = {}
    local str = lualib:GetDBVar(var)
    if str ~= nil and str ~= "" then
        local ok, result = pcall(json2tbl, str)
        if ok and type(result) == "table" then
            data = result
        end
    end

    return data
end

-- 保存指定A变量中的JSON表
function chanChuXiaoHao.setJson(var, data)
    data = data or {}
    lualib:SetDBVar(var, tbl2json(data))
    return ""
end

-- 获取全部产出记录
function chanChuXiaoHao.getOutput()
    return chanChuXiaoHao.getJson(VarCfg["产出记录"])
end

-- 获取全部消耗记录
function chanChuXiaoHao.getConsume()
    return chanChuXiaoHao.getJson(VarCfg["消耗记录"])
end

-- 获取当前轮产出记录
function chanChuXiaoHao.getOutputRound()
    local data = chanChuXiaoHao.getOutput()
    return data[_getRound()] or {}
end

-- 获取当前轮消耗记录
function chanChuXiaoHao.getConsumeRound()
    local data = chanChuXiaoHao.getConsume()
    return data[_getRound()] or {}
end

-- 初始化某一轮的产出/消耗记录，消耗记录额外包含元宝字段
local function _initRound(data, round, isConsume)
    data[round] = {
        time = _nowTime(),
        amount = 0,
    }

    if isConsume == 1 then
        data[round].yuanbao = 0
    end
end

-- 累加当前轮金额，消耗记录可同时累加元宝
local function _addAmount(var, amount, isStart, isConsume, yuanbao)
    local data = chanChuXiaoHao.getJson(var)
    local round = _getRound()
    if data[round] == nil or isStart == 1 then
        _initRound(data, round, isConsume)
    end

    data[round].amount = (tonumber(data[round].amount) or 0) + (tonumber(amount) or 0)
    if isConsume == 1 then
        data[round].yuanbao = (tonumber(data[round].yuanbao) or 0) + (tonumber(yuanbao) or 0)
    end

    chanChuXiaoHao.setJson(var, data)
    return ""
end

-- 产出记录事件入口，业务点通过EventCfg.onOutputRecord派发
local function _onOutputRecord(data)
    data = data or {}
    return _addAmount(VarCfg["产出记录"], data.amount, data.start, 0, 0)
end

-- 消耗记录事件入口，业务点通过EventCfg.onConsumeRecord派发
local function _onConsumeRecord(data)
    data = data or {}
    return _addAmount(VarCfg["消耗记录"], data.amount, data.start, 1, data.yuanbao)
end

GameEvent.add(EventCfg.onOutputRecord, _onOutputRecord, chanChuXiaoHao)
GameEvent.add(EventCfg.onConsumeRecord, _onConsumeRecord, chanChuXiaoHao)

return chanChuXiaoHao