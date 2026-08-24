// 汇总 Shift 状态键与中英切换键，统一维护输入模式相关系统键。
local shiftModule = (
  local styleFactories = import '../../design/styleFactories.libsonnet';

  {
    build(theme, orientation, keyboardLayout, Settings, color, fontSize, createButton, baseHintStyles)::
      local makeShiftForegroundStyle(systemImageName) =
        // 生成 Shift 各状态的系统图标前景。
        styleFactories.makeSystemImageStyle(
          systemImageName,
          fontSize['按键前景文字大小'],
          color[theme]['按键前景颜色'],
          color[theme]['按键前景颜色'],
          {}
        );
      {
        shiftButton: createButton(
          'shift',
          if orientation == 'portrait' then
            keyboardLayout['竖屏按键尺寸']['shift键size']
          else
            keyboardLayout['横屏按键尺寸']['shift键size'],
          {},
          baseHintStyles,
          false
        ) + {
          backgroundStyle: 'systemButtonBackgroundStyle',
          action: 'shift',
          uppercasedStateAction: 'shift',
          capsLockedStateForegroundStyle: 'shiftButtonCapsLockedForegroundStyle',
          uppercasedStateForegroundStyle: 'shiftButtonUppercasedForegroundStyle',
          [if Settings.shift_config.enable_preedit then 'notification' else null]: [
            'shiftButtonPreeditNotification',
          ],
        },
        shiftButtonPreeditNotification: {
          notificationType: 'preeditChanged',
          backgroundStyle: 'systemButtonBackgroundStyle',
          foregroundStyle: 'shiftButtonPreeditForegroundStyle',
          action: Settings.shift_config.preedit_action,
          swipeUpAction: if Settings.keyboard_layout == 26 && Settings.shift_config.preedit_swipeup_action == '辅助筛选' then { character: '`' } else { character: "'" },
        },
        shiftButtonPreeditForegroundStyle:
          // 生成 Shift 预编辑图标前景。
          makeShiftForegroundStyle(
            if Settings.shift_config.preedit_sf_symbol != '' then Settings.shift_config.preedit_sf_symbol else if Settings.fix_sf_symbol then 'paragraphsign' else 'inset.filled.lefthalf.arrow.left.rectangle'
          ),
        // Shift 状态前景
        shiftButtonForegroundStyle: makeShiftForegroundStyle('shift'),
        shiftButtonUppercasedForegroundStyle: makeShiftForegroundStyle('shift.fill'),
        shiftButtonCapsLockedForegroundStyle: makeShiftForegroundStyle('capslock.fill'),
      },
  }
);

local inputModeModule = (
  {
    build(theme, orientation, keyboardLayout, Settings, color, fontSize, center, createButton, baseHintStyles):: {
      cn2enButton: createButton(
        'cn2en',
        if orientation == 'portrait' then
          keyboardLayout['竖屏按键尺寸']['cn2en键size']
        else
          keyboardLayout['横屏按键尺寸']['cn2en键size'],
        {},
        baseHintStyles,
        false
      ) + {
        action: { keyboardType: 'alphabetic' },
        notification: [
          'spaceRightButtonPreeditNotification',
        ],
      },
      cn2enButtonForegroundStyle: {
        buttonStyleType: 'assetImage',
        assetImageName: 'chineseState',
        normalColor: color[theme]['按键前景颜色'],
        highlightColor: color[theme]['按键前景颜色'],
        fontSize: fontSize['按键前景文字大小'] - 3,
        center: center['功能键前景文字偏移'] { y: 0.5 },
      },
      cn2enButtonHintSymbolsStyleOf0: baseHintStyles.cn2enButtonHintSymbolsStyleOf0 {
        foregroundStyle: [
          { styleName: 'cn2enButtonHintSymbolsForegroundStyleOf0', conditionKey: 'rime$s2s', conditionValue: 'true' },
          { styleName: 'cn2enButtonHintSymbolsForegroundStyleOf1', conditionKey: 'rime$s2t', conditionValue: 'true' },
          { styleName: 'cn2enButtonHintSymbolsForegroundStyleOf2', conditionKey: 'rime$s2hk', conditionValue: 'true' },
          { styleName: 'cn2enButtonHintSymbolsForegroundStyleOf3', conditionKey: 'rime$s2tw', conditionValue: 'true' },
        ],
      },
      cn2enButtonHintSymbolsStyleOf4: baseHintStyles.cn2enButtonHintSymbolsStyleOf4 {
        foregroundStyle: [
          { styleName: 'cn2enButtonHintSymbolsForegroundStyleOf4', conditionKey: 'rime$chinese_english', conditionValue: 'true' },
          { styleName: 'cn2enButtonHintSymbolsForegroundStyleOf5', conditionKey: 'rime$chinese_english', conditionValue: 'false' },
        ],
      },
      cn2enButtonHintSymbolsStyleOf6: baseHintStyles.cn2enButtonHintSymbolsStyleOf6 {
        foregroundStyle: [
          { styleName: 'cn2enButtonHintSymbolsForegroundStyleOf6', conditionKey: 'rime$super_tips', conditionValue: 'true' },
          { styleName: 'cn2enButtonHintSymbolsForegroundStyleOf7', conditionKey: 'rime$super_tips', conditionValue: 'false' },
        ],
      },
      cn2enButtonHintSymbolsStyleOf8: baseHintStyles.cn2enButtonHintSymbolsStyleOf8 {
        foregroundStyle: [
          { styleName: 'cn2enButtonHintSymbolsForegroundStyleOf8', conditionKey: 'rime$abbrev', conditionValue: 'true' },
          { styleName: 'cn2enButtonHintSymbolsForegroundStyleOf9', conditionKey: 'rime$abbrev', conditionValue: 'false' },
        ],
      },
      cn2enButtonHintSymbolsStyleOf10: baseHintStyles.cn2enButtonHintSymbolsStyleOf10 {
        foregroundStyle: [
          { styleName: 'cn2enButtonHintSymbolsForegroundStyleOf10', conditionKey: 'rime$chaifen_switch', conditionValue: 'true' },
          { styleName: 'cn2enButtonHintSymbolsForegroundStyleOf11', conditionKey: 'rime$chaifen_switch', conditionValue: 'false' },
        ],
      },
      cn2enButtonHintSymbolsStyle: baseHintStyles.cn2enButtonHintSymbolsStyle {
        symbolStyles: [
          'cn2enButtonHintSymbolsStyleOf0',
          'cn2enButtonHintSymbolsStyleOf4',
          'cn2enButtonHintSymbolsStyleOf6',
          'cn2enButtonHintSymbolsStyleOf8',
          'cn2enButtonHintSymbolsStyleOf10',
        ],
      },
    },
  }
);

{
  buildShift(theme, orientation, keyboardLayout, Settings, color, fontSize, createButton, baseHintStyles)::
    shiftModule.build(theme, orientation, keyboardLayout, Settings, color, fontSize, createButton, baseHintStyles),

  build(theme, orientation, keyboardLayout, Settings, color, fontSize, center, createButton, baseHintStyles)::
    inputModeModule.build(theme, orientation, keyboardLayout, Settings, color, fontSize, center, createButton, baseHintStyles),
}
