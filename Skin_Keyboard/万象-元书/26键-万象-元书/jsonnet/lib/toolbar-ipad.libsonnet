local toolbar = import 'toolbar.libsonnet';

{
  getToolBar(theme):: toolbar.getToolBar(theme) + {
    // 覆盖工具栏布局：移除单手键盘切换和滑动区域，平铺所有按钮
    toolbarLayout: [
      {
        HStack: {
          subviews: [
            { Cell: 'toolbarButtonPanelStyle' },
            { Cell: 'toolbarButtonOpenAppStyle' },
            { Cell: 'toolbarButtonKeyboardSettingsStyle' },
            { Cell: 'toolbarButtonKeyboardSkinsStyle' },
            { Cell: 'toolbarButtonKeyboardPerformanceStyle' },
            { Cell: 'toolbarButtonEmbeddingToggleStyle' },
            { Cell: 'toolbarButtonRimeSwitcherStyle' },
            { Cell: 'toolbarButtonGoogleStyle' },
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
      action: { openURL: 'hamster3://com.ihsiao.apps.hamster3/keyboardSkins' },
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
    toolbarButtonGoogleStyle+: {
      action: { openURL: 'https://www.google.com/search?q=#pasteboardContent' },
    },
    toolbarButtonSafariStyle+: {
      action: { openURL: '#pasteboardContent' },
    },
    toolbarButtonAppleStyle+: {
      action: { openURL: 'itms-apps://search.itunes.apple.com/WebObjects/MZSearch.woa/wa/search?media=software&term=#pasteboardContent' },
    },
  },
}