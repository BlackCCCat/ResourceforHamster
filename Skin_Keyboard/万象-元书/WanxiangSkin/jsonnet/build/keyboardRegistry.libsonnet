// 汇总最终参与输出的键盘模块，并根据 Custom 选择手机端拼音布局。
local Settings = import '../Custom.libsonnet';

local pinyin =
  if Settings.keyboard_layout == 18 then import '../keyboards/pinyin14_18/pinyin18/keyboard.libsonnet'
  else if Settings.keyboard_layout == 17 then import '../keyboards/pinyin14_18/pinyin17/keyboard.libsonnet'
  else if Settings.keyboard_layout == 14 then import '../keyboards/pinyin14_18/pinyin14/keyboard.libsonnet'
  else if Settings.keyboard_layout == 9 then import '../keyboards/pinyin9/keyboard.libsonnet'
  else import '../keyboards/keyboard26/pinyin/keyboard.libsonnet';

{
  pinyin: pinyin,
  tempPinyin: import '../keyboards/keyboard26/tempPinyin/keyboard.libsonnet',
  alphabetic: import '../keyboards/keyboard26/alphabetic/keyboard.libsonnet',
  numeric: import '../keyboards/numeric9/keyboard.libsonnet',
  panel: import '../keyboards/floatPanel/keyboard.libsonnet',
  iPadPinyin: import '../keyboards/keyboard26/pinyin/iPad.libsonnet',
  iPadAlphabetic: import '../keyboards/keyboard26/alphabetic/iPad.libsonnet',
  iPadNumeric: import '../keyboards/numeric9/iPad.libsonnet',
}
