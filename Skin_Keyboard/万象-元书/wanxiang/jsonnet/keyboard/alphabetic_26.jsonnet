// Expose the 26-key alphabetic keyboard through a thin entry module backed by shared context and builder helpers.
local Settings = import '../Custom.libsonnet';
local keyboardRuntime = import '../lib/core/keyboardRuntime.libsonnet';
local keyboard26AlphabeticBuilder = import '../lib/builders/keyboard26AlphabeticBuilder.libsonnet';
local swipeData = import '../lib/data/swipeDataEn.libsonnet';

local defaultContext = keyboardRuntime.new(Settings, 'light', 'portrait', 'iPhone');
local defaultSwipeDataRoot = swipeData.genSwipeenData(defaultContext.deviceType);
local defaultSwipeUp = if std.objectHas(defaultSwipeDataRoot, 'swipe_up') then defaultSwipeDataRoot.swipe_up else {};
local defaultSwipeDown = if std.objectHas(defaultSwipeDataRoot, 'swipe_down') then defaultSwipeDataRoot.swipe_down else {};

local build(theme, orientation, keyboardLayout=null) =
  local context = keyboardRuntime.new(Settings, theme, orientation, 'iPhone');
  local resolvedKeyboardLayout = if keyboardLayout == null then keyboardRuntime.getKeyboardLayout(context) else keyboardLayout;
  keyboard26AlphabeticBuilder.build(context, resolvedKeyboardLayout);

{
  createButton: keyboard26AlphabeticBuilder.createButtonFactory(
    defaultContext,
    defaultSwipeUp,
    defaultSwipeDown
  ),
  keyboard(theme, orientation, keyboardLayout):
    build(theme, orientation, keyboardLayout),
  new(theme, orientation):
    build(theme, orientation),
}
