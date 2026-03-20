// 定义拼音大写切换键及其预编辑通知。
local styleFactories = import '../../../shared/styles/styleFactories.libsonnet';

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
