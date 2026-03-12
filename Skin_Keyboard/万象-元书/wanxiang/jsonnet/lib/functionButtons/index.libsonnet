// Expose the function-button entry wrapper on top of the split functionButtons modules.
local deviceType = 'iPhone';
local Settings = import '../../Custom.libsonnet';
local swipeData = import '../data/swipeData.libsonnet';
local functionButtonBuilder = import 'builder.libsonnet';

// 上下和下划的数据
local swipe_up = if std.objectHas(swipeData.genSwipeData(deviceType), 'swipe_up') then swipeData.genSwipeData(deviceType).swipe_up else {};
local swipe_down = if std.objectHas(swipeData.genSwipeData(deviceType), 'swipe_down') then swipeData.genSwipeData(deviceType).swipe_down else {};
local specs = import 'specs.libsonnet';
local resolvedOrderedKeys = specs.resolveOrderedKeys(Settings);

local makeFunctionButtons(orientation, keyboardLayout, keyboard_type) =
  local getSafeSize =
    if std.objectHas(keyboardLayout, '竖屏按键尺寸') &&
       std.objectHas(keyboardLayout['竖屏按键尺寸'], '自定义键size') &&
       std.objectHas(keyboardLayout, '横屏按键尺寸') &&
       std.objectHas(keyboardLayout['横屏按键尺寸'], '自定义键size') then
      if orientation == 'portrait' then
        keyboardLayout['竖屏按键尺寸']['自定义键size']
      else
        keyboardLayout['横屏按键尺寸']['自定义键size']
    else
      {}
  ;
  local normalizedSize =
    if std.objectHas(getSafeSize, 'height') then { height: getSafeSize.height } else {};
  local getbg =
    if keyboard_type == 'numeric' then 'functionBackgroundStyle' else 'alphabeticBackgroundStyle'
  ;
  // 功能行宽度改由 layout 层按当前按钮数量动态分配，这里不再给按钮对象写死 width。
  functionButtonBuilder.build(Settings, keyboard_type, getbg, swipe_up, swipe_down, normalizedSize, resolvedOrderedKeys);

{
  makeFunctionButtons(orientation, keyboardLayout, keyboard_type): makeFunctionButtons(orientation, keyboardLayout, keyboard_type),
}
