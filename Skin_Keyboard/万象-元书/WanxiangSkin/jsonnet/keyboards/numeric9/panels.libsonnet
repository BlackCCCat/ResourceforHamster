// 定义数字 9 键使用的面板型组件。
local color = import '../../shared/styles/color.libsonnet';
local fontSize = import '../../shared/styles/fontSize.libsonnet';
local styleFactories = import '../../shared/styles/styleFactories.libsonnet';

local numericSymbols = [
  { label: '+', action: { character: '+' } },
  { label: '-', action: { character: '-' } },
  { label: '×', action: { character: '*' } },
  { label: '/', action: { character: '/' } },
  { label: '(', action: { character: '(' } },
  { label: ')', action: { character: ')' } },
  '.',
  '@',
  ',',
  '#',
  ':',
  '_',
  '?',
  '￥',
];

{
  build(context, theme, orientation)::
    local makePanelGeometryStyle(normalColor, extra={}) =
      // 生成 collection 与单元格共用的 geometry 样式。
      styleFactories.makeGeometryStyle(normalColor, extra);
    {
    collection: {
      size: {
        height: '3/4',
      },
      insets: { top: 6, bottom: 6 },
      backgroundStyle: 'collectionBackgroundStyle',
      type: 'symbols',
      dataSource: 'symbols',
      cellStyle: 'collectionCellStyle',
    },
    landscapeCollection: {
      size: {
        height: '3/4',
      },
      insets: { top: 6, bottom: 6 },
      backgroundStyle: 'collectionBackgroundStyle',
      type: 't9Symbols',
      dataSource: 'landscapeSymbols',
      cellStyle: 'collectionCellStyle',
    },
    landscapeNumericSymbols: {
      size: {
        height: '1',
      },
      insets: { top: 3, bottom: 3, left: 3, right: 3 },
      backgroundStyle: 'collectionBackgroundStyle',
      type: 'categorySymbols',
    },
    collectionBackgroundStyle: makePanelGeometryStyle(color[theme]['符号键盘左侧collection背景颜色'], {
      insets: if orientation == 'portrait' then context.Settings.button_insets.portrait else context.Settings.button_insets.landscape,
      cornerRadius: context.Settings.cornerRadius,
      normalLowerEdgeColor: color[theme]['符号键盘左侧collection背景下边缘颜色'],
    }),
    collectionCellStyle: {
      backgroundStyle: 'collectionCellBackgroundStyle',
      foregroundStyle: 'collectionCellForegroundStyle',
    },
    collectionCellBackgroundStyle: makePanelGeometryStyle('ffffff00', {
      insets: if orientation == 'portrait' then context.Settings.button_insets.portrait else context.Settings.button_insets.landscape,
      highlightColor: color[theme]['字母键背景颜色-普通'],
      cornerRadius: context.Settings.cornerRadius,
    }),
    collectionCellForegroundStyle: {
      buttonStyleType: 'text',
      normalColor: color[theme]['collection前景颜色'],
      fontSize: fontSize['collection前景字体大小'],
      fontWeight: 0,
    },
    symbols: numericSymbols,
    landscapeSymbols: [
      if std.type(item) == 'string' then {
        label: item,
        action: { character: item },
      } else item
      for item in numericSymbols
    ],
  },
}
