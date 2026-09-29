// 汇总最终参与输出的键盘模块。
// 中文拼音不再按 Custom.keyboard_layout 单选：全部布局都会产出，
// 由 config.yaml 中的 pinyin9/14/17/18/26/27 槽位配合 action.keyboardType 在运行时互相跳转。
{
  // iPhone 中文拼音的全部布局。26 与 27 共用同一键盘族，靠 new() 的 layoutOverride 区分分号键。
  pinyin9: import '../keyboards/pinyin9/keyboard.libsonnet',
  pinyin14: import '../keyboards/pinyinGrouped/pinyin14/keyboard.libsonnet',
  pinyin17: import '../keyboards/pinyinGrouped/pinyin17/keyboard.libsonnet',
  pinyin18: import '../keyboards/pinyinGrouped/pinyin18/keyboard.libsonnet',
  pinyin26: import '../keyboards/keyboard26/pinyin/keyboard.libsonnet',

  // 布局切换浮动面板（由工具栏 keyboard_swotcher 打开）。
  layoutSwitch: import '../keyboards/layoutSwitch/keyboard.libsonnet',

  tempPinyin: import '../keyboards/keyboard26/tempPinyin/keyboard.libsonnet',
  alphabetic: import '../keyboards/keyboard26/alphabetic/keyboard.libsonnet',
  numeric: import '../keyboards/numeric9/keyboard.libsonnet',
  panel: import '../keyboards/floatPanel/keyboard.libsonnet',
  iPadPinyin: import '../keyboards/keyboard26/pinyin/iPad.libsonnet',
  iPadAlphabetic: import '../keyboards/keyboard26/alphabetic/iPad.libsonnet',
  iPadNumeric: import '../keyboards/numeric9/iPad.libsonnet',
}
