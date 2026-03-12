// Provide reusable style factories and batch generators for text, system-image, and numeric key foreground styles.
{
  makeImageStyle(contentMode, normalFile, highlightFile, normalImage, highlightImage, center, insets):: {
    [if contentMode != null then 'contentMode']: contentMode,
    buttonStyleType: 'fileImage',
    normalImage: {
      file: normalFile,
      image: normalImage,
    },
    highlightImage: {
      file: highlightFile,
      image: highlightImage,
    },
    [if insets != {} then 'insets']: insets,
    [if center != {} then 'center']: center,
  },

  makeTextStyle(text, fontSize, normalColor, highlightColor, center):: {
    buttonStyleType: 'text',
    text: text,
    fontSize: fontSize,
    normalColor: normalColor,
    highlightColor: highlightColor,
    [if center != {} then 'center']: center,
  },

  makeSystemImageStyle(systemImageName, fontSize, normalColor, highlightColor, center):: {
    buttonStyleType: 'systemImage',
    systemImageName: systemImageName,
    fontSize: fontSize,
    normalColor: normalColor,
    highlightColor: highlightColor,
    [if center != {} then 'center']: center,
  },

  genSystemImageStates(keyMap, imageMap, suffix, fontSizeValue, normalColor, highlightColor, centerValue):: {
    [keyName + suffix]: $.makeSystemImageStyle(
      imageMap[keyName],
      fontSizeValue,
      normalColor,
      highlightColor,
      centerValue
    )
    for keyName in std.objectFields(keyMap)
  },

  genTextStates(keyMap, textMap, suffix, fontSizeValue, normalColor, highlightColor, centerValue):: {
    [keyName + suffix]: $.makeTextStyle(
      textMap[keyName],
      fontSizeValue,
      normalColor,
      highlightColor,
      centerValue
    )
    for keyName in std.objectFields(keyMap)
  },

  genNumberStates(prefix, suffix, values, fontSizeValue, normalColor, highlightColor, centerValue):: {
    [prefix + std.toString(num) + suffix]: {
      buttonStyleType: 'text',
      text: values[std.toString(num)],
      normalColor: normalColor,
      highlightColor: highlightColor,
      fontSize: fontSizeValue,
      center: centerValue,
    }
    for num in std.range(0, 9)
  },
}
