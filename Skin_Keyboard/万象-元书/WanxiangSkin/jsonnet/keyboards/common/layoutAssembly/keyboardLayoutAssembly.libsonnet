// 统一装配共享布局数据并生成最终键盘布局集合。
local keyboardLayoutBaseData = import '../../../shared/data/layoutData.libsonnet';
local keyboardLayoutFuncRowPatch = import '../../../shared/functionButtons/functionRowPatch.libsonnet';
local keyboard26Layout = import '../keyboard26/layout.libsonnet';
local pinyin18Layout = import '../../pinyin18/layout.libsonnet';
local pinyin14Layout = import '../../pinyin14/layout.libsonnet';

{
  new(Settings, theme, orientation, deviceType='iPhone'):: {
    Settings: Settings,
    theme: theme,
    orientation: orientation,
    deviceType: deviceType,
    isPortrait: orientation == 'portrait',
    withFunctionsRow: Settings.function_button_config.with_functions_row[deviceType],
  },

  getKeyboardLayout(context)::
    local baseLayout =
      keyboardLayoutBaseData.getKeyboardLayout(context.theme) +
      keyboard26Layout.getKeyboardLayout(context.theme) +
      pinyin18Layout.getKeyboardLayout(context.theme) +
      pinyin14Layout.getKeyboardLayout(context.theme);
    if context.withFunctionsRow then
      baseLayout + keyboardLayoutFuncRowPatch.getPatch(context.theme, baseLayout)
    else
      baseLayout,
}
