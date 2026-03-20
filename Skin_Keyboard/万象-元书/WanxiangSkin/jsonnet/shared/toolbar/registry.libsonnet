// 工具栏按钮注册表，统一维护可配置按钮标识、滑动按钮样式名和滑动按钮动作。
local shared = import 'config.libsonnet';

{
  // action 主要供 horizontalSymbols 滑动按钮使用。
  // 固定按钮仍然依赖 index.libsonnet 里的样式对象自带 action，两者需要保持语义一致。
  getPhoneRegistry(toolbarMenu, switchKeyboardType='alphabetic'):: {
    script: {
      cellName: 'toolbarButtonScriptStyle',
      slideStyleName: 'toolbarButtonScriptStyle',
      action: { shortcutCommand: '#toggleScriptView' },
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
    hide: {
      cellName: 'toolbarButtonHideStyle',
      slideStyleName: 'toolbarButtonHideStyle',
      action: 'dismissKeyboard',
    },
    menu_or_panel: {
      cellName: if toolbarMenu then 'toolbarButtonOpenAppMenuStyle' else 'toolbarButtonPanelStyle',
      slideStyleName: if toolbarMenu then 'toolbarButtonOpenAppMenuStyle' else 'toolbarButtonPanelStyle',
      action: if toolbarMenu then { shortcut: '#keyboardMenu' } else { floatKeyboardType: 'panel' },
    },
    google: {
      cellName: 'toolbarButtonGoogleStyle',
      slideStyleName: shared.searchStyleNameMap.google,
      action: { openURL: shared.searchOpenURLMap.google },
    },
    baidu: {
      cellName: 'toolbarButtonBaiduStyle',
      slideStyleName: shared.searchStyleNameMap.baidu,
      action: { openURL: shared.searchOpenURLMap.baidu },
    },
    bing: {
      cellName: 'toolbarButtonBingStyle',
      slideStyleName: shared.searchStyleNameMap.bing,
      action: { openURL: shared.searchOpenURLMap.bing },
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
    keyboard_settings: {
      cellName: 'toolbarButtonKeyboardSettingsStyle',
      slideStyleName: 'toolbarButtonKeyboardSettingsStyle',
      action: { openURL: 'hamster3://com.ihsiao.apps.hamster3/keyboardSettings' },
    },
    keyboard_skins: {
      cellName: 'toolbarButtonKeyboardSkinsStyle',
      slideStyleName: 'toolbarButtonKeyboardSkinsStyle',
      action: { openURL: 'hamster3://com.ihsiao.apps.hamster3/keyboardSkins' },
    },
    skin_adjust: {
      cellName: 'toolbarButtonSkinAdjustStyle',
      slideStyleName: 'toolbarButtonSkinAdjustStyle',
      action: { openURL: 'hamster3://com.ihsiao.apps.hamster3/finder?action=openSkinsFile&fileURL=jsonnet/Custom.libsonnet' },
    },
    keyboard_performance: {
      cellName: 'toolbarButtonKeyboardPerformanceStyle',
      slideStyleName: 'toolbarButtonKeyboardPerformanceStyle',
      action: { shortcut: '#keyboardPerformance' },
    },
    rime_switcher: {
      cellName: 'toolbarButtonRimeSwitcherStyle',
      slideStyleName: 'toolbarButtonRimeSwitcherStyle',
      action: { shortcut: '#RimeSwitcher' },
    },
    embedding_toggle: {
      cellName: 'toolbarButtonEmbeddingToggleStyle',
      slideStyleName: 'toolbarButtonEmbeddingToggleStyle',
      action: { shortcut: '#toggleEmbeddedInputMode' },
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
    left_hand: {
      cellName: 'toolbarButtonLefthandKeyboardStyle',
      slideStyleName: 'toolbarButtonLefthandKeyboardStyle',
      action: { shortcut: '#左手模式' },
    },
    right_hand: {
      cellName: 'toolbarButtonRighthandKeyboardStyle',
      slideStyleName: 'toolbarButtonRighthandKeyboardStyle',
      action: { shortcut: '#右手模式' },
    },
    switch_keyboard: {
      cellName: 'toolbarButtonswitchKeyboardStyle',
      slideStyleName: 'toolbarButtonswitchKeyboardStyle',
      action: { keyboardType: switchKeyboardType },
    },
    undo: {
      cellName: 'toolbarButtonUndoStyle',
      slideStyleName: 'toolbarButtonUndoStyle',
      action: { shortcut: '#undo' },
    },
    redo: {
      cellName: 'toolbarButtonRedoStyle',
      slideStyleName: 'toolbarButtonRedoStyle',
      action: { shortcut: '#redo' },
    },
    simplified_traditional: {
      cellName: 'toolbarButtonchangeSimplifiedandTraditionalStyle',
      slideStyleName: 'toolbarButtonchangeSimplifiedandTraditionalStyle',
      action: { shortcut: '#简繁切换' },
    },
  },

  getIpadRegistry(toolbarMenu, switchKeyboardType='alphabetic')::
    // iPad 与 iPhone 保持同一组可配置按钮，只在布局层区分展示方式。
    self.getPhoneRegistry(toolbarMenu, switchKeyboardType),
}
