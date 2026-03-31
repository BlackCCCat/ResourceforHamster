// 暴露拼音 26 键入口，衔接共享上下文与构建模块。
local Settings = import '../../Custom.libsonnet';
local keyboardRuntime = import '../../keyboards/common/layoutAssembly/keyboardLayoutAssembly.libsonnet';
local keyboard26Builder = import 'builder.libsonnet';
local keyboard26Layout = import '../common/keyboard26/layout.libsonnet';
local letter26KeysSpecs = import '../common/keyboard26/letters.libsonnet';
local swipeData = import '../../shared/data/swipeData.libsonnet';

local defaultContext = keyboardRuntime.new(Settings, 'light', 'portrait', 'iPhone');
local defaultSwipeDataRoot = swipeData.genSwipeData(defaultContext.deviceType);
local defaultSwipeUp = if std.objectHas(defaultSwipeDataRoot, 'swipe_up') then defaultSwipeDataRoot.swipe_up else {};
local defaultSwipeDown = if std.objectHas(defaultSwipeDataRoot, 'swipe_down') then defaultSwipeDataRoot.swipe_down else {};

local build(theme, orientation, keyboardLayout=null) =
  local context = keyboardRuntime.new(Settings, theme, orientation, 'iPhone');
  local resolvedKeyboardLayout = if keyboardLayout == null then keyboardRuntime.getKeyboardLayout(context) else keyboardLayout;
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
