// 两套拼音键盘共存：副布局的全部顶层定义均加前缀，引用仅在确认为定义名时重写。
local Settings = import '../../Custom.libsonnet';
local p9 = import '../pinyin9/keyboard.libsonnet';
local p14 = import '../pinyinGrouped/pinyin14/keyboard.libsonnet';
local p17 = import '../pinyinGrouped/pinyin17/keyboard.libsonnet';
local p18 = import '../pinyinGrouped/pinyin18/keyboard.libsonnet';
local p26 = import '../keyboard26/pinyin/keyboard.libsonnet';
local moduleFor(n) = if n == 9 then p9 else if n == 14 then p14 else if n == 17 then p17 else if n == 18 then p18 else p26;
local valid(n) = std.member([9, 14, 17, 18, 26, 27], n);
local primary = if valid(Settings.keyboard_layout) then Settings.keyboard_layout else 26;
local requested = if std.objectHas(Settings, 'split_keyboard_layout') then Settings.split_keyboard_layout else 9;
local secondary = if valid(requested) && requested != primary then requested else if primary == 9 then 26 else 9;
local prefix = 'splitSecondary__';
local rewrite(value, definitions) =
  if std.type(value) == 'string' then
    if std.objectHas(definitions, value) then prefix + value else value
  else if std.type(value) == 'array' then
    [rewrite(item, definitions) for item in value]
  else if std.type(value) == 'object' then
    { [key]: rewrite(value[key], definitions) for key in std.objectFields(value) }
  else value;
{
  primaryLayout: primary,
  secondaryLayout: secondary,
  new(theme, orientation):
    local main = moduleFor(primary).new(theme, orientation, primary);
    local other = moduleFor(secondary).new(theme, orientation, secondary);
    local renamed = { [prefix + key]: rewrite(other[key], other) for key in std.objectFields(other) if key != 'keyboardLayout' };
    // 原 keyboardLayout 为行数组；双层 VStack 用样式的 split 覆写显隐。
    // 功能行由两套布局各自产出一次，保持各自通知绑定。
    main + renamed + {
      splitPrimaryColumnStyle: {
        size: { width: '1' },
        split: { size: { width: '0' } },
      },
      splitSecondaryColumnStyle: {
        size: { width: '0' },
        split: { size: { width: '1' } },
      },
      keyboardLayout: [
        { HStack: { subviews: [
          { VStack: { style: 'splitPrimaryColumnStyle', subviews: main.keyboardLayout } },
          { VStack: { style: 'splitSecondaryColumnStyle', subviews: rewrite(other.keyboardLayout, other) } },
        ] } },
      ],
    },
}
