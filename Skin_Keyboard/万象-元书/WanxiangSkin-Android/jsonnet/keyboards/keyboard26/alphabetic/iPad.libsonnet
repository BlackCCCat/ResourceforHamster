// 暴露平板端英文 26 键入口，复用平板端 26 键覆盖构建流程。
local Settings = import '../../../Custom.libsonnet';
local buildContext = import '../../../build/context.libsonnet';
local keyStyles = import '../../../components/key/factory.libsonnet';
local iPadToolbar = import '../../../components/toolbar/iPad.libsonnet';
local ipad26Builder = import '../base/iPadBuilder.libsonnet';
local alphabeticData = import './data.libsonnet';
local alphabeticBase = import './keyboard.libsonnet';

local deviceType = 'iPad';
local toolbarProxy = {
  getToolBar(theme): iPadToolbar.getToolBar(theme, {
    switchKeyboardType: 'pinyin',
    switchKeyboardAsset: 'englishState',
  }),
};

local config = {
  base: alphabeticBase,
  toolbar: toolbarProxy,
  swipeDataGetter(deviceType): alphabeticData.genSwipeenData(deviceType),
  swipeStyleType: 'en',
  hintData: alphabeticData.alphabetic,
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
    local context = buildContext.new(Settings, theme, orientation, deviceType);
    ipad26Builder.build(
      config,
      theme,
      orientation,
      buildContext.getKeyboardLayout(context)
    ),
}
