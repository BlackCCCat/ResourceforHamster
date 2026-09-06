// 暴露 「乱序 17 键」拼音入口，复用 14/18 键共享构建流程。
local Settings = import '../../../Custom.libsonnet';
local buildContext = import '../../../build/context.libsonnet';
local compactKeyboardBuilder = import '../base/builder.libsonnet';
local compact17 = import './data.libsonnet';

local build(theme, orientation, keyboardLayout=null) =
  local context = buildContext.new(Settings, theme, orientation, 'iPhone');
  local resolvedKeyboardLayout = if keyboardLayout == null then buildContext.getKeyboardLayout(context) else keyboardLayout;
  local spec = compact17.getSpec(context, resolvedKeyboardLayout);
  compactKeyboardBuilder.build(context, resolvedKeyboardLayout, spec, compact17);

{
  new(theme, orientation):
    build(theme, orientation),
}
