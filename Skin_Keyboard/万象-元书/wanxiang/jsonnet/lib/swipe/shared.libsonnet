// Provide reusable swipe-style factories for directional foregrounds, hint bubbles, and displayed labels.
{
  swipeStyle(center, colorMap, fontSizeConfig, fs=null):: {
    '上划样式': {
      '文字样式': {
        buttonStyleType: 'text',
        normalColor: colorMap['划动字符颜色'],
        highlightColor: colorMap['划动字符颜色'],
        center: center,
        fontSize: if fs == null then fontSizeConfig['上划文字大小'] else fs,
      },
      'sf符号样式': {
        buttonStyleType: 'systemImage',
        normalColor: colorMap['划动字符颜色'],
        highlightColor: colorMap['划动字符颜色'],
        center: center,
        fontSize: if fs == null then fontSizeConfig['上划文字大小'] else fs,
      },
    },
    '下划样式': {
      '文字样式': {
        buttonStyleType: 'text',
        normalColor: colorMap['划动字符颜色'],
        highlightColor: colorMap['划动字符颜色'],
        center: center,
        fontSize: if fs == null then fontSizeConfig['下划文字大小'] else fs,
      },
      'sf符号样式': {
        buttonStyleType: 'systemImage',
        normalColor: colorMap['划动字符颜色'],
        highlightColor: colorMap['划动字符颜色'],
        center: center,
        fontSize: if fs == null then fontSizeConfig['下划文字大小'] else fs,
      },
    },
    '上划气泡前景样式': {
      buttonStyleType: 'text',
      fontSize: fontSizeConfig['划动气泡前景文字大小'],
      normalColor: colorMap['按下气泡文字颜色'],
    },
    '上划气泡sf符号前景样式': {
      buttonStyleType: 'systemImage',
      fontSize: fontSizeConfig['划动气泡前景sf符号大小'],
      normalColor: colorMap['按下气泡文字颜色'],
    },
    '下划气泡前景样式': {
      buttonStyleType: 'text',
      fontSize: fontSizeConfig['划动气泡前景文字大小'],
      normalColor: colorMap['按下气泡文字颜色'],
    },
    '下划气泡sf符号前景样式': {
      buttonStyleType: 'systemImage',
      fontSize: fontSizeConfig['划动气泡前景sf符号大小'],
      normalColor: colorMap['按下气泡文字颜色'],
    },
    '按下气泡样式': {
      buttonStyleType: 'text',
      fontSize: fontSizeConfig['划动气泡前景文字大小'],
      normalColor: colorMap['按下气泡文字颜色'],
    },
  },

  display(o):: {
    [if std.objectHas(o.label, 'text') then 'text']: o.label.text,
    [if std.objectHas(o.label, 'systemImageName') then 'systemImageName']: o.label.systemImageName,
  },

  styleName(type, key, suffix)::
    if type == 'number' then 'number' + key + suffix else key + suffix,

  directionalForeground(key, o, type, suffix, styleGroupName, textStyleName, imageStyleName, textCenter, imageCenter, colorMap, fontSizeConfig)::
    if !std.objectHas(o, 'label') then {}
    else {
      [$.styleName(type, key, suffix)]:
        $.display(o) +
        if std.objectHas(o.label, 'text') then
          $.swipeStyle(
            if std.objectHas(o, 'center') then o.center else textCenter,
            colorMap,
            fontSizeConfig,
            if std.objectHas(o, 'fontSize') then o.fontSize else null
          )[styleGroupName][textStyleName]
        else
          $.swipeStyle(
            if std.objectHas(o, 'center') then o.center else imageCenter,
            colorMap,
            fontSizeConfig,
            if std.objectHas(o, 'fontSize') then o.fontSize else null
          )[styleGroupName][imageStyleName],
    },

  hintBubbleForeground(key, o, type, suffix, textStyleName, imageStyleName, hintTextCenter, hintImageCenter, colorMap, fontSizeConfig)::
    if !std.objectHas(o, 'label') then {}
    else {
      [$.styleName(type, key, suffix)]:
        $.display(o) +
        if std.objectHas(o.label, 'text') then
          $.swipeStyle(hintTextCenter, colorMap, fontSizeConfig)[textStyleName]
        else
          $.swipeStyle(hintImageCenter, colorMap, fontSizeConfig)[imageStyleName],
    },

  hintForeground(key, Settings, colorMap, fontSizeConfig, hintTextCenter):: {
    [key + 'ButtonHintForegroundStyle']:
      { text: if Settings.is_letter_capital then std.asciiUpper(key) else key } +
      $.swipeStyle(hintTextCenter, colorMap, fontSizeConfig)['按下气泡样式'],
  },
}
