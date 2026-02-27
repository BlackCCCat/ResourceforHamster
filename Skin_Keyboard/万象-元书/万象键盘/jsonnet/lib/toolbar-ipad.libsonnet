local Settings = import '../Custom.libsonnet';
local toolbar = import 'toolbar.libsonnet';

local toolbarSearchEngine = if std.objectHas(Settings, 'toolbar_search_engine') then Settings.toolbar_search_engine else 'google';
local searchEngine =
  if std.member(['google', 'baidu', 'bing'], toolbarSearchEngine) then toolbarSearchEngine
  else 'google';

local searchOpenURLMap = {
  google: 'https://www.google.com/search?q=#pasteboardContent',
  baidu: 'https://www.baidu.com/s?wd=#pasteboardContent',
  bing: 'https://www.bing.com/search?q=#pasteboardContent',
};

local searchCellStyleMap = {
  google: 'toolbarButtonGoogleStyle',
  baidu: 'toolbarButtonBaiduStyle',
  bing: 'toolbarButtonBingStyle',
};

local searchOpenURL = searchOpenURLMap[searchEngine];
local searchCellStyle = searchCellStyleMap[searchEngine];

{
  getToolBar(theme):: toolbar.getToolBar(theme) + {
    // 覆盖工具栏布局：移除单手键盘切换和滑动区域，平铺所有按钮
    toolbarLayout: [
      {
        HStack: {
          subviews: [
            { Cell: 'toolbarButtonOpenAppStyle' },
            { Cell: 'toolbarButtonKeyboardSettingsStyle' },
            { Cell: 'toolbarButtonKeyboardSkinsStyle' },
            { Cell: 'toolbarButtonKeyboardPerformanceStyle' },
            { Cell: 'toolbarButtonEmbeddingToggleStyle' },
            { Cell: 'toolbarButtonRimeSwitcherStyle' },
            { Cell: searchCellStyle },
            { Cell: 'toolbarButtonSafariStyle' },
            { Cell: 'toolbarButtonAppleStyle' },
            { Cell: 'toolbarButtonScriptStyle' },
            { Cell: 'toolbarButtonNoteStyle' },
            { Cell: 'toolbarButtonClipboardStyle' },
            { Cell: 'toolbarButtonHideStyle' },
          ],
        },
      },
    ],

    // 为平铺的按钮补充 action 定义（原文件中这些按钮可能只在 dataSource 中定义了 action）
    toolbarButtonOpenAppStyle+: {
      action: { openURL: 'hamster3://' },
    },
    toolbarButtonKeyboardSettingsStyle+: {
      action: { openURL: 'hamster3://com.ihsiao.apps.hamster3/keyboardSettings' },
    },
    toolbarButtonKeyboardSkinsStyle+: {
      action: { openURL: 'hamster3://com.ihsiao.apps.hamster3/finder?action=openAppFile&fileURL=Skins/万象键盘/jsonnet/Custom.libsonnet' },
    },
    toolbarButtonKeyboardPerformanceStyle+: {
      action: { shortcut: '#keyboardPerformance' },
    },
    toolbarButtonEmbeddingToggleStyle+: {
      action: { shortcut: '#toggleEmbeddedInputMode' },
    },
    toolbarButtonRimeSwitcherStyle+: {
      action: { shortcut: '#RimeSwitcher' },
    },
    [searchCellStyle]+: {
      action: { openURL: searchOpenURL },
    },
    toolbarButtonSafariStyle+: {
      action: { openURL: '#pasteboardContent' },
    },
    toolbarButtonAppleStyle+: {
      action: { openURL: 'itms-apps://search.itunes.apple.com/WebObjects/MZSearch.woa/wa/search?media=software&term=#pasteboardContent' },
    },
  },
}
