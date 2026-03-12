// iPad 工具栏入口：读取 iPad 专属配置，并在手机工具栏基础上覆盖 iPad 布局与少量动作。
local Settings = import '../../Custom.libsonnet';
local toolbar = import 'index.libsonnet';
local toolbarShared = import 'shared.libsonnet';
local toolbarRegistryLib = import 'registry.libsonnet';
local ipadRenderer = import 'ipadRenderer.libsonnet';

local toolbarConfig = toolbarShared.getToolbarConfig(Settings);
local ipadToolbarConfig = toolbarShared.getIpadToolbarConfig(toolbarConfig);
local toolbarMenu = toolbarShared.getIpadToolbarMenu(toolbarConfig);
local ipadToolbarButtonRegistry = toolbarRegistryLib.getIpadRegistry(toolbarMenu);

// iPad 中间滑动区的按钮列表只从 registry 中挑选有效 ID，并在这里去重。
local ipadToolbarItems = toolbarShared.getToolbarIds(ipadToolbarButtonRegistry,
  if std.objectHas(ipadToolbarConfig, 'center_slide') then ipadToolbarConfig.center_slide else [],
  [
    'keyboard_settings',
    'keyboard_skins',
    'keyboard_performance',
    'embedding_toggle',
    'rime_switcher',
    'google',
    'safari',
    'apple',
    'script',
    'note',
    'clipboard',
  ],
  true
);

{
  getToolBar(theme)::
    local ipadRendererConfig = ipadRenderer.build(toolbarMenu, ipadToolbarItems, ipadToolbarButtonRegistry);
    toolbar.getToolBar(theme) + {
    toolbarLayout: ipadRendererConfig.toolbarLayout,

    toolbarSlideButtonsIpadCenter: ipadRendererConfig.toolbarSlideButtonsIpadCenter,
    horizontalSymbolsDataSourceIpadCenter: ipadRendererConfig.horizontalSymbolsDataSourceIpadCenter,
  },
}
