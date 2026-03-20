// Expose the iPad 26-key alphabetic keyboard through the shared iPad 26-key overlay builder.
local Settings = import '../Custom.libsonnet';
local keyboardLayoutProvider = import '../lib/layout/keyboardLayoutProvider.libsonnet';
local ipad26Builder = import '../lib/builders/ipad26Builder.libsonnet';
local alphabetic_base = import 'alphabetic_26.jsonnet';
local toolbar_ipad = import '../lib/toolbar/ipad.libsonnet';
local keyStyles = import '../lib/utils/keyStyles.libsonnet';
local hintSymbolsData = import '../lib/data/hintSymbolsData.libsonnet';
local swipeData = import '../lib/data/swipeDataEn.libsonnet';

local deviceType = 'iPad';

local config = {
  base: alphabetic_base,
  toolbar: toolbar_ipad,
  swipeDataGetter(deviceType): swipeData.genSwipeenData(deviceType),
  swipeStyleType: 'en',
  hintData: hintSymbolsData.alphabetic,
  layoutKey: 'ipad英文26键',
  styleGenerator(fontSize, color, theme, center): keyStyles.genAlphabeticStyles(fontSize, color, theme, center),
  fontSizeOverrides: {
    '按键前景文字大小': 24,
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
    ipad26Builder.build(
      config,
      theme,
      orientation,
      keyboardLayoutProvider.getKeyboardLayout(theme, Settings.function_button_config.with_functions_row[deviceType])
    ),
}
