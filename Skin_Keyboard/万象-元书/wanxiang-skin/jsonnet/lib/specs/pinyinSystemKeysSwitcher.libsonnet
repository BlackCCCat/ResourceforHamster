// Define the pinyin 123 switcher key so keyboard switching stays isolated from other system-key behaviors.
{
  build(theme, orientation, keyboardLayout, createButton, baseHintStyles):: {
    '123Button': createButton(
      '123',
      if orientation == 'portrait' then
        keyboardLayout['竖屏按键尺寸']['123键size']
      else
        keyboardLayout['横屏按键尺寸']['123键size'],
      {},
      baseHintStyles,
      false
    ) + {
      type: 'horizontalSymbols',
      maxColumns: 1,
      insets: { left: 3, right: 3 },
      contentRightToLeft: false,
      backgroundStyle: 'systemButtonBackgroundStyle',
      dataSource: '123ButtonSymbolsDataSource',
    },
    '123ButtonSymbolsDataSource': [
      { label: '1', action: { keyboardType: 'numeric' }, styleName: 'numericStyle' },
      { label: '2', action: { keyboardType: 'symbolic' }, styleName: 'symbolicStyle' },
      { label: '4', action: { keyboardType: 'emojis' }, styleName: 'emojisStyle' },
    ],
  },
}
