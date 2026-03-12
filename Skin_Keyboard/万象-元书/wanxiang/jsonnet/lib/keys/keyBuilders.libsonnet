// Shared helpers for building repetitive key objects.
{
  hintStyle(key, backgroundStyle='alphabeticHintBackgroundStyle'):: {
    [key + 'ButtonHintStyle']: {
      backgroundStyle: backgroundStyle,
      foregroundStyle: key + 'ButtonHintForegroundStyle',
      swipeUpForegroundStyle: key + 'ButtonSwipeUpHintForegroundStyle',
      swipeDownForegroundStyle: key + 'ButtonSwipeDownHintForegroundStyle',
    },
  },

  hintStyles(keys, backgroundStyle='alphabeticHintBackgroundStyle'):: 
    std.foldl(
      function(acc, key) acc + self.hintStyle(key, backgroundStyle),
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
