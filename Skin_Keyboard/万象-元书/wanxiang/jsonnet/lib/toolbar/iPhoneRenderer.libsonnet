// 手机工具栏渲染器：只负责布局结构和 horizontalSymbols 数据源，不定义固定按钮样式。
local Settings = import '../../Custom.libsonnet';
local toolbarShared = import 'shared.libsonnet';

{
  build(toolbarMode, segmentedResolved, carouselResolved, toolbarButtonRegistry)::
    local makeToolbarCell(id) = toolbarShared.makeToolbarCell(toolbarButtonRegistry, id);
    local makeSlideItem(id, index) = toolbarShared.makeSlideItem(toolbarButtonRegistry, id, index);
    {
      toolbarLayout: [
        {
          HStack: {
            subviews:
              if toolbarMode == 'carousel' then
                [
                  makeToolbarCell(carouselResolved.left_fixed),
                  { Cell: 'toolbarSlideButtonsCenter' },
                  makeToolbarCell(carouselResolved.right_fixed),
                ]
              else
                [
                  makeToolbarCell(segmentedResolved.left_fixed),
                  { Cell: 'toolbarSlideButtonsLeft' },
                  makeToolbarCell(segmentedResolved.center_fixed),
                  { Cell: 'toolbarSlideButtonsRight' },
                  makeToolbarCell(segmentedResolved.right_fixed),
                ],
          },
        },
      ],
      toolbarButtonKeyboardSelectionStyle: {
        type: 'horizontalSymbols',
        size: { width: '1/7' },
        maxColumns: 1,
        contentRightToLeft: false,
        insets: { left: 3, right: 3 },
        backgroundStyle: 'toolbarcollectionCellBackgroundStyle',
        dataSource: 'horizontalSymbolsDataSource3',
        cellStyle: 'toolbarcollectionCellStyle',
      },
      // 单手模式切换同样属于滑动数据源路径，动作以这里为准。
      horizontalSymbolsDataSource3: [
        { label: '1', action: { shortcut: '#右手模式' }, styleName: 'toolbarButtonRighthandKeyboardStyle' },
        { label: '0', action: { shortcut: '#左手模式' }, styleName: 'toolbarButtonLefthandKeyboardStyle' },
      ],
      toolbarSlideButtonsLeft: {
        type: 'horizontalSymbols',
        size: { width: '2/7' },
        maxColumns: 2,
        contentRightToLeft: Settings.toolbar_config.content_right_to_left,
        insets: { left: 3, right: 3 },
        backgroundStyle: 'toolbarcollectionCellBackgroundStyle',
        dataSource: 'horizontalSymbolsDataSourceLeft',
        cellStyle: 'toolbarcollectionCellStyle',
      },
      toolbarSlideButtonsRight: {
        type: 'horizontalSymbols',
        size: { width: '2/7' },
        maxColumns: 2,
        contentRightToLeft: Settings.toolbar_config.content_right_to_left,
        insets: { left: 3, right: 3 },
        backgroundStyle: 'toolbarcollectionCellBackgroundStyle',
        dataSource: 'horizontalSymbolsDataSourceRight',
        cellStyle: 'toolbarcollectionCellStyle',
      },
      toolbarSlideButtonsCenter: {
        type: 'horizontalSymbols',
        size: { width: '5/7' },
        maxColumns: 5,
        contentRightToLeft: Settings.toolbar_config.content_right_to_left,
        insets: { left: 3, right: 3 },
        backgroundStyle: 'toolbarcollectionCellBackgroundStyle',
        dataSource: 'horizontalSymbolsDataSourceCenter',
        cellStyle: 'toolbarcollectionCellStyle',
      },
      horizontalSymbolsDataSourceLeft: [
        makeSlideItem(segmentedResolved.left_slide[i], i)
        for i in std.range(0, std.length(segmentedResolved.left_slide) - 1)
      ],
      horizontalSymbolsDataSourceRight: [
        makeSlideItem(segmentedResolved.right_slide[i], i)
        for i in std.range(0, std.length(segmentedResolved.right_slide) - 1)
      ],
      horizontalSymbolsDataSourceCenter: [
        makeSlideItem(carouselResolved.center_slide[i], i)
        for i in std.range(0, std.length(carouselResolved.center_slide) - 1)
      ],
    },
}
