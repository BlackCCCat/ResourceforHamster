// 手机工具栏渲染器，只负责布局结构和滑动数据源，不定义固定按钮样式。
local Settings = import '../../Custom.libsonnet';
local toolbarShared = import 'config.libsonnet';

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
