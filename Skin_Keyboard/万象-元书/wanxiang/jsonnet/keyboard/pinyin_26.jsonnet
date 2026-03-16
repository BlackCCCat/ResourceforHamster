// Expose the 26-key pinyin keyboard through a thin entry module backed by shared context and builder helpers.
local Settings = import '../Custom.libsonnet';
local keyboardRuntime = import '../lib/core/keyboardRuntime.libsonnet';
local keyboard26Builder = import '../lib/builders/keyboard26Builder.libsonnet';
local letter26KeysSpecs = import '../lib/keys/letter26KeysSpecs.libsonnet';
local swipeData = import '../lib/data/swipeData.libsonnet';

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
    letter26KeysSpecs.letters
  ),
  keyboard(theme, orientation, keyboardLayout):
    build(theme, orientation, keyboardLayout),
  new(theme, orientation):
    build(theme, orientation),
}
