local LayoutType = import '../custom/Custom.libsonnet';
local keyboardLayout_ = if LayoutType.with_functions_row then import '../lib/keyboardLayout.libsonnet' else import '../lib/keyboardLayoutWithoutFuncRow.libsonnet';


local animation = import '../lib/animation.libsonnet';
local center = import '../lib/center.libsonnet';
local color = import '../lib/color.libsonnet';
local fontSize = import '../lib/fontSize.libsonnet';
local hintSymbolsData = import '../lib/hintSymbolsData.libsonnet';
local others = import '../lib/others.libsonnet';
local swipeData = import '../lib/swipeData-en.libsonnet';
local toolbar = import '../lib/toolbar-en.libsonnet';
local utils = import '../lib/utils.libsonnet';

local hintSymbolsStyles = import '../lib/hintSymbolsStyles.libsonnet';
local swipeStyles = import '../lib/swipeStyle.libsonnet';

// 123Button的划动前景
local slideForeground = import '../lib/slideForeground.libsonnet';

// 功能按键引入
local functions = import '../lib/functionButton.libsonnet';

// 上下和下划的数据
local swipe_up = if std.objectHas(swipeData, 'swipe_up') then swipeData.swipe_up else {};
local swipe_down = if std.objectHas(swipeData, 'swipe_down') then swipeData.swipe_down else {};

local createButton(key, size, bounds, root, isUpper=true) = {
  size: size,
  [if bounds != {} then 'bounds']: bounds,
  backgroundStyle: 'alphabeticBackgroundStyle',
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
  action: {
    [if std.objectHas(others, '英文键盘方案') then 'character' else 'symbol']: key,
  },
  [if std.length(key) == 1 then 'uppercasedStateAction']: {
    [if std.objectHas(others, '英文键盘方案') then 'character' else 'symbol']: std.asciiUpper(key),
  },
  [if std.objectHas(swipe_up, key) then 'swipeUpAction']: swipe_up[key].action,
  [if std.objectHas(swipe_down, key) then 'swipeDownAction']: swipe_down[key].action,
  [if std.objectHas(root, key + 'ButtonHintSymbolsStyle') then 'hintSymbolsStyle']: key + 'ButtonHintSymbolsStyle',
  // 动画
  animation: [
    'ButtonScaleAnimation',
  ],
};

local keyboard(theme, orientation, keyboardLayout) =
  keyboardLayout[if orientation == 'portrait' then '竖屏英文26键' else '横屏英文26键'] +
  swipeStyles.getStyle('en', theme, swipe_up, swipe_down) +
  hintSymbolsStyles.getStyle(theme, hintSymbolsData.alphabetic) +
  toolbar.getToolBar(theme) +
  utils.genAlphabeticStyles(fontSize, color, theme, center) +
  utils.genFuncKeyStyles(fontSize, color, theme, center) +
  slideForeground.slideForeground(theme) +
  functions.makeFunctionButtons(orientation, keyboardLayout, 'alphabetic') +
  {
    [if std.objectHas(others, '英文键盘方案') then 'rimeSchema']: others['英文键盘方案'],
    preeditHeight: others[if orientation == 'portrait' then '竖屏' else '横屏']['preedit高度'],
    toolbarHeight: others[if orientation == 'portrait' then '竖屏' else '横屏']['toolbar高度'],
    keyboardHeight: others[if orientation == 'portrait' then '竖屏' else '横屏']['keyboard高度'],


    qButton: createButton(
      'q',
      if orientation == 'portrait' then
        keyboardLayout['竖屏按键尺寸']['普通键size']
      else
        keyboardLayout['横屏按键尺寸']['普通键size'],
      {},
      $
    ),


    qButtonHintStyle: {
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: 'qButtonHintForegroundStyle',
      swipeUpForegroundStyle: 'qButtonSwipeUpHintForegroundStyle',
      swipeDownForegroundStyle: 'qButtonSwipeDownHintForegroundStyle',
    },

    wButton: createButton(
      'w',
      if orientation == 'portrait' then
        keyboardLayout['竖屏按键尺寸']['普通键size']
      else
        keyboardLayout['横屏按键尺寸']['普通键size'],
      {},
      $
    ),

    wButtonHintStyle: {
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: 'wButtonHintForegroundStyle',
      swipeUpForegroundStyle: 'wButtonSwipeUpHintForegroundStyle',
      swipeDownForegroundStyle: 'wButtonSwipeDownHintForegroundStyle',
    },
    eButton: createButton(
      'e',
      if orientation == 'portrait' then
        keyboardLayout['竖屏按键尺寸']['普通键size']
      else
        keyboardLayout['横屏按键尺寸']['普通键size'],
      {},
      $
    ),

    eButtonHintStyle: {
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: 'eButtonHintForegroundStyle',
      swipeUpForegroundStyle: 'eButtonSwipeUpHintForegroundStyle',
      swipeDownForegroundStyle: 'eButtonSwipeDownHintForegroundStyle',
    },

    rButton: createButton(
      'r',
      if orientation == 'portrait' then
        keyboardLayout['竖屏按键尺寸']['普通键size']
      else
        keyboardLayout['横屏按键尺寸']['普通键size'],
      {},
      $
    ),

    rButtonHintStyle: {
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: 'rButtonHintForegroundStyle',
      swipeUpForegroundStyle: 'rButtonSwipeUpHintForegroundStyle',
      swipeDownForegroundStyle: 'rButtonSwipeDownHintForegroundStyle',
    },

    tButton: createButton(
      't',
      if orientation == 'portrait' then
        keyboardLayout['竖屏按键尺寸']['普通键size']
      else
        keyboardLayout['横屏按键尺寸']['普通键size'],
      if orientation == 'portrait' then {}
      else
        keyboardLayout['横屏按键尺寸']['t键size和bounds'].bounds,
      $
    ),


    tButtonHintStyle: {
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: 'tButtonHintForegroundStyle',
      swipeUpForegroundStyle: 'tButtonSwipeUpHintForegroundStyle',
      swipeDownForegroundStyle: 'tButtonSwipeDownHintForegroundStyle',
    },

    yButton: createButton(
      'y',
      if orientation == 'portrait' then
        keyboardLayout['竖屏按键尺寸']['普通键size']
      else
        keyboardLayout['横屏按键尺寸']['y键size和bounds'].size,
      if orientation == 'portrait' then {}
      else
        keyboardLayout['横屏按键尺寸']['y键size和bounds'].bounds,
      $
    ),

    yButtonHintStyle: {
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: 'yButtonHintForegroundStyle',
      swipeUpForegroundStyle: 'yButtonSwipeUpHintForegroundStyle',
      swipeDownForegroundStyle: 'yButtonSwipeDownHintForegroundStyle',
    },

    uButton: createButton(
      'u',
      if orientation == 'portrait' then
        keyboardLayout['竖屏按键尺寸']['普通键size']
      else
        keyboardLayout['横屏按键尺寸']['普通键size'],
      {},
      $
    ),

    uButtonHintStyle: {
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: 'uButtonHintForegroundStyle',
      swipeUpForegroundStyle: 'uButtonSwipeUpHintForegroundStyle',
      swipeDownForegroundStyle: 'uButtonSwipeDownHintForegroundStyle',
    },

    iButton: createButton(
      'i',
      if orientation == 'portrait' then
        keyboardLayout['竖屏按键尺寸']['普通键size']
      else
        keyboardLayout['横屏按键尺寸']['普通键size'],
      {},
      $
    ),

    iButtonHintStyle: {
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: 'iButtonHintForegroundStyle',
      swipeUpForegroundStyle: 'iButtonSwipeUpHintForegroundStyle',
      swipeDownForegroundStyle: 'iButtonSwipeDownHintForegroundStyle',
    },


    oButton: createButton(
      'o',
      if orientation == 'portrait' then
        keyboardLayout['竖屏按键尺寸']['普通键size']
      else
        keyboardLayout['横屏按键尺寸']['普通键size'],
      {},
      $
    ),

    oButtonHintStyle: {
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: 'oButtonHintForegroundStyle',
      swipeUpForegroundStyle: 'oButtonSwipeUpHintForegroundStyle',
      swipeDownForegroundStyle: 'oButtonSwipeDownHintForegroundStyle',
    },

    pButton: createButton(
      'p',
      if orientation == 'portrait' then
        keyboardLayout['竖屏按键尺寸']['普通键size']
      else
        keyboardLayout['横屏按键尺寸']['普通键size'],
      {},
      $
    ),

    pButtonHintStyle: {
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: 'pButtonHintForegroundStyle',
      swipeUpForegroundStyle: 'pButtonSwipeUpHintForegroundStyle',
      swipeDownForegroundStyle: 'pButtonSwipeDownHintForegroundStyle',
    },

    aButton: createButton(
      'a',
      if orientation == 'portrait' then
        keyboardLayout['竖屏按键尺寸']['a键size和bounds'].size
      else
        keyboardLayout['横屏按键尺寸']['a键size和bounds'].size,
      if orientation == 'portrait' then
        keyboardLayout['竖屏按键尺寸']['a键size和bounds'].bounds
      else
        keyboardLayout['横屏按键尺寸']['a键size和bounds'].bounds,
      $
    ),

    aButtonHintStyle: {
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: 'aButtonHintForegroundStyle',
      swipeUpForegroundStyle: 'aButtonSwipeUpHintForegroundStyle',
      swipeDownForegroundStyle: 'aButtonSwipeDownHintForegroundStyle',
    },

    sButton: createButton(
      's',
      if orientation == 'portrait' then
        keyboardLayout['竖屏按键尺寸']['普通键size']
      else
        keyboardLayout['横屏按键尺寸']['普通键size'],
      {},
      $
    ),


    sButtonHintStyle: {
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: 'sButtonHintForegroundStyle',
      swipeUpForegroundStyle: 'sButtonSwipeUpHintForegroundStyle',
      swipeDownForegroundStyle: 'sButtonSwipeDownHintForegroundStyle',
    },
    dButton: createButton(
      'd',
      if orientation == 'portrait' then
        keyboardLayout['竖屏按键尺寸']['普通键size']
      else
        keyboardLayout['横屏按键尺寸']['普通键size'],
      {},
      $
    ),

    dButtonHintStyle: {
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: 'dButtonHintForegroundStyle',
      swipeUpForegroundStyle: 'dButtonSwipeUpHintForegroundStyle',
      swipeDownForegroundStyle: 'dButtonSwipeDownHintForegroundStyle',
    },

    fButton: createButton(
      'f',
      if orientation == 'portrait' then
        keyboardLayout['竖屏按键尺寸']['普通键size']
      else
        keyboardLayout['横屏按键尺寸']['普通键size'],
      {},
      $
    ),

    fButtonHintStyle: {
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: 'fButtonHintForegroundStyle',
      swipeUpForegroundStyle: 'fButtonSwipeUpHintForegroundStyle',
      swipeDownForegroundStyle: 'fButtonSwipeDownHintForegroundStyle',
    },

    gButton: createButton(
      'g',
      if orientation == 'portrait' then
        keyboardLayout['竖屏按键尺寸']['普通键size']
      else
        keyboardLayout['横屏按键尺寸']['普通键size'],
      {},
      $
    ),

    gButtonHintStyle: {
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: 'gButtonHintForegroundStyle',
      swipeUpForegroundStyle: 'gButtonSwipeUpHintForegroundStyle',
      swipeDownForegroundStyle: 'gButtonSwipeDownHintForegroundStyle',
    },

    hButton: createButton(
      'h',
      if orientation == 'portrait' then
        keyboardLayout['竖屏按键尺寸']['普通键size']
      else
        keyboardLayout['横屏按键尺寸']['普通键size'],
      {},
      $
    ),

    hButtonHintStyle: {
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: 'hButtonHintForegroundStyle',
      swipeUpForegroundStyle: 'hButtonSwipeUpHintForegroundStyle',
      swipeDownForegroundStyle: 'hButtonSwipeDownHintForegroundStyle',
    },

    jButton: createButton(
      'j',
      if orientation == 'portrait' then
        keyboardLayout['竖屏按键尺寸']['普通键size']
      else
        keyboardLayout['横屏按键尺寸']['普通键size'],
      {},
      $
    ),

    jButtonHintStyle: {
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: 'jButtonHintForegroundStyle',
      swipeUpForegroundStyle: 'jButtonSwipeUpHintForegroundStyle',
      swipeDownForegroundStyle: 'jButtonSwipeDownHintForegroundStyle',
    },

    kButton: createButton(
      'k',
      if orientation == 'portrait' then
        keyboardLayout['竖屏按键尺寸']['普通键size']
      else
        keyboardLayout['横屏按键尺寸']['普通键size'],
      {},
      $
    ),

    kButtonHintStyle: {
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: 'kButtonHintForegroundStyle',
      swipeUpForegroundStyle: 'kButtonSwipeUpHintForegroundStyle',
      swipeDownForegroundStyle: 'kButtonSwipeDownHintForegroundStyle',
    },

    lButton: createButton(
      'l',
      if orientation == 'portrait' then
        keyboardLayout['竖屏按键尺寸']['l键size和bounds'].size
      else
        keyboardLayout['横屏按键尺寸']['l键size和bounds'].size,
      if orientation == 'portrait' then
        keyboardLayout['竖屏按键尺寸']['l键size和bounds'].bounds
      else
        keyboardLayout['横屏按键尺寸']['l键size和bounds'].bounds,
      $
    ),

    lButtonHintStyle: {
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: 'lButtonHintForegroundStyle',
      swipeUpForegroundStyle: 'lButtonSwipeUpHintForegroundStyle',
      swipeDownForegroundStyle: 'lButtonSwipeDownHintForegroundStyle',
    },

    shiftButton: createButton(
      'shift',
      if orientation == 'portrait' then
        keyboardLayout['竖屏按键尺寸']['shift键size']
      else
        keyboardLayout['横屏按键尺寸']['shift键size'],
      {},
      $,
      false
    ) + {
      backgroundStyle: 'systemButtonBackgroundStyle',
      action: 'shift',
      uppercasedStateAction: 'shift',
      capsLockedStateForegroundStyle: 'shiftButtonCapsLockedForegroundStyle',
      uppercasedStateForegroundStyle: 'shiftButtonUppercasedForegroundStyle',
    },
    shiftButtonForegroundStyle: {
      buttonStyleType: 'systemImage',
      systemImageName: 'shift',
      normalColor: color[theme]['按键前景颜色'],
      highlightColor: color[theme]['按键前景颜色'],
      fontSize: fontSize['按键前景文字大小'],
      // center: { y: 0.53 },
    },
    shiftButtonUppercasedForegroundStyle: {
      buttonStyleType: 'systemImage',
      systemImageName: 'shift.fill',
      normalColor: color[theme]['按键前景颜色'],
      highlightColor: color[theme]['按键前景颜色'],
      fontSize: fontSize['按键前景文字大小'],
      // center: { y: 0.53 },
    },
    shiftButtonCapsLockedForegroundStyle: {
      buttonStyleType: 'systemImage',
      systemImageName: 'capslock.fill',
      normalColor: color[theme]['按键前景颜色'],
      highlightColor: color[theme]['按键前景颜色'],
      fontSize: fontSize['按键前景文字大小'],
      // center: { y: 0.53 },
    },
    zButton: createButton(
      'z',
      if orientation == 'portrait' then
        keyboardLayout['竖屏按键尺寸']['普通键size']
      else
        keyboardLayout['横屏按键尺寸']['普通键size'],
      {},
      $
    ),

    zButtonHintStyle: {
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: 'zButtonHintForegroundStyle',
      swipeUpForegroundStyle: 'zButtonSwipeUpHintForegroundStyle',
      swipeDownForegroundStyle: 'zButtonSwipeDownHintForegroundStyle',
    },

    xButton: createButton(
      'x',
      if orientation == 'portrait' then
        keyboardLayout['竖屏按键尺寸']['普通键size']
      else
        keyboardLayout['横屏按键尺寸']['普通键size'],
      {},
      $
    ),

    xButtonHintStyle: {
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: 'xButtonHintForegroundStyle',
      swipeUpForegroundStyle: 'xButtonSwipeUpHintForegroundStyle',
      swipeDownForegroundStyle: 'xButtonSwipeDownHintForegroundStyle',
    },

    cButton: createButton(
      'c',
      if orientation == 'portrait' then
        keyboardLayout['竖屏按键尺寸']['普通键size']
      else
        keyboardLayout['横屏按键尺寸']['普通键size'],
      {},
      $
    ),

    cButtonHintStyle: {
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: 'cButtonHintForegroundStyle',
      swipeUpForegroundStyle: 'cButtonSwipeUpHintForegroundStyle',
      swipeDownForegroundStyle: 'cButtonSwipeDownHintForegroundStyle',
    },

    vButton: createButton(
      'v',
      if orientation == 'portrait' then
        keyboardLayout['竖屏按键尺寸']['普通键size']
      else
        keyboardLayout['横屏按键尺寸']['普通键size'],
      {},
      $
    ),

    vButtonHintStyle: {
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: 'vButtonHintForegroundStyle',
      swipeUpForegroundStyle: 'vButtonSwipeUpHintForegroundStyle',
      swipeDownForegroundStyle: 'vButtonSwipeDownHintForegroundStyle',
    },

    bButton: createButton(
      'b',
      if orientation == 'portrait' then
        keyboardLayout['竖屏按键尺寸']['普通键size']
      else
        keyboardLayout['横屏按键尺寸']['普通键size'],
      {},
      $
    ),

    bButtonHintStyle: {
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: 'bButtonHintForegroundStyle',
      swipeUpForegroundStyle: 'bButtonSwipeUpHintForegroundStyle',
      swipeDownForegroundStyle: 'bButtonSwipeDownHintForegroundStyle',
    },

    nButton: createButton(
      'n',
      if orientation == 'portrait' then
        keyboardLayout['竖屏按键尺寸']['普通键size']
      else
        keyboardLayout['横屏按键尺寸']['普通键size'],
      {},
      $
    ),

    nButtonHintStyle: {
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: 'nButtonHintForegroundStyle',
      swipeUpForegroundStyle: 'nButtonSwipeUpHintForegroundStyle',
      swipeDownForegroundStyle: 'nButtonSwipeDownHintForegroundStyle',
    },

    mButton: createButton(
      'm',
      if orientation == 'portrait' then
        keyboardLayout['竖屏按键尺寸']['普通键size']
      else
        keyboardLayout['横屏按键尺寸']['普通键size'],
      {},
      $
    ),

    mButtonHintStyle: {
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: 'mButtonHintForegroundStyle',
      swipeUpForegroundStyle: 'mButtonSwipeUpHintForegroundStyle',
      swipeDownForegroundStyle: 'mButtonSwipeDownHintForegroundStyle',
    },
    backspaceButton: createButton(
      'backspace',
      if orientation == 'portrait' then
        keyboardLayout['竖屏按键尺寸']['backspace键size']
      else
        keyboardLayout['横屏按键尺寸']['backspace键size'],
      {},
      $,
      false
    ) + {
      backgroundStyle: 'systemButtonBackgroundStyle',
      action: 'backspace',
      repeatAction: 'backspace',
    },

    backspaceButtonForegroundStyle: {
      buttonStyleType: 'systemImage',
      systemImageName: 'delete.left',
      normalColor: color[theme]['按键前景颜色'],
      highlightColor: color[theme]['按键前景颜色'],
      fontSize: fontSize['按键前景文字大小'],
      targetScale: 0.7,
      // center: { y: 0.53 },
    },

    en2cnButton: createButton(
      'en2cn',
      if orientation == 'portrait' then
        keyboardLayout['竖屏按键尺寸']['en2cn键size']
      else
        keyboardLayout['横屏按键尺寸']['en2cn键size'],
      {},
      $,
      false
    ) + {
      // backgroundStyle: 'systemButtonBackgroundStyle',
      action: { keyboardType: 'pinyin' },
    },

    en2cnButtonForegroundStyle: {
      buttonStyleType: 'assetImage',
      assetImageName: 'englishState',
      normalColor: color[theme]['按键前景颜色'],
      highlightColor: color[theme]['按键前景颜色'],
      fontSize: fontSize['按键前景文字大小'] - 3,
      center: center['功能键前景文字偏移'] { y: 0.5 },
    },
    '123Button': createButton(
      '123',
      if orientation == 'portrait' then
        keyboardLayout['竖屏按键尺寸']['123键size']
      else
        keyboardLayout['横屏按键尺寸']['123键size'],
      {},
      $,
      false
    ) + {
      type: 'horizontalSymbols',
      maxColumns: 1,
      contentRightToLeft: false,
      insets: { left: 3, right: 3 },
      backgroundStyle: 'systemButtonBackgroundStyle',
      dataSource: '123ButtonSymbolsDataSource',
    },
    '123ButtonSymbolsDataSource': [
      { label: '1', action: { keyboardType: 'numeric' }, styleName: 'numericStyle' },
      { label: '2', action: { keyboardType: 'symbolic' }, styleName: 'symbolicStyle' },
      // { label: '3', action: { keyboardType: 'emoji' }, styleName: 'emojiStyle' },
      { label: '4', action: { keyboardType: 'emojis' }, styleName: 'emojisStyle' },
    ],

    spaceButton: createButton(
      'space',
      if orientation == 'portrait' then
        keyboardLayout['竖屏按键尺寸']['space键size']
      else
        keyboardLayout['横屏按键尺寸']['space键size'],
      {},
      $,
      false
    ) + {
      backgroundStyle: 'alphabeticBackgroundStyle',
      foregroundStyle: [
        'spaceButtonForegroundStyle',
        'spaceButtonForegroundStyle1',
      ],
      action: 'space',
    },

    spaceButtonForegroundStyle: {
      buttonStyleType: 'systemImage',
      systemImageName: 'space',
      normalColor: color[theme]['按键前景颜色'],
      highlightColor: color[theme]['按键前景颜色'],
      fontSize: fontSize['按键前景文字大小'] - 3,
      center: center['功能键前景文字偏移'],
    },
    spaceButtonForegroundStyle1: {
      buttonStyleType: 'text',
      text: 'A',
      normalColor: color[theme]['划动字符颜色'],
      highlightColor: color[theme]['划动字符颜色'],
      fontSize: fontSize['按键前景文字大小'] - 10,
      center: { x: 0.9, y: 0.8 },
    },

    // 横屏左边空格按键
    spaceFirstButton: createButton(
      'spaceFirst',
      if orientation == 'portrait' then
        keyboardLayout['竖屏按键尺寸']['space键size']
      else
        keyboardLayout['横屏按键尺寸']['spaceFirst键size'],
      {},
      $,
      false
    ) + {
      backgroundStyle: 'alphabeticBackgroundStyle',
      action: 'space',
    },


    spaceFirstButtonForegroundStyle: {
      buttonStyleType: 'systemImage',
      systemImageName: 'space',
      normalColor: color[theme]['按键前景颜色'],
      highlightColor: color[theme]['按键前景颜色'],
      fontSize: fontSize['按键前景文字大小'] - 3,
      center: center['功能键前景文字偏移'],
    },

    // 横屏右边空格按键
    spaceSecondButton: createButton(
      'spaceSecond',
      if orientation == 'portrait' then
        keyboardLayout['竖屏按键尺寸']['space键size']
      else
        keyboardLayout['横屏按键尺寸']['spaceSecond键size'],
      {},
      $,
      false
    ) + {
      backgroundStyle: 'alphabeticBackgroundStyle',
      foregroundStyle: [
        'spaceSecondButtonForegroundStyle',
        'spaceSecondButtonForegroundStyle1',
      ],
      action: 'space',
    },

    spaceSecondButtonForegroundStyle: {
      buttonStyleType: 'systemImage',
      systemImageName: 'space',
      normalColor: color[theme]['按键前景颜色'],
      highlightColor: color[theme]['按键前景颜色'],
      fontSize: fontSize['按键前景文字大小'] - 3,
      center: center['功能键前景文字偏移'],
    },
    spaceSecondButtonForegroundStyle1: {
      buttonStyleType: 'text',
      text: 'A',
      normalColor: color[theme]['划动字符颜色'],
      highlightColor: color[theme]['划动字符颜色'],
      fontSize: fontSize['按键前景文字大小'] - 10,
      center: { x: 0.9, y: 0.8 },
    },
    local srBtn = createButton(
      'spaceRight',
      if orientation == 'portrait' then
        keyboardLayout['竖屏按键尺寸']['spaceRight键size']
      else
        keyboardLayout['横屏按键尺寸']['spaceRight键size'],
      {},
      $,
      false
    ),
    spaceRightButton: srBtn {
      foregroundStyle: [
        'spaceRightButtonForegroundStyle',
        //'spaceRightButtonForegroundStyle2',
      ],
      action: {
        symbol: '.',
      },
    },

    spaceRightButtonForegroundStyle: {
      buttonStyleType: 'text',
      text: '.',
      normalColor: color[theme]['按键前景颜色'],
      highlightColor: color[theme]['按键前景颜色'],
      fontSize: fontSize['按键前景文字大小'],
      // center: { x: 0.5, y: 0.34 },
    },
    spaceRightButtonForegroundStyle2: {
      buttonStyleType: 'text',
      text: '.',
      normalColor: color[theme]['按键前景颜色'],
      highlightColor: color[theme]['按键前景颜色'],
      fontSize: fontSize['按键前景文字大小'],
      // center: { x: 0.5, y: 0.54 },
    },
    local slBtn = createButton(
      'spaceLeft',
      if orientation == 'portrait' then
        keyboardLayout['竖屏按键尺寸']['spaceRight键size']
      else
        keyboardLayout['横屏按键尺寸']['spaceRight键size'],
      {},
      $,
      false
    ),
    spaceLeftButton: srBtn {
      foregroundStyle: [
        'spaceLeftButtonForegroundStyle',
        'spaceLeftButtonForegroundStyle2',
      ],
      action: {
        symbol: ',',
      },
    },

    spaceLeftButtonForegroundStyle: {
      buttonStyleType: 'text',
      text: ',',
      normalColor: color[theme]['按键前景颜色'],
      highlightColor: color[theme]['按键前景颜色'],
      fontSize: fontSize['按键前景文字大小'],
      center: { y: 0.5 },
    },
    spaceLeftButtonForegroundStyle2: {
      buttonStyleType: 'text',
      text: '.',
      normalColor: color[theme]['按键前景颜色'],
      highlightColor: color[theme]['按键前景颜色'],
      fontSize: fontSize['按键前景文字大小'],
      center: { y: 0.3 },
    },
    // "EnZhButton": createButton(
    //     "EnZh",
    //     if orientation == "portrait" then
    //       keyboardLayout["竖屏按键尺寸"]["EnZh键size"]
    //     else
    //         keyboardLayout["横屏按键尺寸"]["EnZh键size"],
    //     {},
    //     $,
    //     false
    //   ) + {
    //       "backgroundStyle": "systemButtonBackgroundStyle",
    //       "action": {
    //         "keyboardType": "pinyin"
    //       },
    //     },
    // "EnZhButtonForegroundStyle": {
    //   "assetImageName": "englishState2",
    //   "normalColor": color[theme]["按键前景颜色"],
    //   "highlightColor": color[theme]["按键前景颜色"],
    //   // "fontSize": fontSize["按键前景文字大小"]-3,
    // },
    enterButton: createButton(
      'enter',
      if orientation == 'portrait' then
        keyboardLayout['竖屏按键尺寸']['enter键size']
      else
        keyboardLayout['横屏按键尺寸']['enter键size'],
      {},
      $,
      false
    ) + {
      backgroundStyle: [
        {
          styleName: 'systemButtonBackgroundStyle',
          conditionKey: '$returnKeyType',
          conditionValue: [0, 2, 3, 5, 8, 10, 11],
        },
        {
          styleName: 'enterButtonBlueBackgroundStyle',
          conditionKey: '$returnKeyType',
          conditionValue: [1, 4, 6, 7, 9],
        },
      ],
      foregroundStyle: [
        {
          styleName: 'enterButtonForegroundStyle0',
          conditionKey: '$returnKeyType',
          conditionValue: [0, 2, 3, 5, 8, 10, 11],
        },
        {
          styleName: 'enterButtonForegroundStyle14',
          conditionKey: '$returnKeyType',
          conditionValue: [1, 4],
        },
        {
          styleName: 'enterButtonForegroundStyle6',
          conditionKey: '$returnKeyType',
          conditionValue: [6],
        },
        {
          styleName: 'enterButtonForegroundStyle7',
          conditionKey: '$returnKeyType',
          conditionValue: [7],
        },
        {
          styleName: 'enterButtonForegroundStyle9',
          conditionKey: '$returnKeyType',
          conditionValue: [9],
        },
      ],
      action: 'enter',

      // 按键通知
      notification: [
        'garyReturnKeyTypeNotification',
        'blueReturnKeyTypeNotification14',
        'blueReturnKeyTypeNotification6',
        'blueReturnKeyTypeNotification7',
        'blueReturnKeyTypeNotification9',
      ],
    },

    enterButtonForegroundStyle0: {
      buttonStyleType: 'text',
      text: 'Enter',
      normalColor: color[theme]['按键前景颜色'],
      highlightColor: color[theme]['按键前景颜色'],
      fontSize: fontSize['按键前景文字大小'] - 3,
      center: center['功能键前景文字偏移'],
    },
    enterButtonForegroundStyle6: {
      buttonStyleType: 'text',
      text: 'Search',
      normalColor: color[theme]['长按选中字体颜色'],
      highlightColor: color[theme]['长按非选中字体颜色'],
      fontSize: fontSize['按键前景文字大小'] - 3,
      center: center['功能键前景文字偏移'],
    },
    // 白色文字
    enterButtonForegroundStyle7: {
      buttonStyleType: 'text',
      text: 'Send',
      normalColor: color[theme]['长按选中字体颜色'],
      highlightColor: color[theme]['长按非选中字体颜色'],
      fontSize: fontSize['按键前景文字大小'] - 3,
      center: center['功能键前景文字偏移'],
    },
    enterButtonForegroundStyle14: {
      buttonStyleType: 'text',
      text: 'Go',
      normalColor: color[theme]['长按选中字体颜色'],
      highlightColor: color[theme]['长按非选中字体颜色'],
      fontSize: fontSize['按键前景文字大小'] - 3,
      center: center['功能键前景文字偏移'],
    },
    enterButtonForegroundStyle9: {
      buttonStyleType: 'text',
      text: 'Done',
      normalColor: color[theme]['长按选中字体颜色'],
      highlightColor: color[theme]['长按非选中字体颜色'],
      fontSize: fontSize['按键前景文字大小'] - 3,
      center: center['功能键前景文字偏移'],
    },
    enterButtonBlueBackgroundStyle: {
      buttonStyleType: 'geometry',
      insets: if orientation == 'portrait' then { top: 5, left: 3, bottom: 5, right: 3 } else { top: 3, left: 2, bottom: 3, right: 2 },
      normalColor: color[theme]['enter键背景(蓝色)'],
      highlightColor: color[theme]['功能键背景颜色-高亮'],
      cornerRadius: 7,
      normalLowerEdgeColor: color[theme]['底边缘颜色-普通'],
      highlightLowerEdgeColor: color[theme]['底边缘颜色-高亮'],
    },

    alphabeticBackgroundStyle: {
      // animation: 'ButtonScaleAnimation',
      buttonStyleType: 'geometry',
      insets: if orientation == 'portrait' then { top: 5, left: 3, bottom: 5, right: 3 } else { top: 3, left: 2, bottom: 3, right: 2 },
      normalColor: color[theme]['字母键背景颜色-普通'],
      highlightColor: color[theme]['字母键背景颜色-高亮'],
      cornerRadius: 7,
      normalLowerEdgeColor: color[theme]['底边缘颜色-普通'],
      highlightLowerEdgeColor: color[theme]['底边缘颜色-高亮'],
    },
    systemButtonBackgroundStyle: {
      // animation: 'ButtonScaleAnimation',
      buttonStyleType: 'geometry',
      insets: if orientation == 'portrait' then { top: 5, left: 3, bottom: 5, right: 3 } else { top: 3, left: 2, bottom: 3, right: 2 },
      normalColor: color[theme]['功能键背景颜色-普通'],
      highlightColor: color[theme]['功能键背景颜色-高亮'],
      cornerRadius: 7,
      normalLowerEdgeColor: color[theme]['底边缘颜色-普通'],
      highlightLowerEdgeColor: color[theme]['底边缘颜色-高亮'],
    },
    ButtonScaleAnimation: animation['26键按键动画'],
    alphabeticHintBackgroundStyle: {
      buttonStyleType: 'geometry',
      normalColor: color[theme]['气泡背景颜色'],
      highlightColor: color[theme]['气泡高亮颜色'],
      cornerRadius: 7,
      shadowColor: color[theme]['长按背景阴影颜色'],
      shadowOffset: { x: 0, y: 5 },
    },
    alphabeticHintSymbolsBackgroundStyle: hintSymbolsStyles['长按背景样式'],
    alphabeticHintSymbolsSelectedStyle: hintSymbolsStyles['长按选中背景样式'],

    // 灰色回车通知（前景 0）
    garyReturnKeyTypeNotification: {
      notificationType: 'returnKeyType',
      returnKeyType: [0, 2, 3, 5, 8, 10, 11],
      backgroundStyle: 'systemButtonBackgroundStyle',
      foregroundStyle: 'enterButtonForegroundStyle0',
    },

    // 蓝色回车通知（按前景细分）
    blueReturnKeyTypeNotification14: {
      notificationType: 'returnKeyType',
      returnKeyType: [1, 4],
      backgroundStyle: 'enterButtonBlueBackgroundStyle',
      foregroundStyle: 'enterButtonForegroundStyle14',
    },
    blueReturnKeyTypeNotification6: {
      notificationType: 'returnKeyType',
      returnKeyType: [6],
      backgroundStyle: 'enterButtonBlueBackgroundStyle',
      foregroundStyle: 'enterButtonForegroundStyle6',
    },
    blueReturnKeyTypeNotification7: {
      notificationType: 'returnKeyType',
      returnKeyType: [7],
      backgroundStyle: 'enterButtonBlueBackgroundStyle',
      foregroundStyle: 'enterButtonForegroundStyle7',
    },
    blueReturnKeyTypeNotification9: {
      notificationType: 'returnKeyType',
      returnKeyType: [9],
      backgroundStyle: 'enterButtonBlueBackgroundStyle',
      foregroundStyle: 'enterButtonForegroundStyle9',
    },
  };
{
  new(theme, orientation):
    keyboard(theme, orientation, keyboardLayout_.getKeyboardLayout(theme)),
}
