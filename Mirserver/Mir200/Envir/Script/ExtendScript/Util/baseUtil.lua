--- table深拷贝
--- @param src table 源表
--- @param dest table 目标表
function table.deepCopy(src, dest)
    if type(src) ~= "table" then
        return src
    end
    if dest == nil then
        dest = {}
    end
    for k, v in pairs(src) do
        if type(v) == "table" then
            dest[k] = {}
            lualib:DeepCopy(v, dest[k])
        else
            dest[k] = v
        end
    end
    return dest
end

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
    symbol = symbol or "/"
    return os.date("%Y"..symbol.."%m"..symbol.."%d %H:%M:%S", timestamp)
end
--获取字符串时间的差值:字符串时间，时间格式：Y-m-d或H:M:S或Y-m-d
function TimeDiff( strDateTime1,strDateTime2)
    return Str2Time(strDateTime2)-Str2Time(strDateTime1)
end
--将时间戳计算为字符型时间（例：20小时5分10秒）
function CalcStrTime(time,type)
    ----release_print("xsksksksk")
    type = type or 1
    local seconds = math.mod(time, 60)
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
    local args = {...}
    for i = 1, #args do
        if type(args[i]) == "table" then

            args[i] = serialize(args[i])
        end
        release_print("进来了",serialize(args[i]))
    end

    release_print(unpack(args))
end

function PRINT(...)
    print(...)
end

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

-- 优化后的 string.split 函数，按分隔符将字符串拆分成表格
function string.splitEX(input, delimiter)
    -- 处理输入为 nil 的情况
    if input == nil then
        return {}
    end
    -- 将输入和分隔符转换为字符串
    input = tostring(input)
    delimiter = tostring(delimiter)
    -- 若分隔符为空字符串，直接返回仅包含输入字符串的表
    if delimiter == '' then
        return {input}
    end

    local result = {}
    local startIndex = 1
    -- 循环查找分隔符
    while true do
        -- 查找分隔符的起始位置
        local delimiterStart, delimiterEnd = string.find(input, delimiter, startIndex, true)
        if delimiterStart then
            -- 提取分隔符前的子字符串并添加到结果表中
            table.insert(result, string.sub(input, startIndex, delimiterStart - 1))
            -- 更新起始位置为分隔符结束位置的下一个字符
            startIndex = delimiterEnd + 1
        else
            -- 若未找到分隔符，提取剩余的子字符串并添加到结果表中
            table.insert(result, string.sub(input, startIndex))
            break
        end
    end
    return result
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
    return tbl2json(obj)
end
--反序列化
function deserialize(text)
    return json2tbl(text)
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

