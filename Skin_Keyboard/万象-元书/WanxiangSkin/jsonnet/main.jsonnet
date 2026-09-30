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

// 拼音布局：第三个参数指定本布局的 keyboard_layout，并在“中→英”键上记录来源槽位。
// 关闭布局切换时只产出默认布局；开启后产出全部布局供运行时互相跳转。
local renderLayout(module, prefix, layout) = {
  [theme + '/' + prefix + '_' + orientation + '.yaml']: std.toString(module.new(theme, orientation, layout))
  for theme in themes
  for orientation in orientations
};

local allPinyinLayouts = [
  { prefix: 'pinyin_9', layout: 9 },
  { prefix: 'pinyin_14', layout: 14 },
  { prefix: 'pinyin_17', layout: 17 },
  { prefix: 'pinyin_18', layout: 18 },
  { prefix: 'pinyin_26', layout: 26 },
  { prefix: 'pinyin_27', layout: 27 },
];
local pinyinLayouts = [
  spec
  for spec in allPinyinLayouts
  if std.member(config.activeLayouts, spec.layout)
];

local pinyinOutputs = std.foldl(
  function(acc, spec) acc + renderLayout(keyboards.pinyinWithReturn, spec.prefix, spec.layout),
  pinyinLayouts,
  {}
);
local alphabeticOutputs = std.foldl(
  function(acc, spec) acc + renderLayout(keyboards.alphabeticFromPinyin, 'alphabetic_' + std.toString(spec.layout), spec.layout),
  pinyinLayouts,
  {}
);

pinyinOutputs + alphabeticOutputs + {
  'config.yaml': std.manifestYamlDoc(config, indent_array_in_object=true, quote_keys=false),
} +
(if config.layoutSwitcherEnabled then render(keyboards.layoutSwitch, 'keyboard_switcher') else {}) +
render(keyboards.tempPinyin, 'temp_pinyin') +
render(keyboards.iPadPinyin, 'ipad_pinyin_26') +
render(keyboards.iPadAlphabetic, 'ipad_alphabetic_26') +
render(keyboards.numeric, 'numeric_9') +
render(keyboards.iPadNumeric, 'ipad_numeric_9') +
render(keyboards.panel, 'panel')
