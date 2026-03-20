// Build the ordered function-button object set from the shared specs, sizes, and background styles.
local specs = import 'specs.libsonnet';

{
  createFunctionButton(key, bg, actionMap, swipeUpMap, swipeDownMap, repeatMap, swipeUp, swipeDown, size, isUpper=true, isNotification=true):: {
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
  },

  createNotification(key, notificationType, bg, actionMap, swipeUpMap, swipeDownMap, repeatMap):: {
    notificationType: notificationType,
    backgroundStyle: bg,
    foregroundStyle: key + 'ButtonPreeditForegroundStyle',
    [if std.objectHas(actionMap, key) && actionMap[key] != {} then 'action']: actionMap[key].action,
    [if std.objectHas(swipeUpMap, key) && swipeUpMap[key] != {} then 'swipeUpAction']: swipeUpMap[key].action,
    [if std.objectHas(swipeDownMap, key) && swipeDownMap[key] != {} then 'swipeDownAction']: swipeDownMap[key].action,
    [if std.objectHas(repeatMap, key) && repeatMap[key] != {} then 'repeatAction']: repeatMap[key].action,
  },

  build(Settings, keyboardType, bg, swipeUp, swipeDown, size, orderedKeys)::
    std.foldl(
      function(acc, key)
        acc + {
          [key + 'Button']: $.createFunctionButton(
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
          [key + 'ButtonPreeditNotification']: $.createNotification(
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
    ),
}
