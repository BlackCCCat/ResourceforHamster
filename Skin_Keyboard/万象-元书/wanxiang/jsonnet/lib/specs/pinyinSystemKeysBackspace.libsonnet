// Define the pinyin backspace key so deletion behavior is isolated from the rest of the system-key assembly.
{
  build(theme, orientation, keyboardLayout, color, fontSize, createButton, baseHintStyles):: {
    backspaceButton: createButton(
      'backspace',
      if orientation == 'portrait' then
        keyboardLayout['竖屏按键尺寸']['backspace键size']
      else
        keyboardLayout['横屏按键尺寸']['backspace键size'],
      {},
      baseHintStyles,
      false
    ) + {
      backgroundStyle: 'systemButtonBackgroundStyle',
      action: 'backspace',
      repeatAction: 'backspace',
    },
    backspaceButtonForegroundStyle: {
      buttonStyleType: 'systemImage',
      systemImageName: 'delete.left',
      normalColor: color[theme]['按键前景颜色'],
      highlightColor: color[theme]['按键前景颜色'],
      fontSize: fontSize['按键前景文字大小'],
      targetScale: 0.7,
    },
  },
}
