// Define the function-button action and notification specs so the entry module can build them without parallel hard-coded blocks.
{
  defaultOrderedKeys: ['left', 'head', 'select', 'cut', 'copy', 'paste', 'tail', 'right'],

  resolveOrderedKeys(Settings)::
    local config =
      if std.objectHas(Settings, 'function_button_config') && std.type(Settings.function_button_config) == 'object' then
        Settings.function_button_config
      else
        {};
    local configured =
      if std.objectHas(config, 'order') && std.type(config.order) == 'array' then
        [
          key
          for key in config.order
          if std.type(key) == 'string' && std.member(self.defaultOrderedKeys, key)
        ]
      else
        [];
    if std.length(configured) > 0 then configured else self.defaultOrderedKeys,

  actionMap: {
    left: { action: 'moveCursorBackward' },
    head: { action: { shortcut: '#行首' } },
    select: { action: { shortcut: '#selectText' } },
    cut: { action: { shortcut: '#cut' } },
    copy: { action: { shortcut: '#copy' } },
    paste: { action: { shortcut: '#paste' } },
    tail: { action: { shortcut: '#行尾' } },
    right: { action: 'moveCursorForward' },
  },

  swipeUpMap: {
    left: {},
    head: {},
    select: {},
    cut: {},
    copy: {},
    paste: {},
    tail: {},
    right: {},
  },

  swipeDownMap: {
    left: {},
    head: {},
    select: {},
    cut: {},
    copy: {},
    paste: {},
    tail: {},
    right: {},
  },

  repeatMap: {
    left: { action: 'moveCursorBackward' },
    head: {},
    select: {},
    cut: {},
    copy: {},
    paste: {},
    tail: {},
    right: { action: 'moveCursorForward' },
  },

  notificationActionMap: {
    left: { action: { sendKeys: 'Up' } },
    head: { action: { shortcut: '#rimeNextPage' } },
    select: { action: { character: '7' } },
    cut: { action: { character: '8' } },
    copy: { action: { character: '9' } },
    paste: { action: { character: '0' } },
    tail: { action: { sendKeys: 'backslash' } },
    right: { action: { sendKeys: 'Down' } },
  },

  notificationSwipeUpMap: {
    left: { action: { character: '[' } },
    head: { action: { shortcut: '#rimePreviousPage' } },
    select: { action: { sendKeys: 'control+1' } },
    cut: { action: { sendKeys: 'control+2' } },
    copy: { action: { sendKeys: 'control+3' } },
    paste: { action: { sendKeys: 'control+4' } },
    tail: { action: { character: '\\' } },
    right: { action: { character: ']' } },
  },

  notificationSwipeDownMap: {
    left: { action: { sendKeys: 'Left' } },
    head: { action: { shortcut: '#rimeNextPage' } },
    select: { action: { sendKeys: 'control+1' } },
    cut: { action: { sendKeys: 'control+2' } },
    copy: { action: { sendKeys: 'control+3' } },
    paste: { action: { sendKeys: 'control+4' } },
    tail: { action: { character: '\\' } },
    right: { action: { sendKeys: 'Right' } },
  },

  notificationRepeatMap: {
    left: { action: { sendKeys: 'Up' } },
    head: {},
    select: {},
    cut: {},
    copy: {},
    paste: {},
    tail: {},
    right: { action: { sendKeys: 'Down' } },
  },

  notificationEnabled(Settings, keyboardType, key)::
    local config =
      if std.objectHas(Settings, 'function_button_config') && std.type(Settings.function_button_config) == 'object' then
        Settings.function_button_config
      else
        {};
    if std.member(['select', 'cut', 'copy', 'paste', 'tail'], key) && std.member(['alphabetic', 'numeric'], keyboardType) then
      false
    else
      if std.objectHas(config, 'enable_notification') then config.enable_notification else true,
}
