// 手机工具栏渲染器：只负责布局结构和 horizontalSymbols 数据源，不定义固定按钮样式。
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
      toolbarSlideButtons2: {
        type: 'horizontalSymbols',
        size: { width: '2/7' },
        maxColumns: 2,
        contentRightToLeft: false,
        insets: { left: 3, right: 3 },
        backgroundStyle: 'toolbarcollectionCellBackgroundStyle',
        dataSource: 'horizontalSymbolsDataSource2',
        cellStyle: 'toolbarcollectionCellStyle',
      },
      // 这一组是历史保留的二级工具入口，样式名和 action 在这里直接绑定。
      // 如果后续调整某个入口动作，要同时检查 index.libsonnet 中固定按钮的同名样式定义。
      horizontalSymbolsDataSource2: [
        { label: '0', action: { openURL: 'hamster3://' }, styleName: 'toolbarButtonOpenAppMenuStyle' },
        { label: '1', action: { openURL: 'hamster3://com.ihsiao.apps.hamster3/keyboardSettings' }, styleName: 'toolbarButtonKeyboardSettingsStyle' },
        { label: '2', action: { openURL: 'hamster3://com.ihsiao.apps.hamster3/keyboardSkins' }, styleName: 'toolbarButtonKeyboardSkinsStyle' },
        { label: '5', action: { shortcut: '#keyboardPerformance' }, styleName: 'toolbarButtonKeyboardPerformanceStyle' },
        { label: '3', action: { shortcut: '#toggleEmbeddedInputMode' }, styleName: 'toolbarButtonEmbeddingToggleStyle' },
        { label: '4', action: { shortcut: '#RimeSwitcher' }, styleName: 'toolbarButtonRimeSwitcherStyle' },
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
        contentRightToLeft: false,
        insets: { left: 3, right: 3 },
        backgroundStyle: 'toolbarcollectionCellBackgroundStyle',
        dataSource: 'horizontalSymbolsDataSourceLeft',
        cellStyle: 'toolbarcollectionCellStyle',
      },
      toolbarSlideButtonsRight: {
        type: 'horizontalSymbols',
        size: { width: '2/7' },
        maxColumns: 2,
        contentRightToLeft: false,
        insets: { left: 3, right: 3 },
        backgroundStyle: 'toolbarcollectionCellBackgroundStyle',
        dataSource: 'horizontalSymbolsDataSourceRight',
        cellStyle: 'toolbarcollectionCellStyle',
      },
      toolbarSlideButtonsCenter: {
        type: 'horizontalSymbols',
        size: { width: '5/7' },
        maxColumns: 5,
        contentRightToLeft: false,
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
