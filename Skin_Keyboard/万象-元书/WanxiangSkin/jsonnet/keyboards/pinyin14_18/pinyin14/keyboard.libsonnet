// 暴露 14 键拼音入口，复用 14/18 键共享构建流程。
local Settings = import '../../../Custom.libsonnet';
local buildContext = import '../../../build/context.libsonnet';
local compactKeyboardBuilder = import '../base/builder.libsonnet';
local compact14 = import './data.libsonnet';

local build(theme, orientation, keyboardLayout=null) =
  local context = buildContext.new(Settings, theme, orientation, 'iPhone');
  local resolvedKeyboardLayout = if keyboardLayout == null then buildContext.getKeyboardLayout(context) else keyboardLayout;
  local spec = compact14.getSpec(context, resolvedKeyboardLayout);
  compactKeyboardBuilder.build(context, resolvedKeyboardLayout, spec, compact14);

{
  new(theme, orientation):
    build(theme, orientation),
}
