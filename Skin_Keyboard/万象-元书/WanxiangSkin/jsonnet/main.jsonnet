// 皮肤总入口只负责渲染，不在此展开键盘选择与配置细节。
local keyboards = import './build/keyboardRegistry.libsonnet';
local config = import './build/skinConfig.libsonnet';


// 输出文件生成
local themes = ['light', 'dark'];
local orientations = ['portrait', 'landscape'];

local render(module, prefix) = {
  [theme + '/' + prefix + '_' + orientation + '.yaml']: std.toString(module.new(theme, orientation))
  for theme in themes
  for orientation in orientations
};

// 拼音布局：new() 的第三个参数覆写 keyboard_layout。
// 全部布局同时产出，运行时通过 config.yaml 的 pinyin9/14/17/18/26/27 槽位互相跳转。
local renderLayout(module, prefix, layout) = {
  [theme + '/' + prefix + '_' + orientation + '.yaml']: std.toString(module.new(theme, orientation, layout))
  for theme in themes
  for orientation in orientations
};

local pinyinLayouts = [
  { module: keyboards.pinyin9, prefix: 'pinyin_9', layout: 9 },
  { module: keyboards.pinyin14, prefix: 'pinyin_14', layout: 14 },
  { module: keyboards.pinyin17, prefix: 'pinyin_17', layout: 17 },
  { module: keyboards.pinyin18, prefix: 'pinyin_18', layout: 18 },
  { module: keyboards.pinyin26, prefix: 'pinyin_26', layout: 26 },
  { module: keyboards.pinyin26, prefix: 'pinyin_27', layout: 27 },
];

local pinyinOutputs = std.foldl(
  function(acc, spec) acc + renderLayout(spec.module, spec.prefix, spec.layout),
  pinyinLayouts,
  {}
);

pinyinOutputs + {
  'config.yaml': std.manifestYamlDoc(config, indent_array_in_object=true, quote_keys=false),
} +
render(keyboards.layoutSwitch, 'keyboard_swotcher') +
render(keyboards.tempPinyin, 'temp_pinyin') +
render(keyboards.iPadPinyin, 'ipad_pinyin_26') +
render(keyboards.alphabetic, 'alphabetic_26') +
render(keyboards.iPadAlphabetic, 'ipad_alphabetic_26') +
render(keyboards.numeric, 'numeric_9') +
render(keyboards.iPadNumeric, 'ipad_numeric_9') +
render(keyboards.panel, 'panel')
