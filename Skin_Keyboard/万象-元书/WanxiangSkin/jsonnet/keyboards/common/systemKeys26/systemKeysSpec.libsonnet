// 定义拼音 26 键系统键装配规格。
local keyHelpers = import '../../../shared/buttonHelpers/key.libsonnet';
local pinyinSystemKeys = import 'systemKeys.libsonnet';

{
  createBackslashNotification(key, bounds={}):: {
    notificationType: 'keyboardAction',
    [if bounds != {} then 'bounds']: bounds,
    backgroundStyle: 'alphabeticBackgroundStyle',
    foregroundStyle: key + 'ButtonBackslashForegroundStyle',
    notificationKeyboardAction: { sendKeys: 'backslash' },
  },

  build(theme, orientation, keyboardLayout, settings, color, fontSize, center, createButton, hintStyles, letterSpecs):: (
    keyHelpers.backslashNotifications(letterSpecs, self.createBackslashNotification) +
    pinyinSystemKeys.build(theme, orientation, keyboardLayout, settings, color, fontSize, center, createButton, hintStyles)
  ),
}
