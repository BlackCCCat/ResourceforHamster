// 定义 26 键共享按钮工厂，统一前景样式与滑动动作接线。
{
  create(context, swipeUp, swipeDown, options):: (
    local buildForegroundNames(key, isUpper) =
      std.filter(
        function(x) x != null,
        [
          key + if isUpper then 'ButtonUppercasedStateForegroundStyle' else 'ButtonForegroundStyle',
          if context.Settings.show_swipe && std.objectHas(swipeUp, key) then key + 'ButtonUpForegroundStyle' else null,
          if context.Settings.show_swipe && std.objectHas(swipeDown, key) then key + 'ButtonDownForegroundStyle' else null,
        ]
      );
    function(key, size, bounds, root, isUpper=true)
      local notification =
        if std.objectHas(options, 'notificationFactory') then options.notificationFactory(key) else null;
      {
        size: size,
        [if bounds != {} then 'bounds']: bounds,
        backgroundStyle: 'alphabeticBackgroundStyle',
        foregroundStyle: buildForegroundNames(key, false),
        [if isUpper then 'uppercasedStateForegroundStyle']: buildForegroundNames(key, true),
        [if isUpper then 'capsLockedStateForegroundStyle']: self.uppercasedStateForegroundStyle,
        hintStyle: key + 'ButtonHintStyle',
        action: options.actionFactory(key),
        [if std.length(key) == 1 then 'uppercasedStateAction']: options.uppercasedActionFactory(key),
        [if std.objectHas(swipeUp, key) then 'swipeUpAction']: swipeUp[key].action,
        [if std.objectHas(swipeDown, key) then 'swipeDownAction']: swipeDown[key].action,
        [if std.objectHas(root, key + 'ButtonHintSymbolsStyle') then 'hintSymbolsStyle']: key + 'ButtonHintSymbolsStyle',
        animation: [
          'ButtonScaleAnimation',
        ],
        [if notification != null then 'notification']: notification,
      }
  ),
}
