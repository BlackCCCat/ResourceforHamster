local swipeData = import '../lib/swipeData.libsonnet';

// 上下和下划的数据
local swipe_up = if std.objectHas(swipeData, 'swipe_up') then swipeData.swipe_up else {};
local swipe_down = if std.objectHas(swipeData, 'swipe_down') then swipeData.swipe_down else {};

local createFunctionButton(key, bg, action_map, swipe_up_map, swipe_down_map, repeat_map, size, isUpper=true, is_notification=true) = {
  size: size,
  backgroundStyle: bg,
  foregroundStyle: std.filter(  // 这样写避免了没有的上下划前景变成null
    function(x) x != null,
    [
      key + 'ButtonForegroundStyle',
      if std.objectHas(swipe_up, key) then key + 'ButtonUpForegroundStyle' else null,
      if std.objectHas(swipe_down, key) then key + 'ButtonDownForegroundStyle' else null,
    ]
  ),
  [if isUpper then 'uppercasedStateForegroundStyle']: std.filter(
    function(x) x != null,
    [
      key + 'ButtonUppercasedStateForegroundStyle',
      if std.objectHas(swipe_up, key) then key + 'ButtonUpForegroundStyle' else null,
      if std.objectHas(swipe_down, key) then key + 'ButtonDownForegroundStyle' else null,
    ]
  ),
  [if isUpper then 'capsLockedStateForegroundStyle']: self.uppercasedStateForegroundStyle,  // 同uppercaseStateForegroundStyle
  hintStyle: key + 'ButtonHintStyle',
  [if std.objectHas(action_map, key) && action_map[key] != {} then 'action']: action_map[key].action,
  [if std.objectHas(swipe_up_map, key) && swipe_up_map[key] != {} then 'swipeUpAction']: swipe_up_map[key].action,
  [if std.objectHas(swipe_down_map, key) && swipe_down_map[key] != {} then 'swipeDownAction']: swipe_down_map[key].action,
  [if std.objectHas(repeat_map, key) && repeat_map[key] != {} then 'repeatAction']: repeat_map[key].action,
  [if std.length(key) == 1 then 'uppercasedStateAction']: {
    character: std.asciiUpper(key),
  },
  [if std.objectHas(swipe_up, key) then 'swipeUpAction']: swipe_up[key].action,
  [if std.objectHas(swipe_down, key) then 'swipeDownAction']: swipe_down[key].action,
  // 动画
  animation: [
    'ButtonScaleAnimation',
  ],
  // notification 只有 key 在 letters 里时才生成
  [ if is_notification then 'notification']: [
    key + 'ButtonPreeditNotification',
  ],
};

local createNotification(key, no_type, bg, no_action_map, no_swipe_up_map, no_swipe_down_map, no_repeat_map) = {
      notificationType: no_type,
      backgroundStyle: bg,
      // 下面的前景样式重写以覆盖utils中生成的前景
      foregroundStyle: key + 'ButtonPreeditForegroundStyle',
      [if std.objectHas(no_action_map, key) && no_action_map[key] != {} then 'action']: no_action_map[key].action,
      [if std.objectHas(no_swipe_up_map, key) && no_swipe_up_map[key] != {} then 'swipeUpAction']: no_swipe_up_map[key].action,
      [if std.objectHas(no_swipe_down_map, key) && no_swipe_down_map[key] != {} then 'swipeDownAction']: no_swipe_down_map[key].action,
      [if std.objectHas(no_repeat_map, key) && no_repeat_map[key] != {} then 'repeatAction']: no_repeat_map[key].action,
};

// action映射
local action_map = {
    left: { action: 'moveCursorBackward' }, 
    head: { action: { shortcut: '#行首' }}, 
    select: { action: { shortcut: '#selectText' }}, 
    cut: { action: { shortcut: '#cut' }}, 
    copy: { action: { shortcut: '#copy' }}, 
    paste: { action: { shortcut: '#paste' }}, 
    tail: { action: {shortcut: '#行尾'}}, 
    right: { action:  'moveCursorForward' }, 
};

// 上划action映射
local swipe_up_map = {
    left: {},
    head: {},
    select:{},
    cut: {},
    copy: {},
    paste: {},
    tail: {},
    right: {},
};

// 下划action映射
local swipe_down_map = {
    left: {},
    head: {},
    select:{},
    cut: {},
    copy: {},
    paste: {},
    tail: {},
    right: {},
};

// 长按action映射
local repeat_map = {
    left: { action:  'moveCursorBackward' }, 
    head: {},
    select:{},
    cut: {},
    copy: {},
    paste: {},
    tail: {},
    right: { action:  'moveCursorForward' }, 
};


// 通知action映射
local no_action_map = {
    left: { action: { sendKeys: 'Up' }}, 
    head: { action: { shortcut: '#rimeNextPage' }}, 
    select: { action: { character: '7' }}, 
    cut: { action: { character: '8' }}, 
    copy: { action: { character: '9' }}, 
    paste: { action: { character: '0' }}, 
    tail: { action: { sendKeys: 'backslash' }}, 
    right: { action: { sendKeys: 'Down' }}, 
};

// 通知上划action映射
local no_swipe_up_map = {
    left: { action: { character: '['  }}, 
    head: { action: { shortcut: '#rimePreviousPage' }}, 
    select: { action: { sendKeys: 'control+1' }}, 
    cut: { action: { sendKeys: 'control+2' }}, 
    copy: { action: {sendKeys: 'control+3' }}, 
    paste: { action: { sendKeys: 'control+4' }}, 
    right: { action: { character: ']' }}, 
};

// 通知下划action映射
local no_swipe_down_map = {
    left: { action: {  sendKeys: 'Left' }}, 
    head: { action: { shortcut: '#rimeNextPage' }}, 
    select: { action: { sendKeys: 'control+1' }}, 
    cut: { action: { sendKeys: 'control+2' }}, 
    copy: { action: {sendKeys: 'control+3'}}, 
    paste: { action: {sendKeys: 'control+4'}}, 
    right: { action: { sendKeys: 'Right' }}, 
};

// 通知长按action映射
local no_repeat_map = {
    left: { action: {  sendKeys: 'Up' }}, 
    head: {},
    select:{},
    cut: {},
    copy: {},
    paste: {},
    tail: {},
    right: { action: { sendKeys: 'Down' }}, 
};

// key, action_map, swipe_up_map, swipe_down_map, repeat_map, size, bounds, root, isUpper=true, is_notification=true
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
      {}  // 必要时提供一个合理的默认尺寸
    ;
  local getbg = 
    if keyboard_type == 'numeric' then 'functionBackgroundStyle' else 'alphabeticBackgroundStyle'
    ;
    {
    leftButton: createFunctionButton(
    'left',
    getbg,
    action_map,
    swipe_up_map,
    swipe_down_map,
    repeat_map,
    getSafeSize,
    true,
    true
    ),
    leftButtonPreeditNotification: createNotification(
        'left', 
        'preeditChanged', // no_type
        getbg,
        no_action_map, no_swipe_up_map, no_swipe_down_map, no_repeat_map,
    ),
    headButton: createFunctionButton(
    'head',
    getbg,
    action_map,
    swipe_up_map,
    swipe_down_map,
    repeat_map,
    getSafeSize,
    true,
    if keyboard_type =='numeric' then false else true
    ),
    headButtonPreeditNotification: createNotification(
        'head', 
        'preeditChanged', // no_type
        getbg,
        no_action_map, no_swipe_up_map, no_swipe_down_map, no_repeat_map,
    ),
    selectButton: createFunctionButton(
    'select',
    getbg,
    action_map,
    swipe_up_map,
    swipe_down_map,
    repeat_map,
    getSafeSize,
    true,
    if keyboard_type == 'alphabetic' || keyboard_type =='numeric' then false else true
    ),
    selectButtonPreeditNotification: createNotification(
        'select', 
        'preeditChanged', // no_type
        getbg,
        no_action_map, no_swipe_up_map, no_swipe_down_map, no_repeat_map,
    ),
    cutButton: createFunctionButton(
    'cut',
    getbg,
    action_map,
    swipe_up_map,
    swipe_down_map,
    repeat_map,
    getSafeSize,
    true,
    if keyboard_type == 'alphabetic'  || keyboard_type =='numeric' then false else true
    ),
    cutButtonPreeditNotification: createNotification(
        'cut', 
        'preeditChanged', // no_type
        getbg,
        no_action_map, no_swipe_up_map, no_swipe_down_map, no_repeat_map,
    ),
    copyButton: createFunctionButton(
    'copy',
    getbg,
    action_map,
    swipe_up_map,
    swipe_down_map,
    repeat_map,
    getSafeSize,
    true,
    if keyboard_type == 'alphabetic'  || keyboard_type =='numeric' then false else true
    ),
    copyButtonPreeditNotification: createNotification(
        'copy', 
        'preeditChanged', // no_type
        getbg,
        no_action_map, no_swipe_up_map, no_swipe_down_map, no_repeat_map,
    ),
    pasteButton: createFunctionButton(
    'paste',
    getbg,
    action_map,
    swipe_up_map,
    swipe_down_map,
    repeat_map,
    getSafeSize,
    true,
    if keyboard_type == 'alphabetic' || keyboard_type =='numeric' then false else true
    ),
    pasteButtonPreeditNotification: createNotification(
        'paste', 
        'preeditChanged', // no_type
        getbg,
        no_action_map, no_swipe_up_map, no_swipe_down_map, no_repeat_map,
    ),
    tailButton: createFunctionButton(
    'tail',
    getbg,
    action_map,
    swipe_up_map,
    swipe_down_map,
    repeat_map,
    getSafeSize,
    true,
    if keyboard_type == 'alphabetic' || keyboard_type =='numeric' then false else true
    ),
    tailButtonPreeditNotification: createNotification(
        'tail', 
        'preeditChanged', // no_type
        getbg,
        no_action_map, no_swipe_up_map, no_swipe_down_map, no_repeat_map,
    ),
    rightButton: createFunctionButton(
    'right',
    getbg,
    action_map,
    swipe_up_map,
    swipe_down_map,
    repeat_map,
    getSafeSize,
    true,
    true
    ),
    rightButtonPreeditNotification: createNotification(
        'right', 
        'preeditChanged', // no_type
        getbg,
        no_action_map, no_swipe_up_map, no_swipe_down_map, no_repeat_map,
    ),
};

{
    makeFunctionButtons(orientation, keyboardLayout, keyboard_type): makeFunctionButtons(orientation, keyboardLayout, keyboard_type)
}