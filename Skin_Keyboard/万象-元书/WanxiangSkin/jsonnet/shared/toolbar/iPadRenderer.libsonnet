// 平板端工具栏渲染器，负责固定首按钮、中间滑动区与固定收起按钮。
local Settings = import '../../Custom.libsonnet';
local toolbarShared = import 'config.libsonnet';

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
        contentRightToLeft: Settings.toolbar_config.ipad.content_right_to_left,
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
