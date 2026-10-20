// 共享功能动作：固定工具栏与滑动工具栏必须引用同一实现。
{
  // 只在用户点击入口时读取当前系统剪贴板，不替代应用的后台历史记录功能。
  clipboardHistory: { combine: [
    { shortcut: '#readSystemPasteboard' },
    { shortcut: '#showPasteboardView' },
  ] },

  // 万象方案的 V 前缀由 super_calculator 处理；数字与运算符交给 Rime。
  calculator: { combine: [
    { character: 'V' },
    { keyboardType: 'numeric' },
  ] },
  calculatorFromAlphabetic: { combine: [
    { keyboardType: 'pinyin' },
    { character: 'V' },
    { keyboardType: 'numeric' },
  ] },
}
