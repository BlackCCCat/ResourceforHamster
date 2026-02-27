local center = import 'center.libsonnet';
local color = import 'color.libsonnet';
local fontSize = import 'fontSize.libsonnet';

{
  getOverrides(theme, keyboardLayout, createButtonFunc, hintRoot):: {
    // 移除 iPhone 的 123Button
    '123Button':: null,

    // iPad 专属的 nextButton (地球键)
    nextButton: createButtonFunc(
      'next',
      keyboardLayout['竖屏按键尺寸']['next键size'], // iPad 横竖屏尺寸一致
      {},
      hintRoot,
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

    // 修改 ipad123Button 定义
    ipad123Button: createButtonFunc(
      'ipad123', // 注意：这里 key 叫 ipad123
      keyboardLayout['竖屏按键尺寸']['ipad123键size'],
      {},
      hintRoot,
      false
    ) + {
      type: 'horizontalSymbols',
      maxColumns: 1,
      contentRightToLeft: false,
      backgroundStyle: 'systemButtonBackgroundStyle',
      
      // 关键：确保这里引用的 styleName (如 numericStyle) 在 root 中是存在的
      // 它们通常由 slideForeground.libsonnet 生成并被导入到 root
      dataSource: 'ipad123ButtonSymbolsDataSource',
    },
    ipad123ButtonSymbolsDataSource: [
        { label: '1', action: { keyboardType: 'numeric' }, styleName: 'numericStyle' },
        { label: '2', action: { keyboardType: 'symbolic' }, styleName: 'symbolicStyle' },
        { label: '4', action: { keyboardType: 'emojis' }, styleName: 'emojisStyle' },
      ],
  },
}
