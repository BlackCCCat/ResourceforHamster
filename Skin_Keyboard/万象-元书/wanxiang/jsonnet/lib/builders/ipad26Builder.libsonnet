// Build iPad 26-key keyboards by overlaying shared iPad-specific patches on top of the iPhone 26-key builders.
local center = import '../shared/center.libsonnet';
local color = import '../shared/color.libsonnet';
local fontSize = import '../shared/fontSize.libsonnet';
local hintSymbolsStyles = import '../shared/hintSymbolsStyles.libsonnet';
local ipad_common = import '../ipad/common.libsonnet';
local others = import '../shared/others.libsonnet';
local swipeStyles = import '../swipe/index.libsonnet';

{
  deviceType:: 'iPad',

  ipadFontSize(overrides):: fontSize + overrides,

  ipadOthers:: others + {
    '竖屏': others['竖屏'] + { 'preedit高度': 20, 'toolbar高度': 57, 'keyboard高度': 240 },
    '横屏': others['横屏'] + { 'preedit高度': 20, 'toolbar高度': 57, 'keyboard高度': 350 },
  },

  toolbarFontSizePatch(toolbarDef, ipadFontSize):: {
    [key]+: { fontSize: ipadFontSize['toolbar按键前景sf符号大小'] }
    for key in std.objectFields(toolbarDef)
    if std.startsWith(key, 'toolbarButton')
  },

  swipeActionPatch(swipeUp, swipeDown):: {
    [key + 'Button']+: {
      swipeDownAction: swipeDown[key].action,
    }
    for key in std.objectFields(swipeDown)
  } + {
    [key + 'Button']+: {
      swipeUpAction: swipeUp[key].action,
    }
    for key in std.objectFields(swipeUp)
  },

  build(config, theme, orientation, keyboardLayout)::
    local ipadFontSize = $.ipadFontSize(config.fontSizeOverrides);
    local ipadOthers = $.ipadOthers;
    local swipeDataRoot = config.swipeDataGetter($.deviceType);
    local swipeUp = if std.objectHas(swipeDataRoot, 'swipe_up') then swipeDataRoot.swipe_up else {};
    local swipeDown = if std.objectHas(swipeDataRoot, 'swipe_down') then swipeDataRoot.swipe_down else {};
    local baseDef = config.base.keyboard(theme, 'portrait', keyboardLayout);
    local hintStyles = hintSymbolsStyles.getStyle(theme, config.hintData);
    local toolbarDef = config.toolbar.getToolBar(theme);
    local ipadOverrides =
      keyboardLayout[config.layoutKey] +
      toolbarDef +
      swipeStyles.getStyle(config.swipeStyleType, theme, swipeUp, swipeDown, ipadFontSize) +
      ipad_common.getOverrides(theme, keyboardLayout, config.base.createButton, hintStyles) +
      config.styleGenerator(ipadFontSize, color, theme, center) +
      {
        preeditHeight: ipadOthers[if orientation == 'portrait' then '竖屏' else '横屏']['preedit高度'],
        toolbarHeight: ipadOthers[if orientation == 'portrait' then '竖屏' else '横屏']['toolbar高度'],
        keyboardHeight: ipadOthers[if orientation == 'portrait' then '竖屏' else '横屏']['keyboard高度'],
      } +
      $.toolbarFontSizePatch(toolbarDef, ipadFontSize) +
      config.extraOverrides +
      $.swipeActionPatch(swipeUp, swipeDown);
    baseDef + ipadOverrides,
}
