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

{
  'config.yaml': std.manifestYamlDoc(config, indent_array_in_object=true, quote_keys=false),
} +
render(keyboards.pinyin, 'pinyin_26') +
render(keyboards.tempPinyin, 'temp_pinyin') +
render(keyboards.iPadPinyin, 'ipad_pinyin_26') +
render(keyboards.alphabetic, 'alphabetic_26') +
render(keyboards.iPadAlphabetic, 'ipad_alphabetic_26') +
render(keyboards.numeric, 'numeric_9') +
render(keyboards.iPadNumeric, 'ipad_numeric_9') +
render(keyboards.panel, 'panel')
