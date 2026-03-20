// 组装平板端 26 键键盘，在手机端 26 键构建结果上叠加平板覆盖。
local Settings = import '../../../Custom.libsonnet';
local buttonInteraction = import '../../../shared/buttonHelpers/buttonInteraction.libsonnet';
local center = import '../../../shared/styles/center.libsonnet';
local color = import '../../../shared/styles/color.libsonnet';
local fontSize = import '../../../shared/styles/fontSize.libsonnet';
local hintSymbolsStyles = import '../../../shared/styles/hintSymbolsStyles.libsonnet';
local others = import '../../../shared/styles/others.libsonnet';
local swipeKeyStyles = import '../../../shared/styles/swipeKeyStyles.libsonnet';

{
  deviceType:: 'iPad',

  ipadFontSize(overrides):: fontSize + overrides,

  ipadOthers:: others {
    '竖屏': others['竖屏'] { 'preedit高度': 20, 'toolbar高度': Settings.toolbar_config.ipad.toolbar_height, 'keyboard高度': 240 },
    '横屏': others['横屏'] { 'preedit高度': 20, 'toolbar高度': Settings.toolbar_config.ipad.toolbar_height, 'keyboard高度': 350 },
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

  getOverrides(theme, keyboardLayout, createButtonFunc, hintRoot):: (
    local button123 = buttonInteraction.button123;
    local slideEnabled = button123.enableSlide(Settings);
    local useHintSymbols = !slideEnabled && button123.secondaryActionMode(Settings) == 'hint_symbols';
    local useSwipeActions = !slideEnabled && button123.secondaryActionMode(Settings) == 'swipe';
    local swipeTargets = button123.swipeMapping(Settings);
    {
      '123Button':: null,

      nextButton: createButtonFunc(
        'next',
        keyboardLayout['竖屏按键尺寸']['next键size'],
        {},
        hintRoot,
        false
      ) + {
        backgroundStyle: 'systemButtonBackgroundStyle',
        foregroundStyle: 'nextButtonForegroundStyle',
        action: 'nextKeyboard',
      },
      nextButtonForegroundStyle: {
        buttonStyleType: 'systemImage',
        systemImageName: 'globe',
        normalColor: color[theme]['按键前景颜色'],
        highlightColor: color[theme]['按键前景颜色'],
        fontSize: fontSize['按键前景文字大小'] - 3,
        center: center['功能键前景文字偏移'] { y: 0.5 },
      },

      ipad123Button: createButtonFunc(
        'ipad123',
        keyboardLayout['竖屏按键尺寸']['ipad123键size'],
        {},
        hintRoot,
        false
      ) + {
        backgroundStyle: 'systemButtonBackgroundStyle',
        [if slideEnabled then 'type']: 'horizontalSymbols',
        [if slideEnabled then 'maxColumns']: 1,
        [if slideEnabled then 'contentRightToLeft']: false,
        [if slideEnabled then 'dataSource']: 'ipad123ButtonSymbolsDataSource',
        [if !slideEnabled then 'action']: { keyboardType: 'numeric' },
        [if !slideEnabled then 'foregroundStyle']: ['123ButtonForegroundStyle'],
        [if useHintSymbols then 'hintSymbolsStyle']: '123ButtonHintSymbolsStyle',
        [if useSwipeActions then 'swipeUpAction']: { keyboardType: swipeTargets.up },
        [if useSwipeActions then 'swipeDownAction']: { keyboardType: swipeTargets.down },
      },
      ipad123ButtonSymbolsDataSource: [
        { label: '1', action: { keyboardType: 'numeric' }, styleName: 'numericStyle' },
        { label: '2', action: { keyboardType: 'symbolic' }, styleName: 'symbolicStyle' },
        { label: '4', action: { keyboardType: 'emojis' }, styleName: 'emojisStyle' },
      ],
    }
  ),

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
      swipeKeyStyles.getStyle(config.swipeStyleType, theme, swipeUp, swipeDown, ipadFontSize) +
      $.getOverrides(theme, keyboardLayout, config.base.createButton, hintStyles) +
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
