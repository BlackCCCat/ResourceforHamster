-- Rime Script >https://github.com/baopaau/rime-lua-collection/blob/master/calculator_translator.lua
-- 簡易計算器（執行任何Lua表達式）
--
-- 格式：=<exp>
-- Lambda語法糖：\<arg>.<exp>|
--
-- 例子：
-- =1+1 輸出 2
-- =floor(9^(8/7)*cos(deg(6))) 輸出 -3
-- =e^pi>pi^e 輸出 true
-- =max({1,7,2}) 輸出 7
-- =map({1,2,3},\x.x^2|) 輸出 {1, 4, 9}
-- =map(range(-5,5),\x.x*pi/4|,deriv(sin)) 輸出 {-0.7071, -1, -0.7071, 0, 0.7071, 1, 0.7071, 0, -0.7071, -1}
-- =$(range(-50,50))(map,\x.x/100|,\x.-60*x^2-16*x+20|)(max)() 輸出 21.066

-- 需在方案增加 `recognizer/patterns/expression: "^=.*$"`

-- 定義全局函數、常數（注意命名空間污染）
cos = math.cos
sin = math.sin
tan = math.tan
acos = math.acos
asin = math.asin
atan = math.atan
rad = math.rad
deg = math.deg

abs = math.abs
floor = math.floor
ceil = math.ceil
mod = math.fmod
trunc = function (x, dc)
  if dc == nil then
    return math.modf(x)
  end
  return x - mod(x, dc)
end

round = function (x, dc)
  dc = dc or 1
  local dif = mod(x, dc)
  if abs(dif) > dc / 2 then
    return x < 0 and x - dif - dc or x - dif + dc
  end
  return x - dif
end

random = math.random
randomseed = math.randomseed

inf = math.huge
MAX_INT = math.maxinteger
MIN_INT = math.mininteger
pi = math.pi
sqrt = math.sqrt
exp = math.exp
e = exp(1)
ln = math.log
log = function (x, base)
  base = base or 10
  return ln(x)/ln(base)
end

min = function (arr)
  local m = inf
  for k, x in ipairs(arr) do
   m = x < m and x or m
  end
  return m
end

max = function (arr)
  local m = -inf
  for k, x in ipairs(arr) do
   m = x > m and x or m
  end
  return m
end

sum = function (t)
  local acc = 0
  for k,v in ipairs(t) do
    acc = acc + v
  end
  return acc
end

avg = function (t)
  return sum(t) / #t
end

isinteger = function (x)
  return math.fmod(x, 1) == 0
end

-- iterator . array
array = function (...)
  local arr = {}
  for v in ... do
    arr[#arr + 1] = v
  end
  return arr
end

-- iterator <- [form, to)
irange = function (from,to)
  if to == nil then
    to = from
    from = 0
  end
  local i = from - 1
  to = to - 1
  return function()
    if i < to then
      i = i + 1
      return i
    end
  end
end

-- array <- [form, to)
range = function (from, to)
  return array(irange(from, to))
end

-- array . reversed iterator
irev = function (arr)
  local i = #arr + 1
  return function()
    if i > 1 then
      i = i - 1
      return arr[i]
    end
  end
end

-- array . reversed array
arev = function (arr)
  return array(irev(arr))
end


-- # Functional
map = function (t, ...)
  local ta = {}
  for k,v in pairs(t) do
    local tmp = v
    for _,f in pairs({...}) do tmp = f(tmp) end
    ta[k] = tmp
  end
  return ta
end

filter = function (t, ...)
  local ta = {}
  local i = 1
  for k,v in pairs(t) do
    local erase = false
    for _,f in pairs({...}) do
      if not f(v) then
        erase = true
        break
      end
    end
    if not erase then
	  ta[i] = v
	  i = i + 1
    end
  end
  return ta
end

-- e.g: foldr({2,3},\n,x.x^n|,2) = 81
foldr = function (t, f, val)
  for k,v in pairs(t) do
    val = f(val, v)
  end
  return val
end

-- e.g: foldl({2,3},\n,x.x^n|,2) = 512
foldl = function (t, f, val)
  for v in irev(t) do
    val = f(val, v)
  end
  return val
end

-- 調用鏈生成函數（HOF for method chaining）
-- e.g: chain(range(-5,5))(map,\x.x/5|)(map,sin)(map,\x.e^x*10|)(map,floor)()
--    = floor(map(map(map(range(-5,5),\x.x/5|),sin),\x.e^x*10|))
--    = {4, 4, 5, 6, 8, 10, 12, 14, 17, 20}
-- 可以用 $ 代替 chain
chain = function (t)
  local ta = t
  local function cf(f, ...)
    if f ~= nil then
      ta = f(ta, ...)
      return cf
    else
      return ta
    end
  end
  return cf
end

-- # Statistics
fac = function (n)
  local acc = 1
  for i = 2,n do
    acc = acc * i
  end
  return acc
end

nPr = function (n, r)
  return fac(n) / fac(n - r)
end

nCr = function (n, r)
  return nPr(n,r) / fac(r)
end

MSE = function (t)
  local ss = 0
  local s = 0
  local n = #t
  for k,v in ipairs(t) do
    ss = ss + v*v
    s = s + v
  end
  return sqrt((n*ss - s*s) / (n*n))
end

-- # Linear Algebra


-- # Calculus
-- Linear approximation
lapproxd = function (f, delta)
  local delta = delta or 1e-8
  return function (x)
           return (f(x+delta) - f(x)) / delta
         end
end

-- Symmetric approximation
sapproxd = function (f, delta)
  local delta = delta or 1e-8
  return function (x)
           return (f(x+delta) - f(x-delta)) / delta / 2
         end
end

-- 近似導數
deriv = function (f, delta, dc)
  dc = dc or 1e-4
  local fd = sapproxd(f, delta)
  return function (x)
           return round(fd(x), dc)
         end
end

-- Trapezoidal rule
trapzo = function (f, a, b, n)
  local dif = b - a
  local acc = 0
  for i = 1, n-1 do
    acc = acc + f(a + dif * (i/n))
  end
  acc = acc * 2 + f(a) + f(b)
  acc = acc * dif / n / 2
  return acc
end

-- 近似積分
integ = function (f, delta, dc)
  delta = delta or 1e-4
  dc = dc or 1e-4
  return function (a, b)
           if b == nil then
             b = a
             a = 0
           end
           local n = round(abs(b - a) / delta)
           return round(trapzo(f, a, b, n), dc)
         end
end

-- Runge-Kutta
rk4 = function (f, timestep)
  local timestep = timestep or 0.01
  return function (start_x, start_y, time)
           local x = start_x
           local y = start_y
           local t = time
           -- loop until i >= t
           for i = 0, t, timestep do
             local k1 = f(x, y)
             local k2 = f(x + (timestep/2), y + (timestep/2)*k1)
             local k3 = f(x + (timestep/2), y + (timestep/2)*k2)
             local k4 = f(x + timestep, y + timestep*k3)
             y = y + (timestep/6)*(k1 + 2*k2 + 2*k3 + k4)
             x = x + timestep
           end
           return y
         end
end


-- # System
date = os.date
time = os.time
path = function ()
  return debug.getinfo(1).source:match("@?(.*/)")
end



local function serialize(obj)
  local type = type(obj)
  if type == "number" then
    return isinteger(obj) and floor(obj) or obj
  elseif type == "boolean" then
    return tostring(obj)
  elseif type == "string" then
    return '"'..obj..'"'
  elseif type == "table" then

    local str = "{"
    local i = 1
    for k, v in pairs(obj) do
      if i ~= k then  
        str = str.."["..serialize(k).."]="
      end
      str = str..serialize(v)..", "  
      i = i + 1
    end
    str = str:len() > 3 and str:sub(0,-3) or str
    return str.."}"
  elseif pcall(obj) then -- function類型
    return "callable"
  end
  return obj
end

-- greedy：隨時求值（每次變化都會求值，否則結尾爲特定字符時求值）
local greedy = true

local function splitNumStr(str)
    --[[
    split a number (or a string describing a number) into 4 parts:
    .sym: "+", "-" or ""
    .int: "0", "000", "123456", "", etc
    .dig: "." or ""
    .dec: "0", "10000", "00001", "", etc
  --]]
    local part = {}
    part.sym, part.int, part.dig, part.dec = string.match(str, "^([%+%-]?)(%d*)(%.?)(%d*)")
    return part
end

local function speakLiterally(str, valMap)
    valMap = valMap or {
        [0] = "零",
        "一",
        "二",
        "三",
        "四",
        "五",
        "六",
        "七",
        "八",
        "九",
        "十",
        ["+"] = "正",
        ["-"] = "负",
        ["."] = "点",
        [""] = ""
    }

    local tbOut = {}
    for k = 1, #str do
        local v = string.sub(str, k, k)
        v = tonumber(v) or v
        tbOut[k] = valMap[v]
    end
    return table.concat(tbOut)
end


local function speakBar(str, posMap, valMap)
	posMap = posMap or {[1]="仟"; [2]="佰"; [3]="拾"; [4]=""}
	valMap = valMap or {[0]="零"; "一"; "二"; "三" ;"四"; "五"; "六"; "七"; "八"; "九"} -- the length of valMap[0] should not excess 1

	local out = ""
	local bar = string.sub("****" .. str, -4, -1) -- the integer part of a number string can be divided into bars; each bar has 4 bits
	for pos = 1, 4 do
		local val = tonumber(string.sub(bar, pos, pos))
		-- case1: place holder
		if val == nil then
			goto continue
		end
		-- case2: number 1~9
		if val > 0 then
			out = out .. valMap[val] .. posMap[pos]
			goto continue
		end
		-- case3: number 0
		local valNext = tonumber(string.sub(bar, pos+1, pos+1))
		if ( valNext==nil or valNext==0 )then
			goto continue
		else
			out = out .. valMap[0]
			goto continue
		end
	::continue::
	end
	if out == "" then out = valMap[0] end
	return out
end


local function speakIntOfficially(str, posMap, valMap)
    posMap = posMap or { [1] = "千",[2] = "百",[3] = "十",[4] = "" }
    valMap = valMap or
        { [0] = "零", "一", "二", "三", "四", "五", "六", "七", "八", "九" } -- the length of valMap[0] should not excess 1

    -- split the number string into bars, for example, in:str=123456789 → out:tbBar={1|2345|6789}
    local int = string.match(str, "^0*(%d+)$")
    if int == "" then int = "0" end
    local remain = #int % 4
    if remain == 0 then remain = 4 end
    local tbBar = { [1] = string.sub(int, 1, remain) }
    for pos = remain + 1, #int, 4 do
        local bar = string.sub(int, pos, pos + 3)
        table.insert(tbBar, bar)
    end
    -- generate the suffixes of each bar, for example, tbSpeakBarSuffix={亿|万|""}
    local tbSpeakBarSuffix = { [1] = "" }
    for iBar = 2, #tbBar do
        local suffix = (iBar % 2 == 0) and ("万" .. tbSpeakBarSuffix[1]) or ("亿" .. tbSpeakBarSuffix[2])
        table.insert(tbSpeakBarSuffix, 1, suffix)
    end
    -- speak each bar
    local tbSpeakBar = {}
    for k = 1, #tbBar do
        tbSpeakBar[k] = speakBar(tbBar[k], posMap, valMap)
    end
    -- combine the results
    local out = ""
    for k = 1, #tbBar do
        local speakBar = tbSpeakBar[k]
        if speakBar ~= valMap[0] then
            out = out .. speakBar .. tbSpeakBarSuffix[k]
        end
    end
    if out == "" then out = valMap[0] end
    return out
end

local function speakDecMoney(str, posMap, valMap)
	posMap = posMap or {[1]="角"; [2]="分"; [3]="厘"; [4]="毫"}
	valMap = valMap or {[0]="零"; "壹"; "贰"; "叁" ;"肆"; "伍"; "陆"; "柒"; "捌"; "玖"} -- the length of valMap[0] should not excess 1

	local dec = string.sub(str, 1, 4)
	dec = string.gsub(dec, "0*$", "")
	if dec == "" then
		return "整"
	end

	local out = ""
	for pos = 1, #dec do
		local val = tonumber(string.sub(dec, pos, pos))
		out = out .. valMap[val] .. posMap[pos]
	end
	return out
end

local function speakMoney(str)
    local part = splitNumStr(str)
    local speakSym = speakLiterally(part.sym)
    local speakInt = speakIntOfficially(part.int, { [1] = "仟",[2] = "佰",[3] = "拾",[4] = "" },
    { [0] = "零", "壹", "贰", "叁", "肆", "伍", "陆", "柒", "捌", "玖" }) .. "元"
    local speakDec = speakDecMoney(part.dec)
    local out = speakSym .. speakInt .. speakDec
    return out
end



local function calculator_translator(input, seg)
  if string.sub(input, 1, 1) ~= "=" then return end

  if string.sub(input,-2,2)=="//" then 
    input = string.sub(input,-1,-2).."("

  end
  
  local expfin = greedy or string.sub(input, -1, -1) == ";"
  local exp = (greedy or not expfin) and string.sub(input, 2, -1) or string.sub(input, 2, -2)
  -- yield(Candidate("123123",seg.start, seg._end, ""..exp, "表達式111",9))
  
  -- 空格輸入可能
  exp = exp:gsub("#", " ")
  
-- yield(Candidate("number", seg.start, seg._end, exp, "表達式"))

  -- if string.sub(input, -1) == "/" then yield(Candidate("number", seg.start, seg._end, "", "表達式")) return end
  -- if string.sub(input, -1) == "*" then yield(Candidate("number", seg.start, seg._end, "", "表達式")) return end
  -- if string.sub(input, -1) == "-" then yield(Candidate("number", seg.start, seg._end, "", "表達式")) return end
  -- if string.sub(input, -1) == "+" then yield(Candidate("number", seg.start, seg._end, "", "表達式")) return end
  -- if string.sub(input, -1) == "(" then yield(Candidate("number", seg.start, seg._end, "", "表達式")) return end
  
  if not expfin then return end
  
  local expe = exp
  -- 鏈式調用語法糖
  expe = expe:gsub("%$", " chain ")
  -- lambda語法糖
  do
    local count
    repeat
      expe, count = expe:gsub("\\%s*([%a%d%s,_]-)%s*%.(.-)|", " (function (%1) return %2 end) ")
    until count == 0
  end
  -- yield(Candidate("number", seg.start, seg._end, expe, "展開"))
  
  -- 防止危險操作，禁用os和io命名空間
  if expe:find("i?os?%.") then return end

  --yield(Candidate("text",seg.start, seg._end, expe, "表达式"))
  local result  = load("return "..expe)()
  -- return語句保證了只有合法的Lua表達式才可執行
  if result == nil then  return end
  

  -- if result == false then yield(Candidate("text",seg.start, seg._end, expe, "表達式")) return end
  
  result = serialize(result)
  yield(Candidate("number", seg.start, seg._end, result, "答案"))
  yield(Candidate("number", seg.start, seg._end, speakMoney(result), " 金额"))
  yield(Candidate("number", seg.start, seg._end, exp.."="..result, "等式","123"))

end

return calculator_translator
