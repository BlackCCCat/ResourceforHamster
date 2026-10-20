// 封装中文 26 键滑动辅助的模式解析、长按重排与通知生成。
{
  resolveSwipeAssistMode(context)::
    if context.deviceType == 'iPhone' && context.Settings.keyboard_layout == 26 then
      if std.member(['up', 'down', 'all'], context.Settings.swipe_assist_mode) then context.Settings.swipe_assist_mode else 'none'
    else
      'none',

  assistedDirectionEnabled(mode, direction)::
    (direction == 'up' && std.member(['up', 'all'], mode)) ||
    (direction == 'down' && std.member(['down', 'all'], mode)),

  applySwipeAssistToMap(baseMap, letters, mode):: {
    [key]:
      if mode != 'none' && std.member(letters, key) then
        baseMap[key] { action: { character: std.asciiUpper(key) } }
      else
        baseMap[key]
    for key in std.objectFields(baseMap)
  },

  extractHintAssistParts(baseList, key):: {
    lower:
      std.filter(
        function(item) std.objectHas(item.action, 'character') && item.action.character == key,
        baseList
      )[0],
    upper:
      std.filter(
        function(item) std.objectHas(item.action, 'character') && item.action.character == std.asciiUpper(key),
        baseList
      )[0],
    kp:
      local matches = std.filter(
        function(item) std.objectHas(item.action, 'sendKeys') && std.substr(item.action.sendKeys, 0, 3) == 'KP_',
        baseList
      );
      if std.length(matches) > 0 then matches[0] else null,
  },

  buildHintAssistItem(sourceMap, key)::
    if std.objectHas(sourceMap, key) && std.objectHas(sourceMap[key], 'label') then
      {
        action: sourceMap[key].action,
        label: sourceMap[key].label,
      } + if std.objectHas(sourceMap[key], 'fontSize') then { fontSize: sourceMap[key].fontSize } else {}
    else
      null,

  orderHintAssistList(key, parts, upItem, downItem, mode)::
    local row1Left = ['q', 'w', 'e', 'r', 't'];
    local row1Right = ['y', 'u', 'i', 'o', 'p'];
    local row2Left = ['a', 's', 'd', 'f'];
    local row2CenterLeft = ['g'];
    local row2Right = ['j', 'k', 'l'];
    local row3Left = ['z', 'x', 'c'];
    local row3CenterLeft = ['v'];
    local row3Right = ['n', 'm'];
    local withItems(items) = std.filter(function(item) item != null, items);
    if std.member(row1Left, key) then
      withItems([parts.lower, parts.upper, parts.kp, upItem, downItem])
    else if std.member(row1Right, key) then
      withItems([downItem, upItem, parts.kp, parts.upper, parts.lower])
    else if std.member(row2Left, key) || std.member(row3Left, key) then
      withItems([parts.lower, parts.upper, upItem, downItem])
    else if std.member(row2CenterLeft, key) || std.member(row3CenterLeft, key) then
      withItems([parts.lower, upItem, downItem, parts.upper])
    else if key == 'h' || key == 'b' || std.member(row2Right, key) || std.member(row3Right, key) then
      withItems([downItem, upItem, parts.upper, parts.lower])
    else
      withItems([parts.lower, parts.upper, parts.kp, upItem, downItem]),

  selectedHintAssistIndex(key, parts, mode)::
    local row1Left = ['q', 'w', 'e', 'r', 't'];
    local row1Right = ['y', 'u', 'i', 'o', 'p'];
    local row2Left = ['a', 's', 'd', 'f'];
    local row2CenterLeft = ['g'];
    local row2Right = ['h', 'j', 'k', 'l'];
    local row3Left = ['z', 'x', 'c'];
    local row3CenterLeft = ['v'];
    local row3Right = ['b', 'n', 'm'];
    local hasKp = parts.kp != null;
    if mode == 'all' then
      if std.member(row1Left, key) || std.member(row2Left, key) || std.member(row3Left, key) then
        if hasKp then 3 else 2
      else if std.member(row2CenterLeft, key) || std.member(row3CenterLeft, key) then
        1
      else if std.member(row1Right, key) || std.member(row2Right, key) || std.member(row3Right, key) then
        1
      else
        1
    else if mode == 'up' then
      if std.member(row1Left, key) || std.member(row2Left, key) || std.member(row3Left, key) then
        if hasKp then 3 else 2
      else if std.member(row2CenterLeft, key) || std.member(row3CenterLeft, key) then
        1
      else
        0
    else if mode == 'down' then
      if std.member(row1Left, key) || std.member(row2Left, key) || std.member(row3Left, key) then
        if hasKp then 3 else 2
      else if std.member(row2CenterLeft, key) || std.member(row3CenterLeft, key) then
        1
      else
        0
    else
      1,

  buildAssistNotificationForegroundNames(settings, swipeUp, swipeDown, key)::
    std.filter(
      function(x) x != null,
      [
        key + 'ButtonForegroundStyle',
        if settings.show_swipe && std.objectHas(swipeUp, key) then key + 'ButtonUpForegroundStyle' else null,
        if settings.show_swipe && std.objectHas(swipeDown, key) then key + 'ButtonDownForegroundStyle' else null,
      ]
    ),

  createSwipeAssistNotification(key, bounds, settings, swipeUp, swipeDown, mode):: {
    notificationType: 'preeditChanged',
    [if bounds != {} then 'bounds']: bounds,
    backgroundStyle: 'alphabeticBackgroundStyle',
    foregroundStyle: $.buildAssistNotificationForegroundNames(settings, swipeUp, swipeDown, key),
    hintStyle: key + 'ButtonSwipeAssistHintStyle',
    [if $.assistedDirectionEnabled(mode, 'up') then 'swipeUpAction']: { character: std.asciiUpper(key) },
    [if $.assistedDirectionEnabled(mode, 'down') then 'swipeDownAction']: { character: std.asciiUpper(key) },
  },

  swipeAssistNotifications(letterSpecs, settings, swipeUp, swipeDown, mode):: {
    [spec.key + 'ButtonSwipeAssistNotification']: $.createSwipeAssistNotification(
      spec.key,
      if std.objectHas(spec, 'bounds') then spec.bounds else {},
      settings,
      swipeUp,
      swipeDown,
      mode
    )
    for spec in letterSpecs
  },

  extendHintDataForSwipeAssist(baseHintData, sourceMaps, letters, mode):: {
    [key]:
      if mode != 'none' && std.member(letters, key) then
        local parts = $.extractHintAssistParts(baseHintData[key].list, key);
        local upItem = if std.member(['up', 'all'], mode) then $.buildHintAssistItem(sourceMaps[0], key) else null;
        local downItem =
          if mode == 'down' then
            $.buildHintAssistItem(sourceMaps[0], key)
          else if mode == 'all' then
            $.buildHintAssistItem(sourceMaps[1], key)
          else
            null;
        baseHintData[key] {
          selectedIndex: $.selectedHintAssistIndex(key, parts, mode),
          list: $.orderHintAssistList(key, parts, upItem, downItem, mode),
        }
      else
        baseHintData[key]
    for key in std.objectFields(baseHintData)
  },

}
