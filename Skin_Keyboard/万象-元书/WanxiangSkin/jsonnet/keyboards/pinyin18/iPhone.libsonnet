// 暴露 18 键拼音入口，复用 14/18 键共享构建流程。
local Settings = import '../../Custom.libsonnet';
local keyboardRuntime = import '../../keyboards/common/layoutAssembly/keyboardLayoutAssembly.libsonnet';
local compact18 = import 'specs.libsonnet';
local compact18Layout = import '../common/keyboard26/layout.libsonnet';
local compactKeyboardBuilder = import '../common/pinyin14_18/iPhone.libsonnet';
local p26 = import '../pinyin26/iPhone.libsonnet';

local build(theme, orientation, keyboardLayout=null) =
  local context = keyboardRuntime.new(Settings, theme, orientation, 'iPhone');
  local resolvedKeyboardLayout = if keyboardLayout == null then keyboardRuntime.getKeyboardLayout(context) else keyboardLayout;
  local spec = compact18.getSpec(context, resolvedKeyboardLayout);
  local p26Layout = p26.keyboard(theme, orientation, resolvedKeyboardLayout);
  compactKeyboardBuilder.build(context, resolvedKeyboardLayout, spec, p26Layout);

{
  new(theme, orientation):
    build(theme, orientation),
}
