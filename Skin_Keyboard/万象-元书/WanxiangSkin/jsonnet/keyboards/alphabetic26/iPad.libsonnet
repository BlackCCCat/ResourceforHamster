// 暴露平板端英文 26 键入口，复用平板端 26 键覆盖构建流程。
local Settings = import '../../Custom.libsonnet';
local keyboardRuntime = import '../../keyboards/common/layoutAssembly/keyboardLayoutAssembly.libsonnet';
local ipad26Builder = import '../common/keyboard26/iPadBuilder.libsonnet';
local alphabetic_base = import 'iPhone.libsonnet';
local toolbar_ipad = import '../../shared/toolbar/iPad.libsonnet';
local keyStyles = import '../../shared/styles/keyStyles.libsonnet';
local hintSymbolsData = import '../../shared/data/hintSymbolsData.libsonnet';
local swipeData = import '../../shared/data/swipeDataEn.libsonnet';

local deviceType = 'iPad';
local toolbarProxy = {
  getToolBar(theme): toolbar_ipad.getToolBar(theme, {
    switchKeyboardType: 'pinyin',
    switchKeyboardAsset: 'englishState',
  }),
};

local config = {
  base: alphabetic_base,
  toolbar: toolbarProxy,
  swipeDataGetter(deviceType): swipeData.genSwipeenData(deviceType),
  swipeStyleType: 'en',
  hintData: hintSymbolsData.alphabetic,
  layoutKey: 'ipad英文26键',
  styleGenerator(fontSize, color, theme, center): keyStyles.genAlphabeticStyles(fontSize, color, theme, center),
  fontSizeOverrides: {
    '按键前景文字大小': 24,
    '26键字母前景文字大小': 24,
    '上划文字大小': 12,
    '下划文字大小': 12,
    'toolbar按键前景sf符号大小': 20,
  },
  extraOverrides: {
    spaceLeftButtonForegroundStyle+: {
      center: { y: 0.5 },
    },
    spaceLeftButtonForegroundStyle2+: {
      center: { y: 0.3 },
    },
  },
};

{
  new(theme, orientation)::
    local context = keyboardRuntime.new(Settings, theme, orientation, deviceType);
    ipad26Builder.build(
      config,
      theme,
      orientation,
      keyboardRuntime.getKeyboardLayout(context)
    ),
}
