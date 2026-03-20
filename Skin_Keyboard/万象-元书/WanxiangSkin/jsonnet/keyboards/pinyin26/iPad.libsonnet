// 暴露平板端拼音 26 键入口，复用平板端 26 键覆盖构建流程。
local Settings = import '../../Custom.libsonnet';
local keyboardRuntime = import '../../keyboards/common/layoutAssembly/keyboardLayoutAssembly.libsonnet';
local ipad26Builder = import '../common/keyboard26/iPadBuilder.libsonnet';
local pinyin_base = import 'iPhone.libsonnet';
local toolbar_ipad = import '../../shared/toolbar/iPad.libsonnet';
local keyStyles = import '../../shared/styles/keyStyles.libsonnet';
local hintSymbolsData = import '../../shared/data/hintSymbolsData.libsonnet';
local swipeData = import '../../shared/data/swipeData.libsonnet';

local deviceType = 'iPad';

local config = {
  base: pinyin_base,
  toolbar: toolbar_ipad,
  swipeDataGetter(deviceType): swipeData.genSwipeData(deviceType),
  swipeStyleType: 'cn',
  hintData: hintSymbolsData.pinyin,
  layoutKey: 'ipad中文26键',
  styleGenerator(fontSize, color, theme, center): keyStyles.genPinyinStyles(fontSize, color, theme, center),
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
    local context = keyboardRuntime.new(Settings, theme, orientation, deviceType);
    ipad26Builder.build(
      config,
      theme,
      orientation,
      keyboardRuntime.getKeyboardLayout(context)
    ),
}
