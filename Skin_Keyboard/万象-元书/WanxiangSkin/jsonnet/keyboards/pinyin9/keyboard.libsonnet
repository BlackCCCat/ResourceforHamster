// 暴露拼音 9 键入口，衔接共享上下文、布局解析和构建逻辑。
local Settings = import '../../Custom.libsonnet';
local buildContext = import '../../build/context.libsonnet';
local pinyin9Builder = import './builder.libsonnet';
local pinyin9Layout = import './layout.libsonnet';

local build(theme, orientation, layoutRoot=null) =
  local context = buildContext.new(Settings, theme, orientation, 'iPhone');
  local baseLayoutRoot = if layoutRoot == null then buildContext.getKeyboardLayout(context) else layoutRoot;
  local resolvedLayoutRoot = baseLayoutRoot + pinyin9Layout.getKeyboardLayout(theme);
  pinyin9Builder.build(context, resolvedLayoutRoot);

{
  new(theme, orientation):
    build(theme, orientation),
}
