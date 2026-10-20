// 定义拼音 9 键使用的面板型组件。
local appearance = import '../../design/appearance.libsonnet';
local color = appearance.color;
local fontSize = appearance.fontSize;
local styleFactories = import '../../design/styleFactories.libsonnet';
local hintSymbolsStyles = import '../../components/key/longPress.libsonnet';

{
  build(context, theme, orientation)::
    local makePanelGeometryStyle(normalColor, extra={}) =
      // 生成 collection 与单元格共用的 geometry 样式。
      styleFactories.makeGeometryStyle(normalColor, extra);
    {
      collection: {
        size: { height: '3/4' },
        insets: { top: 6, bottom: 6 },
        backgroundStyle: 'collectionBackgroundStyle',
        type: 't9Symbols',
        dataSource: 'symbols',
        cellStyle: 'collectionCellStyle',
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
      alphabeticHintSymbolsBackgroundStyle: hintSymbolsStyles['长按背景样式'],
      alphabeticHintSymbolsSelectedStyle: hintSymbolsStyles['长按选中背景样式'],

      // 宿主通过固定名称 verticalCandidates 识别横屏九键左侧候选区。
      verticalCandidates: {
        type: 'verticalCandidates',
        size: { height: '1' },
        insets: { top: 3, left: 6, right: 6, bottom: 3 },
        maxRows: 4,
        separatorColor: 0,
        backgroundStyle: 'alphabeticBackgroundStyle',
        candidateStyle: 'verticalCandidateCellStyle',
      },
      verticalCandidateCellStyle: {
        highlightBackgroundColor: 0,
        preferredBackgroundColor: color[theme]['选中候选背景颜色'],
        preferredIndexColor: color[theme]['候选字体选中字体颜色'],
        preferredTextColor: color[theme]['候选字体选中字体颜色'],
        preferredCommentColor: color[theme]['候选字体选中字体颜色'],
        indexColor: color[theme]['长按非选中字体颜色'],
        textColor: color[theme]['长按非选中字体颜色'],
        commentColor: color[theme]['长按非选中字体颜色'],
        indexFontSize: 16,
        textFontSize: 16,
        commentFontSize: 16,
        bottomRowHeight: 50,
      },
    },
}
