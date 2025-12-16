local pinyin_base = import 'pinyin_26.jsonnet';
local toolbar_ipad = import '../lib/toolbar-ipad.libsonnet';
local ipad_common = import '../lib/ipad_common.libsonnet';

// iPad 使用的 deviceType 和相关的库
local deviceType = 'iPad';
local Settings = import '../custom/Custom.libsonnet';
local keyboardLayout_ = if Settings.with_functions_row[deviceType] then import '../lib/keyboardLayout.libsonnet' else import '../lib/keyboardLayoutWithoutFuncRow.libsonnet';

// 定义一个专门用于生成 iPad 键盘的函数
local ipad_keyboard(theme, orientation, keyboardLayout) =
  // 1. 首先，调用 pinyin_base 的 keyboard 函数，生成一个完整的 iPhone 键盘定义
  local base_def = pinyin_base.keyboard(theme, orientation, keyboardLayout);

  // 2. 然后，定义一个 "补丁"，包含所有 iPad 与 iPhone 的差异点
  local ipad_overrides =
    // 2.1. 使用 iPad 的专属布局
    keyboardLayout['ipad中文26键'] +
    toolbar_ipad.getToolBar(theme) +
    ipad_common.getOverrides(theme, keyboardLayout, pinyin_base.createButton, $);

  // 3. 最后，将 iPad 的 "补丁" 合并到 iPhone 的基础定义上，同名字段会被覆盖
  base_def + ipad_overrides;

// 导出与 pinyin_26.jsonnet 结构相同的对象
{
  new(theme, orientation)::
    ipad_keyboard(theme, orientation, keyboardLayout_.getKeyboardLayout(theme)),
}
