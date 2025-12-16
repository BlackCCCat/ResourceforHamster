local center = import 'center.libsonnet';
local color = import 'color.libsonnet';
local fontSize = import 'fontSize.libsonnet';

{
  // 生成 iPad 专属的覆盖配置
  getOverrides(theme, keyboardLayout, createButtonFunc, root):: {
    // 移除 iPhone 的 123Button
    '123Button':: null,

    // iPad 专属的 nextButton (地球键)
    nextButton: createButtonFunc(
      'next',
      keyboardLayout['竖屏按键尺寸']['next键size'], // iPad 横竖屏尺寸一致
      {},
      root,
      false
    ) + {
      backgroundStyle: 'systemButtonBackgroundStyle',
      foregroundStyle: 'nextButtonForegroundStyle',
      action: 'nextKeyboard',
    },
    nextButtonForegroundStyle: {
      buttonStyleType: 'systemImage',
      systemImageName: 'globe',
      normalColor: color[theme]['按键前景颜色'],
      highlightColor: color[theme]['按键前景颜色'],
      fontSize: fontSize['按键前景文字大小'] - 3,
      center: center['功能键前景文字偏移'] { y: 0.5 },
    },

    // iPad 专属的 ipad123Button
    ipad123Button: createButtonFunc(
      'ipad123',
      keyboardLayout['竖屏按键尺寸']['ipad123键size'], // iPad 横竖屏尺寸一致
      {},
      root,
      false
    ) + {
      type: 'horizontalSymbols',
      maxColumns: 1,
      contentRightToLeft: false,
      insets: { left: 3, right: 3 },
      backgroundStyle: 'systemButtonBackgroundStyle',
      dataSource: [
        { label: '1', action: { keyboardType: 'numeric' }, styleName: 'numericStyle' },
        { label: '2', action: { keyboardType: 'symbolic' }, styleName: 'symbolicStyle' },
        { label: '4', action: { keyboardType: 'emojis' }, styleName: 'emojisStyle' },
      ],
    },
  },
}