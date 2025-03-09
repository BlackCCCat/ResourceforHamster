-- Rime Script >https://github.com/baopaau/rime-lua-collection/blob/master/calculator.lua
-- 簡易計算器（執行任何Lua表達式）
-- modify: 空山明月
-- date: 2024-05-10
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
-- =$(range(-5,5,0.01))(map,\x.-60*x^2-16*x+20|)(max)() 輸出 21.066
-- =test(\x.trunc(sin(x),1e-3)==trunc(deriv(cos)(x),1e-3)|,range(-2,2,0.1)) 輸出 true
--
-- 函数名 	描述 	格式 	结果
-- pi 	圆周率 	=pi 	3.1415926535898
-- abs 	取绝对值 	=abs(-2012) 	2012
-- ceil 	向上取整 	=ceil(9.1) 	10
-- floor 	向下取整 	=floor(9.9) 	9
-- max 	取参数最大值 	=max(2,4,6,8) 	8
-- min 	取参数最小值 	=min(2,4,6,8) 	2
-- pow 	计算x的y次幂 	=pow(2,16) 	65536
-- sqrt 	开平方 	=sqrt(65536) 	256
-- mod 	取模 	=mod(65535,2) 	1
-- modf 	取整数和小数部分 	=modf(20.12) 	20   0.12
-- randomseed 	设随机数种子 	=randomseed(os.time()) 	　
-- random 	取随机数 	=random(5,90) 	5~90
-- rad 	角度转弧度 	=rad(180) 	3.1415926535898
-- deg 	弧度转角度 	=deg(=pi) 	180
-- exp 	e的x次方 	=exp(4) 	54.598150033144
-- log 	计算x的自然对数 	=log(54.598150033144) 	4
-- log10 	计算10为底，x的对数 	=log10(1000) 	3
-- frexp 	将参数拆成x * (2 ^ y)的形式 	=frexp(160) 	0.625    8
-- ldexp 	计算x * (2 ^ y) 	=ldexp(0.625,8) 	160
-- sin 	正弦 	=sin(rad(30)) 	0.5
-- cos 	余弦 	=cos(rad(60)) 	0.5
-- tan 	正切 	=tan(rad(45)) 	1
-- asin 	反正弦 	=deg(asin(0.5)) 	30
-- acos 	反余弦 	=deg(acos(0.5)) 	60
-- atan 	反正切 	=deg(atan(1)) 	45
-- ————————————————



-- 安装：
-- - 將本文件保存至 <rime>/lua/
-- - 在 <rime>/rime.lua 新增一行：
--   `calculator = require("calculator")`
-- - 在 <rime>/<schema>.schema.yaml 新增：
--   `engine/translators/@next: lua_translator@calculator`
--   `recognizer/patterns/expression: "^=.*$"`
-- 註：
-- - <rime> 替換爲RIME的共享目錄
-- - <schema> 替換爲自己的方案ID
-- - 如目錄／文件不存在，請自行創建

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
irange = function (from, to, step)
  if to == nil then
    to = from
    from = 0
  end
  step = step or 1
  local i = from - step
  to = to - step
  return function()
    if i < to then
      i = i + step
      return i
    end
  end
end

-- array <- [form, to)
range = function (from, to, step)
  return array(irange(from, to, step))
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

test = function (f, t)
  for k,v in ipairs(t) do
    if not f(v) then
      return false
    end
  end
  return true
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
foldr = function (t, f, acc)
  for k,v in pairs(t) do
    acc = f(acc, v)
  end
  return acc
end

-- e.g: foldl({2,3},\n,x.x^n|,2) = 512
foldl = function (t, f, acc)
  for v in irev(t) do
    acc = f(acc, v)
  end
  return acc
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




local function speakLiterally(str, valMap)
	valMap = valMap or {
		[0]="零"; "一"; "二"; "三"; "四"; "五"; "六"; "七"; "八"; "九"; "十";
		["+"]="正"; ["-"]="负"; ["."]="点"; [""]=""
	}

	local tbOut = {}
	for k = 1, #str do
		local v = string.sub(str, k, k)
		v = tonumber(v) or v
		tbOut[k] = valMap[v]
	end
	return table.concat(tbOut)
end

local function speakMillitary(str)
	return speakLiterally(str, {[0]="洞"; "幺"; "两"; "三"; "四"; "五"; "六"; "拐"; "八"; "勾"; "十";["+"]="正"; ["-"]="负"; ["."]="点"; [""]=""})
end

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
	posMap = posMap or {[1]="千"; [2]="百"; [3]="十"; [4]=""}
	valMap = valMap or {[0]="零"; "一"; "二"; "三" ;"四"; "五"; "六"; "七"; "八"; "九"} -- the length of valMap[0] should not excess 1

	-- split the number string into bars, for example, in:str=123456789 → out:tbBar={1|2345|6789}
	local int = string.match(str, "^0*(%d+)$")
	if int=="" then int = "0" end
	local remain = #int % 4
	if remain==0 then remain = 4 end
	local tbBar = {[1] = string.sub(int, 1, remain)}
	for pos = remain+1, #int, 4 do
		local bar = string.sub(int, pos, pos+3)
		table.insert(tbBar, bar)
	end
	-- generate the suffixes of each bar, for example, tbSpeakBarSuffix={亿|万|""}
	local tbSpeakBarSuffix = {[1]=""}
	for iBar = 2, #tbBar do
		local suffix = (iBar % 2 == 0) and ("万"..tbSpeakBarSuffix[1]) or ("亿"..tbSpeakBarSuffix[2])
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

local function speakOfficiallyLower(str)
	local part = splitNumStr(str)
	local speakSym = speakLiterally(part.sym)
	local speakInt = speakIntOfficially(part.int)
	local speakDig = speakLiterally(part.dig)
	local speakDec = speakLiterally(part.dec)
	local out = speakSym .. speakInt .. speakDig .. speakDec
	return out
end

local function speakOfficiallyUpper(str)
  local part = splitNumStr(str)
	local speakSym = speakLiterally(part.sym)
	local speakInt = speakIntOfficially(part.int, {[1]="仟"; [2]="佰"; [3]="拾"; [4]=""}, {[0]="零"; "壹"; "贰"; "叁" ;"肆"; "伍"; "陆"; "柒"; "捌"; "玖"})
	local speakDig = speakLiterally(part.dig)
	local speakDec = speakLiterally(part.dec)
	local out = speakSym .. speakInt .. speakDig .. speakDec
	return out
end

local function speakMoneyUpper(str)
	local part = splitNumStr(str)
	local speakSym = speakLiterally(part.sym)
	local speakInt = speakIntOfficially(part.int, {[1]="仟"; [2]="佰"; [3]="拾"; [4]=""}, {[0]="零"; "壹"; "贰"; "叁" ;"肆"; "伍"; "陆"; "柒"; "捌"; "玖"}) .. "元"
	local speakDec = speakDecMoney(part.dec)
	local out = speakSym .. speakInt .. speakDec
	return out
end

local function speakMoneyLower(str)
	local part = splitNumStr(str)
	local speakSym = speakLiterally(part.sym)
	local speakInt = speakIntOfficially(part.int, {[1]="千"; [2]="百"; [3]="十"; [4]=""}, {[0]="〇"; "一"; "二"; "三" ;"四"; "五"; "六"; "七"; "八"; "九"}) .. "元"
	local speakDec = speakDecMoney(part.dec)
	local out = speakSym .. speakInt .. speakDec
	return out
end

local function baseConverse(str, from, to)
	local str10 = str
	if from == 16 then
		str10 = string.format("%d", str)
	end
	local strout = str10
	if to == 16 then
		strout = string.format("%#x", str10)
	end
	return strout
end



-- greedy：隨時求值（每次變化都會求值，否則結尾爲特定字符時求值）
local greedy = true

local function calculator(input, seg)
  if string.sub(input, 1, 1) ~= "=" then return end
  
  local expfin = greedy or string.sub(input, -1, -1) == ";"
  local exp = (greedy or not expfin) and string.sub(input, 2, -1) or string.sub(input, 2, -2)
  
  -- 空格輸入可能
  exp = exp:gsub("#", " ")
  
  -- yield(Candidate("number", seg.start, seg._end, exp, "表達式"))
       
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
  --yield(Candidate("number", seg.start, seg._end, expe, "展開"))

  -- 防止危險操作，禁用os和io命名空間
  if expe:find("i?os?%.") then return end
  -- return語句保證了只有合法的Lua表達式才可執行
  local result = load("return "..expe)()
  if result == nil then return end
  
  result = serialize(result)
  yield(Candidate("number", seg.start, seg._end, result, "〈计算结果〉"))
 -- yield(Candidate("number", seg.start, seg._end, exp.." = "..result, "等式"))


  if string.match(result, "^[%+%-]?%d*%.?%d*$") then -- sadly, lua does not support regex like {0,4}
    -- comment or reorder following lines to adjust the effects
    yield(Candidate("number", seg.start, seg._end, exp.."="..result, "〈计算等式〉","123"))
    -- yield(Candidate("number", seg.start, seg._end, result, "〈计算结果〉"))
    yield(Candidate("number", seg.start, seg._end, speakMoneyUpper(result), "〈大写金额〉"))
    yield(Candidate("number", seg.start, seg._end, speakMoneyLower(result), "〈小写金额〉"))
    yield(Candidate("number", seg.start, seg._end, speakOfficiallyUpper(result), "〈大写数字〉"))
    yield(Candidate("number", seg.start, seg._end, speakOfficiallyLower(result), "〈小写数字〉"))
  end
end

return calculator
