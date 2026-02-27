local deviceType = 'iPhone';

local Settings = import '../Custom.libsonnet';
local keyboardLayout_ = if Settings.with_functions_row[deviceType] then import '../lib/keyboardLayout.libsonnet' else import '../lib/keyboardLayoutNoFuncRow.libsonnet';



local animation = import '../lib/animation.libsonnet';
local center = import '../lib/center.libsonnet';
local color = import '../lib/color.libsonnet';
local fontSize = import '../lib/fontSize.libsonnet';
local hintSymbolsData = import '../lib/hintSymbolsData.libsonnet';
local others = import '../lib/others.libsonnet';
local swipeData = import '../lib/swipeData.libsonnet';
local toolbar = import '../lib/toolbar.libsonnet';
local utils = import '../lib/utils.libsonnet';
local keyboardBaseStyles = import '../lib/keyboardBaseStyles.libsonnet';
local pinyinSystemKeys = import '../lib/pinyinSystemKeys.libsonnet';
local keyBuilders = import '../lib/keyBuilders.libsonnet';
local letterKeySpecs = import '../lib/letterKeySpecs.libsonnet';

local hintSymbolsStyles = import '../lib/hintSymbolsStyles.libsonnet';
local swipeStyles = import '../lib/swipeStyle.libsonnet';

// 123Button的划动前景
local slideForeground = import '../lib/slideForeground.libsonnet';

// 功能按键引入
local functions = import '../lib/functionButton.libsonnet';

// 上下和下划的数据
local swipe_up = if std.objectHas(swipeData.genSwipeData(deviceType), 'swipe_up') then swipeData.genSwipeData(deviceType).swipe_up else {};
local swipe_down = if std.objectHas(swipeData.genSwipeData(deviceType), 'swipe_down') then swipeData.genSwipeData(deviceType).swipe_down else {};

local letters = letterKeySpecs.letters;

local createButton(key, size, bounds, root, isUpper=true) = {
  size: size,
  [if bounds != {} then 'bounds']: bounds,
  backgroundStyle: 'alphabeticBackgroundStyle',
  foregroundStyle: std.filter(  // 这样写避免了没有的上下划前景变成null
    function(x) x != null,
    [
      key + 'ButtonForegroundStyle',
      if Settings.show_swipe then
        if std.objectHas(swipe_up, key) then key + 'ButtonUpForegroundStyle' else null
      else null,
      if Settings.show_swipe then
        if std.objectHas(swipe_down, key) then key + 'ButtonDownForegroundStyle' else null
      else null,
    ]
  ),
  [if isUpper then 'uppercasedStateForegroundStyle']: std.filter(
    function(x) x != null,
    [
      key + 'ButtonUppercasedStateForegroundStyle',
      if Settings.show_swipe then
        if std.objectHas(swipe_up, key) then key + 'ButtonUpForegroundStyle' else null
      else null,
      if Settings.show_swipe then
        if std.objectHas(swipe_down, key) then key + 'ButtonDownForegroundStyle' else null
      else null,
    ]
  ),
  [if isUpper then 'capsLockedStateForegroundStyle']: self.uppercasedStateForegroundStyle,  // 同uppercaseStateForegroundStyle
  hintStyle: key + 'ButtonHintStyle',
  action: {
    character: key,
  },
  [if std.length(key) == 1 then 'uppercasedStateAction']: {
    character: std.asciiUpper(key),
  },
  [if std.objectHas(swipe_up, key) then 'swipeUpAction']: swipe_up[key].action,
  [if std.objectHas(swipe_down, key) then 'swipeDownAction']: swipe_down[key].action,
  [if std.objectHas(root, key + 'ButtonHintSymbolsStyle') then 'hintSymbolsStyle']: key + 'ButtonHintSymbolsStyle',
  // 动画
  animation: [
    'ButtonScaleAnimation',
  ],
  // notification 只有 key 在 letters 里时才生成
  [if std.member(letters, key) then 'notification']: [
    key + 'ButtonBackslashNotification',
  ],
};

// 专门生成 <key>ButtonBackslashNotification
local createBackslashNotification(key, bounds={}) = {
  notificationType: 'keyboardAction',
  [if bounds != {} then 'bounds']: bounds,
  backgroundStyle: 'alphabeticBackgroundStyle',
  foregroundStyle: key + 'ButtonBackslashForegroundStyle',
  notificationKeyboardAction: { sendKeys: 'backslash' },
};


// 26个按键前景批量生成


local keyboard(theme, orientation, keyboardLayout) =
  local letterSpecs = letterKeySpecs.get26KeySpecs(orientation, keyboardLayout);
  local letterKeys = [spec.key for spec in letterSpecs];
  local hintStyles = hintSymbolsStyles.getStyle(theme, hintSymbolsData.pinyin);
  keyboardLayout[if orientation == 'portrait' then '竖屏中文26键' else '横屏中文26键'] +
  swipeStyles.getStyle('cn', theme, swipe_up, swipe_down) +
  hintStyles +
  toolbar.getToolBar(theme) +
  utils.genPinyinStyles(fontSize, color, theme, center) +
  utils.genFuncKeyStyles(fontSize, color, theme, center) +
  slideForeground.slideForeground(theme) +
  functions.makeFunctionButtons(orientation, keyboardLayout, 'pinyin') +
  keyboardBaseStyles.baseStyles(theme, orientation, Settings, color, animation, hintSymbolsStyles) +
  {
    preeditHeight: others[if orientation == 'portrait' then '竖屏' else '横屏']['preedit高度'],
    toolbarHeight: others[if orientation == 'portrait' then '竖屏' else '横屏']['toolbar高度'],
    keyboardHeight: others[if orientation == 'portrait' then '竖屏' else '横屏']['keyboard高度'],


  } +
  keyBuilders.letterButtons(letterSpecs, createButton, hintStyles) +
  keyBuilders.backslashNotifications(letterSpecs, createBackslashNotification) +
  keyBuilders.hintStyles(letterKeys) +
  pinyinSystemKeys.build(theme, orientation, keyboardLayout, Settings, color, fontSize, center, createButton, hintStyles);

{
  keyboard: keyboard,
  createButton: createButton,
  new(theme, orientation):
    keyboard(theme, orientation, keyboardLayout_.getKeyboardLayout(theme)),
}
