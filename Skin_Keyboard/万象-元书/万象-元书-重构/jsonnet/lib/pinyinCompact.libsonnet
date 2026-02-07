// Helpers for compact pinyin layouts (14/18).
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

  compactForegroundStyles(keys, fontSize, color, theme):: {
    [k.id + 'ButtonForegroundStyle']: {
      buttonStyleType: 'text',
      text: k.label,
      normalColor: color[theme]['按键前景颜色'],
      highlightColor: color[theme]['按键前景颜色'],
      fontSize: if std.length(k.label) > 2 then fontSize['按键前景文字大小'] - 4 else fontSize['按键前景文字大小'],
      center: { x: 0.5, y: 0.5 },
    }
    for k in keys
  } + {
    [k.id + 'ButtonUppercasedStateForegroundStyle']: {
      buttonStyleType: 'text',
      text: std.asciiUpper(k.label),
      normalColor: color[theme]['按键前景颜色'],
      highlightColor: color[theme]['按键前景颜色'],
      fontSize: if std.length(k.label) > 2 then fontSize['按键前景文字大小'] - 4 else fontSize['按键前景文字大小'],
      center: { x: 0.5, y: 0.5 },
    }
    for k in keys
  },

  commonFromP26(p26Layout, sizes, baseHintStyles):: {
    shiftButton: p26Layout.shiftButton + { size: { width: sizes.shift } },
    shiftButtonForegroundStyle: p26Layout.shiftButtonForegroundStyle,
    shiftButtonUppercasedForegroundStyle: p26Layout.shiftButtonUppercasedForegroundStyle,
    shiftButtonCapsLockedForegroundStyle: p26Layout.shiftButtonCapsLockedForegroundStyle,

    backspaceButton: p26Layout.backspaceButton + { size: { width: sizes.backspace } },
    backspaceButtonForegroundStyle: p26Layout.backspaceButtonForegroundStyle,

    '123Button': p26Layout['123Button'] + { size: { width: sizes.oneTwoThree } },
    '123ButtonSymbolsDataSource': p26Layout['123ButtonSymbolsDataSource'],

    spaceButton: p26Layout.spaceButton + { size: { width: sizes.space } },
    spaceButtonForegroundStyle: p26Layout.spaceButtonForegroundStyle,
    spaceButtonPreeditNotification: p26Layout.spaceButtonPreeditNotification,
    spaceButtonForegroundStyle1: p26Layout.spaceButtonForegroundStyle1,

    spaceLeftButton: p26Layout.spaceLeftButton + { size: { width: sizes.spaceLeft } },
    spaceLeftButtonForegroundStyle: p26Layout.spaceLeftButtonForegroundStyle,
    spaceLeftButtonForegroundStyle2: p26Layout.spaceLeftButtonForegroundStyle2,
    spaceRightButtonForegroundStyle: p26Layout.spaceRightButtonForegroundStyle,
    spaceRightButtonForegroundStyle2: p26Layout.spaceRightButtonForegroundStyle2,

    spaceFirstButtonPreeditNotification: p26Layout.spaceFirstButtonPreeditNotification,
    spaceFirstButtonForegroundStyle: p26Layout.spaceFirstButtonForegroundStyle,
    spaceSecondButtonPreeditNotification: p26Layout.spaceSecondButtonPreeditNotification,
    spaceSecondButtonForegroundStyle: p26Layout.spaceSecondButtonForegroundStyle,
    spaceSecondButtonForegroundStyle1: p26Layout.spaceSecondButtonForegroundStyle1,

    spaceRightButtonPreeditNotification: p26Layout.spaceRightButtonPreeditNotification,
    spaceRightButtonPreeditForegroundStyle: p26Layout.spaceRightButtonPreeditForegroundStyle,

    cn2enButton: p26Layout.cn2enButton,
    cn2enButtonForegroundStyle: p26Layout.cn2enButtonForegroundStyle,
    cn2enButtonHintSymbolsStyle: baseHintStyles['cn2enButtonHintSymbolsStyle'] + {
      symbolStyles: [
        'cn2enButtonHintSymbolsStyleOf0',
        'cn2enButtonHintSymbolsStyleOf4',
        'cn2enButtonHintSymbolsStyleOf6',
        'cn2enButtonHintSymbolsStyleOf8',
      ],
    },
    cn2enButtonHintSymbolsStyleOf0: p26Layout.cn2enButtonHintSymbolsStyleOf0,
    cn2enButtonHintSymbolsStyleOf4: p26Layout.cn2enButtonHintSymbolsStyleOf4,
    cn2enButtonHintSymbolsStyleOf6: p26Layout.cn2enButtonHintSymbolsStyleOf6,
    cn2enButtonHintSymbolsStyleOf8: p26Layout.cn2enButtonHintSymbolsStyleOf8,

    enterButton: p26Layout.enterButton + { size: { width: sizes.enter } },
    enterButtonForegroundStyle0: p26Layout.enterButtonForegroundStyle0,
    enterButtonForegroundStyle6: p26Layout.enterButtonForegroundStyle6,
    enterButtonForegroundStyle7: p26Layout.enterButtonForegroundStyle7,
    enterButtonForegroundStyle14: p26Layout.enterButtonForegroundStyle14,
    enterButtonForegroundStyle9: p26Layout.enterButtonForegroundStyle9,

    spaceFirstButton: p26Layout.spaceFirstButton,
    spaceSecondButton: p26Layout.spaceSecondButton,
  },
}
