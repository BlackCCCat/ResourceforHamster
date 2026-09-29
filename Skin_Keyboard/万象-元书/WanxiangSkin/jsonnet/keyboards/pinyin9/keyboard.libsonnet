// 暴露拼音 9 键入口，衔接共享上下文、布局解析和构建逻辑。
local Settings = import '../../Custom.libsonnet';
local buildContext = import '../../build/context.libsonnet';
local pinyin9Builder = import './builder.libsonnet';
local pinyin9Layout = import './layout.libsonnet';

local build(theme, orientation, layoutRoot=null, layoutOverride=null) =
  local context = buildContext.new(buildContext.withLayout(Settings, layoutOverride), theme, orientation, 'iPhone');
  local baseLayoutRoot = if layoutRoot == null then buildContext.getKeyboardLayout(context) else layoutRoot;
  local resolvedLayoutRoot = baseLayoutRoot + pinyin9Layout.getKeyboardLayout(theme);
  pinyin9Builder.build(context, resolvedLayoutRoot);

{
  new(theme, orientation, layoutOverride=null):
    build(theme, orientation, null, layoutOverride),
}
