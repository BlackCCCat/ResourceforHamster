// 组装手机端功能行按钮，汇合规格、样式和滑动数据。
local deviceType = 'iPhone';
local Settings = import '../../Custom.libsonnet';
local swipeData = import '../data/swipeData.libsonnet';
local specs = import 'specs.libsonnet';

// 上下和下划的数据
local swipe_up = if std.objectHas(swipeData.genSwipeData(deviceType), 'swipe_up') then swipeData.genSwipeData(deviceType).swipe_up else {};
local swipe_down = if std.objectHas(swipeData.genSwipeData(deviceType), 'swipe_down') then swipeData.genSwipeData(deviceType).swipe_down else {};
local resolvedOrderedKeys = specs.resolveOrderedKeys(Settings);

local createFunctionButton(key, bg, actionMap, swipeUpMap, swipeDownMap, repeatMap, swipeUp, swipeDown, size, isUpper=true, isNotification=true) = {
  size: size,
  backgroundStyle: bg,
  foregroundStyle: std.filter(
    function(x) x != null,
    [
      key + 'ButtonForegroundStyle',
      if std.objectHas(swipeUp, key) then key + 'ButtonUpForegroundStyle' else null,
      if std.objectHas(swipeDown, key) then key + 'ButtonDownForegroundStyle' else null,
    ]
  ),
  [if isUpper then 'uppercasedStateForegroundStyle']: std.filter(
    function(x) x != null,
    [
      key + 'ButtonUppercasedStateForegroundStyle',
      if std.objectHas(swipeUp, key) then key + 'ButtonUpForegroundStyle' else null,
      if std.objectHas(swipeDown, key) then key + 'ButtonDownForegroundStyle' else null,
    ]
  ),
  [if isUpper then 'capsLockedStateForegroundStyle']: self.uppercasedStateForegroundStyle,
  hintStyle: key + 'ButtonHintStyle',
  [if std.objectHas(actionMap, key) && actionMap[key] != {} then 'action']: actionMap[key].action,
  [if std.objectHas(swipeUpMap, key) && swipeUpMap[key] != {} then 'swipeUpAction']: swipeUpMap[key].action,
  [if std.objectHas(swipeDownMap, key) && swipeDownMap[key] != {} then 'swipeDownAction']: swipeDownMap[key].action,
  [if std.objectHas(repeatMap, key) && repeatMap[key] != {} then 'repeatAction']: repeatMap[key].action,
  [if std.length(key) == 1 then 'uppercasedStateAction']: {
    character: std.asciiUpper(key),
  },
  [if std.objectHas(swipeUp, key) then 'swipeUpAction']: swipeUp[key].action,
  [if std.objectHas(swipeDown, key) then 'swipeDownAction']: swipeDown[key].action,
  animation: ['ButtonScaleAnimation'],
  [if isNotification then 'notification']: [key + 'ButtonPreeditNotification'],
};

local createNotification(key, notificationType, bg, actionMap, swipeUpMap, swipeDownMap, repeatMap) = {
  notificationType: notificationType,
  backgroundStyle: bg,
  foregroundStyle: key + 'ButtonPreeditForegroundStyle',
  [if std.objectHas(actionMap, key) && actionMap[key] != {} then 'action']: actionMap[key].action,
  [if std.objectHas(swipeUpMap, key) && swipeUpMap[key] != {} then 'swipeUpAction']: swipeUpMap[key].action,
  [if std.objectHas(swipeDownMap, key) && swipeDownMap[key] != {} then 'swipeDownAction']: swipeDownMap[key].action,
  [if std.objectHas(repeatMap, key) && repeatMap[key] != {} then 'repeatAction']: repeatMap[key].action,
};

local buildFunctionButtons(Settings, keyboardType, bg, swipeUp, swipeDown, size, orderedKeys) =
  std.foldl(
    function(acc, key)
      acc + {
        [key + 'Button']: createFunctionButton(
          key,
          bg,
          specs.actionMap,
          specs.swipeUpMap,
          specs.swipeDownMap,
          specs.repeatMap,
          swipeUp,
          swipeDown,
          size,
          true,
          specs.notificationEnabled(Settings, keyboardType, key)
        ),
        [key + 'ButtonPreeditNotification']: createNotification(
          key,
          'preeditChanged',
          bg,
          specs.notificationActionMap,
          specs.notificationSwipeUpMap,
          specs.notificationSwipeDownMap,
          specs.notificationRepeatMap
        ),
      },
    orderedKeys,
    {}
  );

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
  // 功能行宽度由 layout 层按当前按钮数量动态分配，按钮对象不再写死 width。
  buildFunctionButtons(Settings, keyboard_type, getbg, swipe_up, swipe_down, normalizedSize, resolvedOrderedKeys);

{
  makeFunctionButtons(orientation, keyboardLayout, keyboard_type): makeFunctionButtons(orientation, keyboardLayout, keyboard_type),
}
