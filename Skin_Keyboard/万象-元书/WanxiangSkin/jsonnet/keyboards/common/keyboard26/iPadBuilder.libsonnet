// 组装平板端 26 键键盘，在手机端 26 键构建结果上叠加平板覆盖。
local Settings = import '../../../Custom.libsonnet';
local buttonInteraction = import '../../../shared/buttonHelpers/buttonInteraction.libsonnet';
local center = import '../../../shared/styles/center.libsonnet';
local color = import '../../../shared/styles/color.libsonnet';
local fontSize = import '../../../shared/styles/fontSize.libsonnet';
local hintSymbolsStyles = import '../../../shared/styles/hintSymbolsStyles.libsonnet';
local others = import '../../../shared/styles/others.libsonnet';
local swipeKeyStyles = import '../../../shared/styles/swipeKeyStyles.libsonnet';
local styleFactories = import '../../../shared/styles/styleFactories.libsonnet';

{
  deviceType:: 'iPad',

  ipadFontSize(overrides):: fontSize + overrides,

  ipadOthers:: others {
    '竖屏': others['竖屏'] { 'preedit高度': 20, 'toolbar高度': Settings.toolbar_config.ipad.toolbar_height, 'keyboard高度': 240 },
    '横屏': others['横屏'] { 'preedit高度': 20, 'toolbar高度': Settings.toolbar_config.ipad.toolbar_height, 'keyboard高度': 350 },
  },

  ipadPortraitKeySizes:: {
    // 生成 iPad 26 键底层按钮尺寸，配合独立四行布局放大系统键宽度。
    '普通键size': {
      width: {
        percentage: 1 / 11,
      },
    },
    'a键size和bounds': {
      size: {
        width: {
          percentage: 1.5 / 11,
        },
      },
      bounds: {
        width: '2/3',
        alignment: 'right',
      },
    },
    'l键size和bounds': {
      size: {
        width: {
          percentage: 1 / 11,
        },
      },
      bounds: {},
    },
    'shift键size': {
      width: {
        percentage: 1.5 / 11,
      },
    },
    'rightShift键size': {
      width: {
        percentage: 1.5/11,
      },
    },
    'backspace键size': {
      width: {
        percentage: 0.15,
      },
    },
    'tab键size': {
      width: {
        percentage: 1/11,
      },
    },
    'next键size': {
      width: {
        percentage: 1 / 11,
      },
    },
    'ipad123键size': {
      width: {
        percentage: 1 / 11,
      },
    },
    'cn2en键size': {
      width: {
        percentage: 1 / 11,
      },
    },
    'en2cn键size': {
      width: {
        percentage: 1 / 11,
      },
    },
    'spaceRight键size': {
      width: {
        percentage: 1 / 11,
      },
    },
    'enter键size': {
      width: {
        percentage: 1.5/11,
      },
    },
    'space键size': {
      width: {
        percentage: 5 / 11,
      },
    },
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
    local makeSystemImageForeground(systemImageName) =
      // 生成 iPad 底行和扩展系统键的系统图标前景。
      styleFactories.makeSystemImageStyle(
        systemImageName,
        fontSize['按键前景文字大小'] - 3,
        color[theme]['按键前景颜色'],
        color[theme]['按键前景颜色'],
        center['功能键前景文字偏移'] { y: 0.5 }
      );
    local makeIpad123Button(name) =
      createButtonFunc(
        name,
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
      };
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

      ipad123Button: makeIpad123Button('ipad123'),
      ipad123ButtonRight: makeIpad123Button('ipad123Right'),
      ipad123ButtonSymbolsDataSource: [
        { label: '1', action: { keyboardType: 'numeric' }, styleName: 'numericStyle' },
        { label: '2', action: { keyboardType: 'symbolic' }, styleName: 'symbolicStyle' },
        { label: '4', action: { keyboardType: 'emojis' }, styleName: 'emojisStyle' },
      ],

      tabButton: createButtonFunc(
        'tab',
        keyboardLayout['竖屏按键尺寸']['tab键size'],
        {},
        hintRoot,
        false
      ) + {
        backgroundStyle: 'systemButtonBackgroundStyle',
        foregroundStyle: 'tabButtonForegroundStyle',
        hintStyle:: null,
        action: 'tab',
      },
      tabButtonForegroundStyle: makeSystemImageForeground('arrow.right.to.line.compact'),

      rightShiftButton: createButtonFunc(
        'rightShift',
        keyboardLayout['竖屏按键尺寸']['rightShift键size'],
        {},
        hintRoot,
        false
      ) + {
        backgroundStyle: 'systemButtonBackgroundStyle',
        action: 'shift',
        uppercasedStateAction: 'shift',
        foregroundStyle: 'shiftButtonForegroundStyle',
        uppercasedStateForegroundStyle: 'shiftButtonUppercasedForegroundStyle',
        capsLockedStateForegroundStyle: 'shiftButtonCapsLockedForegroundStyle',
        [if Settings.shift_config.enable_preedit then 'notification' else null]: [
          'rightShiftButtonPreeditNotification',
        ],
        hintStyle:: null,
      },
      rightShiftButtonPreeditNotification: {
        notificationType: 'preeditChanged',
        backgroundStyle: 'systemButtonBackgroundStyle',
        foregroundStyle: 'rightShiftButtonPreeditForegroundStyle',
        action: Settings.shift_config.preedit_action,
        swipeUpAction:
          if Settings.keyboard_layout == 26 && Settings.shift_config.preedit_swipeup_action == '辅助筛选' then
            { character: '`' }
          else
            { character: "'" },
      },
      rightShiftButtonPreeditForegroundStyle: makeSystemImageForeground(
        if Settings.shift_config.preedit_sf_symbol != '' then
          Settings.shift_config.preedit_sf_symbol
        else if Settings.fix_sf_symbol then
          'paragraphsign'
        else
          'inset.filled.lefthalf.arrow.left.rectangle'
      ),

      // 复用空格左侧逗号键，保留逗号与句号前景并补上上划句号动作。
      spaceLeftButton+: {
        foregroundStyle: [
          'spaceLeftButtonForegroundStyle',
          'spaceLeftButtonForegroundStyle2',
        ],
        swipeUpAction: { character: '.' },
      },

      dismissButton: createButtonFunc(
        'dismiss',
        keyboardLayout['竖屏按键尺寸']['next键size'],
        {},
        hintRoot,
        false
      ) + {
        backgroundStyle: 'systemButtonBackgroundStyle',
        foregroundStyle: 'dismissButtonForegroundStyle',
        hintStyle:: null,
        action: 'dismissKeyboard',
      },
      dismissButtonForegroundStyle: makeSystemImageForeground('keyboard.chevron.compact.down'),
    }
  ),

  build(config, theme, orientation, keyboardLayout)::
    local ipadFontSize = $.ipadFontSize(config.fontSizeOverrides);
    local ipadOthers = $.ipadOthers;
    local swipeDataRoot = config.swipeDataGetter($.deviceType);
    local swipeUp = if std.objectHas(swipeDataRoot, 'swipe_up') then swipeDataRoot.swipe_up else {};
    local swipeDown = if std.objectHas(swipeDataRoot, 'swipe_down') then swipeDataRoot.swipe_down else {};
    local ipadKeyboardLayout = keyboardLayout + {
      '竖屏按键尺寸'+: $.ipadPortraitKeySizes,
    };
    local baseDef = config.base.keyboard(theme, 'portrait', ipadKeyboardLayout);
    local hintStyles = hintSymbolsStyles.getStyle(theme, config.hintData);
    local toolbarDef = config.toolbar.getToolBar(theme);
    local ipadOverrides =
      ipadKeyboardLayout[config.layoutKey] +
      toolbarDef +
      swipeKeyStyles.getStyle(config.swipeStyleType, theme, swipeUp, swipeDown, ipadFontSize) +
      $.getOverrides(theme, ipadKeyboardLayout, config.base.createButton, hintStyles) +
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
