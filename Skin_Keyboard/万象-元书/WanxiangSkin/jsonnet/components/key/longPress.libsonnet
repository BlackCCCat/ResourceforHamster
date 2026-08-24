// 根据按键长按数据生成气泡容器、选中背景和每个候选项的前景样式。
local appearance = import '../../design/appearance.libsonnet';
local center = appearance.center;
local color = appearance.color;
local fontSize = appearance.fontSize;


// 文字前景样式
// 生成长按菜单的文字前景。
local textStyle(text, fontSizeValue, theme) = {
  buttonStyleType: 'text',
  text: text,
  fontSize: fontSizeValue,
  normalColor: color[theme]['长按非选中字体颜色'],
  highlightColor: color[theme]['长按选中字体颜色'],
  // center: center['长按气泡文字偏移'],
};

// 生成长按菜单的 SF Symbol 前景。
local systemImageStyle(systemImageName, fontSizeValue, theme) = {
  buttonStyleType: 'systemImage',
  systemImageName: systemImageName,
  fontSize: fontSizeValue,
  normalColor: color[theme]['长按非选中字体颜色'],
  highlightColor: color[theme]['长按选中字体颜色'],
  // center: center['长按气泡sf符号偏移'],
};

// 生成单个按键的长按菜单容器、条目和前景。
local holdSymbolsStyle(key, selectedIndex, size, symbol_list, theme) = {
  [key + 'ButtonHintSymbolsStyle']: {
    insets: { top: 3, bottom: 3, left: 8, right: 8 },
    backgroundStyle: 'alphabeticHintSymbolsBackgroundStyle',
    [if size != {} then 'size']:
      {
        width: size.width,
        height: size.height,
      },
    symbolStyles: [
      key + 'ButtonHintSymbolsStyleOf' + std.toString(index)
      for index in std.range(0, std.length(symbol_list) - 1)
    ],
    selectedBackgroundStyle: 'alphabeticHintSymbolsSelectedStyle',
    selectedIndex: selectedIndex,
  },
} + {

  [key + 'ButtonHintSymbolsForegroundStyleOf' + std.toString(index)]:
    if std.objectHas(symbol_list[index].label, 'text') then
      textStyle(
        symbol_list[index].label.text,
        if std.objectHas(symbol_list[index], 'fontSize') then symbol_list[index].fontSize else fontSize['长按气泡文字大小'],
        theme
      )
    else
      systemImageStyle(
        symbol_list[index].label.systemImageName,
        if std.objectHas(symbol_list[index], 'fontSize') then symbol_list[index].fontSize else fontSize['长按气泡sf符号大小'],
        theme
      )
  for index in std.range(0, std.length(symbol_list) - 1)
} + {
  [key + 'ButtonHintSymbolsStyleOf' + std.toString(index)]: {
    action: symbol_list[index].action,
    foregroundStyle: key + 'ButtonHintSymbolsForegroundStyleOf' + std.toString(index),
  }
  for index in std.range(0, std.length(symbol_list) - 1)
};

// 遍历长按数据并合并全部按键样式。
local finalStyles(theme, hintSymbolsData) = {
  style: std.foldl(
    function(acc, key) acc + holdSymbolsStyle(
      key,
      hintSymbolsData[key].selectedIndex,
      if std.objectHas(hintSymbolsData[key], 'size') then hintSymbolsData[key].size else {},
      hintSymbolsData[key].list,
      theme
    ),
    std.objectFields(hintSymbolsData),
    {}
  ),
};


{
  getStyle(theme, hintSymbolsData):
    finalStyles(theme, hintSymbolsData).style,
  '长按背景样式': {
    buttonStyleType: 'fileImage',
    normalImage: {
      file: 'hold_back',
      image: 'IMG1',
    },
    targetScale: {
      x: 1,
      y: 1.1,
    },
  },
  '长按选中背景样式': {
    buttonStyleType: 'fileImage',
    insets: { left: 4, right: 3, top: 8, bottom: 8 },
    normalImage: {
      file: 'hint',
      image: 'IMG1',
    },
    highlightImage: {
      file: 'hint',
      image: 'IMG1',
    },
    targetScale: {
      x: 0.8,
      y: 0.7,
    },
  },

}
