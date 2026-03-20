// Expose the pinyin 9-key keyboard through a thin entry module backed by shared context, layout resolution, and builder logic.
local Settings = import '../Custom.libsonnet';
local keyboardRuntime = import '../lib/core/keyboardRuntime.libsonnet';
local pinyin9Builder = import '../lib/builders/pinyin9Builder.libsonnet';
local p26 = import 'pinyin_26.jsonnet';

local build(theme, orientation, layoutRoot=null) =
  local context = keyboardRuntime.new(Settings, theme, orientation, 'iPhone');
  local resolvedLayoutRoot = if layoutRoot == null then keyboardRuntime.getKeyboardLayout(context) else layoutRoot;
  local p26Layout = p26.keyboard(theme, orientation, resolvedLayoutRoot);
  pinyin9Builder.build(context, resolvedLayoutRoot, p26Layout);

{
  new(theme, orientation):
    build(theme, orientation),
}
