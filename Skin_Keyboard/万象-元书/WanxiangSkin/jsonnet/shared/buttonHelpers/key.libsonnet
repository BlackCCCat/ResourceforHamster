// 提供重复按键对象与长按样式包装的共享辅助函数。
{
  hintStyle(key, backgroundStyle='alphabeticHintBackgroundStyle', enableSwipeUp=true, enableSwipeDown=true):: {
    [key + 'ButtonHintStyle']: {
      backgroundStyle: backgroundStyle,
      foregroundStyle: key + 'ButtonHintForegroundStyle',
      [if enableSwipeUp then 'swipeUpForegroundStyle']: key + 'ButtonSwipeUpHintForegroundStyle',
      [if enableSwipeDown then 'swipeDownForegroundStyle']: key + 'ButtonSwipeDownHintForegroundStyle',
    },
  },

  hintStyles(keys, backgroundStyle='alphabeticHintBackgroundStyle', enableSwipeUp=true, enableSwipeDown=true):: 
    std.foldl(
      function(acc, key) acc + self.hintStyle(key, backgroundStyle, enableSwipeUp, enableSwipeDown),
      keys,
      {}
    ),

  letterButtons(specs, createButton, root):: {
    [spec.key + 'Button']: createButton(
      spec.key,
      spec.size,
      spec.bounds,
      root,
      if std.objectHas(spec, 'isUpper') then spec.isUpper else true
    )
    for spec in specs
  },

  backslashNotifications(specs, createBackslashNotification):: {
    [spec.key + 'ButtonBackslashNotification']: createBackslashNotification(
      spec.key,
      if std.objectHas(spec, 'bounds') then spec.bounds else {}
    )
    for spec in specs
  },
}
