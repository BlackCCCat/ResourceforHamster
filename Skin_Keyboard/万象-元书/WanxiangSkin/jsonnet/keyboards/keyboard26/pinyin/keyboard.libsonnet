// 暴露拼音 26 键入口，衔接共享上下文与构建模块。
local Settings = import '../../../Custom.libsonnet';
local buildContext = import '../../../build/context.libsonnet';
local letter26KeysSpecs = import '../base/letters.libsonnet';
local keyboard26Builder = import './builder.libsonnet';
local swipeData = import './data.libsonnet';

local defaultContext = buildContext.new(Settings, 'light', 'portrait', 'iPhone');
local defaultSwipeDataRoot = swipeData.genSwipeData(defaultContext.deviceType);
local defaultSwipeUp = if std.objectHas(defaultSwipeDataRoot, 'swipe_up') then defaultSwipeDataRoot.swipe_up else {};
local defaultSwipeDown = if std.objectHas(defaultSwipeDataRoot, 'swipe_down') then defaultSwipeDataRoot.swipe_down else {};

local build(theme, orientation, keyboardLayout=null) =
  local context = buildContext.new(Settings, theme, orientation, 'iPhone');
  local resolvedKeyboardLayout = if keyboardLayout == null then buildContext.getKeyboardLayout(context) else keyboardLayout;
  keyboard26Builder.build(context, resolvedKeyboardLayout);

{
  createButton: keyboard26Builder.createButtonFactory(
    defaultContext,
    defaultSwipeUp,
    defaultSwipeDown,
    letter26KeysSpecs.getLetters(Settings.keyboard_layout == 27)
  ),
  keyboard(theme, orientation, keyboardLayout):
    build(theme, orientation, keyboardLayout),
  new(theme, orientation):
    build(theme, orientation),
}
