// Define the pinyin shift key and its preedit notification so shift-specific behavior stays isolated.
{
  build(theme, orientation, keyboardLayout, Settings, color, fontSize, createButton, baseHintStyles):: {
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
    shiftButtonPreeditForegroundStyle: {
      buttonStyleType: 'systemImage',
      systemImageName: if Settings.shift_config.preedit_sf_symbol != '' then Settings.shift_config.preedit_sf_symbol else if Settings.fix_sf_symbol then 'paragraphsign' else 'inset.filled.lefthalf.arrow.left.rectangle',
      normalColor: color[theme]['按键前景颜色'],
      highlightColor: color[theme]['按键前景颜色'],
      fontSize: fontSize['按键前景文字大小'],
    },
    shiftButtonForegroundStyle: {
      buttonStyleType: 'systemImage',
      systemImageName: 'shift',
      normalColor: color[theme]['按键前景颜色'],
      highlightColor: color[theme]['按键前景颜色'],
      fontSize: fontSize['按键前景文字大小'],
    },
    shiftButtonUppercasedForegroundStyle: {
      buttonStyleType: 'systemImage',
      systemImageName: 'shift.fill',
      normalColor: color[theme]['按键前景颜色'],
      highlightColor: color[theme]['按键前景颜色'],
      fontSize: fontSize['按键前景文字大小'],
    },
    shiftButtonCapsLockedForegroundStyle: {
      buttonStyleType: 'systemImage',
      systemImageName: 'capslock.fill',
      normalColor: color[theme]['按键前景颜色'],
      highlightColor: color[theme]['按键前景颜色'],
      fontSize: fontSize['按键前景文字大小'],
    },
  },
}
