--cjson=require "cjson"

--cjson.encode()--将table序列化为json字符串，返回值为string
--cjson.decode()--将json字符串序列化为table，返回值为table
moneyIcon = {[1]="public/moneyIcon/000001.png",[2]="public/moneyIcon/000002.png",[20]="public/moneyIcon/000020.png",[21]="public/moneyIcon/000021.png",[18] = "public/moneyIcon/000018.png"}
local bindMoney = {
    [1]    =  {name = "金币",                [0] = {3,"绑定金币"},            [1] = {1,"金币"}},
    [3]    =  {name = "绑定金币",             [0] = {3,"绑定金币"},            [1] = {1,"金币"}},
}
function GetTodayByZero()--获取当天零点的时间戳（秒）
    local cDateCurrectTime = os.date("*t")
    local cDateTodayTime = os.time({year=cDateCurrectTime.year, month=cDateCurrectTime.month, day=cDateCurrectTime.day, hour=0,min=0,sec=0})
    return cDateTodayTime
end

-- 返回string类型
function GetNowTime()--获取当前时间戳（秒）1970-现在
    return os.time();
end

-- 返回string类型
function GetDay()--获取当前天数
    return  os.date("%d")
end

-- 返回string类型
function GetWeek()--获取周：0 - 6 = 星期天 - 星期六
    return  os.date("%w")
end

-- 返回string类型
function GetYear()--获取年-》(2016)
    return  os.date("%Y")
end

-- 返回string类型
function GetMin()--获取分钟-》(48)[00 - 59]
    return  os.date("%M")
end

-- 返回string类型
function GetHour()--获取时-》(18)[00 - 23]
    return  os.date("%H")
end

-- 返回string类型
function GetMonth()--获取月-》(May)
    return  os.date("%m")
end

-- 返回string类型
function GetNowTimeStr()--获取当前时间-》(23:48:10)
    return  os.date("%X")
end



--将字符型时间转换为时间戳
function Str2Time(strTime)
    if type(strTime) ~= 'string' then PRINT('string2time: strTime is not a string') return 0 end
    local fun = string.gmatch( strTime, "%d+")
    local y = fun() or 0
    if y == 0 then PRINT('strTime is a invalid time string') return 0 end
    local m = fun() or 0
    if m == 0 then PRINT('strTime is a invalid time string') return 0 end
    local d = fun() or 0
    if d == 0 then PRINT('strTime is a invalid time string') return 0 end
    local H = fun() or 0
    local M = fun() or 0
    local S = fun() or 0
    return os.time({year=y, month=m, day=d, hour=H,min=M,sec=S})
end

--将字符型时间转换为时间表
function Str2TimeEx(strTime)
    if type(strTime) ~= 'string' then PRINT('string2time: strTime is not a string') return 0 end
    local fun = string.gmatch( strTime, "%d+")
    local y = fun() or 0
    if y == 0 then PRINT('strTime is a invalid time string') return 0 end
    local m = fun() or 0
    if m == 0 then PRINT('strTime is a invalid time string') return 0 end
    local d = fun() or 0
    if d == 0 then PRINT('strTime is a invalid time string') return 0 end
    local H = fun() or 0
    local M = fun() or 0
    local S = fun() or 0
    return {y,m,d,H,M,S}
end


--将时间戳转换为字符型时间
function Time2Str(timestamp,symbol)
    if symbol==nil then symbol="/" end
    return os.date("%Y"..symbol.."%m"..symbol.."%d %H:%M:%S", timestamp)
end

--获取字符串时间的差值:字符串时间，时间格式：Y-m-d或H:M:S或Y-m-d
function TimeDiff( strDateTime1,strDateTime2)
    return Str2Time(strDateTime2)-Str2Time(strDateTime1)
end

--取得当天0点的时间戳
function GetTodayTimeStamp()
    local cDateCurrectTime = os.date("*t")
    local cDateTodayTime = os.time({year=cDateCurrectTime.year, month=cDateCurrectTime.month, day=cDateCurrectTime.day, hour=0,min=0,sec=0})
    return cDateTodayTime
end

-- 获取密码
function GetCode()
    local code=0
    local year = tonumber(GetYear()) --年
    local month = tonumber(GetMonth()) --月
    local day = tonumber(GetDay()) -- 日
    local hour = tonumber(GetHour()) --小时
    local min = tonumber(GetMin()) --分钟
    code = (min*hour)+(min*min)+year+month+day
    return code
end

function print(...)
    release_print(...)
end
--function PRINT(...)
--    print(...)
--end
function getFileName(str)--获取文件名称
    local idx = str:match(".+()%.%w+$")
    if (idx) then
        return str:sub(1, idx - 1)
    else
        return str
    end
end
function  getFileSize(sourceFilePath)--获取文件大小
    local sourceFile, errorString = io.open(sourceFilePath, "rb")
    assert(sourceFile ~= nil, errorString)

    local len = sourceFile:seek("end")
    sourceFile:close()

    return len
end

function dup(object)--复制变量
    local lookup_table = {}
    local function _copy(object)
        if type(object) ~= "table" then
            return object
        elseif lookup_table[object] then
            return lookup_table[object]
        end
        local new_table = {}
        lookup_table[object] = new_table
        for key, value in pairs(object) do
            new_table[_copy(key)] = _copy(value)
        end
        return setmetatable(new_table, getmetatable(object))
    end
    return _copy(object)
end

function CopyFile(src, dst) --复制文件
    local src_file, err = io.open(src,"r")
    if (not src_file) then
        return false, err
    end
    local content = src_file:read("*a")
    src_file:close()
    local dst_file, err = io.open(dst, "w")
    if (not dst_file) then
        return false, err
    end
    dst_file:write(content)
    dst_file:close()
    return true
end

function contains(str, item)--比较两个字符串数组具有的相同元素(数组含有多个相同元素时,对比数组必须一一对应)
    local t = {}
    local l = {}
    local index = 0
    for i = 1, string.len(str) do
        table.insert(t, string.byte(string.sub(str, i, i)))
    end

    for i = 1, string.len(item) do
        table.insert(l, string.byte(string.sub(item, i, i)))
    end
    if #l > #t then
        return false
    end

    for k, v1 in pairs(t) do
        index = index + 1
        if v1 == l[1] then
            local iscontens = true
            for i = 1, #l do
                if t[index + i - 1] ~= l[i] then
                    iscontens = false
                end
            end
            if iscontens then
                return iscontens
            end
        end
    end
    return false
end
function trim(s)--去除字符串中的空格
    return (string.gsub(s, "^%s*(.-)%s*$", "%1"))
end
function drawnum(str)--提取字符串中的数字
    local res=str:gsub("%D+", "")
    return tonumber(res)
end
function readFile(fileName)--读取文件
    local f = assert(io.open(fileName, "r"))
    local content = f:read("*all")
    f:close()
    return content
end
function file_exists(path)--文件是否存在
    local file = io.open(path, "rb")
    if file then
        file:close()
    end
    return file ~= nil
end

function createLuaArray(length)--创建一个元素个数为length且初始值为0的顺序表
    local t = {}
    for i=1,length do
        t[i] = 0
    end
    return t
end
function table.nums(t)--获取哈希表大小。
    local count = 0
    for k, v in pairs(t) do
        count = count + 1
    end
    return count
end
function table.keys(hashtable)--获取表的键作为数组中的值。
    local keys = {}
    for k, v in pairs(hashtable) do
        keys[#keys + 1] = k
    end
    return keys
end
function table.values(hashtable)--获取表的值作为数组中的值
    local values = {}
    for k, v in pairs(hashtable) do
        values[#values + 1] = v
    end
    return values
end
function table.merge(dest, src)--合并table
    for k, v in pairs(src) do
        dest[k] = v
    end
end
function table.insertto(dest, src, begin)--在tabe的指定位置插入table
    begin = checkint(begin)
    if begin <= 0 then
        begin = #dest + 1
    end

    local len = #src
    for i = 0, len - 1 do
        dest[i + begin] = src[i + 1]
    end
end
function table.indexof(array, value, begin)--在table中查找指定值的下标
    for i = begin or 1, #array do
        if array[i] == value then return i end
    end
    return false
end
function table.keyof(hashtable, value)--在table中查找指定值的索引
    for k, v in pairs(hashtable) do
        if v == value then return k end
    end
    return nil
end
function table.removebyvalue(array, value, removeall)--删除table中指定值
    local c, i, max = 0, 1, #array
    while i <= max do
        if array[i] == value then
            table.remove(array, i)
            c = c + 1
            i = i - 1
            max = max - 1
            if not removeall then break end
        end
        i = i + 1
    end
    return c
end


function table.map(t, fn)--迭代表，将值和键传递给回调，使用回调的返回值作为新值。
    for k, v in pairs(t) do
        t[k] = fn(v, k)
    end
end
function table.walk(t, fn)--像table.map，但不改变原点值。
    for k,v in pairs(t) do
        fn(v, k)
    end
end
function table.filter(t, fn)--迭代表，将值和键传递给回调，如果回调返回false，则从表中删除它。
    for k, v in pairs(t) do
        if not fn(v, k) then t[k] = nil end
    end
end
function table.unique(t, bArray)--迭代表，自动删除重复值。
    local check = {}
    local n = {}
    local idx = 1
    for k, v in pairs(t) do
        if not check[v] then
            if bArray then
                n[idx] = v
                idx = idx + 1
            else
                n[k] = v
            end
            check[v] = true
        end
    end
    return n
end
function table.slice(array,begin,_end)--返回指定范围元素的数组。
    array = checktable(array)
    local t = {}
    if type(begin) == "number" and type(_end) =="number" and (_end >=begin)  then
        for pos = begin,(_end<=#array and _end or #array) do
            table.insert(t,array[pos])
        end
    elseif type(begin) =="number" and type(_end) =="nil" and begin <#array then
        for pos = begin, #array do
            table.insert(t,array[pos])
        end
    else
        for pos = 1, #array do
            table.insert(t,array[pos])
        end
    end
    return t
end
function table.reverse(array)--返回所有元素都反向的表格。
    array = checktable(array)
    if next(array) == nil then return array end
    local arr = {}
    for i=#array,1,-1 do
        table.insert(arr,array[i])
    end
    return arr
end
function string.split(input, delimiter)--按分隔符将字符串拆分成表格
    input = tostring(input)
    delimiter = tostring(delimiter)
    if (delimiter=='') then return false end
    local pos,arr = 0, {}
    -- for each divider found
    for st,sp in function() return string.find(input, delimiter, pos, true) end do
        table.insert(arr, string.sub(input, pos, st - 1))
        pos = sp + 1
    end
    table.insert(arr, string.sub(input, pos))
    return arr
end
function string.ltrim(input)--从字符串头中删除空白(空格\t \n \r)。
    return string.gsub(input, "^[ \t\n\r]+", "")
end
function string.rtrim(input)--从字符串尾部删除空白(空格\t \n \r)。
    return string.gsub(input, "[ \t\n\r]+$", "")
end
function string.trim(input)--从字符串头部和尾部删除空白(空格\t \n \r)。
    input = string.gsub(input, "^[ \t\n\r]+", "")
    return string.gsub(input, "[ \t\n\r]+$", "")
end
function string.ucfirst(input)--字符串的上半部分字符。
    return string.upper(string.sub(input, 1, 1)) .. string.sub(input, 2)
end
function string.utf8len(input)--从utf8字符串中获取字长。
    local left = string.len(input)
    local cnt  = 0
    local arr  = {0, 0xc0, 0xe0, 0xf0, 0xf8, 0xfc}
    while left > 0 do
        local tmp = string.byte(input, -left)
        local i   = #arr
        while arr[i] do
            if tmp >= arr[i] then
                left = left - i
                break
            end
            i = i - 1
        end
        cnt = cnt + 1
    end
    return cnt
end
function string.formatnumberthousands(num)--将值格式化为包含千分之一分隔符的字符串。
    local formatted = tostring(checknumber(num))
    local k
    while true do
        formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
        if k == 0 then break end
    end
    return formatted
end

--序列化
function serialize(obj)
    local text = ""
    local t = type(obj)
    if t == "number" then
        text = text .. obj
    elseif t == "boolean" then
        text = text .. tostring(obj)
    elseif t == "string" then
        text = text .. string.format("%q", obj)
    elseif t == "table" then
        text = text .. "{\n"

        for k, v in pairs(obj) do
            text = text .. "[" .. serialize(k) .. "]=" .. serialize(v) .. ",\n"
        end

        local metatable = getmetatable(obj)
        if metatable ~= nil and type(metatable.__index) == "table" then
            for k, v in pairs(metatable.__index) do
                text = text .. "[" .. serialize(k) .. "]=" .. serialize(v) .. ",\n"
            end
        end

        text = text .. "}"

    elseif t == "nil" then
        return nil
    else
        error("can not serialize a " .. t .. " type.")
    end

    return text
end

--反序列化
function deserialize(text)
    local t = type(text)
    if t == "nil" or text == "" then
        return nil
    elseif t == "number" or t == "string" or t == "boolean" then
        text = tostring(text)
    else
        error("can not unserialize a " .. t .. " type.")
    end

    text = "return " .. text

    local func = loadstring(text)
    if func == nil then return nil end
    return func()
end

--Lua--十进制转二进制
function dec_to_binary (data)
    local dst = ""
    local remainder, quotient

    --异常处理
    if not data then return dst end                 --源数据为空
    if not tonumber(data) then return dst end       --源数据无法转换为数字

    --如果源数据是字符串转换为数字
    if "string" == type(data) then
        data = tonumber(data)
    end

    while true do
        quotient = math.floor(data / 2)
        remainder = data % 2
        dst = dst..remainder
        data = quotient
        if 0 == quotient then
            break
        end
    end

    --翻转
    dst = string.reverse(dst)

    --补齐8位
    if 8 > #dst then
        for i = 1, 8 - #dst, 1 do
            dst = '0'..dst
        end
    end
    return dst
end

--Lua--二进制转十进制
function binary_to_dec (data)
    local dst = 0
    local tmp = 0

    --异常处理
    if not data then return dst end                 --源数据为空
    if not tonumber(data) then return dst end       --源数据无法转换为数字

    --如果源数据是字符串去除前面多余的0
    if "string" == type(data) then
        data = tostring(tonumber(data))
    end

    --如果源数据是数字转换为字符串
    if "number" == type(data) then
        data = tostring(data)
    end

    --转换
    for i = #data, 1, -1 do
        tmp = tonumber(data:sub(-i, -i))
        if 0 ~= tmp then
            for j = 1, i - 1, 1 do
                tmp = 2 * tmp
            end
        end
        dst = dst + tmp
    end
    return dst
end

--Lua--base64加密
function base64encode(data)
    local basecode = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
    local code = ""
    local dst = ""
    local tmp
    local encode_num = 0            --base64编码后的分组数，6字节为一组
    local num = 0                   --编码后后缀"="的个数
    local len = 1                   --用于统计编码个数，76个编码字符换行
    --异常处理
    if not data then return dst end                 --源数据为空
    --转换为二进制
    for i = 1, #data, 1 do
        tmp = data:byte(i)
        if 0 > tmp or 255 < tmp then
            return dst
        end
        code = code..dec_to_binary(tmp)
    end
    --字符串长度不能被3整除的情况
    num = 3 - #data % 3
    if 0 < num then
        for i = 1, num, 1 do
            code = code.."00000000"
        end
    end
    encode_num = #code / 6
    --开始编码
    for i = 1, #code, 6 do
        tmp = binary_to_dec(code:sub(i, i + 5))
        tmp = tmp + 1                                              --Lua下标从1开始，切记

        if 0 == num then                                           --无"="后缀的情况
            dst = dst..basecode:sub(tmp, tmp)
            len = len + 1
            encode_num = encode_num - 1
            --每76个字符换行
            if 76 == len then
                dst = dst.."\n"
                len = 1
            end
        end

        if 0 < num then                                            --有"="后缀的情况
            if encode_num == num and 1 == tmp then
                dst = dst..'='
                len = len + 1
                encode_num = encode_num - 1
                num = num - 1
                --每76个字符换行
                if 76 == len then
                    dst = dst.."\n"
                    len = 1
                end
            else
                dst = dst..basecode:sub(tmp, tmp)
                len = len + 1
                encode_num = encode_num - 1
                --每76个字符换行
                if 76 == len then
                    dst = dst.."\n"
                    len = 1
                end
            end
        end
    end
    return dst
end

--Lua--base64解密
function base64decode(data)
    local basecode = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
    local dst = ""
    local code = ""
    local tmp, index

    --异常处理
    if not data then return dst end                   --源数据为空

    data = data:gsub("\n", "")                        --去除换行符
    data = data:gsub("=", "")                         --去除'='

    for i = 1, #data, 1 do
        tmp = data:sub(i, i)
        index = basecode:find(tmp)
        if nil == index then
            return dst
        end
        index = index - 1
        tmp = dec_to_binary(index)
        code = code..tmp:sub(3)                       --去除前面多余的两个'00'
    end

    --开始解码
    for i = 1, #code, 8 do
        tmp = string.char(binary_to_dec(code:sub(i, i + 7)))
        if nil ~= tmp then
            dst = dst..tmp
        end
    end
    return dst
end

function strsplit(str, char)--分割字符串
    local splitRet = {}
    repeat
        local _Ret =
        string.gsub(
                str,
                "^(.-)%" .. char .. "(.-)$",
                function(a, b)
                    splitRet[#splitRet + 1] = a
                    str = b
                end
        )
        if str == _Ret then
            splitRet[#splitRet + 1] = _Ret
            break
        end
    until (str == "")
    return splitRet
end

-- function next(tb)
--     if type(tb)~="table" then
--         return false
--     end
--     for k ,v in pairs(tb) do
--         return true
--     end
--     return false
-- end


--瞬发调用函数
local function load_mainex_system(player,func)
    lualib:GoTo(player,func)
    return
end

--无限参数调用
local function unpack(t, i, n)
    i = i or 1
    n = n or #t
    if i <= n then
        return t[i], unpack(t, i + 1, n)
    end
end

module ("lualib", package.seeall)

function lualib:GetNowTimeStr()
    local data = os.date("*t")
    return string.format("%d年-%d月-%d日-%d时:%d分:%d秒", data.year, data.month, data.day, data.hour, data.min, data.sec)
end


--将时间戳计算为字符型时间（例：20小时5分10秒）
function lualib:CalcStrTime(time,type)
    if type==nil then type=1 end

    local seconds = time%60
    local min = math.floor(time/60)
    local hour = math.floor(min/60)
    local day = math.floor(hour/24)
    if type==1 then
        local str=""
        --if tonumber(seconds) > 0 and tonumber(seconds) < 60 then
        str = ""..seconds.."秒" ..str
        --end
        --if tonumber(min - hour*60)>0 and tonumber(min - hour*60)<60 then
        str = ""..(min - hour*60).."分"..str
        --end
        --if tonumber(hour - day*24)>0 and tonumber(hour - day*60)<24 then
        str = (hour - day*24).."时"..str
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

-- 开始挂机
function lualib:StarAttack(player)
    if not lualib:Player_IsPlayer(player) then return "" end
    lualib:SetInt(player,"_sys_挂机状态",1)
    startautoattack(player)
    return true
end
-- 停止挂机
function lualib:StopAttack(player)
    if not lualib:Player_IsPlayer(player) then return "" end
    lualib:SetInt(player,"_sys_挂机状态",0)
    stopautoattack(player)
    return true
end
-- 判断是否在挂机
function lualib:HasAttack(player)
    if not lualib:Player_IsPlayer(player) then return "" end
    if lualib:GetInt(player,"_sys_挂机状态")==1 then
        return true
    else
        return false
    end
end

--延时回调触发
function lualib:GoToEx(player,time,func)
    if not lualib:Player_IsPlayer(player) then
        return
    end
    delaygoto(player,time,func)
    return true
end

--延时回调触发调用瞬发
function lualib:GoToExs(player,time,func)
    if not lualib:Player_IsPlayer(player) then
        return
    end
    delaygoto(player,time,"load_mainex_system,"..func)
    return true
end

--瞬发
function lualib:GoTo(player,func)
    -- assert(player, "player 参数为错误")
    local split = strsplit(func,":")
    local file,func=split[1],split[2]
    local tbs = strsplit(func,",")
    func = tbs[1]
    include("QuestDiary/"..file..".lua")
    local split = strsplit(file,"/")
    local _,form = split[1],split[2]
    if form~=nil and form~="" then
        table.remove(tbs,1)
        if _G[form]==nil then
            _G["lualib"][func](player,unpack(tbs))
        else
            _G[form][func](player,unpack(tbs))
        end
    else
        _G["lualib"][func](player,unpack(tbs))
    end
    return true
end

--自定义排序
function lualib:GetRank(var,playflag,sortflag,count,param) --变量名   0-所有玩家 1-在线玩家 2-行会   0-升序，1-降序   获取的数据量为空或0取所有，取前几名 是否传奇变量

    local tb = {}
    if param==nil then
        tb=sorthumvar("_Int"..var,playflag,sortflag,count)
    else
        tb=sorthumvar(var,playflag,sortflag,count)
    end
    local tbs = {}
    if not tb then
        for i =1,count do
            tbs[i]={'',''}
        end
        return tbs
    end
    local a =1
    for i = 1,count*2,2 do
        if tb[i]~=nil then
            tbs[a]={tb[i],tb[i+1]}
        else
            tbs[a]={"",""}
        end
        a = a + 1
    end
    return tbs
end

-- 获取时装的状态
function lualib:GetFashion(player)
    if not lualib:Player_IsPlayer(player) then
        print("对象不是人物")
        return false
    end
    return getbaseinfo(player,58)
end

function lualib:Getid(name)  --获取道具idx
    local id = getstditeminfo(name,0)
    return id
end
function lualib:GetMoney(player,name)  --获取货币数量
    local count = 0
    if not lualib:Player_IsPlayer(player) then
        print("对象不是人物")
        return count
    end
    local id = lualib:Getid(name)
    count = lualib:GetMoneyID(player,id)
    return count
end

function lualib:SubMoney(player,name,num,txt) --扣除货币名称 扣除货币数量 扣除货币原因
    if not lualib:Player_IsPlayer(player) then return "" end
    local id = lualib:Getid(name)
    lualib:ChangeMoneyID(player,id,'-',num,txt,true)
    return true
end

function lualib:AddMoney(player,name,num,txt) --添加货币名称 添加货币数量 添加货币原因
    if not lualib:Player_IsPlayer(player) then return "" end
    local id = lualib:Getid(name)
    lualib:ChangeMoneyID(player,id,'+',num,txt,true)
    return true
end

function lualib:SetMoney(player,name,num,txt)  --设置货币名称 设置货币相等金额 设置货币原因
    if not lualib:Player_IsPlayer(player) then return "" end
    local id = lualib:Getid(name)
    lualib:ChangeMoneyID(player,id,'=',num,txt,true)
    return true
end

function lualib:ChangeMoneyID(player,id,type,num,desc,flag)
    --print(id,num,desc)
    changemoney(player,id,type,num,desc,flag)
    return true
end



local pos_tb = {
    [10] = 0,
    [11] = 0,
    [5] = 1,
    [6] = 1,
    [30]=2,
    [19]=3,
    [20]=3,
    [21]=3,
    [15]=4,
    [24]={5,6},
    [26]={5,6},
    [22]={7,8},
    [23]={7,8},
    [25]=9,
    [51]=9,
    [54]=10,
    [64]=10,
    [52]=11,
    [62]=11,
    [53]=12,
    [63]=12,
    [7]=12,
    [16]=13,
    [65]=14,
    [28]=15,
    [48]=16,
    [50]=55,
    [66]=17,
    [67]=17,
    [68]=18,
    [69]=18,
    [71]=19,
    [75]=20,
    [76]=20,
    [77]=20,
    [78]=21,
    [79]={22,23},
    [80]={22,23},
    [81]={24,25},
    [82]={24,25},
    [83]=26,
    [84]=27,
    [85]=27,
    [86]=28,
    [87]=28,
    [88]=29,
    [89]=29,
    [100]=30,
    [101]=31,
    [102]=32,
    [103]=33,
    [104]=34,
    [105]=35,
    [106]=36,
    [107]=37,
    [108]=38,
    [109]=39,
    [110]=40,
    [111]=41,
    [90]=42,
    [91]=43,
    [92]=44,
    [93]=45,
    [94]=46,
    [29]=2,
    [127] = 77,
    [128] = 78,
    [129] = 79,
    [130] = 80,
    [131] = 81,
    [132] = 82,
    [133] = 83,
    [134] = 84,
    [135] = 85,
    [136] = 86,
    [137] = 87,
    [138] = 88,
    [301] = 71,
    [302] = 72,
    [303] = 73,
    [304] = 74,
    [305] = 75,
    [306] = 76,
    [307] = 77,
    [308] = 78,
    [309] = 79,
    [310] = 80,
    [311] = 81,
    [312] = 82,
    [313] = 83,
    [401] = 84,
    [402] = 85,
    [403] = 86,
    [404] = 87,
    [405] = 88,
    [406] = 89,
    [501] = 90,
    [502] = 91,
    [503] = 92,
    [504] = 93,
    [505] = 94,
    [506] = 95,
    [507] = 96,
    [508] = 97,
    [509] = 98,
    [510] = 99,
    [511] = 100,
    [601] = 101,
    [602] = 102,
    [603] = 103,
    [604] = 104,
    [605] = 105,
    [606] = 106,
    [607] = 107,
    [608] = 108,
    [609] = 109,
    [610] = 110,
    [611] = 111,
    [612] = 112,
    [701] = 113,
    [702] = 114,
    [703] = 115,
    [704] = 116,
    [705] = 117,
    [613] = 119,
}
---获得装备位置
---@param player string --玩家
---@param itemname string --物品名字
function lualib:GetItemPos(player,itemname)  --玩家,物品名字
    if not lualib:Player_IsPlayer(player) then return "" end
    local id = getstditeminfo(itemname,2)
    ---print("装备位11："..itemname,id)
    if pos_tb[id] == nil then
       return false
    end
    ---print("装备位22："..id)
    local size = 0
    if type(pos_tb[id]) == "table" then
        size = pos_tb[id][1]
        for i=1,#pos_tb[id] do
            local item = linkbodyitem(player,pos_tb[id][i])
            if item ~= "0" then
                size = pos_tb[id][i]
                break
            end
        end
    else
        size = pos_tb[id]
    end
    --print("装备位："..size)
    return size
end

-- 获取物品基础信息
function lualib:ItemInto(item,id) --物品ID/物品名称  0:idx 1:名称 2:StdMode 3:Shape 4:重量 5:AniCount 6:最大持久 7:叠加数量 8:价格（price） 9:使用条件 10:使用等级 11:道具表自定义常量(29列) 12:道具表自定义常量（30列）
    return getstditeminfo(item,id)
end


--获取物品数量
function lualib:ItemCount(player,name)  --物品名字 bool==nil 获取全部 bool==true 获取身上 bool==false 获取背包
    if not lualib:Player_IsPlayer(player) then return "" end
    return getbagitemcount(player,name)
end

--在地图上刷出物品
function lualib:MapItem(map,x,y,r,item_n,item_m,time) --地图id  x坐标 y坐标 范围 道具名称 道具数量 多少秒可以拾取
    throwitem(nil,map,x,y,r,item_n,item_m,time,true,false,false,false)
    return true
end

--发送滚动消息
function lualib:SendMoveMsg(player,type,fcolor,bcolor,y,scroll,msg) --	模式，发送对象0-自己1-所有人2-行会3-当前地图4-组队  字体景色 背景色 Y坐标  滚动次数  消息内容
    sendmovemsg(player,type,fcolor,bcolor,y,scroll,msg)
    return true
end

--发送屏幕居中消息
function lualib:SendCenterMsg(player,fcolor,bcolor,msg,flag,time,func) --前景色 背景色 消息 发送对象：0=发送给自己；1=发送所有人物；2=发送行会；3=发送国家；4=发送当前地图；5=替换模式；7=组队 显示时间 触发函数
    sendcentermsg(player,fcolor,bcolor,msg,flag,time,func)
    return true
end

--发送聊天框消息
function lualib:SendMsg(player,int,Msg,Type,FColor,BColor,Time,SendName,SendId,y) --发送对象：1-自己，2-全服3-行会，4-当前地图，5-组队  消息内容  类型 1 系统频道;2 行会频道;3 组队频道;4 顶部跑马灯公告;5 屏幕跑马灯公告 可控制Y轴;6 聊天上方公告;8 固定聊天;9 systemtips;10 可控制xy坐标广播;11 屏幕跑马灯公告 系统公告;12 系统频道 带超链;13 系统公告缩放 前景色 背景色  倒计时  发送人 发送ID
    local int = tonumber(int)
    if Type ==9 then
        Msg= "<outline size='2'>"..Msg.."</outline>"
    end
    local msg_tb={}
    msg_tb.Msg=Msg
    msg_tb.FColor=tonumber(FColor)
    msg_tb.BColor=tonumber(BColor)
    msg_tb.Type=tonumber(Type)
    msg_tb.Time=tonumber(Time)
    msg_tb.SendName=SendName
    msg_tb.SendId=SendId
    msg_tb.y=y
    local msg =tbl2json(msg_tb)
    sendmsg(player,int,msg)
    return true
end

--弹出公告
function lualib:SendMsgNew(player,fcolor,bcolor,msg,type,tiem) --前景色 背景色 消息 	模式，发送对象0-自己1-所有人2-行会3-当前地图4-组队 时间
    sendmsgnew(player,fcolor,bcolor,msg,type,tiem)
    return true
end

--聊天框消息
function lualib:SendChatMsg(player,type,fcolor,bcolor,time,msg,par) --发送对象 0-所有人 1-自己 2-行会 3-当前地图 4-组队 前景色 背景色 显示时间 发送消息 	是否显示人物名称0-是1-否
    sendtopchatboardmsg(player,type,fcolor,bcolor,time,msg,par)
    return true
end

function lualib:Get_item_luck(player,item) --获取幸运数值
    if not lualib:Player_IsPlayer(player) then return "" end
    local int = getitemaddvalue(player,item,1,5)
    if int==nil then
        int = 0
    end
    return int
end

--function lualib:Set_item_luck(player,item,par) --设置幸运数值
--    if not lualib:Player_IsPlayer(player) then return "" end
--    local par = tonumber(par)
--    setitemaddvalue(player,item,1,5,par)
--    refreshitem(player,item)
--    return true
--end

---设置武器衣服外观
---@param player userdata
---@param item -物品对象
---@param par -外观值
function lualib:ChangeItemShape(player,item,par) --0:衣服 1:武器
    if not lualib:Player_IsPlayer(player) then
        return
    end
    changeitemshape(player,item,par)
    return true
end

--设置人物称谓
function lualib:Player_NameEx(player,str)
    if not lualib:Player_IsPlayer(player) then return "" end
    setranklevelname(player,str)
    return true
end

--获取玩家转生
function lualib:ReinLv(player)
    if not lualib:Player_IsPlayer(player) then
        return
    end
    return getbaseinfo(player,39)
end

--设置玩家转生
function lualib:SetReinLv(player,par)
    if not lualib:Player_IsPlayer(player) then
        return
    end
    setbaseinfo(player,39,par)
    GameEvent.push(EventCfg.onRein,player,par)
    recalcabilitys(player)
    return true
end

--复活玩家
function lualib:Realive(player)
    if not lualib:Player_IsPlayer(player) then return "" end
    realive(player)
    ---print("复活了，fuhuol")
    GameEvent.push(EventCfg.onRealive,player)
    return true
end

---发送邮件
---@param player string --玩家对象
---@param ID integer --邮件ID
---@param title string --邮件标题
---@param text string --邮件内容
---@param give table --附件内容{{物品ID,物品名字,数量,绑定状态},{物品ID,物品名字,数量,绑定状态}...}不可超过6个
function lualib:SendMail(player,ID,title,text,give)
    if checkkuafuserver(player) then
        local txt = {ID,title,text}
        kfbackcall(6,getbaseinfo(player, 2),tbl2json(txt),tbl2json(give))
        return true
    end

    local rewards = ""
    ---print(serialize( give))
    for i=1,#give do
        local bind = 0
        if give[i][3] then
            bind = give[i][3]
        end
        ---print(serialize(give[i]))
        ---print(give[i][1],give[i][2])
        if i == #give then
            rewards = rewards..give[i][1].."#"..give[i][2].."#"..bind
        else
            rewards = rewards..give[i][1].."#"..give[i][2].."#"..bind.."&"
        end
    end
    ---print(lualib:Name(player),rewards)
    sendmail("#"..lualib:Name(player),ID,title,text,rewards)
    return true
end

---发送邮件
---@param player string --玩家对象
---@param ID integer --邮件ID
---@param title string --邮件标题
---@param text string --邮件内容
---@param give table --附件内容{{物品ID,物品名字,数量,绑定状态},{物品ID,物品名字,数量,绑定状态}...}不可超过6个
function lualib:SendMailEx(player,ID,title,text,give)
    sendmail("#"..lualib:Name(player),ID,title,text,give)
    return true
end

---发送名字邮件
---@param name string --玩家对象
---@param ID integer --邮件ID
---@param title string --邮件标题
---@param text string --邮件内容
---@param give table --附件内容{{物品ID,物品名字,数量,绑定状态},{物品ID,物品名字,数量,绑定状态}...}不可超过6个
function lualib:SendMailToName(name,ID,title,text,give)
    local rewards = ""
    for i=1,#give do
        local bind = 0
        if give[i][3] then
            bind = give[i][3]
        end

        if i == #give then
            rewards = rewards..give[i][1].."#"..give[i][2].."#"..bind
        else
            rewards = rewards..give[i][1].."#"..give[i][2].."#"..bind.."&"
        end
    end

    sendmail("#"..name,ID,title,text,rewards)
    return true
end

--判断是不是人
function lualib:Player_IsPlayer(player)
    return isplayer(player)
end

--判断是否是怪物
function lualib:Player_IsMob(player)
    if isplaymon(player) or ismon(player) then
        return true
    else
        return false
    end

    return ismob(player)
end

--获取服务器玩家对象
function lualib:PlayerList()
    local t=getplayerlst()
    local tb={}
    for k, v  in ipairs(t) do
        tb[#tb+1]=v
    end
    return tb
end

--根据名称获取玩家对象
function lualib:GetPlayerByName(name)  --没有返回nil
    return getplayerbyname(name)
end

--根据id获取玩家对象
function lualib:GetPlayerById(id)
    return getplayerbyid(id)
end

--调用触发
function lualib:GotoLabel(player,info,func,range) --触发模式：0-小组成员触发1-行会成员触发2-当前地图的人物触发3-以自己坐标为中心指定范围人物触发  跳转后的接口(Qf.lua) 触发模式=3时指定的范围大小
    if not lualib:Player_IsPlayer(player) then return "" end
    gotolabel(player,info,func,range)
    return true
end

--获取怪物标识 标识(0-9) 注意返回string类型
function lualib:GetMobIndex(mob,var)
    local var =tostring(var)
    return  getcurrent(mob,var)
end

--设置怪物标识  标识(0-9) 注意返回string类型
function lualib:SetMobIndex(mob,var,par)
    local var,par=tostring(var),tostring(par)
    setcurrent(mob,var,par)
    return true
end

--获取玩家标识
function lualib:GetIndex(player,id)
    if not lualib:Player_IsPlayer(player) then
        return
    end
    return getflagstatus(player,id)
end

--设置玩家标识
function lualib:SetIndex(player,id,par)
    if not lualib:Player_IsPlayer(player) then
        return
    end
    setflagstatus(player,id,par)
    return true
end

--判断对象是否死亡
function lualib:Is_Die(player)
    if not lualib:Player_IsPlayer(player) then return "" end
    return getbaseinfo(player,0)
end

--查询人物名称
function lualib:CheckPlayerName(player,newname)
    if not lualib:Player_IsPlayer(player) then
        return
    end
    return queryhumnameexist(player,newname)
end

--更改玩家名字
function lualib:ChangePlayerName(player,newname)
    if not lualib:Player_IsPlayer(player) then
        return
    end
    return changehumname(player,newname)
end

function lualib:Name(player)  --获取玩家名称
    return getbaseinfo(player,1)
end

--获得怪物名字
---@param mob userdata 怪物对象
---@param type integer --0-怪物显示名 1-怪物表中配置的名字 2-实际展示的名字
function lualib:MobName(mob,type)
    type = type or 0
    return getbaseinfo(mob,1,type)
end

--function lualib:ItemName(player,item)  --获取道具名称
--    local name = ''
--    local id = getiteminfo(player,item,2)
--    name = getstditeminfo(id,1)
--    return name
--end

function lualib:Get_Critical_damage(player,item)  --获取暴击伤害
    if not lualib:Player_IsPlayer(player) then return "" end
    local int = getitemaddvalue(player,item,1,31)
    if int==nil then
        int = 0
    end
    return int
end

--设置进度条数据
function lualib:Set_Item_Bar(player,item,index,open,show,name,color,img,cur,max,lv) --进度条编号0-2 open:0关1开  show:0-不显示数值1-百分比，2-数字 进度条文本  进度条颜色，0~255 imgcount:1 cur:当前值 max:最大值 level:级别(0~65535)
    if not lualib:Player_IsPlayer(player) then return "" end
    local json_tb = {open=open,show=show,name=name,color=color,imgcount=img,cur=cur,max=max,level=lv}
    local str=tbl2json(json_tb)
    setcustomitemprogressbar(player,item,index,str)
    refreshitem(player,item)
    return true
end

--绑定装备自定义属性
function lualib:Set_ItemAbiltb(player,item,json)
    if not lualib:Player_IsPlayer(player) then return "" end
    if json ==nil then
        json=tbl2json({})
    end
    setitemcustomabil(player,item,json)
    refreshitem(player,item)
    return true
end

--获取装备自定义属性
function lualib:Get_ItemAbiltb(player,item,par,pos,var)
    if not lualib:Player_IsPlayer(player) then return "" end
end

--设置装备标识
function lualib:SetItemIndex(player,item,int,par) --支持（1-32)lua 传奇对应(1-32)
    if not lualib:Player_IsPlayer(player) then return "" end
    setitemaddvalue(player,item,3,int,par)
    return true
end

--获取装备标识
function lualib:GetItemIndex(player,item,int) --支持（1-32)lua 传奇对应(1-32)
    if not lualib:Player_IsPlayer(player) then return "" end
    return  getitemaddvalue(player,item,3,int)
end

--通知物品发送到前端刷新
function lualib:UpDataItem(player,item)
    if not lualib:Player_IsPlayer(player) then return "" end
    refreshitem(player,item)
    return true
end


function lualib:Set_Critical_damage(player,item,par) --设置暴击伤害
    if not lualib:Player_IsPlayer(player) then return "" end
    local par = tonumber(par)
    setitemaddvalue(player,item,1,31,par)
    refreshitem(player,item)
end

function lualib:Level(player)  --获取玩家等级
    return getbaseinfo(player,6)
end

function lualib:GetLevel(player)
    return lualib:Level(player)
end

function lualib:SetLevel(player,par)  --设置玩家等级
    if not lualib:Player_IsPlayer(player) then return "" end
    setbaseinfo(player,6,par)
    return true
end

function lualib:GetBagNum(player)  --获取背包空格子数量  注意：快捷栏的6个格子也会计算上！
    if not lualib:Player_IsPlayer(player) then return "" end
    return getbagblank(player) - 6
end

--设置行会人数上限
function lualib:SetFamilyPlayer(family,pars)  --行会对象  设置人数上限
    changeguildmemberlimit(family,pars)
    return true
end

--初始化行会自定义字符串变量
function lualib:FamilyStr(family,name,param)
    if param~= nil then
        iniguildvar(family,"string",name)
    else
        iniguildvar(family,"string", "_FamilyStr"..name)
    end
    return true
end

--初始化行会自定义数值型变量
function lualib:FamilyInt(family,name,param)
    if param~= nil then
        iniguildvar(family,"integer",name)
    else
        iniguildvar(family,"integer", "_FamilyInt"..name)
    end
    return true
end


--获取全局自定义字符变量
function lualib:GetFamilyStr(family,name,param)
    lualib:FamilyStr(family,name,param)
    if param~= nil then
        return getguildvar(family,"_FamilyStr"..name)
    else
        return getguildvar(family,name)
    end

end

--设置全局自定义字符变量
function lualib:SetFamilyStr(family,name,par,param)
    lualib:FamilyStr(family,name,param)
    if param~= nil then
        setguildvar(family,name, par,1)
    else
        setguildvar(family,"_FamilyStr"..name, par,1)
    end
    return true
end

--获取行会自定义数值变量
function lualib:GetFamilyInt(family,name,param)
    lualib:FamilyInt(family,name,param)
    if param~= nil then
        return getguildvar(family,name)
    else
        return getguildvar(family,"_FamilyInt"..name)
    end
end

--设置行会自定义数值变量
function lualib:SetFamilyInt(family,name,par,param)
    lualib:FamilyInt(family,name,param)
    if param~= nil then
        setguildvar(family,name,par,1)
    else
        setguildvar(family,"_FamilyInt"..name,par,1)
    end

    return true
end

--清理行会全部自定义变量
function lualib:ClearFamily(family_name) --要清理的行会名称传入空值表示清理所有行会  变量名, 多个变量用|分隔 *代表所有变量
    if family_name==nil then
        clearguildcustvar(" ",'*')
    else
        clearguildcustvar(family_name,'*')
    end
    return true
end

--清理行会自定义数值变量
function lualib:ClearFamilyInt(family_name,str,param) --要清理的行会名称传入空值表示清理所有行会  变量名, 多个变量用|分隔 *代表所有变量
    if param~=nil then
        if str==nil then
            clearguildcustvar(" ",family_name)
        else
            clearguildcustvar(family_name,str)
        end
    else
        if str==nil then
            family_name="_FamilyInt"..family_name
            family_name=family_name:gsub("|","|_FamilyInt")
            clearguildcustvar(" ",family_name)
        else
            str="_FamilyInt"..str
            str=str:gsub("|","|_FamilyInt")
            clearguildcustvar(family_name,str)
        end
    end
    return true
end

--清理行会自定义字符变量
function lualib:ClearFamilyStr(family_name,str,param) --要清理的行会名称传入空值表示清理所有行会  变量名, 多个变量用|分隔 *代表所有变量
    if param~=nil then
        if str==nil then
            clearguildcustvar(" ",family_name)
        else
            clearguildcustvar(family_name,str)
        end
    else
        if str==nil then
            family_name="_FamilyStr"..family_name
            family_name=family_name:gsub("|","|_FamilyStr")
            clearguildcustvar(" ",family_name)
        else
            str="_FamilyStr"..str
            str=str:gsub("|","|_FamilyStr")
            clearguildcustvar(family_name,str)
        end
    end
    return true
end

--清理全局自定义变量
function lualib:ClearGlobal() --变量名, 多个变量用|分隔 *代表所有变量
    clearglobalcustvar("*")
    return true
end

--清理全局自定义字符变量
function lualib:ClearGlobalStr(str,param) --变量名, 多个变量用|分隔 *代表所有变量
    if param==nil then
        str="_DBStr"..str
        str=str:gsub("|","|_DBStr")
    end
    clearglobalcustvar(str)
    return true
end

--清理全局自定义数值变量
function lualib:ClearGlobalNum(str,param) --变量名, 多个变量用|分隔 *代表所有变量
    if param==nil then
        str="_DBNum"..str
        str=str:gsub("|","|_DBNum")
    end
    clearglobalcustvar(str)
    return true
end

--初始化全局自定义字符串变量
function lualib:SystemStr(name,param)
    if param~= nil then
        inisysvar("string",name)
    else
        inisysvar("string", "_DBStr"..name)
    end
    return true
end

--初始化全局自定义数值型变量
function lualib:SystemInt(name,param)
    if param~= nil then
        inisysvar("string",name)
    else
        inisysvar("string", "_DBNum"..name)
    end
    return true
end
--获取全局自定义字符变量
function lualib:GetDBStr(name,param)
    lualib:SystemStr(name,param)
    if param~= nil then
        return getsysvarex(name)
    else
        return getsysvarex("_DBStr"..name)
    end
end

--设置全局自定义字符变量
function lualib:SetDBStr(name,par,param)
    lualib:SystemStr(name,param)
    if param~= nil then
        setsysvarex(name, par,1)
    else
        setsysvarex("_DBStr"..name, par,1)
    end
    return true
end

--获取全局自定义数值变量
function lualib:GetDBNum(name,param)
    return getsysvar(name)
end

--初始化个人自定义字符串变量
function lualib:PlayerStr(player,name,param)
    if not lualib:Player_IsPlayer(player) then return "" end
    if param~= nil then
        iniplayvar(player, "string", "HUMAN",name)
    else
        iniplayvar(player, "string", "HUMAN","_Str"..name)
    end
    return true
end


--初始化个人自定义数值型变量
function lualib:PlayerInt(player,name,param)
    if not lualib:Player_IsPlayer(player) then return "" end
    if param~= nil then
        iniplayvar(player, "integer", "HUMAN",name)
    else
        iniplayvar(player, "integer", "HUMAN","_Int"..name)
    end
    return true
end

--清理玩家全部自定义变量
function lualib:ClearPlayer(player) --要清理的人物对象传入空值表示清理所有玩家
    if player==nil then
        clearhumcustvar(" ",'*')
    else
        clearhumcustvar(player,'*')
    end
    return true
end

--清理玩家自定义数值变量
function lualib:ClearPlayerInt(player,str,param) --要清理的人物对象传入空值表示清理所有玩家  变量名, 多个变量用|分隔 *代表所有变量
    if param~=nil then
        if str==nil then
            clearhumcustvar(" ",player)
        else
            clearhumcustvar(player,str)
        end
    else
        if str==nil then
            player="_Int"..player
            player=player:gsub("|","|_Int")
            clearhumcustvar(" ",player)
        else
            str="_Int"..str
            str=str:gsub("|","|_Int")
            clearhumcustvar(player,str)
        end
    end
    return true
end

--清理玩家自定义字符变量
function lualib:ClearPlayerStr(player,str,param) --要清理的人物对象传入空值表示清理所有玩家  变量名, 多个变量用|分隔 *代表所有变量
    if param~=nil then
        if str==nil then
            clearhumcustvar(" ",player)
        else
            clearhumcustvar(player,str)
        end
    else
        if str==nil then
            player="_Str"..player
            player=player:gsub("|","|_Str")
            clearhumcustvar(" ",player)
        else
            str="_Str"..str
            str=str:gsub("|","|_Str")
            clearhumcustvar(player,str)
        end
    end
    return true
end

--获取个人自定义字符变量
function lualib:GetPlayerStr(player,name,param)
    if not lualib:Player_IsPlayer(player) then return "" end
    lualib:PlayerStr(player,name,param)
    if param~=nil then
        return getplayvar(player,"HUMAN",name)
    else
        return getplayvar(player,"HUMAN","_Str"..name)
    end
end

--设置个人自定义字符变量
function lualib:SetPlayerStr(player,name,par,param)
    if not lualib:Player_IsPlayer(player) then return "" end
    if param~=nil then
        setplayvar(player, "HUMAN",name, par,1)
    else
        setplayvar(player, "HUMAN","_Str"..name, par,1)
    end
    return true
end

--获取个人自定义数值变量
function lualib:GetPlayerInt(player,name,param)
    if not lualib:Player_IsPlayer(player) then return "" end
    lualib:PlayerInt(player,name,param)
    if param~=nil then
        return getplayvar(player,"HUMAN",name)
    else
        return getplayvar(player,"HUMAN","_Int"..name)
    end
end

--设置个人自定义数值变量
function lualib:SetPlayerInt(player,name,par,param)
    if not lualib:Player_IsPlayer(player) then return "" end
    lualib:PlayerInt(player,name,param)

    if param~=nil then
        setplayvar(player, "HUMAN",name, par,1)
    else
        setplayvar(player, "HUMAN","_Int"..name, par,1)
    end
    return true
end

-- 过滤消息
function lualib:DisMsg(player,par)
    if not lualib:Player_IsPlayer(player) then return "" end
    filterglobalmsg(player,par)
    return true
end

-- 获取系统变量
function lualib:GetSysVar(var)
    return getsysvar(var)
end

-- 设置系统变量
function lualib:SetSysVar(var,par)
    return setsysvar(var,par,1)
end

--获取玩家变量
function lualib:GetDef(player,name)
    if not lualib:Player_IsPlayer(player) then return "" end
    return getplaydef(player,name)
end

--设置玩家变量
function lualib:SetDef(player,name,par)
    if not lualib:Player_IsPlayer(player) then return "" end
    setplaydef(player, name,par)
    return true
end

--获取玩家临时字符串变量
function lualib:GetStr(player,name)
    if not lualib:Player_IsPlayer(player) then return "" end
    return getplaydef(player,"S$"..name)
end

--设置玩家临时字符串变量
function lualib:SetStr(player,name,par)
    if not lualib:Player_IsPlayer(player) then return "" end
    setplaydef(player,"S$"..name,par)
    return true
end

--获取玩家临时数值型变量
function lualib:GetInt(player,name)
    if not lualib:Player_IsPlayer(player) then return "" end
    return getplaydef(player,"N$"..name)
end

--设置玩家临时数值型变量
function lualib:SetInt(player,name,par)
    if not lualib:Player_IsPlayer(player) then return "" end
    setplaydef(player,"N$"..name,par)
    return true
end


--判断玩家是否为新人
function lualib:IsNew(player)
    if not lualib:Player_IsPlayer(player) then return "" end
    return getbaseinfo(player,47)
end

--获取游戏载体 1:PC 2:手游
function lualib:GetForm(player)
    if not lualib:Player_IsPlayer(player) then return "" end
    return tonumber(parsetext("<$CLIENTFLAG>",player))
end

--获取分辨率
function lualib:GetPx(player)
    if not lualib:Player_IsPlayer(player) then return "" end
    return tonumber(parsetext("<$SCREENWIDTH>",player)), tonumber(parsetext("<$SCREENHEIGHT>",player))
end

--获取坐标
function lualib:X(player)
    return tonumber(getbaseinfo(player,4))
end

function lualib:Y(player)
    return tonumber(getbaseinfo(player,5))
end

--获取当前地图名称
function lualib:Map(player)
    return getmapname(getbaseinfo(player,3))
end

--获取地图代码
function lualib:GetMapId(player)
    return getbaseinfo(player,3)
end

--获取玩家账号id
function lualib:UserId(player)
    if not lualib:Player_IsPlayer(player) then return "" end
    return getbaseinfo(player,2)
end

--服务器名称
function lualib:ServerName(player)
    if not lualib:Player_IsPlayer(player) then return "" end
    return parsetext("<$SERVERNAME>",player)
end

--关闭窗口
function lualib:Close(player)
    if not lualib:Player_IsPlayer(player) then return "" end
    close(player)
    return true
end
--根据唯一id删除物品
function lualib:DelItemId(player,id) --物品唯一ID，逗号串联
    if not lualib:Player_IsPlayer(player) then return "" end
    delitembymakeindex(player,id)
    return true
end

--发送前端数据
function lualib:ShowFrom(player,form,str,par1,par2,par3)
    if not lualib:Player_IsPlayer(player) then return "" end
    if par1 == nil then
        par1 = 0
    end
    if par2 == nil then
        par2 = 0
    end
    if par3 == nil then
        par3 = 0
    end
    local par = math.random(100,1000)
    if  str~=nil then
        sendluamsg(player,par,par1,par2,par3,form.."#"..str)
    else
        sendluamsg(player,par,par1,par2,par3,tbl2json(form_tb))
    end
    return true
end


--发送脚本表单
function lualib:Invoke(player, func, p1, p2, p3, p4, p5, p6, p7, p8, p9, pA, pB, pC, pD, pE, pF)
    if not lualib:Player_IsPlayer(player) then return "" end
    if type(func) ~= "string" or func == "" then
        print("Invoke函数调用失败，函数名传递错误！")
        return end

    local t = {p1, p2, p3, p4, p5, p6, p7, p8, p9, pA, pB, pC, pD, pE, pF}
    local num = 0
    for i = 15, 1, -1 do
        if t[i] ~= nil then
            num = i
            break end
    end

    local pre_table_name = "server_unname"
    local pre_table_index = 1
    local pre_table_define = ""
    local script_param = ""

    for i = 1, num do
        local v = t[i]
        local val_type = type(v)

        local pre_param = ""
        local param = ""
        if val_type == "nil" then
            param = "nil"
        elseif val_type == "number" then
            param = tostring(v)
        elseif val_type == "string" then
            param = string.format("%q", v)
        elseif val_type == "table" then
            pre_param = "local "..pre_table_name..pre_table_index.."="..serialize(v)..";"
            param = pre_table_name..pre_table_index
            pre_table_index = pre_table_index + 1
        elseif val_type == "function" then
            print("Invoke函数调用错误，函数类型参数不支持！")
        else
            print("Invoke函数调用错误，未知的参数类型！")
        end
        if pre_param ~= "" then
            pre_table_define = pre_table_define..pre_param
        end
        if param ~= "" then
            if script_param == "" then
                script_param = script_param..param
            else
                script_param = script_param..","..param
            end
        end
    end

    local script = pre_table_define
    script = script..func.."("..script_param..")"
    lualib:ShowFrom(player, "脚本表单", script)
    return true
end

--传送
function lualib:MapMove(player,maps,x,y,r) --传送地图 x坐标 y坐标 范围
    if maps == nil then return "" end
    r = r or 0
    if x==nil then
        map(player,maps)
    else
        mapmove(player,maps,x,y,r)
    end
    return true
end

--弹框
function lualib:MsgBox(player,str,par1,par2)
    if not lualib:Player_IsPlayer(player) then return "" end
    if par1 == nil then
        par1 = ""
    end
    if par2 == nil then
        par2 = ""
    end
    messagebox(player,str,par1,par2)
    return true
end

--判断定时器
function lualib:HasTime(player,id)
    if not lualib:Player_IsPlayer(player) then return "" end
    if lualib:GetInt(player,id)==0 then
        return false
    else
        return true
    end
end

--开启定时器
function lualib:AddTime(player,id,time,int) --定时器id 秒 执行次数(不建议使用,使用变量(_Timeid)自己删除)
    if not lualib:Player_IsPlayer(player) then return "" end
    if int==nil then
        int = 0
    end
    setontimer(player,id,time,int)
    lualib:SetInt(player,"_Time"..id,1)
    return true
end

--关闭定时器
function lualib:DelTime(player,id)
    if not lualib:Player_IsPlayer(player) then return "" end
    setofftimer(player,id)
    lualib:SetInt(player,"_Time"..id,0)
    return true
end
--获取生命值百分比
function lualib:HpEx(player)
    return math.ceil((lualib:Hp(player,false)/lualib:Hp(player,true))*100)
end

--获取魔法值百分比
function lualib:MpEx(player)
    return math.ceil((lualib:Mp(player,false)/lualib:Mp(player,true))*100)
end

--获取生命值
function lualib:Hp(player,par)  --ture上限 false当前
    if par then
        return getbaseinfo(player,10)
    else
        return getbaseinfo(player,9)
    end
end

--获取魔法值
function lualib:Mp(player,par)  --ture上限 false当前
    if par then
        return getbaseinfo(player,12)
    else
        return getbaseinfo(player,11)
    end
end

--设置人物血量
function lualib:SetHp(player,hp,id)
    local hp = tonumber(hp)
    if id==nil then
        id = 0
    end
    humanhp(player,"=",hp,id,0,player)
    return true
end
--设置人物蓝量
function lualib:SetMp(player,mp,id)
    local mp = tonumber(mp)
    if id==nil then
        id = 0
    end
    humanmp(player,"=",mp,id,0,player)
    return true
end

--扣除人物血量
function lualib:SubHp(player,hp)
    local hp = tonumber(hp)
    if id==nil then
        id = 0
    end
    humanhp(player,"-",hp,id,0,player)
    return true
end
--扣除人物蓝量
function lualib:SubMp(player,mp)
    local mp = tonumber(mp)
    if id==nil then
        id = 0
    end
    humanmp(player,"-",mp,id,0,player)
    return true
end

--添加人物血量
function lualib:AddHp(player,hp)
    local hp = tonumber(hp)
    if id==nil then
        id = 0
    end
    humanhp(player,"+",hp,4,0,player)
    return true
end
--添加人物蓝量
function lualib:AddMp(player,mp)
    local mp = tonumber(mp)
    if id==nil then
        id = 0
    end
    humanmp(player,"+",mp)
    return true
end

--设置人物百分比血量
function lualib:SetHpEx(player,hp)
    local hp = tonumber(hp)

    setbaseinfo(player,9,lualib:Hp(player,true)*hp/100)
    return true
end
--设置人物百分比蓝量
function lualib:SetMpEx(player,mp)
    local mp = tonumber(mp)
    setbaseinfo(player,10,lualib:Mp(player,true)*mp/100)
    return true
end

--设置伤害吸收
function lualib:SetSuckDamage(player,par)
    if not lualib:Player_IsPlayer(player) then return "" end
    setsuckdamage(player,'=',2100000000,par*10,100)
end

--是否在安全区
function lualib:Is_Safe(player)
    if not lualib:Player_IsPlayer(player) then return "" end
    return getbaseinfo(player,48)
end

--GM权限
function lualib:GetGm(player)
    if not lualib:Player_IsPlayer(player) then return "" end
    return getgmlevel(player)
end
--设置游戏速度
function lualib:ChangeSpeed(player,par,var,time) --速度类型：1-移动速度2-攻击速度3-施法速度   速度等级(-10-10)
    if not lualib:Player_IsPlayer(player) then return "" end
    changespeed(player,par,var,time)
    return true
end
--添加技能
function lualib:AddSkill(player,skill,lv)
    if not lualib:Player_IsPlayer(player) then return "" end
    addskill(player,skill,lv)
    return true
end

--删除技能
---@param player
---@param skill -技能id
function lualib:DelSkill(player,skill)
    if not lualib:Player_IsPlayer(player) then return "" end
    delskill(player,skill)
    return true
end

---强化技能
---@param player
---@param skill -技能id
---@param type -类型 1-技能等级 2-强化等级 3 -技能熟练度
---@param lv -等级
function lualib:SkillLevel(player,skill,type,lv)
    if not lualib:Player_IsPlayer(player) then return "" end
    setskillinfo(player,skill,lv)
    return true
end

--首饰盒
function lualib:Item_Box(player,par) --0关闭 1 开启
    if not lualib:Player_IsPlayer(player) then return "" end
    local par = tonumber(par)
    setsndaitembox(player,par)
    return true
end

--设置背包格子
function lualib:SetBag(player,par) --（不小于46，不大于126）
    if not lualib:Player_IsPlayer(player) then return "" end
    local par = tonumber(par)
    setbagcount(player,par)
    return true
end
--设置仓库格子
function lualib:SetStorage(player,par)
    if not lualib:Player_IsPlayer(player) then return "" end
    local par = tonumber(par)
    changestorage(player,par)
    return true
end

--整理背包
function lualib:Bag(player)
    if not lualib:Player_IsPlayer(player) then return "" end
    refreshbag(player)
    return true
end

--根据对象自动穿戴装备
function lualib:TakeOnItem(player,item)
    if not lualib:Player_IsPlayer(player) then return "" end
    local id = getiteminfo(player,item,1) --唯一id
    local idx = getiteminfo(player,item,2) --物品id
    local std = getstditeminfo(idx,2) -- 获取StdMode位置
    if pos_tb[std]==nil then
        lualib:MsgBox(player,"获取装备位置错误,请联系管理员")
        return false
    end
    local a = 0
    if type(pos_tb[std])=="table" then
        for i = 1,#pos_tb[std] do
            local itemx =linkbodyitem(player,pos_tb[std][i])
            if itemx=='0' then
                a = pos_tb[std][i]
                break
            end
        end
        if a ==0 then
            a = pos_tb[std][1]
        end
    else
        a = pos_tb[std]
    end
    takeonitem(player,a,id)
    return true
end

--直接给物品并且穿戴
function lualib:TakeOnItemEx(player,item_n,item_m,item_b) --名称 数量  规则
    if not lualib:Player_IsPlayer(player) then return "" end
    if item_b==nil then
        item_b = 0
    end
    local std = getstditeminfo(item_n,2) -- 获取StdMode位置
    if pos_tb[std]==nil then
        lualib:MsgBox(player,"获取装备位置错误,请联系管理员")
        return false
    end
    local a = 0
    if type(pos_tb[std])=="table" then
        for i = 1,#pos_tb[std] do
            local itemx =linkbodyitem(player,pos_tb[std][i])
            if itemx=='0' then
                a = pos_tb[std][i]
                break
            end
        end
        if a ==0 then
            a = pos_tb[std][1]
        end
    else
        a = pos_tb[std]
    end
    local item = lualib:AddItem(player,item_n,item_m,item_b)
    local id =getiteminfo(player,item,1)
    takeonitem(player,a,id)
    return true
end

--添加物品
function lualib:AddItem(player,item_n,item_m,item_b,desc) --道具名称  道具数量 道具规则 (最后一个物品对象)，不建议使用在叠加物品，一次性给多个物品的情况，此物品在添加背包触发后，注意可能被回收的情况
    if not lualib:Player_IsPlayer(player) then return "" end

    if checkkuafuserver() then
        kfbackcall(8,getbaseinfo(player, 2),tbl2json({item_n,item_m,item_b,desc}),"添加物品")
        return true
    end

    if item_b == nil then
        item_b = 0
        if lualib:GetFlag(player,VarCfg["特权"]) > 0 then
            item_b = 0
        else
            item_tb = 307
        end
    end
    desc = desc or ""
    logact(player,10001,"获得物品"..item_n.."*"..item_m)
    return giveitem(player,item_n,item_m,item_b,desc)
end
--删除物品
function lualib:DelItem(player,item_n,item_m,item_j,desc)  --名称 数量 忽略极品（0不1是）
    if not lualib:Player_IsPlayer(player) then return "" end
    if checkkuafuserver() then
        kfbackcall(8,getbaseinfo(player, 2),tbl2json({item_n,item_m,item_j,desc}),"删除物品")
        return true
    end

    if item_j==nil then
        item_j = 0
    end

    desc = desc or ""

    logact(player,10002,"扣除物品"..item_n.."*"..item_m)
    return takeitem(player,item_n,item_m,item_j)
end

--打开仓库
function lualib:OpenStorage(player)
    if not lualib:Player_IsPlayer(player) then return "" end
    openstorage(player)
    return true
end

--光头发型
function lualib:Hairs(player)
    if not lualib:Player_IsPlayer(player) then return "" end
    setbaseinfo(player,33,0)
    return true
end

--人物变色
---@param player
---@param color
---@param time
function lualib:Player_Color(player,color,time)
    if not lualib:Player_IsPlayer(player) then return "" end
    setbodycolor(player,color,time)
    return true
end

--是否在攻城
function lualib:Is_Sbk()
    return castleinfo(5)
end

--强制攻击模式
function lualib:SetAttackMode(player,par,time) --攻击模式：0-全体攻击1-和平攻击2-夫妻攻击3-师徒攻击4-编组攻击5-行会攻击6-红名攻击7-国家攻击
    if not lualib:Player_IsPlayer(player) then return "" end
    setattackmode(player,par,time)
    return true
end

--获取攻击模式
function lualib:GetAttackMode(player)
    if not lualib:Player_IsPlayer(player) then return "" end
    return getattackmode(player)
end

--行会对象
function lualib:Family(player)  --注意返回字符串
    if not lualib:Player_IsPlayer(player) then return "" end
    local family =getmyguild(player)
    if family=="0" then
        family=""
    end
    return family
end

--根据行会对象获取行会成员列表名称
function lualib:FamilyPlayerName(family)
    return getguildinfo(family,3)
end

--根据行会对象获取行会名称
function lualib:FamilyName(family)
    return getguildinfo(family,1)
end

--获取行会成员数量
function lualib:FamilyCount(player)
    if lualib:Family(player)=="" then
        return ""
    end
    return getguildmembercount(player)
end

--根据行会对象获取行会ID
function lualib:FamilyIdx(family)
    return getguildinfo(family,0)
end

--根据行会对象获取行会公告
function lualib:FamilyMsg(family)
    return getguildinfo(family,4)
end

--根据行会对象获取行会老大
function lualib:FamilyOldBig(family)
    return getguildinfo(family,4)
end

--沙巴克行会
function lualib:Sbk_Family()
    -- return castleinfo(2)
    return lualib:Parsetext('0',"<$OWNERGUILD>")
end

--沙巴克老大
function lualib:Sbk_Brother()
    -- return castleinfo(3)
    return lualib:Parsetext('0',"<$LORD>")
end

--获取玩家沙巴克身份
function lualib:Get_PlayerSbk(player)
    return castleidentity(player)
end

-- 禁止频繁触发  禁止变量  禁止秒数 单位:秒
function lualib:StopTimes(player,var,int)
    if not lualib:Player_IsPlayer(player) then return "" end
    local begin = tonumber(GetNowTime())
    local par = lualib:GetInt(player,var.."_cd")
    if begin - tonumber(par) < int then
        return false
    else
        lualib:SetInt(player, var.."_cd", begin)
        return true
    end
end

--修改人物模式
function lualib:ChangeMode(player,idx,time,par,pars) --建议看后端说明书..
    if not lualib:Player_IsPlayer(player) then return "" end
    changemode(player,idx,time,par,pars)
    return true
end
--增加附加伤害效果
function lualib:RangeHarm(player,x,y,r,pow,par,var,check,role,tx) --建议看后端说明书..
    if not lualib:Player_IsPlayer(player) then return "" end
    rangeharm(player,x,y,r,pow,par,var,check,role,tx)
    return true
end
--修改人物怪物状态
function lualib:MakePosin(player,param,time,value)  --类型(0=绿毒 1=红毒 5=麻痹 12=冰冻 13= 蛛网 其他无效) 时间（秒） 威力，只针对绿毒有用
    makeposion(player,param,time,value)
    return true
end


-- 解毒
function lualib:Detox(player)
    if not lualib:Player_IsPlayer(player) then return "" end
    detoxifcation(player)
    return true
end

--修改人物临时属性
function lualib:SetValue(player,att_id,par,time) --属性id 属性值 持续时间
    if not lualib:Player_IsPlayer(player) then return "" end
    changehumnewvalue(player,att_id,par,time)
    recalcabilitys(player)
    return true
end

--获取人物临时属性
function lualib:GetValue(player,att_id)
    if not lualib:Player_IsPlayer(player) then return "" end
    return gethumnewvalue(player,att_id)
end

--获取人物自定义属性
function lualib:GetValueEx(player,att_id)
    if not lualib:Player_IsPlayer(player) then return "" end
    recalcabilitys(player)
    return tonumber(lualib:Parsetext(player,"<$CUSTABIL["..att_id.."]>"))
end

--设置物品属性
function lualib:SetItemValue(player,item,att,par) --0.AC1.MAC2.DC3.MC4.SC5.幸运6.准确7.敏捷8.攻击速度9.魔法躲避10.毒物躲避11.体力恢复12.魔法恢复13.中毒恢复15.沙巴克武器升级标记20.物理伤害减少21.魔法伤害减少22.忽视目标防御23.所有伤害反弹24.人物体力增加25.人物魔力增加26.增加目标爆率27.神 圣28.强 度29.诅 咒30.暴击率31.暴击伤害32.攻击伤害 40~44. 脚本使用
    if not lualib:Player_IsPlayer(player) then return "" end
    setitemaddvalue(player,item,1,att,par)
    return true
end

--获取物品属性
function lualib:GetItemValue(player,item,att) --0.AC1.MAC2.DC3.MC4.SC5.幸运6.准确7.敏捷8.攻击速度9.魔法躲避10.毒物躲避11.体力恢复12.魔法恢复13.中毒恢复15.沙巴克武器升级标记20.物理伤害减少21.魔法伤害减少22.忽视目标防御23.所有伤害反弹24.人物体力增加25.人物魔力增加26.增加目标爆率27.神 圣28.强 度29.诅 咒30.暴击率31.暴击伤害32.攻击伤害 40~44. 脚本使用
    if not lualib:Player_IsPlayer(player) then return "" end
    return getitemaddvalue(player,item,1,att)
end

--让怪物再爆(注意:在后面的对象会实现)
function lualib:MonItem(player,par)  --怪物名称 可爆次数(最大20次)
    if not lualib:Player_IsPlayer(player) then return "" end
    monitems(player,par)
    return true
end

--让怪物再爆
---@param player
---@param num -可爆次数(最大20次)
function lualib:MonItem(player,num)  --玩家对象 可爆次数(最大20次) 延迟毫秒数(默认不延迟)
    if not lualib:Player_IsPlayer(player) then return "" end
    monitems(player,num)
    return true
end

-- 临时增加怪物爆率
function lualib:MobItemsList(player,mob,item) --多个物品使用|分隔；增加爆出物品，需要在KillMon触发中使用，仅一次有效。
    if not lualib:Player_IsPlayer(player) then return end
    additemtodroplist(player,mob,item)
    return true
end

--设置怪物爆率
---@param player
---@param par -爆率
function lualib:SetMobAtt(player,par)
    if not lualib:Player_IsPlayer(player) then return end
    setbaseinfo(player,43,par)
    return true
end

--设置人物神力倍攻
function lualib:SetPlayerPower(player,par,time)
    if not lualib:Player_IsPlayer(player) then return end
    powerrate(player,par,time)
    return true
end

--修改血量特效
function lualib:HuManHp(player,str,value,id) --符号 数值 特效id
    if id ==nil then
        id = 0
    end
    humanhp(player,str,value,id)
    return true
end

-- 发送血量特效
function lualib:HuManHpEx(player,var,par)
    sendattackeff(player,var,par,"*")
    return true
end

--添加称号
---@param player
---@param title
---@param par
function lualib:AddTitle(player,title,par) --添加称号 是否应用
    if not lualib:Player_IsPlayer(player) then return end

    if checkkuafuserver() then
        kfbackcall(2,getbaseinfo(player, 2),title,"1")
        return false
    end

    par = par or 0
    if confertitle(player,title,par) then
    else
        callscriptex(player,"CONFERTITLE ",title)
    end
    GameEvent.push(EventCfg.onTitleChange,player,title,1)
    return true
end

--删除称号
----@param player
---@param title
function lualib:DelTitle(player,title)
    --print("删除失败title",title)
    if not lualib:Player_IsPlayer(player) then return end
    if checkkuafuserver() then
        kfbackcall(2,getbaseinfo(player, 2),title,"0")
        return false
    end

    if deprivetitle(player,title) then
        --print("删除成功title",title)
    else
        callscriptex(player,"DEPRIVETITLE",title)
        --print("删除失败title",title)
    end
    GameEvent.push(EventCfg.onTitleChange,player,title,0)
    return true
end

--检查称号
function lualib:CheckTitle(player,title)
    if not lualib:Player_IsPlayer(player) then return end
    if checktitle(player,title) then
        return true
    else
        return false
    end
end

--应用称号
function lualib:ConTitle(player,title)
    if not lualib:Player_IsPlayer(player) then return end
    setranklevelname(player,title)
    return true
end
--获取称号列表
function lualib:Title_Tb(player)
    if not lualib:Player_IsPlayer(player) then return end
    return gettitlelist(player)
end

--顶戴花翎
function lualib:SetIcon(player,par,int,idx,x,y,drop,selfsee) --位置(0-9)  播放效果(0图片名称 1特效ID) 图片名或者特效ID X坐标 (为空时默认X=0) Y坐标 (为空时默认Y=0) 自动补全空白位置0,1(0=掉 1=不掉) 是否只有自己看见(0=所有人都可见 1=仅仅自己可见)
    if not lualib:Player_IsPlayer(player) then return end
    seticon(player,par,int,idx,x,y,drop,selfsee)
    return true
end

--人物特效
function lualib:PlayerEffect(player,effectid,x,y,times,behind,selfshow) --特效ID 相对于人物偏移的X坐标 相对于人物偏移的Y坐标 播放次数0-一直播放  播放模式0-前面1-后面  仅自己可见0-否，视野内均可见，1-是
    if not lualib:Player_IsPlayer(player) then return "" end
    playeffect(player,effectid,x,y,times,behind,selfshow)
    return true
end

--删除人物特效
function lualib:ClearPlayeffect(player,txid)
    if not lualib:Player_IsPlayer(player) then return "" end
    clearplayeffect(player,txid)
    return true
end

--获取pk值
---@param player
function lualib:Pk(player)
    if not lualib:Player_IsPlayer(player) then return "" end
    return getbaseinfo(player,46)
end


--设置pk值
---@param player
---@param par -pk值
function lualib:SetPk(player,par)
    if not lualib:Player_IsPlayer(player) then return "" end
    setbaseinfo(player,46,par)
    return true
end

--增加pk值
---@param player
---@param par -pk值
function lualib:AddPk(player,par)
    if not lualib:Player_IsPlayer(player) then return "" end
    setbaseinfo(player,46,getbaseinfo(player,46) + par)
    return true
end

-- 获取合区次数
function lualib:GetInfo(var) --1: 开服天数(后台维护)2: 开服时间(后台维护)3: 合服次数4: 合服时间5: 服务器IP6: 玩家数量7: 背包最大数量
    return grobalinfo(3)
end

--解析传奇数据
function lualib:Parsetext(player,str) --注意获取的数字是string类型
    if player==nil then
        player='0'
    end
    return parsetext(str,player)
end
-- 获取地图怪物数量
function lualib:GetMapMobs(map,mob,x,y,r) --怪物名，为空 or * 为检测所有怪
    return checkrangemoncount(map,mob,x,y,r)
end

--刷怪
function lualib:GenMon(table)   --地图代码 x坐标 y坐标 范围 怪物名称 怪物数量 怪物名字颜色
    local tb = genmon(table[1],table[2],table[3],table[4],table[5],table[6],table[7])
    return tb
end

--自动拾取
function lualib:PickItems(player,mode,range,time) --模式（0=以人物为中心捡取，1=以小精灵为中心捡取） 范围  间隔，最小500ms
    if not lualib:Player_IsPlayer(player) then return "" end
    pickupitems(player,mode,range,time)
    return true
end

--停止拾取
function lualib:StopPick(player)
    if not lualib:Player_IsPlayer(player) then return "" end
    stoppickupitems(player)
    return true
end
--所有行会今晚攻城
function lualib:AddAttackSabukAll()
    addattacksabakall()
    return true
end

--获取NPC对象
function lualib:Npc(npcidx)
    getnpcbyindex(npcidx)
    return true
end

-- 获取物品来源
function lualib:GetItemJosnLy(player,item)
    if not lualib:Player_IsPlayer(player) then return end
    local str_tb = getthrowitemly(player,item)
    str_tb=tbl2json(str_tb)
    return str_tb
end
--
---- 获取物品变量
--function lualib:GetItemInt(player,item,var)
--    if not lualib:Player_IsPlayer(player) then return end
--    return getitemaddvalue(player,item,1,40+var)
--end
--
---- 设置物品变量
--function lualib:SetItemInt(player,item,var,par)
--    if not lualib:Player_IsPlayer(player) then return end
--    setitemaddvalue(player,item,1,40+var,par)
--    return true
--end

--获取微信验证码
function lualib:WeChatKey(player,par) --1获取绑定KEY 2获取解绑KEY 3获取验证KEY
    if not lualib:Player_IsPlayer(player) then return end
    bindwechat(player,par)
    return true
end

--创建进度条
function lualib:Star_Show(player,time,fun,str,int,funs) --进度条时间秒 成功函数 提示消息 是否可中断（0,1） 中断函数
    if not lualib:Player_IsPlayer(player) then return end
    showprogressbardlg(player,time,fun,str,int,funs)
    return true
end


--创建界面
function lualib:CreateWnd(player,w,h,img) --宽 高 图片
    if not lualib:Player_IsPlayer(player) then return end
    local w,h = tonumber(w),tonumber(h)
    lualib:SetInt(player,"界面宽度",w)
    lualib:SetInt(player,"界面高度",h)
    lualib:SetInt(player,"开启引导",0)
    local px1,px2= lualib:GetPx(player)
    local msg = [[
        <Img|img=custom/bjk.png|x=-1000|y=-1000|width=9999|height=9999|link=@exit>
        <Img|x=]]..((px1-w)/2)..[[|y=]]..((px2-h)/2)..[[|width=]]..w..[[|height=]]..h..[[|scale9l=10|scale9r=10|scale9t=10|scale9b=10|esc=1|move=0|bg=1|img=]]..img..[[>
    ]]
    return msg,math.ceil((px1-w)/2),math.ceil((px2-h)/2)
end
--关闭界面
function lualib:WndClose(player)
    if not lualib:Player_IsPlayer(player) then return end
    close(player)
    return true
end

--踢下线
function lualib:Kick(player)
    if not lualib:Player_IsPlayer(player) then return end
    kick(player)
    return true
end

function lualib:dbg(str1,str2)
    release_print(str1,str2)
    return true
end

function lualib:msg(player,str)
    if not lualib:Player_IsPlayer(player) then return end
    guildnoticemsg(player,150,200,tostring(str),self)
    return true
end

--给物品并获得唯一ID
function lualib:AddItemId(player,itemName)  --玩家对象,道具名字
    if not lualib:Player_IsPlayer(player) then return end
    local item = giveitem(player,itemName)
    local id = getiteminfo(player,item,1) --唯一id
    return id
end
--发送给自己的字
function lualib:SendMsgEx(player,num,str)
    if not lualib:Player_IsPlayer(player) then return end
    --callscriptex(player,"sendmsg",num,str)
    sendmsg(player, 1, '{"Msg":"'..str..'","Type":'..num..'}')
    return true
end

--发送给自己的字 添加文字板
---@param player 角色对象
---@param num    发送类型
---@param str    发送内容
function lualib:SendMsgGetColor(player,num,str)
    if not lualib:Player_IsPlayer(player) then return end

    local originalString = str
    local parts = {}
    for part in string.gmatch(originalString, "([^|]+)") do
        table.insert(parts, part)
    end

    local result = ""
    for i = 2, #parts, 2 do
        local text = parts[i]
        local colorCode = parts[i-1]
        result = result.. string.format("<font color='%s'>%s</font>", colorCode, text)
    end
    sendmsg(player, 1, '{"Msg":"'..result..'","Type":'..num..'}')
    return true
end
--
---发送地图消息
--@param mapid 地图id
--@param Msg 消息
--@param FColor 前景色
--@param BColor 背景色
--@param Type 消息类型
--@param Time 消息显示时间
--@param SendName 发送者名字
--@param SendId 发送id
function lualib:SendMapMsg(mapid,Msg,FColor,BColor,Type,Time,SendName,SendId)
    --if not lualib:Player_IsPlayer(player) then return end
    sendmapmsg(mapid,'{"Msg":"'..Msg..'","FColor":'..FColor..',"BColor":'..BColor..',"Type":'..Type..',"Time":'..Time..',"SendName":"'..SendName..'","SendId":'..SendId..'}')
    return true
end
--自动转化大数字
function lualib:numberToBig(num)
    local num = tonumber(num)
    local str = num
    if num >= 100000000 then
        str = math.floor(num/100000000).."亿"
    elseif num >= 10000 then
        str = math.floor(num/10000).."万"
    end
    return str
end

--获得玩家或是怪物的名字
function lualib:Name(player)
    return tostring(getbaseinfo(player,1))
end

--获得人物转生
function lualib:ReinLevel(player)
    if not lualib:Player_IsPlayer(player) then return end
    return tonumber(getbaseinfo(player,39))
end

--获得数字常量
function lualib:GetNumConst(player,str)
    if not lualib:Player_IsPlayer(player) then return end
    return tonumber(getconst(player,str))
end

function lualib:AddLog(player,str)
    if not lualib:Player_IsPlayer(player) then return end
    lualib:ChangeMoneyID(player,19,"+",1,str,true)
    return true
end

function lualib:Weight(tb)
    local weight = 0
    ---print(serialize(tb))
    for i = 1, #tb do
        weight = weight + tb[i].weight
    end

    local rand = math.random(1, weight)
    for i = 1, #tb do
        if rand <= tb[i].weight then
            return i
        end
        rand = rand - tb[i].weight
    end

    return 1
end

function lualib:WeightEx(tb,num)
    num = num or 2
    local weight = 0
    for i = 1, #tb do
        weight = weight + tb[i][num]
    end

    local rand = math.random(1, weight)
    for i = 1, #tb do
        --print(weight,rand,tb[i][num])
        if rand <= tb[i][num] then
            return i
        end
        rand = rand - tb[i][num]
    end
    return 1
end

function lualib:WeightEx1(tb)
    local weight = 0
    for i = 1, #tb do
        weight = weight + tb[i]
    end

    local rand = math.random(1, weight)
    for i = 1, #tb do
        if rand <= tb[i] then
            return i
        end
        rand = rand - tb[i]
    end
    return 1
end

function lualib:GoHome(player)
    if not lualib:Player_IsPlayer(player) then return end

    if lualib:ItemCount(player,"紫色藏品宝箱") > 0 then
        lualib:DelItem(player,"紫色藏品宝箱",lualib:ItemCount(player,"紫色藏品宝箱"))
    end

    local gold = cheLiDian.getGold(player)
    if gold > 0 then
        GameEvent.push(EventCfg.onOutputRecord,{amount = gold})
    else
        GameEvent.push(EventCfg.onOutputRecord,{amount = 0})
    end

    chouKa.reset(player)
    lualib:AddHPEx(player,100)
    lualib:AddMPEx(player,100)
    lualib:SetVar(player,VarCfg["进入地图"],0)
    lualib:SetVar(player,VarCfg["局内金币"],0)
    lualib:SetVar(player,VarCfg["入局物资"],0)

    if not checkkuafuserver(player) then
        lualib:MapMove(player,"3",330,331,6)
    else
        kfbackcall(3,getbaseinfo(player, 2))
    end

    return true
end

---将字符串切割成需要的物品表
function lualib:ParseItems(str)
    if str == nil or str == "" then
        return nil
    end
    local need_tb = {}
    local tb = string.split(str,"|")

    for k,v in ipairs(tb) do
        local tb2 = string.split(v,"#")
        local item = {}
        for i=1,#tb2 do
            item[i] = tb2[i]
        end
        table.insert(need_tb,item)
    end

    return need_tb
end
---属性转化
---将属性表转化为属性字符串
function lualib:ParseAttr(table)
    local temp_tb = {}
    for i=1,#table do
        if temp_tb[table[i][1]] ~= nil then
            temp_tb[table[i][1]] = temp_tb[table[i][1]] + table[i][2]
        else
            temp_tb[table[i][1]] =  table[i][2]
        end
    end

    return temp_tb
end

function lualib:GetAttrColorName(tb)
    local color = 250
    local name = ""
    local type = 1
    local tb = att_score_tb[tb[1]]
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

function lualib:GetAttrColorNameEx(attr)
    local color = 250
    local name = ""
    local type = 1
    local tb = att_score_tb[attr]
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

function lualib:getStringLength(inputstr)
    if not inputstr or type(inputstr) ~= "string" or #inputstr <= 0 then  --inputstr不为nil、类型为字符串、且长度不为0
        return nil
    end
    local length = 0  -- 字符的个数
    local i = 1       --累计的每个字符的字节数，如果 i = 0，那么跳出while条件就是  i >= #intutstr 或 i == #inputstr
    while true do     --这里我们是通过获取一个字符的头字节来判断是几字节的，如汉字的头字节ASCII是大于223的，所以直接跳过后面2个字节的判断，byteCount = 3
        local curByte = string.byte(inputstr, i)  --获取单个字节的ASCII码
        local byteCount = 1                       --单个字符的字节数，根据ASCII判断字节数
        if curByte > 239 then
            byteCount = 4  -- 4字节字符
        elseif curByte > 223 then
            byteCount = 3  -- 汉字，3字节
        elseif curByte > 128 then
            byteCount = 2  -- 双字节字符
        else
            byteCount = 1  -- 单字节字符
        end
        -- local char = string.sub(inputstr, i, i + byteCount - 1)
        -- print(char)  -- 打印单个字符
        i = i + byteCount
        length = length + 1
        if i > #inputstr then
            break
        end
    end
    return length          --返回字符个数
end

function lualib:CopyTable(tab)      --深拷贝
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

function lualib:GetMoneyID(player,data)
    local money = 0
    local idx = getstditeminfo(data[1],0)
    ---print(idx,"xxxxx",data[1])
    if bindMoney[idx] ~= nil then
        money = getbindmoney(player,data[1])
    else
        money = querymoney(player,idx)
    end
    print(money)
    return money
end

function lualib:DelMoneyID(player,data,num,desc)
    local idx = getstditeminfo(data[1],0)

    if bindMoney[idx] ~= nil then
        consumebindmoney(player,data[1],num,desc)
    else
        changemoney(player,idx,"-",data[2],desc,true)
    end

    return true
end

---获得货币数量
---@param player string 玩家对象
---@param data table 货币名称
---@param desc string 货币原因
function lualib:GetMoneyEx(player,data)
    local money = 0
    local idx = getstditeminfo(data[1],0)
    money = querymoney(player,idx)
    return money
end

---直接删除货币
---@param player string 玩家对象
---@param data table 货币名称
---@param desc string 货币原因
function lualib:DelMoneyEx(player,data,desc)
    if not lualib:Player_IsPlayer(player) then return "" end
    desc = desc or ""
    local idx = getstditeminfo(data[1],0)
    changemoney(player,idx,"-",data[2],desc,true)
    return true
end


---直接添加货币
---@param player string 玩家对象
---@param data table 货币名称
---@param desc string 货币原因
function lualib:AddMoneyEx(player,data,desc) --添加货币名称 添加货币数量 添加货币原因
    if not lualib:Player_IsPlayer(player) then return "" end
    desc = desc or ""
    local idx = getstditeminfo(data[1],0)
    changemoney(player,idx,"+",data[2],desc,true)
    return true
end

---添加货币
---@param player string 玩家对象
---@param data table 货币名称 {}
---@param num number 货币数量
---@param desc string 货币原因
function lualib:AddMoneyID(player,data,num,desc) --添加货币名称 添加货币数量 添加货币原因
    if not lualib:Player_IsPlayer(player) then return "" end
    desc = desc or ""
    local bind = lualib:GetFlag(player,VarCfg["特权"])
    local idx = getstditeminfo(data[1],0)

    if bindMoney[idx] ~= nil then
        --print(bindMoney[idx][bind][1])
        changemoney(player,bindMoney[idx][bind][1],"+",num,desc,true)
    else
        changemoney(player,idx,"+",num,desc,true)
    end
    return true
end

---添加绑定货币
---@param player string 玩家对象
---@param data table 货币名称
---@param num number 货币数量
---@param desc string 货币原因
function lualib:AddBindMoneyID(player,data,num,desc) --添加货币名称 添加货币数量 添加货币原因
    if not lualib:Player_IsPlayer(player) then return "" end
    desc = desc or ""
    local idx = getstditeminfo(data[1],0)
    changemoney(player,bindMoney[idx][0][1],"+",num,desc,true)
    return true
end

function lualib:GetBagRecycleItems(player)
    local str = lualib:GetVar(player,"S$背包回收物品")
    if str == "" then
        local itemCount = getbaseinfo(player,34)
        for i=1,(itemCount - 1) do
            local item =  getiteminfobyindex(player, i)
            str = str..getiteminfo(player,item,1)..","
        end
    end
    selectbagitems(player,str)
    return true--data,str
end

function lualib:GetMapInfo(player)
    local dataTb = {}
	--local line = 0
	--local repeatBlank = 0
	--while repeatBlank < 10 do
    --    local  fileText = getrandomtext("..\\MapInfo.txt",line)
    --    line = line + 1
	--	if #fileText == 0 then
	--		repeatBlank = repeatBlank + 1
	--	else
	--		repeatBlank = 0
	--		local startpos = string.find(fileText, "%[.+%|.+%]")  -- 查找"|"
	--		local name, desc
	--		if startpos then -- 含有|
	--			name, desc = fileText:match("%[(.-)|%s*(.-)%]")
	--			local s1, s2 = desc:match("(.+)%s(.+)")
	--			desc = s2
	--		else
	--			name, desc = fileText:match("%[(.+)%s(.+)%]")
	--		end
    --
	--		if name and desc then
	--			name = string.gsub(name, "^%s*(.-)%s*$", "%1")
	--			dataTb[#dataTb+1] = {n=name, v=desc,i=#dataTb+1}
	--		end
	--	end
	--end

	return {}
end

function lualib:MainlandAllExpont(player,mainland,i)
    mainland = tonumber(mainland)
    local temp_tb = lualib:CopyTable(cfg_all_expend_tb[mainland].currency)
    return temp_tb[i][3]*cfg_all_expend_tb[mainland].all
end
---判断需求物品是否足够但是不给提示
---@param player
---@param need_tb 需要的物品表 {{物品id,物品名字,物品数量},{物品id,物品名字,物品数量}} or {物品id,物品名字,物品数量}
function lualib:CheckNeedItemsNoTip(player,need_tb)
    local isEnough = true
    if #need_tb == 2 and type(need_tb[1]) ~= "table" then
        local idx = getstditeminfo(need_tb[1],0)
        if idx < 100 then
            if lualib:GetMoneyID(player,need_tb) < need_tb[2] then
                isEnough = false
            end
        else
            if lualib:ItemCount(player,need_tb[1]) < need_tb[2] then
                isEnough = false
            end
        end
    else
        for i=1,#need_tb do
            local idx = getstditeminfo(need_tb[i][1],0)
            if idx < 100 then
                if lualib:GetMoneyID(player,need_tb[i]) < need_tb[i][2] then
                    isEnough = false
                    break
                end
            else
                if lualib:ItemCount(player,need_tb[i][1]) < need_tb[i][2] then
                    isEnough = false
                    break
                end
            end
        end
    end
    return isEnough
end

---判断需求物品是否足够
---@param player
---@param need_tb 需要的物品表 {{物品id,物品名字,物品数量},{物品id,物品名字,物品数量}} or {物品id,物品名字,物品数量}
function lualib:CheckNeedItems(player,need_tb)
    local isEnough = true
    if #need_tb == 2 and type(need_tb[1]) ~= "table" then
        local idx = getstditeminfo(need_tb[1],0)
        if idx < 100 then
            print(idx,need_tb[1],need_tb[2],lualib:GetMoneyID(player,need_tb))
            if lualib:GetMoneyID(player,need_tb) < need_tb[2] then
                lualib:SendMsgEx(player,9,"<font color='#00ff40'>您的</font><font color='#f2ff00'>"..need_tb[1].."</font><font color='#00ff40'>不足</font><font color='#f2ff00'>"..need_tb[2].."</font>")
                isEnough = false
            end
        else
            if lualib:ItemCount(player,need_tb[1]) < need_tb[2] then
                lualib:SendMsgEx(player,9,"<font color='#00ff40'>您的</font><font color='#f2ff00'>"..need_tb[1].."</font><font color='#00ff40'>不足</font><font color='#f2ff00'>"..need_tb[2].."个</font>")
                isEnough = false
            end
        end
    else
        for i=1,#need_tb do
            local idx = getstditeminfo(need_tb[i][1],0)
            if idx < 100 then
                if lualib:GetMoneyID(player,need_tb[i]) < need_tb[i][2] then
                    lualib:SendMsgEx(player,9,"<font color='#00ff40'>您的</font><font color='#f2ff00'>"..need_tb[i][1].."</font><font color='#00ff40'>不足</font><font color='#f2ff00'>"..need_tb[i][2].."</font>")
                    isEnough = false
                    break
                end
            else
                if lualib:ItemCount(player,need_tb[i][1]) < need_tb[i][2] then
                    lualib:SendMsgEx(player,9,"<font color='#00ff40'>您的</font><font color='#f2ff00'>"..need_tb[i][1].."</font><font color='#00ff40'>不足</font><font color='#f2ff00'>"..need_tb[i][2].."个!</font>")
                    isEnough = false
                    break
                end
            end
        end
    end

    return isEnough
end

---判断需求物品是否足够(货币不判断是否绑定)
---@param player
---@param need_tb 需要的物品表 {{物品id,物品名字,物品数量},{物品id,物品名字,物品数量}} or {物品id,物品名字,物品数量}
function lualib:CheckNeedItemsNoBind(player,need_tb)
    local isEnough = true

    if #need_tb == 2 and type(need_tb[1]) ~= "table" then
        local idx = getstditeminfo(need_tb[1],0)
        if idx < 100 then
            if lualib:GetMoneyEx(player,need_tb) < need_tb[2] then
                lualib:SendMsgEx(player,9,"<font color='#00ff40'>您的</font><font color='#f2ff00'>"..need_tb[1].."</font><font color='#00ff40'>不足</font><font color='#f2ff00'>"..need_tb[2].."</font>")
                isEnough = false
            end
        else
            if lualib:ItemCount(player,need_tb[1]) < need_tb[2] then
                lualib:SendMsgEx(player,9,"<font color='#00ff40'>您的</font><font color='#f2ff00'>"..need_tb[1].."</font><font color='#00ff40'>不足</font><font color='#f2ff00'>"..need_tb[2].."个</font>")
                isEnough = false
            end
        end
    else
        for i=1,#need_tb do
            local idx = getstditeminfo(need_tb[i][1],0)
            if idx < 100 then
                if lualib:GetMoneyEx(player,need_tb[i]) < need_tb[i][2] then
                    lualib:SendMsgEx(player,9,"<font color='#00ff40'>您的</font><font color='#f2ff00'>"..need_tb[i][1].."</font><font color='#00ff40'>不足</font><font color='#f2ff00'>"..need_tb[i][2].."</font>")
                    isEnough = false
                    break
                end
            else
                if lualib:ItemCount(player,need_tb[i][1]) < need_tb[i][2] then
                    lualib:SendMsgEx(player,9,"<font color='#00ff40'>您的</font><font color='#f2ff00'>"..need_tb[i][1].."</font><font color='#00ff40'>不足</font><font color='#f2ff00'>"..need_tb[i][2].."个!</font>")
                    isEnough = false
                    break
                end
            end
        end
    end

    return isEnough
end


---扣除需求物品
---@param player
---@param need_tb 需要的物品表 {{物品id,物品名字,物品数量},{物品id,物品名字,物品数量}} or {物品id,物品名字,物品数量}
---@param desc  删除描述
function lualib:DelNeedItems(player,need_tb,desc)
    if lualib:CheckKuaFuServer(player) then
        kfbackcall(5,getbaseinfo(player, 2),tbl2json(need_tb),"跨服删除货币")
        return ""
    end

    if #need_tb == 2 and type(need_tb[1]) ~= "table" then
        local idx = getstditeminfo(need_tb[1],0)
        if idx < 100 then
            lualib:DelMoneyID(player,need_tb,need_tb[2],desc)
        else
            lualib:DelItem(player,need_tb[1],need_tb[2])
        end
    else
        for i=1,#need_tb do
            local idx = getstditeminfo(need_tb[i][1],0)
            if idx < 100 then
                lualib:DelMoneyID(player,need_tb[i],need_tb[i][2],desc)
            else
                lualib:DelItem(player,need_tb[i][1],need_tb[i][2])
            end
        end
    end
    --GameEvent.push(EventCfg.onPushRedPoint ,player)
end
---扣除需求物品(不判断货币是否绑定直接扣除)
---@param player
---@param need_tb 需要的物品表 {{物品id,物品名字,物品数量},{物品id,物品名字,物品数量}} or {物品id,物品名字,物品数量}
---@param desc  删除描述
function lualib:DelNeedItemsNoBind(player,need_tb,desc)
    if lualib:CheckKuaFuServer(player) then
        kfbackcall(5,getbaseinfo(player, 2),tbl2json(need_tb),"跨服删除不绑定货币")
        return ""
    end
    ---print(serialize(need_tb),"跨服回传")
    if #need_tb == 2 and type(need_tb[1]) ~= "table" then
        local idx = getstditeminfo(need_tb[1],0)
        if idx < 100 then
            --lualib:DelMoneyEx(player,data,desc)
            lualib:DelMoneyEx(player,need_tb,desc)
        else
            lualib:DelItem(player,need_tb[1],need_tb[2])
        end
    else
        for i=1,#need_tb do
            local idx = getstditeminfo(need_tb[i][1],0)
            --print(need_tb[i][1] .. "xxxxx" .. idx)
            if idx < 100 then
                lualib:DelMoneyEx(player,need_tb[i],desc)
            else
                lualib:DelItem(player,need_tb[i][1],need_tb[i][2])
            end
        end
    end
    ---GameEvent.push(EventCfg.onPushRedPoint ,player)
end
---添加物品表里的物品
---@param player
---@param need_tb 需要的物品表 {{物品id,物品名字,物品数量},{物品id,物品名字,物品数量}} or {物品id,物品名字,物品数量}
---@param desc  添加描述
function lualib:AddNeedItems(player,need_tb,desc)
    if lualib:CheckKuaFuServer(player) then
        kfbackcall(5,getbaseinfo(player, 2),tbl2json(need_tb),"跨服增加货币")
        return ""
    end

    if #need_tb == 2 and type(need_tb[1]) ~= "table" then
        local idx = getstditeminfo(need_tb[1],0)
        if idx < 100 then
            lualib:AddMoneyID(player,need_tb,need_tb[2],desc)
        else
            lualib:AddItem(player,need_tb[1],need_tb[2])
        end
    else
        for i=1,#need_tb do
            local idx = getstditeminfo(need_tb[i][1],0)
            if idx < 100 then
                lualib:AddMoneyID(player,need_tb[i],need_tb[i][2],desc)
            else
                lualib:AddItem(player,need_tb[i][1],need_tb[i][2])
            end
        end
    end
    GameEvent.push(EventCfg.onPushRedPoint ,player)
end

---添加绑定物品表里的物品
---@param player
---@param need_tb 需要的物品表 {{物品id,物品名字,物品数量},{物品id,物品名字,物品数量}} or {物品id,物品名字,物品数量}
---@param desc  添加描述
function lualib:AddNeedBindItems(player,need_tb,desc)
    if #need_tb == 2 and type(need_tb[1]) ~= "table" then
        local idx = getstditeminfo(need_tb[1],0)
        if idx < 100 then
            lualib:AddBindMoneyID(player,need_tb,need_tb[2],desc)
        else
            lualib:AddItem(player,need_tb[1],need_tb[2],307,desc)
        end
    else
        for i=1,#need_tb do
            local idx = getstditeminfo(need_tb[i][1],0)

            if idx < 100 then
                lualib:AddBindMoneyID(player,need_tb[i],need_tb[i][2],desc)
            else
                lualib:AddItem(player,need_tb[i][1],need_tb[i][2],307,desc)
            end
        end
    end
    --GameEvent.push(EventCfg.onPushRedPoint ,player)
end

---乱序表
---@param table
function lualib:RandomTable(table)
    local temp_tb = lualib:CopyTable(table)
    local len = #temp_tb
    for i=1,len do
        local index = math.random(1,len)
        temp_tb[i],temp_tb[index] = temp_tb[index],temp_tb[i]
    end
    return temp_tb
end

--发送前端数据
---@param  player userdata  --玩家对象
---@param  script string  --前端函数名(name/func)json解析不了_符号
---@param  ... table  --前端函数参数

function lualib:ShowFormWithContent(player,script,...)
    if not lualib:Player_IsPlayer(player) then return "" end
    local content = {}
    if not func then
        print("ShowFormWithContent函数调用失败，函数名传递错误！")
        return ""
    end
    content.script = script
    content.paramList = {}
    local arg = {...}
    for i=1, #arg do
        content.paramList[i] = arg[i]
    end

    Message.sendmsg(player,666,0,0,0,content)
    return true
end
---设置玩家变量
---@player
---@var 变量名
function lualib:SetVar(player,var,par)
    if not lualib:Player_IsPlayer(player) then return "" end
    setplaydef(player,var,par)
    ---print(var,par,"变量")
    if var == "U13" then
        sheZhiDengJi.setFuZhong(player)
    elseif var == "U12" then
        sheZhiDengJi.setLevel(player)
    end
    return true
end
---获取玩家变量
---@player
---@var 变量名
function lualib:GetVar(player,var)
    if not lualib:Player_IsPlayer(player) then return "" end
    local num = getplaydef(player,var)
    if var == VarCfg["负重"] then
        ---实际负重统一由229属性提供，U13只作为永久基础负重存档
        return lualib:Attr(player,229)
    end

    return num
end
---设置全局变量
---@var 变量名
---@par 变量值
function lualib:SetDBVar(var,par)
    setsysvar(var,par)
    return true
end
---获取全局变量
---@var 变量名
function lualib:GetDBVar(var)
    return getsysvar(var)
end
---字符串转table
function lualib:StrToTable(str)
    if str == nil or type(str) ~= "string" then
        return
    end
    return loadstring("return " .. str)()
end

---添加buff
---@param player guid  --玩家对象
---@param buffid number  --buffid
---@param time number  --持续时间
---@param par number  --叠加数量
---@param pars guid  --释放者
---@param attr table  --属性
function lualib:AddBuff(player,buffid,time,par,pars,attr)
    if not isnotnull(player) then
        return false
    end
    par = par or 1
    time = time or 0
    pars = pars or player
    attr = attr or nil
    if checkkuafuserver() then
        kfbackcall(1,getbaseinfo(player, 2),tbl2json({buffid,time, par, attr}),"1")
        return true
    end

    if addbuff(player,buffid,time,par,pars,attr) then
        --if buffid ==  20009 then
        --    lualib:ShowFormWithContent(player,"右上图标_fuHuoTimes",time)
        --end

        return true
    else
        return false
    end

    return true
end

---删除buff
---@param player guid  --玩家对象
---@param buffid number  --buffid
function lualib:DelBuff(player,buffid)

    if not isnotnull(player) then
        return false
    end

    if checkkuafuserver() then
        kfbackcall(1,getbaseinfo(player, 2),tostring(buffid),"0")
        return true
    end

    delbuff(player,buffid)

    return true
end

---@param player
---@param str
---@param type
function lualib:Say(player,str,type)
    if not lualib:Player_IsPlayer(player) then return "" end
    --type = type or 0
    --if type == 0 then
    --    str = "<Img|x=-1000|y=-1000|width=4000|height=4000|img=public/all/shadow.png|opacity=130|link=@exit>"..str
    --end
    say(player,str)
    lualib:ShowFormWithContent(player,"NPC打开_init")
    return true
end

---添加自定义属性
---@param player object  --玩家对象
---@param item object  --装备对象
---@param name string  --附加属性标题名字
---@param data tabele --需要属性表 {key = {{254,220,31,1,0},{254,219,32,1,1},{254,203,33,1,2}},value = {5,5,10}}--{颜色,属性,属性名字,(0属性值,1百分比),显示位置}
---@param type string -- + - =
---@param group number --自定义属性组
function lualib:AddCustomAttr(player,item,name,data,type,group)
    if not lualib:Player_IsPlayer(player) then return "" end
    type = type or "="
    group = group or 0
    changecustomitemtext(player,item,name,group)
    changecustomitemtextcolor(player,item,154,group)
    for i=1,#data.key do
        for j=1,#data.key[i] do
            changecustomitemabil(player,item,data.key[i][5],(j-1),data.key[i][j],group)
        end

        local value = lualib:CopyTable(data.value[i])
       ---- print(cfg_att_score_tb[data.key[i][2]],cfg_att_score_tb[data.key[i][2]].type)
        if cfg_att_score_tb[data.key[i][2]] ~= nil and cfg_att_score_tb[data.key[i][2]].type == 2 then
            value = value * 100
        end
        changecustomitemvalue(player,item,data.key[i][5],type,value,group)
    end

    refreshitem(player,item)
    recalcabilitys(player)

    if Stats and Stats.load then
        Stats.load(player)
    end
    return true
end
---个人标记
---@param player object  --玩家对象
---@param index integer  --索引(1-1000)
---@param value integer  --标记值(0,1)
function lualib:SetFlag(player,index,value)
    if not lualib:Player_IsPlayer(player) then return "" end
    setflagstatus(player,index,value)
    return true
end
---获取个人标记
---@param player object  --玩家对象
---@param index integer  --索引(1-1000)
function lualib:GetFlag(player,index)
    if not lualib:Player_IsPlayer(player) then return "" end
    return getflagstatus(player,index)
end

---获得背包所有物品
---@param player object  --玩家对象
---@param name string  --物品名字
---@param bind integer  --绑定状态(0全部,1不绑定,2绑定)
function lualib:GetBagItems(player,name,bind)
    name = name or nil
    bind = bind or 0
    if not lualib:Player_IsPlayer(player) then return "" end
    --getbagitems(player,name,bind)
    return getbagitems(player,name,bind)
end

---获得道具名字
---@param player object  --玩家对象
---@param item object  --道具对象
function lualib:ItemName(player,item)
    local name = getiteminfo(player,item,7)
    return name
end
---获得物品修改后的名字
---@param player object  --玩家对象
-----@param item object  --道具对象
function lualib:ItemNameEx(player,item)
    local name = getiteminfo(player,item,8)
    return name
end
--使用名字获得道具id
function lualib:GetItemIndex(itemname)
    local id = getstditeminfo(itemname,0)
    return id
end
---根据物品对象删除物品
---@param player object  --玩家对象
---@param item object  --道具对象
function lualib:DelItemObject(player,item)
    if not lualib:Player_IsPlayer(player) then return "" end
    --lualib:dbg(getiteminfo(player,item,1))
    delitembymakeindex(player,getiteminfo(player,item,1))
    return true
end
---根据物品对象获得唯一ID
---@param player object  --玩家对象
---@param item object  --道具对象
function lualib:GetMakeIndex(player,item)
    if not lualib:Player_IsPlayer(player) then return "" end
    return getiteminfo(player,item,1)
end
---获取玩家属性
---@param player object  --玩家对象
---@param attr interger  --属性名
function lualib:Attr(player,attr)
    if not lualib:Player_IsPlayer(player) then return "" end
    return getbaseinfo(player,51,tonumber(attr))
end

---增加血量百分比
---@param player object  --玩家对象
---@param percent number  --百分比
function lualib:AddHPEx(player,percent)
    addhpper(player,"+",percent)
    return true
end

---增加蓝量百分比
---@param player object  --玩家对象
---@param percent number  --百分比
function lualib:AddMPEx(player,percent)
    addmpper(player,"+",percent)
    return true
end

---减少血量百分比
---@param player object  --玩家对象
---@param percent number  --百分比
function lualib:DelHPEx(player,percent)
    addhpper(player,"-",percent)
    return true
end

---装备位获得物品对象
---@param player object  --玩家对象
---@param index integer  --装备位
function lualib:GetItem(player,index)
    if not lualib:Player_IsPlayer(player) then return "" end
    local item = linkbodyitem(player,index)
    if item == "0" or item == "" or item == nil then
        item = "0"
    end
    return item
end
---设置对象int变量
---@param player object  --怪物/NPC对象
---@param key integer  --变量名(1-50)
---@param value integer  --变量值
function lualib:SetObjectInt(player,key,value)
    setobjintvar(player,key,value)
    return true
end
---获得对象int变量
---@param player object  --怪物/NPC对象
---@param key integer  --变量名(1-50)
function lualib:GetObjectInt(player,index)
    return getobjintvar(player,index,key)
end

---设置对象int变量
---@param player object  --怪物/NPC对象
---@param key integer  --变量名(1-50)
---@param value integer  --变量值
function lualib:SetObjectStr(player,key,value)
    setobjstrvar(player,key,value)
    return true
end
---获得对象int变量
---@param player object  --怪物/NPC对象
---@param key integer  --变量名(1-50)
function lualib:GetObjectStr(player,index)
    return getobjstrvar(player,index,key)
end

---检查buff是否存在
---@param player object  --玩家对象
---@param buffid integer  --buffid
function lualib:HasBuff(player,buffid)
    return hasbuff(player,buffid)
end
---连接tips展示
---@param table table --tips
function lualib:TipsLink(table)
    local str = ""
    for i=1,#table do
        str = str.."^"..table[i]
    end
    return str
end
---根据名字获得玩家对象
---@param name string  --玩家名字
function lualib:GetGuidByName(name)
    return getplayerbyname(name)
end
---获得不规则table长度
---@param table table --tips
function lualib:GetTableLen(t)
    local count = 0
    for _ in pairs(t) do
        count = count + 1
    end
    return count
end

--转换数字为时间 xx:xx:xx
function lualib:TimeFormat(time)
    local hour = math.floor(time/3600)
    local minute = math.floor((time%3600)/60)
    local second = math.floor(time%60)
    return string.format("%02d:%02d:%02d",hour,minute,second)
end

--获得字符串中第一个连续的数字
function lualib:GetFirstNumber(str)
    return tonumber(string.match(str,"%d+"))
end

--获得玩家面前一格的坐标
---@param   direction integer --方向
---@param   playerPosition table --玩家坐标
function lualib:GetFrontPos(direction, playerPosition)
    local x, y = playerPosition[1], playerPosition[2]
    if direction == 0 then -- 东
        return {x + 1, y}
    elseif direction == 1 then -- 东北
        return {x + 1, y - 1}
    elseif direction == 2 then -- 北
        return {x, y - 1}
    elseif direction == 3 then -- 西北
        return {x - 1, y - 1}
    elseif direction == 4 then -- 西
        return {x - 1, y}
    elseif direction == 5 then -- 西南
        return {x - 1, y + 1}
    elseif direction == 6 then -- 南
        return {x, y + 1}
    elseif direction == 7 then -- 东南
        return {x + 1, y + 1}
    end
end

--杀死所有宝宝
function lualib:KillAllBaby(player)
    if not lualib:Player_IsPlayer(player) then return "" end
    local ncount = getbaseinfo(player,38)
    for i = 0 ,ncount-1 do
        local mon = getslavebyindex(player, i)
        if mon and isnotnull(mon) then
            killmonbyobj(player,mon,false,false,false)
        end
    end
    return true
end

--获得所有宝宝
function lualib:GetAllBaby(player)
    if not lualib:Player_IsPlayer(player) then return "" end
    local ncount = getbaseinfo(player,38)
    local tb = {}
    print("数量=====",ncount)
    for i = 0 ,ncount-1 do
        local mon = getslavebyindex(player, i)
        if mon and isnotnull(mon) then
            table.insert(tb,mon)
        end
    end

    return tb
end

--buff剩余时间
---@param player object  --玩家对象
---@param id integer  --buffid
function lualib:BuffTime(player,id)
    if not lualib:Player_IsPlayer(player) then return "" end

    if not lualib:HasBuff(player,id) then
        return 0
    end

    return getbuffinfo(player,id,2)
end

--创建镜像地图
--@param tb 创建表  --玩家对象
function lualib:CreateMirrorMap(tb)
    addmirrormap(tb[1],tb[2],tb[3],tb[4],tb[5],tb[6],tb[7],tb[8])
    return true
end

--增加寿命
--@param player object  --玩家对象
--@param value number  --增加值
function lualib:AddLife(player,value)
    if not lualib:Player_IsPlayer(player) then return "" end
    lualib:SetVar(player,VarCfg["最大寿命"],lualib:GetVar(player,VarCfg["最大寿命"])+value)
    --ScreenBtnData.age(player)
    return ture
end
--判断是否是跨服
--@param player object --玩家对象
function lualib:CheckKuaFu(player)
    if not lualib:Player_IsPlayer(player) then return false end
    return checkkuafu(player)
end

--判断是否是跨服跨服务器
--@param player object --玩家对象
function lualib:CheckKuaFuServer(player)
    if not lualib:Player_IsPlayer(player) then return false end
    return checkkuafuserver(player)
end


--数字转化成阿拉伯数字
function lualib:ArabicToChinese(num)
    local chineseNums = {[0] = "零", "一", "二", "三", "四", "五", "六", "七", "八", "九","十"}
    return chineseNums[num]
end

--获得今天周几
function lualib:GetWeek()
    local weekday_num = tonumber(os.date("%w"))
    local weekdays = {"周一", "周二", "周三", "周四", "周五", "周六","周日"}
    local today_weekday = weekdays[weekday_num]
    return today_weekday
end

--是否是攻城日期
function lualib:GetCastle()
    --local id = globalinfo(11)
    --if 1881 == id then
    --    return true
    --end

    if tonumber(globalinfo(3)) == 0 then
        print("是否攻城：没有合区.")
        return false
    end

    if castleinfo(5) then
        print("是否攻城：在攻城.")
        return true
    end

    if lualib:GetDBVar(VarCfg["今日是否攻城"]) == 1 then
        print("是否攻城：今日本日攻城.")
        return true
    end

    if lualib:GetDBVar(VarCfg["只开启一次本服攻城"]) == 0 then
        lualib:SetDBVar(VarCfg["只开启一次本服攻城"],1)
        lualib:SetDBVar(VarCfg["今日是否攻城"],1)
        print("是否攻城：今日本日攻城.")
        return true
    else
        if checkkuafuconnect() then
            local tb = {2,4,6}
            local weekday_num = tonumber(os.date("%w"))
            for i=1,#tb do
                if tb[i] == weekday_num then
                    print("是否攻城：今日"..weekday_num.."攻城.")
                    return true
                end
            end
        else
            print("xxxx--------跨服链接失败--------")
        end
    end

    return false
end

--连接字符串属性 addattlist
function lualib:LinkAttList(list)
    local str = ""
    for i=1,#list do
        str = str.."3#"..list[i] .. "|"
    end
    return str
end

---获得PK等级
---
function lualib:GetPK(player)
    if not lualib:Player_IsPlayer(player) then return false end
    return  getpklevel(player)
end

--获得行会名字
--@param player object  --玩家对象
function lualib:GetGuidName(player)
    if not lualib:Player_IsPlayer(player) then return false end
    return getbaseinfo(player,36)
end
---添加刀魂
---@param player object  --玩家对象
---@param max    number  --最大层数
---@param add    number  --添加层数
---@param attrType    opt  --默认+,=
---@param attr_tb  table  --参考 nil不添加属性
---@param type  number  --装备精度条索引（0~2）
---@param name string  --刀魂名字
---@param attr_name string  --增加属性名字
---@param open number  --是否打开
function lualib:SetProgress(player,max,item,add,attrType,attr_tb,type,name,attr_name,level)
    local data = json2tbl(getcustomitemprogressbar(player,item,type))
    max = tonumber(max)
    add = tonumber(add)

    attrType = attrType or "+"
    level = level or 1
    type = type or  1
    local cur = data.cur
    data.show = 2
    data.open = 1
    data.max = max
    data.color = 250
    data.level = level
    data.name = name
    data.imgcount = 1
    data.cur = cur + add

    if max == 0 then
        data.open = 0
    end

    if attrType == "=" then
        data.cur = add
    end

    if attr_tb ~= nil then
        lualib:AddCustomAttr(player,item,attr_name,attr_tb)
    end
    setcustomitemprogressbar(player,item,type,tbl2json(data))
    refreshitem(player,item)
    recalcabilitys(player)
    return true
end

---buff专用提示
---@param player object  --玩家对象
---@param type  number   --消息类型
---@param msg  string    --消息内容
---@param FColor number  --前景色
---@param BColor number  --背景色
---@param x number  --X坐标
---@param y number  --Y坐标
function lualib:SendBuffMsg(player,msg)
    sendcentermsg(player,246,0,msg,0)
    return true
end

---增加临时属性
---@param player object  --玩家对象
---@param name  string   --属性名字
---@param opt  string    --操作符 +、-、=
---@param attrStr string   --属性字符串
---@param type  number  --不填默认是0 (0,1,2)
function lualib:AddAttrList(player,name,opt,attrStr,type)
    if not lualib:Player_IsPlayer(player) then return false end
    type = type or 2
    addattlist(player,name,opt,attrStr,type)
    ---Stats.onCheckAttr(player)
    ServerCache.onUpdatePlayerNumberVars(player, "属性变化", 1)
    return true
end

---删除临时属性
---@param player object  --玩家对象
---@param name  string   --属性名字
function lualib:DelAttrList(player,name)
    if not lualib:Player_IsPlayer(player) then return false end
    delattlist(player,name)
    ---Stats.onCheckAttr(player)
    ServerCache.onUpdatePlayerNumberVars(player, "属性变化", 1)
    return true
end

---获得临时属性
---@param player object  --玩家对象
---@param name  string   --属性名字
function lualib:GetAttrList(player,name)
    if not lualib:Player_IsPlayer(player) then return false end
    return getattlist(player,name)
end

---把一个表转化成属性需要的字符串
---@param attr_tb  table  --属性表 {{1,2},{2,2}} 转化成 3#1#2|3#2#2
function lualib:AttrList2Str(attr_tb)
    local str = ""
    for i=1,#attr_tb do
        local attr = attr_tb[i]
        str = str.."3#"..attr[1].."#"..attr[2].."|"
    end

    return str
end
---把buff用的表结构改成需要的字符串
---@param attr_tb  table  --属性表 {[19]=1111,[20]=100} 转化成 3#19#11|3#20#100
function lualib:BuffAttrList2Str(attr_tb)
    local str = ""
    for k,v in pairs(attr_tb) do
        str = str.."3#"..k.."#"..v.."|"
    end
    return str
end

---转生等级
---@param player object  --玩家对象
function lualib:Rein(player)
    if not lualib:Player_IsPlayer(player) then return false end
    return getbaseinfo(player,39)
end

---转生等级
---@param player object  --玩家对象
---@param par number  --转生等级
function lualib:SetRein(player,par)
    if not lualib:Player_IsPlayer(player) then return false end
    GameEvent.push(EventCfg.onRein,player,par)
    setbaseinfo(player,39,par)
    return true
end

---黑屏
---@param player object  --玩家对象
---@param times number  --黑屏时间
function lualib:HeiPing(player,times,txt)
    times = tonumber(times) or 1
    txt = txt or "致盲"
    local w = 500
    local h = 500
    local str = [[
        <Img|ay=1|x=-10|y=0|width=]]..w..[[|height=]]..h..[[|img=public/bgk.png>
        <Layout|x=-1000|y=-1000|width=3000|height=3000|color=0>
        <Text|x=467.0|y=298.0|outline=1|color=103|size=24|outlinecolor=0|text=]]..txt..[[>
        <COUNTDOWN|id=5|x=520.0|y=298.0|time=]]..times..[[|outline=2|outlinecolor=0|color=254|count=1|size=24|link=@exit>
    ]]

    lualib:Say(player,str)
end

---设置物品int变量
---@param player object  --玩家对象
---@param item object    --道具对象
---@param key integer  --变量名(1-50)
---@param value integer --值
function lualib:SetItemInt(player,item,key,value)
    setitemintparam(player,-2,key,value,item)
    updatecustitemparam(player,-2,item)
    return true
end

---获得物品int变量
---@param player object --玩家对象
---@param item object   --道具对象
---@param key integer   --变量名(1-50)
function lualib:GetItemInt(player,item,key)
    local num = getitemintparam(player,-2,key,item)
    if num == nil then
        num = 0
    end
    return num
end

---设置物品int变量
---@param player object  --玩家对象
---@param item object    --道具对象
---@param key integer  --变量名(1-50)
---@param value string --值
function lualib:SetItemStr(player,item,key,value)
    setitemparam(player,-2,key,value,item)
    updatecustitemparam(player,-2,item)
    return true
end

---获得物品int变量
---@param player object --玩家对象
---@param item object   --道具对象
---@param key integer   --变量名(1-50)
function lualib:GetItemStr(player,item,key)
    if not lualib:Player_IsPlayer(player) then return false end
    return getitemparam(player,-2,key,item) or ""
end

---道具改名
---@param player object --玩家对象
---@param item object   --道具对象
---@param name string   --需要修改的道具名字
function lualib:ChangeItemName(player,item,name)
    changeitemname(player,-2,name,item)
    refreshitem(player,item)
    return  true
end

---删除装备位的名字
---@param player object --玩家对象
---@param index integer --装备位
---@param desc string --扣除描述
function lualib:DelBodyItem(player,index,desc)
    return delbodyitem(player,index,desc)
end

---添加角色等级
---@param player object --玩家对象
---@param opt string --操作符 + - =
---@param num number --改变等级
function lualib:AddLevel(player,num)
    if not lualib:Player_IsPlayer(player) then return false end
    changelevel(player,"+",num)
    return true
end

---获得装备星星数量
---@param player object --玩家对象
---@param item object --物品对象
function lualib:GetItemStars(player,item)
    if not lualib:Player_IsPlayer(player) then return false end
    return getitemaddvalue(player,item,2,3)
end

---强化加星
---@param player object --玩家对象
---@param item object --物品对象
---@param stars number  --加星数量
function lualib:AddItemStars(player,item,num)
    if not lualib:Player_IsPlayer(player) then return false end

    setitemaddvalue(player,item,2,3,getitemaddvalue(player,item,2,3) + num)
    return true
end

---强化加星
---@param player object --玩家对象
---@param item object --物品对象
---@param stars number  --加星数量
function lualib:SetItemStars(player,item,num)
    if not lualib:Player_IsPlayer(player) then return false end
    setitemaddvalue(player,item,2,3,num)
    return true
end

---改变 人/怪物 状态
---@param player object --玩家对象
---@param id integer --状态ID 0=绿毒;1=红毒;3=紫毒;5=麻痹;12=冰冻;13=蛛网
---@param time integer --持续时间
---@param value integer --威力
---@param model integer --是否进行防护的判断 （0/1）
function lualib:MakePosion(player,id,time,value,model)
    makeposion(player,id,time,value,model)
    if id == 5 or id == 12 or id == 13 then
        GameEvent.push(EventCfg.onControl,player)
    end

    return true
end

---改变人物模式
---@param player object --玩家对象
---@param id integer --状态ID
---@param time integer --持续时间
---@param value integer --参数1 （几率）
---@param model integer --参数2
function lualib:ChangeMode(player,id,time,param1,param2)
    param1 = param1 or 0
    param2 = param2 or 0

    makeposion(player,id,time,param1,param2)
    if id == 10 or id == 11 or id == 12 or id == 13 then
        GameEvent.push(EventCfg.onControl,player)
    end
    return true
end

---表进行反转操作
---@param t table --需要反转的表
---@param reversed table --返回的表
function lualib:ReverseKeyValue(t)
    local reversed = {}
    for k, v in ipairs(t) do
        reversed[v] = k
    end
    return reversed
end

---数字转化成天小时分钟秒
function lualib:Num2Time(seconds)
    -- 确保输入为数字，默认为0
    seconds = tonumber(seconds) or 0

    -- 定义各时间单位的秒数
    local day = 86400   -- 24*60*60
    local hour = 3600   -- 60*60
    local minute = 60

    -- 计算各单位数值
    local days = math.floor(seconds / day)
    seconds = seconds % day  -- 剩余秒数

    local hours = math.floor(seconds / hour)
    seconds = seconds % hour  -- 剩余秒数

    local minutes = math.floor(seconds / minute)
    local seconds = seconds % minute  -- 最终剩余秒数

    -- 构建结果字符串
    local timeStr = ""
    if days > 0 then
        timeStr = timeStr .. days .. "天"
    end
    if hours > 0 then
        timeStr = timeStr .. hours .. "小时"
    end
    if minutes > 0 then
        timeStr = timeStr .. minutes .. "分钟"
    end
    -- 即使秒数为0也显示，确保至少有一个时间单位
    timeStr = timeStr .. seconds .. "秒"

    return timeStr
end

--- 功能：获取表中的最大值或最小值
--- 参数：
---   tbl - 要处理的表（假设表中元素都是数字）
---   mode - 模式，"max" 表示求最大值，"min" 表示求最小值 不填默认为 "min"
--- 返回值：表中的最大值或最小值，如果表为空则返回 nil
function lualib:GetExtremeValue(tbl, mode)
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

--- 设置合区次数 （主区为准）
function lualib:SetMergeCount()
    -------------------------------------------------------合区次数计算---------------------------------------------------
    inisysvar("integer","合区次数标记",6)         --标记合区标记 合区清除
    inisysvar("integer","主区合区次数",1)         --主区合区次数 取主区的合区次数

    if getsysvarex("合区次数标记") == 0 then      --标记为0时，表示刚合区过 主区合区次数 + 1 标记设置为1
        local num = getsysvarex("主区合区次数")
        setsysvarex("主区合区次数",num + 1,1)
        setsysvarex("合区次数标记",1,1)
    end
    ------------------------------------------------------合区次数计算结束-------------------------------------------------
    return true
end
--- 获取合区次数
function lualib:GetMergeCount()
    inisysvar("integer","合区次数标记",6)         --标记合区标记 合区清除
    inisysvar("integer","主区合区次数",1)         --主区合区次数 取主区的合区次数
    return getsysvarex("主区合区次数")
end

---获取地图是否是主城
function lualib:IsMainCity(player,page)
    if not lualib:Player_IsPlayer(player) then return false end
    local flag = false
    page = page or 2
    local mapName = lualib:GetMapId(player)
    if anQuanXiang.config[mapName] ~= nil then
        if anQuanXiang.config[mapName].type == page then
            flag = true
        end
    end
    return flag
end

---获得职业（1战，2法，3道）
function lualib:Job(player)
    if not lualib:Player_IsPlayer(player) then return false end
    return getbaseinfo(player,7) + 1
end

---获得性别（1男，2女）
function lualib:Sex(player)
    if not lualib:Player_IsPlayer(player) then return false end
    return getbaseinfo(player,8) + 1
end

---增加经验
function lualib:AddExp(player,exp)
    if not lualib:Player_IsPlayer(player) then return false end
    changeexp(player,"+",exp)
    sheZhiDengJi.setLevel(player)
    return true
end

---设置职业
function lualib:SetJob(player,job)
    if not lualib:Player_IsPlayer(player) then return false end
    setbaseinfo(player,7,job - 1)
    return true
end

---获得方向
function lualib:GetDirection(player)
    ---if not lualib:Player_IsPlayer(player) then return false end
    return getbaseinfo(player,69)
end

return lualib