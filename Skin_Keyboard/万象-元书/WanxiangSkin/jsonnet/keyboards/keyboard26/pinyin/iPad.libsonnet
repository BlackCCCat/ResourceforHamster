// 暴露平板端拼音 26 键入口，复用平板端 26 键覆盖构建流程。
local Settings = import '../../../Custom.libsonnet';
local buildContext = import '../../../build/context.libsonnet';
local keyStyles = import '../../../components/key/factory.libsonnet';
local iPadToolbar = import '../../../components/toolbar/iPad.libsonnet';
local ipad26Builder = import '../base/iPadBuilder.libsonnet';
local pinyinData = import './data.libsonnet';
local pinyinBase = import './keyboard.libsonnet';

local deviceType = 'iPad';

local config = {
  base: pinyinBase,
  toolbar: iPadToolbar,
  swipeDataGetter(deviceType): pinyinData.genSwipeData(deviceType),
  swipeStyleType: 'cn',
  hintData: pinyinData.pinyin,
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
    local context = buildContext.new(Settings, theme, orientation, deviceType);
    ipad26Builder.build(
      config,
      theme,
      orientation,
      buildContext.getKeyboardLayout(context)
    ),
}
