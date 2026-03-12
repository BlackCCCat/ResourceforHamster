// Define the pinyin space-key family so main system-key assembly can treat space behaviors as a separate module.
{
  build(theme, orientation, keyboardLayout, Settings, color, fontSize, center, createButton, baseHintStyles):: {
    spaceButton: createButton(
      'space',
      if orientation == 'portrait' then
        keyboardLayout['竖屏按键尺寸']['space键size']
      else
        keyboardLayout['横屏按键尺寸']['space键size'],
      {},
      baseHintStyles,
      false
    ) + {
      foregroundStyle: [
        'spaceButtonForegroundStyle',
        if Settings.show_wanxiang then 'spaceButtonForegroundStyle1' else null,
      ],
      action: 'space',
      [if Settings.keyboard_layout == 26 then 'swipeUpAction']: { sendKeys: 'Shift+space' },
      notification: [
        'spaceButtonPreeditNotification',
      ],
    },
    spaceButtonPreeditNotification: {
      notificationType: 'preeditChanged',
      backgroundStyle: 'alphabeticBackgroundStyle',
      foregroundStyle: [
        'spaceButtonForegroundStyle',
        if Settings.show_wanxiang then 'spaceButtonForegroundStyle1' else null,
      ],
      swipeUpAction: { shortcut: '#次选上屏' },
      swipeDownAction: { shortcut: '#三选上屏' },
    },
    spaceButtonForegroundStyle: {
      buttonStyleType: 'systemImage',
      systemImageName: 'space',
      normalColor: color[theme]['按键前景颜色'],
      highlightColor: color[theme]['按键前景颜色'],
      fontSize: fontSize['按键前景文字大小'] - 3,
      center: center['功能键前景文字偏移'],
    },
    spaceButtonForegroundStyle1: {
      buttonStyleType: 'text',
      text: '万象',
      normalColor: color[theme]['划动字符颜色'],
      highlightColor: color[theme]['划动字符颜色'],
      fontSize: fontSize['按键前景文字大小'] - 10,
      center: { x: 0.9, y: 0.8 },
    },

    spaceFirstButton: createButton(
      'spaceFirst',
      if orientation == 'portrait' then
        keyboardLayout['竖屏按键尺寸']['space键size']
      else
        keyboardLayout['横屏按键尺寸']['spaceFirst键size'],
      {},
      baseHintStyles,
      false
    ) + {
      foregroundStyle: 'spaceFirstButtonForegroundStyle',
      action: 'space',
      [if Settings.keyboard_layout == 26 then 'swipeUpAction']: { sendKeys: 'Shift+space' },
      notification: [
        'spaceFirstButtonPreeditNotification',
      ],
    },
    spaceFirstButtonPreeditNotification: {
      notificationType: 'preeditChanged',
      backgroundStyle: 'alphabeticBackgroundStyle',
      foregroundStyle: 'spaceFirstButtonForegroundStyle',
      swipeUpAction: { shortcut: '#次选上屏' },
      swipeDownAction: { shortcut: '#三选上屏' },
    },
    spaceFirstButtonForegroundStyle: {
      buttonStyleType: 'systemImage',
      systemImageName: 'space',
      normalColor: color[theme]['按键前景颜色'],
      highlightColor: color[theme]['按键前景颜色'],
      fontSize: fontSize['按键前景文字大小'] - 3,
      center: center['功能键前景文字偏移'],
    },

    spaceSecondButton: createButton(
      'spaceSecond',
      if orientation == 'portrait' then
        keyboardLayout['竖屏按键尺寸']['space键size']
      else
        keyboardLayout['横屏按键尺寸']['spaceSecond键size'],
      {},
      baseHintStyles,
      false
    ) + {
      foregroundStyle: [
        'spaceSecondButtonForegroundStyle',
        if Settings.show_wanxiang then 'spaceSecondButtonForegroundStyle1' else null,
      ],
      action: 'space',
      [if Settings.keyboard_layout == 26 then 'swipeUpAction']: { sendKeys: 'Shift+space' },
      notification: [
        'spaceSecondButtonPreeditNotification',
      ],
    },
    spaceSecondButtonPreeditNotification: {
      notificationType: 'preeditChanged',
      backgroundStyle: 'alphabeticBackgroundStyle',
      foregroundStyle: [
        'spaceSecondButtonForegroundStyle',
        if Settings.show_wanxiang then 'spaceSecondButtonForegroundStyle1' else null,
      ],
      swipeUpAction: { shortcut: '#次选上屏' },
      swipeDownAction: { shortcut: '#三选上屏' },
    },
    spaceSecondButtonForegroundStyle: {
      buttonStyleType: 'systemImage',
      systemImageName: 'space',
      normalColor: color[theme]['按键前景颜色'],
      highlightColor: color[theme]['按键前景颜色'],
      fontSize: fontSize['按键前景文字大小'] - 3,
      center: center['功能键前景文字偏移'],
    },
    spaceSecondButtonForegroundStyle1: {
      buttonStyleType: 'text',
      text: '万象',
      normalColor: color[theme]['划动字符颜色'],
      highlightColor: color[theme]['划动字符颜色'],
      fontSize: fontSize['按键前景文字大小'] - 10,
      center: { x: 0.85, y: 0.8 },
    },

    spaceRightButton: createButton(
      'spaceRight',
      if orientation == 'portrait' then
        keyboardLayout['竖屏按键尺寸']['spaceRight键size']
      else
        keyboardLayout['横屏按键尺寸']['spaceRight键size'],
      {},
      baseHintStyles,
      false
    ) + {
      action: { character: '.' },
      repeatAction: { character: '.' },
      notification: [
        'spaceRightButtonPreeditNotification',
      ],
    },
    spaceRightButtonPreeditNotification: {
      notificationType: 'preeditChanged',
      backgroundStyle: 'alphabeticBackgroundStyle',
      foregroundStyle: 'spaceRightButtonPreeditForegroundStyle',
      action: Settings.tips_button_action,
      swipeUpAction: { character: '.' },
      hintSymbolsStyle: 'cn2enButtonHintSymbolsStyle',
    },
    spaceRightButtonPreeditForegroundStyle: {
      buttonStyleType: 'systemImage',
      systemImageName: if Settings.fix_sf_symbol then 'lightbulb' else 'lightbulb.max',
      normalColor: color[theme]['按键前景颜色'],
      highlightColor: color[theme]['按键前景颜色'],
      fontSize: fontSize['按键前景文字大小'],
    },
    spaceRightButtonForegroundStyle: {
      buttonStyleType: 'text',
      text: '。',
      normalColor: color[theme]['按键前景颜色'],
      highlightColor: color[theme]['按键前景颜色'],
      fontSize: fontSize['按键前景文字大小'],
    },
    spaceRightButtonForegroundStyle2: {
      buttonStyleType: 'text',
      text: '。',
      normalColor: color[theme]['按键前景颜色'],
      highlightColor: color[theme]['按键前景颜色'],
      fontSize: fontSize['按键前景文字大小'] - 2,
    },

    local slBtn = createButton(
      'spaceLeft',
      if orientation == 'portrait' then
        keyboardLayout['竖屏按键尺寸']['spaceRight键size']
      else
        keyboardLayout['横屏按键尺寸']['spaceRight键size'],
      {},
      baseHintStyles,
      false
    ),
    spaceLeftButton: slBtn {
      foregroundStyle: [
        'spaceLeftButtonForegroundStyle',
        'spaceLeftButtonForegroundStyle2',
      ],
      action: {
        character: ',',
      },
    },
    spaceLeftButtonForegroundStyle: {
      buttonStyleType: 'text',
      text: ',',
      normalColor: color[theme]['按键前景颜色'],
      highlightColor: color[theme]['按键前景颜色'],
      fontSize: fontSize['按键前景文字大小'],
      center: { x: 0.5, y: 0.5 },
    },
    spaceLeftButtonForegroundStyle2: {
      buttonStyleType: 'text',
      text: '.',
      normalColor: color[theme]['按键前景颜色'],
      highlightColor: color[theme]['按键前景颜色'],
      fontSize: fontSize['按键前景文字大小'] - 2,
      center: { x: 0.5, y: 0.3 },
    },
  },
}
