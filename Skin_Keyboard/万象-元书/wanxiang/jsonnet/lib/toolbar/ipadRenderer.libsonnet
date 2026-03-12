// iPad 工具栏渲染器：固定首按钮 + 中间滑动区 + 固定收起按钮。
local toolbarShared = import 'shared.libsonnet';

{
  build(toolbarMenu, ipadToolbarItems, ipadToolbarButtonRegistry)::
    local makeIpadSlideItem(id, index) = toolbarShared.makeSlideItem(ipadToolbarButtonRegistry, id, index);
    {
      toolbarLayout: [
        {
          HStack: {
            subviews: [
              // iPad 首按钮不走 registry，而是直接引用固定样式：
              // toolbar_menu=true 时打开 keyboardMenu，false 时直接打开 App。
              { Cell: if toolbarMenu then 'toolbarButtonOpenAppMenuStyle' else 'toolbarButtonOpenAppStyle' },
              { Cell: 'toolbarSlideButtonsIpadCenter' },
              { Cell: 'toolbarButtonHideStyle' },
            ],
          },
        },
      ],
      toolbarSlideButtonsIpadCenter: {
        type: 'horizontalSymbols',
        size: { width: '11/13' },
        maxColumns: 11,
        contentRightToLeft: false,
        insets: { left: 3, right: 3 },
        backgroundStyle: 'toolbarcollectionCellBackgroundStyle',
        dataSource: 'horizontalSymbolsDataSourceIpadCenter',
        cellStyle: 'toolbarcollectionCellStyle',
      },
      horizontalSymbolsDataSourceIpadCenter: [
        makeIpadSlideItem(ipadToolbarItems[i], i)
        for i in std.range(0, std.length(ipadToolbarItems) - 1)
      ],
    },
}
