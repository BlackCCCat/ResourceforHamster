// 定义拼音退格键。
local styleFactories = import '../../../shared/styles/styleFactories.libsonnet';

{
  build(theme, orientation, keyboardLayout, color, fontSize, createButton, baseHintStyles)::
    local makeBackspaceForegroundStyle() =
      // 生成退格键图标前景。
      styleFactories.makeSystemImageStyle(
        'delete.left',
        fontSize['按键前景文字大小'],
        color[theme]['按键前景颜色'],
        color[theme]['按键前景颜色'],
        {}
      ) + { targetScale: 0.7 };
    {
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
    backspaceButtonForegroundStyle: makeBackspaceForegroundStyle(),
  },
}
