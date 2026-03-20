// Expose the 14-key compact pinyin keyboard through a thin entry module backed by a shared compact builder.
local Settings = import '../Custom.libsonnet';
local keyboardRuntime = import '../lib/core/keyboardRuntime.libsonnet';
local compact14 = import '../lib/specs/compact14.libsonnet';
local compactKeyboardBuilder = import '../lib/builders/compactKeyboardBuilder.libsonnet';
local p26 = import 'pinyin_26.jsonnet';

local build(theme, orientation, keyboardLayout=null) =
  local context = keyboardRuntime.new(Settings, theme, orientation, 'iPhone');
  local resolvedKeyboardLayout = if keyboardLayout == null then keyboardRuntime.getKeyboardLayout(context) else keyboardLayout;
  local spec = compact14.getSpec(context, resolvedKeyboardLayout);
  local p26Layout = p26.keyboard(theme, orientation, resolvedKeyboardLayout);
  compactKeyboardBuilder.build(context, resolvedKeyboardLayout, spec, p26Layout);

{
  new(theme, orientation):
    build(theme, orientation),
}
