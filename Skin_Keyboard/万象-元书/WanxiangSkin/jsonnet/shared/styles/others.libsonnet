// 定义共享尺寸与几何常量。

local Settings = import '../../../Custom.libsonnet';

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
    'toolbar高度': Settings.toolbar_config.toolbar_height,
    'keyboard高度': 240,
    '键盘总高度': sumHeights([
      self['preedit高度'],
      self['toolbar高度'],
      self['keyboard高度'],
    ]),
  },
  '横屏': {
    'preedit高度': 15,
    'toolbar高度': Settings.toolbar_config.toolbar_height,
    'keyboard高度': 205,
    '键盘总高度': sumHeights([
      self['preedit高度'],
      self['toolbar高度'],
      self['keyboard高度'],
    ]),
  },

}
