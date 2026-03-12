// Expose the iPad 26-key pinyin keyboard through the shared iPad 26-key overlay builder.
local Settings = import '../Custom.libsonnet';
local keyboardLayouts = import '../lib/layout/keyboardLayouts.libsonnet';
local ipad26Builder = import '../lib/builders/ipad26Builder.libsonnet';
local pinyin_base = import 'pinyin_26.jsonnet';
local toolbar_ipad = import '../lib/toolbar/ipad.libsonnet';
local utils = import '../lib/utils/index.libsonnet';
local hintSymbolsData = import '../lib/data/hintSymbolsData.libsonnet';
local swipeData = import '../lib/data/swipeData.libsonnet';

local deviceType = 'iPad';

local config = {
  base: pinyin_base,
  toolbar: toolbar_ipad,
  swipeDataGetter(deviceType): swipeData.genSwipeData(deviceType),
  swipeStyleType: 'cn',
  hintData: hintSymbolsData.pinyin,
  layoutKey: 'ipad中文26键',
  styleGenerator(fontSize, color, theme, center): utils.genPinyinStyles(fontSize, color, theme, center),
  fontSizeOverrides: {
    '按键前景文字大小': 24,
    '26键字母前景文字大小': 24,
    '上划文字大小': 12,
    '下划文字大小': 12,
    'toolbar按键前景sf符号大小': 20,
  },
  extraOverrides: {
    spaceLeftButtonForegroundStyle+: {
      text: ',',
      center: { y: 0.5 },
    },
    spaceLeftButtonForegroundStyle2+: {
      text: '.',
      center: { y: 0.3 },
    },
  },
};

{
  new(theme, orientation)::
    ipad26Builder.build(
      config,
      theme,
      orientation,
      keyboardLayouts.getKeyboardLayout(theme, Settings.function_button_config.with_functions_row[deviceType])
    ),
}
