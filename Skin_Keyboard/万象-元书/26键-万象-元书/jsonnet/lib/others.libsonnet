local fromVh(s) =
  local num = std.substr(s, 0, std.length(s) - 2);
  std.parseJson(num);

local sumVh(arr) = (
  local sum = std.foldl(
    function(acc, v) acc + fromVh(v),
    arr,
    0
  );
  std.toString(sum) + 'vh'
);

local sumHeights(arr) = (
  if std.length(arr) == 0 then
    null  // 空数组返回 null（或自定义默认值）
  else if std.type(arr[0]) == 'string' && std.endsWith(arr[0], 'vh') then
    sumVh(arr)
  else
    std.sum(arr)
);
// 以上为键盘高度求和函数，勿动

{
  // 杂项设置
  // 键盘高度，建议统一使用同一单位，不要混用
  '竖屏': {
    'preedit高度': 15,
    'toolbar高度': 50,
    'keyboard高度': 240,
    '键盘总高度': sumHeights([
      self['preedit高度'],
      self['toolbar高度'],
      self['keyboard高度'],
    ]),
  },
  '横屏': {
    'preedit高度': 15,
    'toolbar高度': 50,
    'keyboard高度': 200,
    '键盘总高度': sumHeights([
      self['preedit高度'],
      self['toolbar高度'],
      self['keyboard高度'],
    ]),
  },

  // 方案绑定
  // 英文键盘若不设置绑定方案(注释掉)，英文键盘中的按键action会自动转为symbol，即自动上屏，缺点是不能进行'联想'。
  // "中文键盘方案": "tigress",
  // "英文键盘方案": "easy_english",
}
