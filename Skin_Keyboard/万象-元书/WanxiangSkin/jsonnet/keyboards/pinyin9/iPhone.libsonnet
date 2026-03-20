// 暴露拼音 9 键入口，衔接共享上下文、布局解析和构建逻辑。
local Settings = import '../../Custom.libsonnet';
local keyboardRuntime = import '../../keyboards/common/layoutAssembly/keyboardLayoutAssembly.libsonnet';
local pinyin9Builder = import 'builder.libsonnet';
local pinyin9Layout = import 'layout.libsonnet';
local p26 = import '../pinyin26/iPhone.libsonnet';

local build(theme, orientation, layoutRoot=null) =
  local context = keyboardRuntime.new(Settings, theme, orientation, 'iPhone');
  local baseLayoutRoot = if layoutRoot == null then keyboardRuntime.getKeyboardLayout(context) else layoutRoot;
  local resolvedLayoutRoot = baseLayoutRoot + pinyin9Layout.getKeyboardLayout(theme);
  local p26Layout = p26.keyboard(theme, orientation, resolvedLayoutRoot);
  pinyin9Builder.build(context, resolvedLayoutRoot, p26Layout);

{
  new(theme, orientation):
    build(theme, orientation),
}
