// 暴露 14 键拼音入口，复用 pinyinGrouped 共享构建流程。
local Settings = import '../../../Custom.libsonnet';
local buildContext = import '../../../build/context.libsonnet';
local groupedKeyboardBuilder = import '../base/builder.libsonnet';
local pinyin14Data = import './data.libsonnet';

local build(theme, orientation, keyboardLayout=null) =
  local context = buildContext.new(Settings, theme, orientation, 'iPhone');
  local resolvedKeyboardLayout = if keyboardLayout == null then buildContext.getKeyboardLayout(context) else keyboardLayout;
  local spec = pinyin14Data.getSpec(context, resolvedKeyboardLayout);
  groupedKeyboardBuilder.build(context, resolvedKeyboardLayout, spec, pinyin14Data);

{
  new(theme, orientation):
    build(theme, orientation),
}
