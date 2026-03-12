// 工具栏共享辅助模块：负责读取配置、校验按钮 ID，并生成滑动按钮数据源项。
{
  searchOpenURLMap: {
    google: 'https://www.google.com/search?q=#pasteboardContent',
    baidu: 'https://www.baidu.com/s?wd=#pasteboardContent',
    bing: 'https://www.bing.com/search?q=#pasteboardContent',
  },

  searchStyleNameMap: {
    google: 'toolbarButtonGoogleStyle',
    baidu: 'toolbarButtonBaiduStyle',
    bing: 'toolbarButtonBingStyle',
  },

  getToolbarConfig(Settings)::
    if std.objectHas(Settings, 'toolbar_config') then Settings.toolbar_config else {},

  getToolbarMenu(toolbarConfig)::
    if std.objectHas(toolbarConfig, 'toolbar_menu') then toolbarConfig.toolbar_menu else false,

  getIpadToolbarConfig(toolbarConfig)::
    if std.objectHas(toolbarConfig, 'ipad') then toolbarConfig.ipad else {},

  getIpadToolbarMenu(toolbarConfig)::
    local ipadToolbarConfig = self.getIpadToolbarConfig(toolbarConfig);
    if std.objectHas(ipadToolbarConfig, 'toolbar_menu') then ipadToolbarConfig.toolbar_menu
    else self.getToolbarMenu(toolbarConfig),

  dedupeIds(ids)::
    std.foldl(
      function(acc, id)
        if std.member(acc, id) then acc else acc + [id],
      ids,
      []
    ),

  getToolbarId(registry, value, fallback)::
    if std.type(value) == 'string' && std.objectHas(registry, value) then value else fallback,

  getToolbarIds(registry, values, fallback, dedupe=false)::
    local source = if std.type(values) == 'array' then values else fallback;
    local filtered = [
      value
      for value in source
      if std.type(value) == 'string' && std.objectHas(registry, value)
    ];
    local normalized = if dedupe then self.dedupeIds(filtered) else filtered;
    if std.length(normalized) > 0 then normalized else fallback,

  // 固定按钮布局只需要 Cell 名称，真正的 action 由对应样式对象提供。
  makeToolbarCell(registry, id)::
    { Cell: registry[id].cellName },

  // 滑动按钮不会读取样式对象中的 action，因此这里要把 registry 里的 action 写入数据源。
  makeSlideItem(registry, id, index):: {
    label: std.toString(index),
    action: registry[id].action,
    styleName: registry[id].slideStyleName,
  },
}
