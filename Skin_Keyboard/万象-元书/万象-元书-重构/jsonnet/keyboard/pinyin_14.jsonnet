local deviceType = 'iPhone';

local Settings = import '../custom/Custom.libsonnet';
// Import layout with functions row or without
local keyboardLayout_ = if Settings.with_functions_row[deviceType] then import '../lib/keyboardLayout.libsonnet' else import '../lib/keyboardLayoutWithoutFuncRow.libsonnet';
local p26 = import 'pinyin_26.jsonnet';

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
local pinyinCompact = import '../lib/pinyinCompact.libsonnet';
local keyBuilders = import '../lib/keyBuilders.libsonnet';
local hintSymbolsStyles = import '../lib/hintSymbolsStyles.libsonnet';
local swipeStyles = import '../lib/swipeStyle.libsonnet';
local slideForeground = import '../lib/slideForeground.libsonnet';
local functions = import '../lib/functionButton.libsonnet';

local swipe_up = if std.objectHas(swipeData.genSwipeData(deviceType), 'swipe_up_14') then swipeData.genSwipeData(deviceType).swipe_up_14 else {};
local swipe_down = if std.objectHas(swipeData.genSwipeData(deviceType), 'swipe_down_14') then swipeData.genSwipeData(deviceType).swipe_down_14 else {};

local createButton(id, actionKey, size, bounds, root, theme) = {
  size: size,
  [if bounds != {} then 'bounds']: bounds,
  backgroundStyle: 'alphabeticBackgroundStyle',
  foregroundStyle: std.filter(
    function(x) x != null,
    [
      id + 'ButtonForegroundStyle',
      if Settings.show_swipe then
        if std.objectHas(swipe_up, id) then id + 'ButtonUpForegroundStyle' else null
      else null,
      if Settings.show_swipe then
        if std.objectHas(swipe_down, id) then id + 'ButtonDownForegroundStyle' else null
      else null,
    ]
  ),
  [if std.length(actionKey) == 1 then 'uppercasedStateForegroundStyle']: std.filter(
    function(x) x != null,
    [
      id + 'ButtonUppercasedStateForegroundStyle',
      if Settings.show_swipe then
        if std.objectHas(swipe_up, id) then id + 'ButtonUpForegroundStyle' else null
      else null,
      if Settings.show_swipe then
        if std.objectHas(swipe_down, id) then id + 'ButtonDownForegroundStyle' else null
      else null,
    ]
  ),
  [if std.length(actionKey) == 1 then 'capsLockedStateForegroundStyle']: self.uppercasedStateForegroundStyle,
  hintStyle: id + 'ButtonHintStyle',
  action: {
    character: if Settings.is_wanxiang_14 then std.asciiUpper(actionKey) else actionKey,
  },
  [if std.length(actionKey) == 1 then 'uppercasedStateAction']: {
    character: std.asciiUpper(actionKey),
  },
  [if std.objectHas(swipe_up, id) then 'swipeUpAction']: swipe_up[id].action,
  [if std.objectHas(swipe_down, id) then 'swipeDownAction']: swipe_down[id].action,
  [if std.objectHas(root, id + 'ButtonHintSymbolsStyle') then 'hintSymbolsStyle']: id + 'ButtonHintSymbolsStyle',
  animation: [
    'ButtonScaleAnimation',
  ],
};


local keyboard(theme, orientation, keyboardLayout) =
  local isPortrait = orientation == 'portrait';
  local isCapital = Settings.is_letter_capital;
  local hintStyles = hintSymbolsStyles.getStyle(theme, hintSymbolsData.pinyin_14);
  local sizes = {
    shift: if isPortrait then keyboardLayout['竖屏按键尺寸']['shift键size'].width else keyboardLayout['横屏按键尺寸']['14键横屏shift键size'].width,
    backspace: if isPortrait then keyboardLayout['竖屏按键尺寸']['backspace键size'].width else keyboardLayout['横屏按键尺寸']['14键横屏backspace键size'].width,
    oneTwoThree: if isPortrait then keyboardLayout['竖屏按键尺寸']['123键size'].width else keyboardLayout['横屏按键尺寸']['123键size'].width,
    space: if isPortrait then keyboardLayout['竖屏按键尺寸']['space键size'].width else keyboardLayout['横屏按键尺寸']['space键size'].width,
    spaceLeft: if isPortrait then keyboardLayout['竖屏按键尺寸']['spaceLeft键size'].width else keyboardLayout['横屏按键尺寸']['spaceLeft键size'].width,
    enter: if isPortrait then keyboardLayout['竖屏按键尺寸']['enter键size'].width else keyboardLayout['横屏按键尺寸']['enter键size'].width,
  };
  local p26Layout = p26.keyboard(theme, orientation, keyboardLayout);
  local keys = [
    // Row 1 (5 keys)
    // Row 1 (5 keys)
    { id: 'qw', action: 'q', label: if isCapital then 'Q W' else 'q w', width: if isPortrait then keyboardLayout['竖屏按键尺寸']['14键Row1Size'].width.percentage else keyboardLayout['横屏按键尺寸']['14键横屏Row1Size'].width.percentage },
    { id: 'er', action: 'e', label: if isCapital then 'E R' else 'e r', width: if isPortrait then keyboardLayout['竖屏按键尺寸']['14键Row1Size'].width.percentage else keyboardLayout['横屏按键尺寸']['14键横屏Row1Size'].width.percentage },
    { id: 'ty', action: 't', label: if isCapital then 'T Y' else 't y', width: if isPortrait then keyboardLayout['竖屏按键尺寸']['14键Row1Size'].width.percentage else keyboardLayout['横屏按键尺寸']['14键横屏Row1Size'].width.percentage },
    { id: 'ui', action: 'u', label: if isCapital then 'U I' else 'u i', width: if isPortrait then keyboardLayout['竖屏按键尺寸']['14键Row1Size'].width.percentage else keyboardLayout['横屏按键尺寸']['14键横屏Row1Size'].width.percentage },
    { id: 'op', action: 'o', label: if isCapital then 'O P' else 'o p', width: if isPortrait then keyboardLayout['竖屏按键尺寸']['14键Row1Size'].width.percentage else keyboardLayout['横屏按键尺寸']['14键横屏Row1Size'].width.percentage },
    // Row 2
    { id: 'as', action: 'a', label: if isCapital then 'A S' else 'a s', width: if isPortrait then keyboardLayout['竖屏按键尺寸']['14键As键size和bounds'].size.width.percentage else keyboardLayout['横屏按键尺寸']['14键横屏As键size和bounds'].size.width.percentage },
    { id: 'df', action: 'd', label: if isCapital then 'D F' else 'd f', width: if isPortrait then keyboardLayout['竖屏按键尺寸']['14键Row2Size'].width.percentage else keyboardLayout['横屏按键尺寸']['14键横屏Row1Size'].width.percentage },
    { id: 'gh', action: 'g', label: if isCapital then 'G H' else 'g h', width: if isPortrait then keyboardLayout['竖屏按键尺寸']['14键Row2Size'].width.percentage else keyboardLayout['横屏按键尺寸']['14键横屏Row1Size'].width.percentage },
    { id: 'jk', action: 'j', label: if isCapital then 'J K' else 'j k', width: if isPortrait then keyboardLayout['竖屏按键尺寸']['14键Row2Size'].width.percentage else keyboardLayout['横屏按键尺寸']['14键横屏Row1Size'].width.percentage },
    { id: 'l', action: 'l', label: if isCapital then 'L' else 'l', width: if isPortrait then keyboardLayout['竖屏按键尺寸']['14键L键size和bounds'].size.width.percentage else keyboardLayout['横屏按键尺寸']['14键横屏L键size和bounds'].size.width.percentage },
    // Row 3 (4 keys)
    { id: 'zx', action: 'z', label: if isCapital then 'Z X' else 'z x', width: if isPortrait then keyboardLayout['竖屏按键尺寸']['14键Row3Size'].width.percentage else keyboardLayout['横屏按键尺寸']['14键横屏Row1Size'].width.percentage }, // Assuming 0.33 for landscape
    { id: 'cv', action: 'c', label: if isCapital then 'C V' else 'c v', width: if isPortrait then keyboardLayout['竖屏按键尺寸']['14键Row3Size'].width.percentage else keyboardLayout['横屏按键尺寸']['14键横屏Row1Size'].width.percentage },
    { id: 'bn', action: 'b', label: if isCapital then 'B N' else 'b n', width: if isPortrait then keyboardLayout['竖屏按键尺寸']['14键Row3Size'].width.percentage else keyboardLayout['横屏按键尺寸']['14键横屏Row1Size'].width.percentage },
    { id: 'm', action: 'm', label: if isCapital then 'M' else 'm', width: if isPortrait then keyboardLayout['竖屏按键尺寸']['14键Row3Size'].width.percentage else keyboardLayout['横屏按键尺寸']['14键横屏Row1Size'].width.percentage },
  ];

  keyboardLayout[if orientation == 'portrait' then '竖屏中文14键' else '横屏中文14键'] +
  swipeStyles.getStyle('cn', theme, swipe_up, swipe_down) +
  toolbar.getToolBar(theme) +
  utils.genPinyinStyles(fontSize, color, theme, center) +
  utils.genFuncKeyStyles(fontSize, color, theme, center) +
  slideForeground.slideForeground(theme) +
  hintStyles +
  functions.makeFunctionButtons(orientation, keyboardLayout, 'pinyin') +
  keyboardBaseStyles.baseStyles(theme, orientation, Settings, color, animation, hintSymbolsStyles) +
  {
    preeditHeight: others[if orientation == 'portrait' then '竖屏' else '横屏']['preedit高度'],
    toolbarHeight: others[if orientation == 'portrait' then '竖屏' else '横屏']['toolbar高度'],
    keyboardHeight: others[if orientation == 'portrait' then '竖屏' else '横屏']['keyboard高度'],
  } +
  pinyinCompact.compactButtons(keys, createButton, hintStyles, theme) +
  pinyinCompact.compactForegroundStyles(keys, fontSize, color, theme) +
  pinyinCompact.commonFromP26(p26Layout, sizes, hintStyles) +
  keyBuilders.hintStyles([k.id for k in keys]);


{
  new(theme, orientation):
    keyboard(theme, orientation, keyboardLayout_.getKeyboardLayout(theme))
}
