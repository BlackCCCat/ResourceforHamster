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
  [if std.objectHas(root, id + 'ButtonUppercasedStateForegroundStyle') then 'uppercasedStateForegroundStyle']: std.filter(
    function(x) x != null,
    [
      id + 'ButtonUppercasedStateForegroundStyle',
      if std.objectHas(swipe_up, id) then id + 'ButtonUpForegroundStyle' else null,
      if std.objectHas(swipe_down, id) then id + 'ButtonDownForegroundStyle' else null,
    ]
  ),
  [if std.objectHas(root, id + 'ButtonUppercasedStateForegroundStyle') then 'capsLockedStateForegroundStyle']: self.uppercasedStateForegroundStyle,
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
  hintSymbolsStyles.getStyle(theme, hintSymbolsData.pinyin_14) +
  functions.makeFunctionButtons(orientation, keyboardLayout, 'pinyin') +
  {
    preeditHeight: others[if orientation == 'portrait' then '竖屏' else '横屏']['preedit高度'],
    toolbarHeight: others[if orientation == 'portrait' then '竖屏' else '横屏']['toolbar高度'],
    keyboardHeight: others[if orientation == 'portrait' then '竖屏' else '横屏']['keyboard高度'],

    // Styles copied from pinyin_26.jsonnet
    alphabeticBackgroundStyle: {
      buttonStyleType: 'geometry',
      insets: if orientation == 'portrait' then Settings.button_insets.portrait else Settings.button_insets.landscape,
      normalColor: color[theme]['字母键背景颜色-普通'],
      highlightColor: color[theme]['字母键背景颜色-高亮'],
      cornerRadius: Settings.cornerRadius,
      normalLowerEdgeColor: color[theme]['底边缘颜色-普通'],
      highlightLowerEdgeColor: color[theme]['底边缘颜色-高亮'],
    },
    systemButtonBackgroundStyle: {
      buttonStyleType: 'geometry',
      insets: if orientation == 'portrait' then Settings.button_insets.portrait else Settings.button_insets.landscape,
      normalColor: color[theme]['功能键背景颜色-普通'],
      highlightColor: color[theme]['功能键背景颜色-高亮'],
      cornerRadius: Settings.cornerRadius,
      normalLowerEdgeColor: color[theme]['底边缘颜色-普通'],
      highlightLowerEdgeColor: color[theme]['底边缘颜色-高亮'],
    },
    enterButtonBlueBackgroundStyle: {
      buttonStyleType: 'geometry',
      normalColor: color[theme]['enter键背景(蓝色)'],
      highlightColor: color[theme]['功能键背景颜色-高亮'],
      cornerRadius: Settings.cornerRadius,
      normalLowerEdgeColor: color[theme]['底边缘颜色-普通'],
      highlightLowerEdgeColor: color[theme]['底边缘颜色-高亮'],
      insets: if orientation == 'portrait' then Settings.button_insets.portrait else Settings.button_insets.landscape,
    },
    ButtonScaleAnimation: animation['26键按键动画'],
    alphabeticHintBackgroundStyle: {
      buttonStyleType: 'geometry',
      normalColor: color[theme]['气泡背景颜色'],
      highlightColor: color[theme]['气泡高亮颜色'],
      cornerRadius: Settings.cornerRadius,
      shadowColor: color[theme]['长按背景阴影颜色'],
      shadowOffset: { x: 0, y: 5 },
    },
    alphabeticHintSymbolsBackgroundStyle: hintSymbolsStyles['长按背景样式'],
    alphabeticHintSymbolsSelectedStyle: hintSymbolsStyles['长按选中背景样式'],

  } + {
    [k.id + 'Button']: createButton(k.id, k.action, { width: { percentage: k.width } }, if std.objectHas(k, 'bounds') && k.bounds != null then k.bounds else {}, $, theme)
    for k in keys
  } + {
    [k.id + 'ButtonForegroundStyle']: utils.makeTextStyle(
      k.label,
      if std.length(k.label) > 2 then fontSize['按键前景文字大小'] - 4 else fontSize['按键前景文字大小'],
      color[theme]['按键前景颜色'],
      color[theme]['按键前景颜色'],
      { x: 0.5, y: 0.5 }
    )
    for k in keys
  } + {
    [k.id + 'ButtonUppercasedStateForegroundStyle']: utils.makeTextStyle(
      std.asciiUpper(k.label),
      if std.length(k.label) > 2 then fontSize['按键前景文字大小'] - 4 else fontSize['按键前景文字大小'],
      color[theme]['按键前景颜色'],
      color[theme]['按键前景颜色'],
      { x: 0.5, y: 0.5 }
    )
    for k in keys
  } + {

    shiftButton: p26Layout.shiftButton + {
       size: { width: if isPortrait then keyboardLayout['竖屏按键尺寸']['shift键size'].width else keyboardLayout['横屏按键尺寸']['14键横屏shift键size'].width },
    },
    shiftButtonForegroundStyle: p26Layout.shiftButtonForegroundStyle,
    shiftButtonUppercasedForegroundStyle: p26Layout.shiftButtonUppercasedForegroundStyle,
    shiftButtonCapsLockedForegroundStyle: p26Layout.shiftButtonCapsLockedForegroundStyle,

    backspaceButton: p26Layout.backspaceButton + {
       size: { width: if isPortrait then keyboardLayout['竖屏按键尺寸']['backspace键size'].width else keyboardLayout['横屏按键尺寸']['14键横屏backspace键size'].width },
    },
    backspaceButtonForegroundStyle: p26Layout.backspaceButtonForegroundStyle,

    '123Button': p26Layout['123Button'] + {
       size: { width: if isPortrait then keyboardLayout['竖屏按键尺寸']['123键size'].width else keyboardLayout['横屏按键尺寸']['123键size'].width },
    },
    '123ButtonSymbolsDataSource': p26Layout['123ButtonSymbolsDataSource'],

    spaceButton: p26Layout.spaceButton + {
        size: { width: if isPortrait then keyboardLayout['竖屏按键尺寸']['space键size'].width else keyboardLayout['横屏按键尺寸']['space键size'].width },
    },
    spaceButtonForegroundStyle: p26Layout.spaceButtonForegroundStyle,
    spaceButtonPreeditNotification: p26Layout.spaceButtonPreeditNotification,
    spaceButtonForegroundStyle1: p26Layout.spaceButtonForegroundStyle1,

    spaceLeftButton: p26Layout.spaceLeftButton + {
       size: { width: if isPortrait then keyboardLayout['竖屏按键尺寸']['spaceLeft键size'].width else keyboardLayout['横屏按键尺寸']['spaceLeft键size'].width }, 
    },
    spaceLeftButtonForegroundStyle: p26Layout.spaceLeftButtonForegroundStyle,
    spaceLeftButtonForegroundStyle2: p26Layout.spaceLeftButtonForegroundStyle2,
    spaceRightButtonForegroundStyle: p26Layout.spaceRightButtonForegroundStyle,
    spaceRightButtonForegroundStyle2: p26Layout.spaceRightButtonForegroundStyle2,

    spaceFirstButtonPreeditNotification: p26Layout.spaceFirstButtonPreeditNotification,
    spaceFirstButtonForegroundStyle: p26Layout.spaceFirstButtonForegroundStyle,
    spaceSecondButtonPreeditNotification: p26Layout.spaceSecondButtonPreeditNotification,
    spaceSecondButtonForegroundStyle: p26Layout.spaceSecondButtonForegroundStyle,
    spaceSecondButtonForegroundStyle1: p26Layout.spaceSecondButtonForegroundStyle1,

    spaceRightButtonPreeditNotification: p26Layout.spaceRightButtonPreeditNotification,
    spaceRightButtonPreeditForegroundStyle: p26Layout.spaceRightButtonPreeditForegroundStyle,

    cn2enButton: p26Layout.cn2enButton,
    cn2enButtonForegroundStyle: p26Layout.cn2enButtonForegroundStyle,
    cn2enButtonHintSymbolsStyle: super['cn2enButtonHintSymbolsStyle'] + {
      symbolStyles: [
        'cn2enButtonHintSymbolsStyleOf0',
        'cn2enButtonHintSymbolsStyleOf4',
        'cn2enButtonHintSymbolsStyleOf6',
        'cn2enButtonHintSymbolsStyleOf8',
      ],
    },
    cn2enButtonHintSymbolsStyleOf0: p26Layout.cn2enButtonHintSymbolsStyleOf0,
    cn2enButtonHintSymbolsStyleOf4: p26Layout.cn2enButtonHintSymbolsStyleOf4,
    cn2enButtonHintSymbolsStyleOf6: p26Layout.cn2enButtonHintSymbolsStyleOf6,
    cn2enButtonHintSymbolsStyleOf8: p26Layout.cn2enButtonHintSymbolsStyleOf8,
    
    enterButton: p26Layout.enterButton + {
        size: { width: if isPortrait then keyboardLayout['竖屏按键尺寸']['enter键size'].width else keyboardLayout['横屏按键尺寸']['enter键size'].width },
    },
    enterButtonForegroundStyle0: p26Layout.enterButtonForegroundStyle0,
    enterButtonForegroundStyle6: p26Layout.enterButtonForegroundStyle6,
    enterButtonForegroundStyle7: p26Layout.enterButtonForegroundStyle7,
    enterButtonForegroundStyle14: p26Layout.enterButtonForegroundStyle14,
    enterButtonForegroundStyle9: p26Layout.enterButtonForegroundStyle9,
    spaceFirstButton: p26Layout.spaceFirstButton,
    spaceSecondButton: p26Layout.spaceSecondButton,

    


  } + {
    [k.id + 'ButtonHintStyle']: {
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: k.id + 'ButtonHintForegroundStyle',
      swipeUpForegroundStyle: k.id + 'ButtonSwipeUpHintForegroundStyle',
      swipeDownForegroundStyle: k.id + 'ButtonSwipeDownHintForegroundStyle',
    }
    for k in keys
  };


{
  new(theme, orientation):
    keyboard(theme, orientation, keyboardLayout_.getKeyboardLayout(theme))
}
