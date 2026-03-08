local Settings = import '../Custom.libsonnet';
local toolbar = import 'toolbar.libsonnet';

local toolbarConfig = if std.objectHas(Settings, 'toolbar_config') then Settings.toolbar_config else {};
local ipadToolbarConfig =
  if std.objectHas(toolbarConfig, 'ipad') then toolbarConfig.ipad else {};
local toolbarMenu =
  if std.objectHas(ipadToolbarConfig, 'toolbar_menu') then ipadToolbarConfig.toolbar_menu
  else if std.objectHas(toolbarConfig, 'toolbar_menu') then toolbarConfig.toolbar_menu
  else false;

local searchOpenURLMap = {
  google: 'https://www.google.com/search?q=#pasteboardContent',
  baidu: 'https://www.baidu.com/s?wd=#pasteboardContent',
  bing: 'https://www.bing.com/search?q=#pasteboardContent',
};

local searchStyleNameMap = {
  google: 'toolbarButtonGoogleStyle',
  baidu: 'toolbarButtonBaiduStyle',
  bing: 'toolbarButtonBingStyle',
};

local ipadToolbarButtonRegistry = {
  keyboard_settings: {
    cellName: 'toolbarButtonKeyboardSettingsStyle',
    slideStyleName: 'toolbarButtonKeyboardSettingsStyle',
    action: { openURL: 'hamster3://com.ihsiao.apps.hamster3/keyboardSettings' },
  },
  keyboard_skins: {
    cellName: 'toolbarButtonKeyboardSkinsStyle',
    slideStyleName: 'toolbarButtonKeyboardSkinsStyle',
    action: { openURL: 'hamster3://com.ihsiao.apps.hamster3/finder?action=openSkinsFile&fileURL=jsonnet/Custom.libsonnet' },
  },
  keyboard_performance: {
    cellName: 'toolbarButtonKeyboardPerformanceStyle',
    slideStyleName: 'toolbarButtonKeyboardPerformanceStyle',
    action: { shortcut: '#keyboardPerformance' },
  },
  embedding_toggle: {
    cellName: 'toolbarButtonEmbeddingToggleStyle',
    slideStyleName: 'toolbarButtonEmbeddingToggleStyle',
    action: { shortcut: '#toggleEmbeddedInputMode' },
  },
  rime_switcher: {
    cellName: 'toolbarButtonRimeSwitcherStyle',
    slideStyleName: 'toolbarButtonRimeSwitcherStyle',
    action: { shortcut: '#RimeSwitcher' },
  },
  google: {
    cellName: 'toolbarButtonGoogleStyle',
    slideStyleName: searchStyleNameMap.google,
    action: { openURL: searchOpenURLMap.google },
  },
  baidu: {
    cellName: 'toolbarButtonBaiduStyle',
    slideStyleName: searchStyleNameMap.baidu,
    action: { openURL: searchOpenURLMap.baidu },
  },
  bing: {
    cellName: 'toolbarButtonBingStyle',
    slideStyleName: searchStyleNameMap.bing,
    action: { openURL: searchOpenURLMap.bing },
  },
  safari: {
    cellName: 'toolbarButtonSafariStyle',
    slideStyleName: 'toolbarButtonSafariStyle',
    action: { openURL: '#pasteboardContent' },
  },
  apple: {
    cellName: 'toolbarButtonAppleStyle',
    slideStyleName: 'toolbarButtonAppleStyle',
    action: { openURL: 'itms-apps://search.itunes.apple.com/WebObjects/MZSearch.woa/wa/search?media=software&term=#pasteboardContent' },
  },
  script: {
    cellName: 'toolbarButtonScriptStyle',
    slideStyleName: 'toolbarButtonScriptStyle',
    action: { shortcutCommand: '#toggleScriptView' },
  },
  symbol: {
    cellName: 'toolbarButtonSymbolStyle',
    slideStyleName: 'toolbarButtonSymbolStyle',
    action: { keyboardType: 'symbolic' },
  },
  emoji: {
    cellName: 'toolbarButtonEmojiStyle',
    slideStyleName: 'toolbarButtonEmojiStyle',
    action: { keyboardType: 'emojis' },
  },
  note: {
    cellName: 'toolbarButtonNoteStyle',
    slideStyleName: 'toolbarButtonNoteStyle',
    action: { shortcutCommand: '#showPhraseView' },
  },
  clipboard: {
    cellName: 'toolbarButtonClipboardStyle',
    slideStyleName: 'toolbarButtonClipboardStyle',
    action: { shortcutCommand: '#showPasteboardView' },
  },
};

local dedupeIds(ids) =
  std.foldl(
    function(acc, id)
      if std.member(acc, id) then acc else acc + [id],
    ids,
    []
  );

local getIpadToolbarIds(values, fallback) =
  local source = if std.type(values) == 'array' then values else fallback;
  local filtered = [
    value
    for value in source
    if std.type(value) == 'string' && std.objectHas(ipadToolbarButtonRegistry, value)
  ];
  local deduped = dedupeIds(filtered);
  if std.length(deduped) > 0 then deduped else fallback;

local ipadToolbarItems = getIpadToolbarIds(
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
  ]
);

local makeIpadSlideItem(id, index) = {
  label: std.toString(index),
  action: ipadToolbarButtonRegistry[id].action,
  styleName: ipadToolbarButtonRegistry[id].slideStyleName,
};

{
  getToolBar(theme):: toolbar.getToolBar(theme) + {
    toolbarLayout: [
      {
        HStack: {
          subviews: [
            { Cell: if toolbarMenu then 'toolbarButtonOpenAppMenuStyle' else 'toolbarButtonPanelStyle' },
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

    toolbarButtonKeyboardSkinsStyle+: {
      action: { openURL: 'hamster3://com.ihsiao.apps.hamster3/finder?action=openSkinsFile&fileURL=jsonnet/Custom.libsonnet' },
    },
  },
}
