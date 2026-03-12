// Provide shared button-factory helpers for the pinyin 9-key builder.
{
  create(context, swipeUp, swipeDown, t9Letters)::
    function(key, size, bounds, root, isUpper=true)
      local styleKey = if std.length(key) == 1 then 'number' + key else key;
      {
        [if size != {} then 'size']: size,
        backgroundStyle: if std.length(key) == 1 then 'numberButtonBackgroundStyle' else key + 'ButtonBackgroundStyle',
        foregroundStyle: std.flattenArrays(std.filter(
          function(x) x != null,
          [
            if std.length(key) == 1 then
              if std.objectHas(t9Letters, key) then
                ['number' + key + 'LettersStyle']
              else
                ['number' + key + 'ButtonForegroundStyle']
            else
              [key + 'ButtonForegroundStyle'],
            if context.Settings.show_swipe then
              if std.objectHas(swipeUp, key) then ['number' + key + 'ButtonUpForegroundStyle'] else null
            else null,
            if context.Settings.show_swipe then
              if std.objectHas(swipeDown, key) then ['number' + key + 'ButtonDownForegroundStyle'] else null
            else null,
          ]
        )),
        hintStyle: styleKey + 'ButtonHintStyle',
        [styleKey + 'ButtonHintStyle']: {
          backgroundStyle: 'alphabeticHintBackgroundStyle',
          foregroundStyle: styleKey + 'ButtonHintForegroundStyle',
          swipeUpForegroundStyle: styleKey + 'ButtonSwipeUpHintForegroundStyle',
          swipeDownForegroundStyle: styleKey + 'ButtonSwipeDownHintForegroundStyle',
        },
        action: {
          character: key,
        },
        animation: [
          'ButtonScaleAnimation',
        ],
        [if std.objectHas(swipeUp, key) then 'swipeUpAction']: swipeUp[key].action,
        [if std.objectHas(swipeDown, key) then 'swipeDownAction']: swipeDown[key].action,
        [if std.objectHas(root, styleKey + 'ButtonHintSymbolsStyle') then 'hintSymbolsStyle']: styleKey + 'ButtonHintSymbolsStyle',
      },

  genT9Styles(t9Letters, theme, color, fontSize, center):: {
    ['number' + key + 'LettersStyle']: {
      buttonStyleType: 'text',
      text: t9Letters[key],
      normalColor: color[theme]['按键前景颜色'],
      highlightColor: color[theme]['按键前景颜色'],
      fontSize: fontSize['中文九键字符键前景文字大小'],
      fontWeight: 0,
      center: center['中文九键字符前景偏移'],
    }
    for key in std.objectFields(t9Letters)
  },
}
