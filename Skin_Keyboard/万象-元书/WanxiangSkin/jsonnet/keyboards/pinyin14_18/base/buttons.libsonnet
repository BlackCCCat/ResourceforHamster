// 组装 14 键与 18 键共用的按钮集合。
{
  compactButtons(keys, createButton, root, theme):: {
    [k.id + 'Button']: createButton(
      k.id,
      k.action,
      { width: { percentage: k.width } },
      if std.objectHas(k, 'bounds') && k.bounds != null then k.bounds else {},
      root,
      theme
    )
    for k in keys
  },

  compactForegroundStyles(keys, fontSize, color, theme)::
    local baseLetterFontSize = fontSize['14/18键字母前景文字大小'];
    local normalizeLabel(label) = std.strReplace(label, ' ', '');
    local getLetterFontSize(label) =
      local compactLabel = normalizeLabel(label);
      if std.length(compactLabel) <= 1 then baseLetterFontSize
      else if baseLetterFontSize >= 22 then baseLetterFontSize - 2
      else if baseLetterFontSize >= 18 then baseLetterFontSize - 1
      else baseLetterFontSize;
    {
      [k.id + 'ButtonForegroundStyle']: {
        buttonStyleType: 'text',
        text: normalizeLabel(k.label),
        normalColor: color[theme]['按键前景颜色'],
        highlightColor: color[theme]['按键前景颜色'],
        fontSize: getLetterFontSize(k.label),
        center: { x: 0.5, y: 0.5 },
      }
      for k in keys
    } + {
      [k.id + 'ButtonUppercasedStateForegroundStyle']: {
        buttonStyleType: 'text',
        text: std.asciiUpper(normalizeLabel(k.label)),
        normalColor: color[theme]['按键前景颜色'],
        highlightColor: color[theme]['按键前景颜色'],
        fontSize: getLetterFontSize(k.label),
        center: { x: 0.5, y: 0.5 },
      }
      for k in keys
    },

  // 从共享系统键集合提取 14/18 键需要的按钮，并仅覆盖本布局尺寸。
  commonSystemKeys(systemKeys, sizes, baseHintStyles):: {
    shiftButton: systemKeys.shiftButton { size: { width: sizes.shift } },
    shiftButtonForegroundStyle: systemKeys.shiftButtonForegroundStyle,
    shiftButtonUppercasedForegroundStyle: systemKeys.shiftButtonUppercasedForegroundStyle,
    shiftButtonCapsLockedForegroundStyle: systemKeys.shiftButtonCapsLockedForegroundStyle,

    backspaceButton: systemKeys.backspaceButton { size: { width: sizes.backspace } },
    backspaceButtonForegroundStyle: systemKeys.backspaceButtonForegroundStyle,

    '123Button': systemKeys['123Button'] { size: { width: sizes.oneTwoThree } },
    '123ButtonSymbolsDataSource': systemKeys['123ButtonSymbolsDataSource'],
    [if std.objectHas(systemKeys, '123ButtonHintStyle') then '123ButtonHintStyle']: systemKeys['123ButtonHintStyle'],
    [if std.objectHas(systemKeys, '123ButtonHintForegroundStyle') then '123ButtonHintForegroundStyle']: systemKeys['123ButtonHintForegroundStyle'],
    [if std.objectHas(systemKeys, '123ButtonSwipeUpHintForegroundStyle') then '123ButtonSwipeUpHintForegroundStyle']: systemKeys['123ButtonSwipeUpHintForegroundStyle'],
    [if std.objectHas(systemKeys, '123ButtonSwipeDownHintForegroundStyle') then '123ButtonSwipeDownHintForegroundStyle']: systemKeys['123ButtonSwipeDownHintForegroundStyle'],
    [if std.objectHas(systemKeys, '123ButtonUpForegroundStyle') then '123ButtonUpForegroundStyle']: systemKeys['123ButtonUpForegroundStyle'],
    [if std.objectHas(systemKeys, '123ButtonDownForegroundStyle') then '123ButtonDownForegroundStyle']: systemKeys['123ButtonDownForegroundStyle'],
    [if std.objectHas(systemKeys, '123ButtonHintSymbolsStyle') then '123ButtonHintSymbolsStyle']: systemKeys['123ButtonHintSymbolsStyle'],
    [if std.objectHas(systemKeys, '123ButtonHintSymbolsForegroundStyleOf0') then '123ButtonHintSymbolsForegroundStyleOf0']: systemKeys['123ButtonHintSymbolsForegroundStyleOf0'],
    [if std.objectHas(systemKeys, '123ButtonHintSymbolsForegroundStyleOf1') then '123ButtonHintSymbolsForegroundStyleOf1']: systemKeys['123ButtonHintSymbolsForegroundStyleOf1'],
    [if std.objectHas(systemKeys, '123ButtonHintSymbolsStyleOf0') then '123ButtonHintSymbolsStyleOf0']: systemKeys['123ButtonHintSymbolsStyleOf0'],
    [if std.objectHas(systemKeys, '123ButtonHintSymbolsStyleOf1') then '123ButtonHintSymbolsStyleOf1']: systemKeys['123ButtonHintSymbolsStyleOf1'],

    spaceButton: systemKeys.spaceButton { size: { width: sizes.space } },
    spaceButtonForegroundStyle: systemKeys.spaceButtonForegroundStyle,
    spaceButtonPreeditNotification: systemKeys.spaceButtonPreeditNotification,
    spaceButtonForegroundStyle1: systemKeys.spaceButtonForegroundStyle1,

    spaceLeftButton: systemKeys.spaceLeftButton { size: { width: sizes.spaceLeft } },
    spaceLeftButtonForegroundStyle: systemKeys.spaceLeftButtonForegroundStyle,
    spaceLeftButtonForegroundStyle2: systemKeys.spaceLeftButtonForegroundStyle2,
    spaceRightButtonForegroundStyle: systemKeys.spaceRightButtonForegroundStyle,
    spaceRightButtonForegroundStyle2: systemKeys.spaceRightButtonForegroundStyle2,

    spaceFirstButtonPreeditNotification: systemKeys.spaceFirstButtonPreeditNotification,
    spaceFirstButtonForegroundStyle: systemKeys.spaceFirstButtonForegroundStyle,
    spaceSecondButtonPreeditNotification: systemKeys.spaceSecondButtonPreeditNotification,
    spaceSecondButtonForegroundStyle: systemKeys.spaceSecondButtonForegroundStyle,
    spaceSecondButtonForegroundStyle1: systemKeys.spaceSecondButtonForegroundStyle1,

    spaceRightButtonPreeditNotification: systemKeys.spaceRightButtonPreeditNotification,
    spaceRightButtonPreeditForegroundStyle: systemKeys.spaceRightButtonPreeditForegroundStyle,

    cn2enButton: systemKeys.cn2enButton,
    cn2enButtonForegroundStyle: systemKeys.cn2enButtonForegroundStyle,
    cn2enButtonHintSymbolsStyle: baseHintStyles.cn2enButtonHintSymbolsStyle {
      symbolStyles: [
        'cn2enButtonHintSymbolsStyleOf0',
        'cn2enButtonHintSymbolsStyleOf4',
        'cn2enButtonHintSymbolsStyleOf6',
        'cn2enButtonHintSymbolsStyleOf8',
      ],
    },
    cn2enButtonHintSymbolsStyleOf0: systemKeys.cn2enButtonHintSymbolsStyleOf0,
    cn2enButtonHintSymbolsStyleOf4: systemKeys.cn2enButtonHintSymbolsStyleOf4,
    cn2enButtonHintSymbolsStyleOf6: systemKeys.cn2enButtonHintSymbolsStyleOf6,
    cn2enButtonHintSymbolsStyleOf8: systemKeys.cn2enButtonHintSymbolsStyleOf8,

    enterButton: systemKeys.enterButton { size: { width: sizes.enter } },
    enterButtonForegroundStyle0: systemKeys.enterButtonForegroundStyle0,
    enterButtonForegroundStyle6: systemKeys.enterButtonForegroundStyle6,
    enterButtonForegroundStyle7: systemKeys.enterButtonForegroundStyle7,
    enterButtonForegroundStyle14: systemKeys.enterButtonForegroundStyle14,
    enterButtonForegroundStyle9: systemKeys.enterButtonForegroundStyle9,

    spaceFirstButton: systemKeys.spaceFirstButton,
    spaceSecondButton: systemKeys.spaceSecondButton,
  },
}
