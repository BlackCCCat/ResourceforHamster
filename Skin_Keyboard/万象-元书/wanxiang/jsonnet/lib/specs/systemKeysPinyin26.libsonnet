// Define the pinyin 26-key system-key assembly so the main builder can delegate Chinese-only buttons and notifications.
local keyBuilders = import '../keys/keyBuilders.libsonnet';
local pinyinSystemKeys = import '../keys/pinyinSystemKeys.libsonnet';

{
  createBackslashNotification(key, bounds={}):: {
    notificationType: 'keyboardAction',
    [if bounds != {} then 'bounds']: bounds,
    backgroundStyle: 'alphabeticBackgroundStyle',
    foregroundStyle: key + 'ButtonBackslashForegroundStyle',
    notificationKeyboardAction: { sendKeys: 'backslash' },
  },

  build(theme, orientation, keyboardLayout, settings, color, fontSize, center, createButton, hintStyles, letterSpecs):: (
    keyBuilders.backslashNotifications(letterSpecs, self.createBackslashNotification) +
    pinyinSystemKeys.build(theme, orientation, keyboardLayout, settings, color, fontSize, center, createButton, hintStyles)
  ),
}
