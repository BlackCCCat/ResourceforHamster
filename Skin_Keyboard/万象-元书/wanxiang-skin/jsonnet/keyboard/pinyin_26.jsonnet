// Expose the 26-key pinyin keyboard through a thin entry module backed by shared context and builder helpers.
local Settings = import '../Custom.libsonnet';
local contextLib = import '../lib/core/context.libsonnet';
local layoutResolver = import '../lib/core/layoutResolver.libsonnet';
local keyboard26Builder = import '../lib/builders/keyboard26Builder.libsonnet';
local letterKeySpecs = import '../lib/keys/letterKeySpecs.libsonnet';
local swipeData = import '../lib/data/swipeData.libsonnet';

local defaultContext = contextLib.new(Settings, 'light', 'portrait', 'iPhone');
local defaultSwipeDataRoot = swipeData.genSwipeData(defaultContext.deviceType);
local defaultSwipeUp = if std.objectHas(defaultSwipeDataRoot, 'swipe_up') then defaultSwipeDataRoot.swipe_up else {};
local defaultSwipeDown = if std.objectHas(defaultSwipeDataRoot, 'swipe_down') then defaultSwipeDataRoot.swipe_down else {};

local build(theme, orientation, keyboardLayout=null) =
  local context = contextLib.new(Settings, theme, orientation, 'iPhone');
  local resolvedKeyboardLayout = if keyboardLayout == null then layoutResolver.getKeyboardLayout(context) else keyboardLayout;
  keyboard26Builder.build(context, resolvedKeyboardLayout);

{
  createButton: keyboard26Builder.createButtonFactory(
    defaultContext,
    defaultSwipeUp,
    defaultSwipeDown,
    letterKeySpecs.letters
  ),
  keyboard(theme, orientation, keyboardLayout):
    build(theme, orientation, keyboardLayout),
  new(theme, orientation):
    build(theme, orientation),
}
