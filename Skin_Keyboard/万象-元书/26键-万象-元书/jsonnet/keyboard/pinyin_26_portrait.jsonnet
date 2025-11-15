local animation = import '../lib/animation.libsonnet';
local center = import '../lib/center.libsonnet';
local color = import '../lib/color.libsonnet';
local fontSize = import '../lib/fontSize.libsonnet';
local hintSymbolsData = import '../lib/hintSymbolsData.libsonnet';
local keyboardLayout_ = import '../lib/keyboardLayout.libsonnet';
local others = import '../lib/others.libsonnet';
local swipeData = import '../lib/swipeData.libsonnet';
local toolbar = import '../lib/toolbar.libsonnet';
local utils = import '../lib/utils.libsonnet';

local hintSymbolsStyles = import '../lib/hintSymbolsStyles.libsonnet';
local swipeStyles = import '../lib/swipeStyle.libsonnet';

// 123Button的划动前景
local slideForeground = import '../lib/slideForeground.libsonnet';

// 上下和下划的数据
local swipe_up = if std.objectHas(swipeData, 'swipe_up') then swipeData.swipe_up else {};
local swipe_down = if std.objectHas(swipeData, 'swipe_down') then swipeData.swipe_down else {};

local letters = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'];

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
  keyboardLayout[if orientation == 'portrait' then '竖屏中文26键' else '横屏中文26键'] +
  swipeStyles.getStyle('cn', theme, swipe_up, swipe_down) +
  hintSymbolsStyles.getStyle(theme, hintSymbolsData.pinyin) +
  toolbar.getToolBar(theme) +
  utils.genPinyinStyles(fontSize, color, theme, center) +
  utils.genFuncKeyStyles(fontSize, color, theme, center) +
  slideForeground.slideForeground(theme) +
  {
    [if std.objectHas(others, '中文键盘方案') then 'rimeSchema']: others['中文键盘方案'],
    preeditHeight: others[if orientation == 'portrait' then '竖屏' else '横屏']['preedit高度'],
    toolbarHeight: others[if orientation == 'portrait' then '竖屏' else '横屏']['toolbar高度'],
    keyboardHeight: others[if orientation == 'portrait' then '竖屏' else '横屏']['keyboard高度'],
    preedit: {
      insets: {
        left: 8,
        top: 2,
      },
      backgroundStyle: 'preeditBackgroundStyle',
      foregroundStyle: 'preeditForegroundStyle',
    },
    preeditBackgroundStyle: {
      buttonStyleType: 'geometry',
      normalColor: color[theme]['键盘背景颜色'],
    },
    preeditForegroundStyle: {
      textColor: color[theme]['候选字体未选中字体颜色'],
      fontSize: fontSize['preedit区字体大小'],
      fontWeight: 0,
    },

    leftButton: createButton(
      'left',
      if orientation == 'portrait' then
        keyboardLayout['竖屏按键尺寸']['自定义键size']
      else
        keyboardLayout['横屏按键尺寸']['自定义键size'],
      {},
      $
    ) + {
      action: 'moveCursorBackward',
      repeatAction: 'moveCursorBackward',
      backgroundStyle: 'alphabeticBackgroundStyle',
      notification: [
        'leftButtonPreeditNotification',
      ],
    },
    leftButtonPreeditNotification: {
      notificationType: 'preeditChanged',
      backgroundStyle: 'alphabeticBackgroundStyle',
      foregroundStyle: 'leftButtonPreeditForegroundStyle',
      action: { sendKeys: 'Up' },
      swipeDownAction: { character: '[' },

    },

    headButton: createButton(
      'head',
      if orientation == 'portrait' then
        keyboardLayout['竖屏按键尺寸']['自定义键size']
      else
        keyboardLayout['横屏按键尺寸']['自定义键size'],
      {},
      $
    ) + {
      action: { shortcut: '#行首' },
      backgroundStyle: 'alphabeticBackgroundStyle',
      notification: [
        'headButtonPreeditNotification',
      ],
    },
    headButtonPreeditNotification: {
      notificationType: 'preeditChanged',
      backgroundStyle: 'alphabeticBackgroundStyle',
      // 下面的前景样式重写以覆盖utils中生成的前景
      foregroundStyle: 'headButtonPreeditForegroundStyle',
      action: { shortcut: '#rimeNextPage' },
      swipeUpAction: { shortcut: '#rimePreviousPage' },
      swipeDownAction: { shortcut: '#rimeNextPage' },
    },

    selectButton: createButton(
      'select',
      if orientation == 'portrait' then
        keyboardLayout['竖屏按键尺寸']['自定义键size']
      else
        keyboardLayout['横屏按键尺寸']['自定义键size'],
      {},
      $
    ) + {
      action: { shortcut: '#selectText' },
      backgroundStyle: 'alphabeticBackgroundStyle',
      notification: [
        'selectButtonPreeditNotification',
      ],
    },
    selectButtonPreeditNotification: {
      notificationType: 'preeditChanged',
      backgroundStyle: 'alphabeticBackgroundStyle',
      foregroundStyle: 'selectButtonPreeditForegroundStyle',
      action: { character: '7' },
      swipeDownAction: { sendKeys: 'control+1' },
      swipeUpAction: { sendKeys: 'control+1' },
    },
    cutButton: createButton(
      'cut',
      if orientation == 'portrait' then
        keyboardLayout['竖屏按键尺寸']['自定义键size']
      else
        keyboardLayout['横屏按键尺寸']['自定义键size'],
      {},
      $
    ) + {
      action: { shortcut: '#cut' },
      backgroundStyle: 'alphabeticBackgroundStyle',
      notification: [
        'cutButtonPreeditNotification',
      ],
    },
    cutButtonPreeditNotification: {
      notificationType: 'preeditChanged',
      backgroundStyle: 'alphabeticBackgroundStyle',
      foregroundStyle: 'cutButtonPreeditForegroundStyle',
      action: { character: '8' },
      swipeDownAction: { sendKeys: 'control+2' },
      swipeUpAction: { sendKeys: 'control+2' },
    },


    copyButton: createButton(
      'copy',
      if orientation == 'portrait' then
        keyboardLayout['竖屏按键尺寸']['自定义键size']
      else
        keyboardLayout['横屏按键尺寸']['自定义键size'],
      {},
      $
    ) + {
      action: { shortcut: '#copy' },
      backgroundStyle: 'alphabeticBackgroundStyle',
      notification: [
        'copyButtonPreeditNotification',
      ],
    },
    copyButtonPreeditNotification: {
      notificationType: 'preeditChanged',
      backgroundStyle: 'alphabeticBackgroundStyle',
      foregroundStyle: 'copyButtonPreeditForegroundStyle',
      action: { character: '9' },
      swipeDownAction: { sendKeys: 'control+3' },
      swipeUpAction: { sendKeys: 'control+3' },
    },

    pasteButton: createButton(
      'paste',
      if orientation == 'portrait' then
        keyboardLayout['竖屏按键尺寸']['自定义键size']
      else
        keyboardLayout['横屏按键尺寸']['自定义键size'],
      {},
      $
    ) + {
      action: { shortcut: '#paste' },
      backgroundStyle: 'alphabeticBackgroundStyle',
      notification: [
        'pasteButtonPreeditNotification',
      ],
    },
    pasteButtonPreeditNotification: {
      notificationType: 'preeditChanged',
      backgroundStyle: 'alphabeticBackgroundStyle',
      foregroundStyle: 'pasteButtonPreeditForegroundStyle',
      action: { character: '0' },
      swipeDownAction: { sendKeys: 'control+4' },
      swipeUpAction: { sendKeys: 'control+4' },
    },

    tailButton: createButton(
      'tail',
      if orientation == 'portrait' then
        keyboardLayout['竖屏按键尺寸']['自定义键size']
      else
        keyboardLayout['横屏按键尺寸']['自定义键size'],
      {},
      $
    ) + {
      action: { shortcut: '#行尾' },
      backgroundStyle: 'alphabeticBackgroundStyle',
      notification: [
        'tailButtonPreeditNotification',
      ],
    },
    tailButtonPreeditNotification: {
      notificationType: 'preeditChanged',
      backgroundStyle: 'alphabeticBackgroundStyle',
      foregroundStyle: 'tailButtonPreeditForegroundStyle',
      action: { sendKeys: 'backslash' },
    },

    rightButton: createButton(
      'right',
      if orientation == 'portrait' then
        keyboardLayout['竖屏按键尺寸']['自定义键size']
      else
        keyboardLayout['横屏按键尺寸']['自定义键size'],
      {},
      $
    ) + {
      action: 'moveCursorForward',
      repeatAction: 'moveCursorForward',
      backgroundStyle: 'alphabeticBackgroundStyle',
      notification: [
        'rightButtonPreeditNotification',
      ],
    },
    rightButtonPreeditNotification: {
      notificationType: 'preeditChanged',
      backgroundStyle: 'alphabeticBackgroundStyle',
      foregroundStyle: 'rightButtonPreeditForegroundStyle',
      action: { sendKeys: 'Down' },
      swipeDownAction: { character: ']' },
    },

    qButton: createButton(
      'q',
      if orientation == 'portrait' then
        keyboardLayout['竖屏按键尺寸']['普通键size']
      else
        keyboardLayout['横屏按键尺寸']['普通键size'],
      {},
      $
    ),
    qButtonBackslashNotification: createBackslashNotification('q'),
    qButtonHintStyle: {
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: 'qButtonHintForegroundStyle',
      // swipeUpForegroundStyle: 'qButtonSwipeUpHintForegroundStyle',
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
    wButtonBackslashNotification: createBackslashNotification('w'),

    wButtonHintStyle: {
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: 'wButtonHintForegroundStyle',
      // swipeUpForegroundStyle: 'wButtonSwipeUpHintForegroundStyle',
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
    eButtonBackslashNotification: createBackslashNotification('e'),

    eButtonHintStyle: {
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: 'eButtonHintForegroundStyle',
      // swipeUpForegroundStyle: 'eButtonSwipeUpHintForegroundStyle',
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
    rButtonBackslashNotification: createBackslashNotification('r'),

    rButtonHintStyle: {
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: 'rButtonHintForegroundStyle',
      // swipeUpForegroundStyle: 'rButtonSwipeUpHintForegroundStyle',
    },

    tButton: createButton(
      't',
      if orientation == 'portrait' then
        keyboardLayout['竖屏按键尺寸']['普通键size']
      else
        keyboardLayout['横屏按键尺寸']['普通键size'],
      if orientation == 'portrait' then {} else keyboardLayout['横屏按键尺寸']['t键size和bounds'].bounds,
      $
    ),
    tButtonBackslashNotification: createBackslashNotification(
      't',
      if orientation == 'portrait' then {} else keyboardLayout['横屏按键尺寸']['t键size和bounds'].bounds,
    ),


    tButtonHintStyle: {
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: 'tButtonHintForegroundStyle',
      // swipeUpForegroundStyle: 'tButtonSwipeUpHintForegroundStyle',
    },

    yButton: createButton(
      'y',
      if orientation == 'portrait' then
        keyboardLayout['竖屏按键尺寸']['普通键size']
      else
        keyboardLayout['横屏按键尺寸']['y键size和bounds'].size,
      if orientation == 'portrait' then {} else keyboardLayout['横屏按键尺寸']['y键size和bounds'].bounds,
      $
    ),
    yButtonBackslashNotification: createBackslashNotification(
      'y',
      if orientation == 'portrait' then {} else keyboardLayout['横屏按键尺寸']['y键size和bounds'].bounds,
    ),

    yButtonHintStyle: {
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: 'yButtonHintForegroundStyle',
      // swipeUpForegroundStyle: 'yButtonSwipeUpHintForegroundStyle',
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
    uButtonBackslashNotification: createBackslashNotification('u'),

    uButtonHintStyle: {
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: 'uButtonHintForegroundStyle',
      // swipeUpForegroundStyle: 'uButtonSwipeUpHintForegroundStyle',
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
    iButtonBackslashNotification: createBackslashNotification('i'),

    iButtonHintStyle: {
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: 'iButtonHintForegroundStyle',
      // swipeUpForegroundStyle: 'iButtonSwipeUpHintForegroundStyle',
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
    oButtonBackslashNotification: createBackslashNotification('o'),

    oButtonHintStyle: {
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: 'oButtonHintForegroundStyle',
      // swipeUpForegroundStyle: 'oButtonSwipeUpHintForegroundStyle',
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
    pButtonBackslashNotification: createBackslashNotification('p'),

    pButtonHintStyle: {
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: 'pButtonHintForegroundStyle',
      // swipeUpForegroundStyle: 'pButtonSwipeUpHintForegroundStyle',
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
    aButtonBackslashNotification: createBackslashNotification(
      'a',
      if orientation == 'portrait' then
        keyboardLayout['竖屏按键尺寸']['a键size和bounds'].bounds
      else
        keyboardLayout['横屏按键尺寸']['a键size和bounds'].bounds,
    ),

    aButtonHintStyle: {
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: 'aButtonHintForegroundStyle',
      // swipeUpForegroundStyle: 'aButtonSwipeUpHintForegroundStyle',
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
    sButtonBackslashNotification: createBackslashNotification('s'),

    sButtonHintStyle: {
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: 'sButtonHintForegroundStyle',
      // swipeUpForegroundStyle: 'sButtonSwipeUpHintForegroundStyle',
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
    dButtonBackslashNotification: createBackslashNotification('d'),

    dButtonHintStyle: {
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: 'dButtonHintForegroundStyle',
      // swipeUpForegroundStyle: 'dButtonSwipeUpHintForegroundStyle',
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
    fButtonBackslashNotification: createBackslashNotification('f'),

    fButtonHintStyle: {
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: 'fButtonHintForegroundStyle',
      // swipeUpForegroundStyle: 'fButtonSwipeUpHintForegroundStyle',
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
    gButtonBackslashNotification: createBackslashNotification('g'),

    gButtonHintStyle: {
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: 'gButtonHintForegroundStyle',
      // swipeUpForegroundStyle: 'gButtonSwipeUpHintForegroundStyle',
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
    hButtonBackslashNotification: createBackslashNotification('h'),

    hButtonHintStyle: {
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: 'hButtonHintForegroundStyle',
      // swipeUpForegroundStyle: 'hButtonSwipeUpHintForegroundStyle',
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
    jButtonBackslashNotification: createBackslashNotification('j'),

    jButtonHintStyle: {
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: 'jButtonHintForegroundStyle',
      // swipeUpForegroundStyle: 'jButtonSwipeUpHintForegroundStyle',
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
    kButtonBackslashNotification: createBackslashNotification('k'),

    kButtonHintStyle: {
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: 'kButtonHintForegroundStyle',
      // swipeUpForegroundStyle: 'kButtonSwipeUpHintForegroundStyle',
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
    lButtonBackslashNotification: createBackslashNotification(
      'l',
      if orientation == 'portrait' then
        keyboardLayout['竖屏按键尺寸']['l键size和bounds'].bounds
      else
        keyboardLayout['横屏按键尺寸']['l键size和bounds'].bounds,
    ),

    lButtonHintStyle: {
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: 'lButtonHintForegroundStyle',
      // swipeUpForegroundStyle: 'lButtonSwipeUpHintForegroundStyle',
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
      notification: [
        'shiftButtonPreeditNotification',
      ],
    },
    shiftButtonPreeditNotification: {
      notificationType: 'preeditChanged',
      backgroundStyle: 'systemButtonBackgroundStyle',
      foregroundStyle: 'shiftButtonPreeditForegroundStyle',
      action: { character: '/' },
      swipeUpAction: { character: "'" },
    },
    shiftButtonPreeditForegroundStyle: {
      buttonStyleType: 'systemImage',
      systemImageName: 'inset.filled.lefthalf.arrow.left.rectangle',
      normalColor: color[theme]['按键前景颜色'],
      highlightColor: color[theme]['按键前景颜色'],
      fontSize: fontSize['按键前景文字大小'],
      // center: { y: 0.53 },
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
    zButtonBackslashNotification: createBackslashNotification('z'),

    zButtonHintStyle: {
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: 'zButtonHintForegroundStyle',
      // swipeUpForegroundStyle: 'zButtonSwipeUpHintForegroundStyle',
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
    xButtonBackslashNotification: createBackslashNotification('x'),

    xButtonHintStyle: {
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: 'xButtonHintForegroundStyle',
      // swipeUpForegroundStyle: 'xButtonSwipeUpHintForegroundStyle',
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
    cButtonBackslashNotification: createBackslashNotification('c'),

    cButtonHintStyle: {
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: 'cButtonHintForegroundStyle',
      // swipeUpForegroundStyle: 'cButtonSwipeUpHintForegroundStyle',
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
    vButtonBackslashNotification: createBackslashNotification('v'),

    vButtonHintStyle: {
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: 'vButtonHintForegroundStyle',
      // swipeUpForegroundStyle: 'vButtonSwipeUpHintForegroundStyle',
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
    bButtonBackslashNotification: createBackslashNotification('b'),

    bButtonHintStyle: {
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: 'bButtonHintForegroundStyle',
      // swipeUpForegroundStyle: 'bButtonSwipeUpHintForegroundStyle',
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
    nButtonBackslashNotification: createBackslashNotification('n'),

    nButtonHintStyle: {
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: 'nButtonHintForegroundStyle',
      // swipeUpForegroundStyle: 'nButtonSwipeUpHintForegroundStyle',
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
    mButtonBackslashNotification: createBackslashNotification('m'),

    mButtonHintStyle: {
      backgroundStyle: 'alphabeticHintBackgroundStyle',
      foregroundStyle: 'mButtonHintForegroundStyle',
      // swipeUpForegroundStyle: 'mButtonSwipeUpHintForegroundStyle',
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
    cn2enButton: createButton(
      'cn2en',
      if orientation == 'portrait' then
        keyboardLayout['竖屏按键尺寸']['cn2en键size']
      else
        keyboardLayout['横屏按键尺寸']['cn2en键size'],
      {},
      $,
      false
    ) + {
      // backgroundStyle: 'systemButtonBackgroundStyle',
      action: { keyboardType: 'alphabetic' },
      notification: [
        'spaceRightButtonPreeditNotification',  // 复用后面的空格右侧按钮
      ],
    },

    cn2enButtonForegroundStyle: {
      buttonStyleType: 'assetImage',
      assetImageName: 'chineseState',
      normalColor: color[theme]['按键前景颜色'],
      highlightColor: color[theme]['按键前景颜色'],
      fontSize: fontSize['按键前景文字大小'] - 3,
      center: center['功能键前景文字偏移'] { y: 0.5 },
    },
    // super是父类继承，类似于python，如super.aButtonHintSymbolsStyleOf4，但是由于是123开头，所以要用super["123ButtonHintSymbolsStyleOf0"]
    cn2enButtonHintSymbolsStyleOf0: super['cn2enButtonHintSymbolsStyleOf0'] + {
      foregroundStyle: [  // 使用方括号 [] 来表示Jsonnet中的数组
        {
          styleName: 'cn2enButtonHintSymbolsForegroundStyleOf0',
          conditionKey: 'rime$s2s',
          conditionValue: 'true',
        },
        {
          styleName: 'cn2enButtonHintSymbolsForegroundStyleOf1',
          conditionKey: 'rime$s2t',  // 已移除多余空格
          conditionValue: 'true',
        },
        {
          styleName: 'cn2enButtonHintSymbolsForegroundStyleOf2',
          conditionKey: 'rime$s2hk',
          conditionValue: 'true',
        },
        {
          styleName: 'cn2enButtonHintSymbolsForegroundStyleOf3',
          conditionKey: 'rime$s2tw',
          conditionValue: 'true',
        },
      ],
    },
    cn2enButtonHintSymbolsStyleOf4: super['cn2enButtonHintSymbolsStyleOf4'] + {
      foregroundStyle: [
        {
          styleName: 'cn2enButtonHintSymbolsForegroundStyleOf4',
          conditionKey: 'rime$chinese_english',
          conditionValue: 'true',
        },
        {
          styleName: 'cn2enButtonHintSymbolsForegroundStyleOf5',
          conditionKey: 'rime$chinese_english',
          conditionValue: 'false',
        },
      ],
    },
    cn2enButtonHintSymbolsStyleOf6: super['cn2enButtonHintSymbolsStyleOf6'] + {
      foregroundStyle: [
        {
          styleName: 'cn2enButtonHintSymbolsForegroundStyleOf6',
          conditionKey: 'rime$chaifen_switch',
          conditionValue: 'true',
        },
        {
          styleName: 'cn2enButtonHintSymbolsForegroundStyleOf7',
          conditionKey: 'rime$chaifen_switch',
          conditionValue: 'false',
        },
      ],
    },
    cn2enButtonHintSymbolsStyleOf8: super['cn2enButtonHintSymbolsStyleOf8'] + {
      foregroundStyle: [
        {
          styleName: 'cn2enButtonHintSymbolsForegroundStyleOf8',
          conditionKey: 'rime$super_tips',
          conditionValue: 'true',
        },
        {
          styleName: 'cn2enButtonHintSymbolsForegroundStyleOf9',
          conditionKey: 'rime$super_tips',
          conditionValue: 'false',
        },
      ],
    },
    cn2enButtonHintSymbolsStyle: super['cn2enButtonHintSymbolsStyle'] + {
      symbolStyles: [
        'cn2enButtonHintSymbolsStyleOf0',
        'cn2enButtonHintSymbolsStyleOf4',
        'cn2enButtonHintSymbolsStyleOf6',
        'cn2enButtonHintSymbolsStyleOf8',
      ],
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
      insets: { left: 3, right: 3 },
      contentRightToLeft: false,
      backgroundStyle: 'systemButtonBackgroundStyle',
      dataSource: '123ButtonSymbolsDataSource',
    },
    '123ButtonSymbolsDataSource': [
      { label: '1', action: { keyboardType: 'numeric' }, styleName: 'numericStyle' },
      { label: '2', action: { keyboardType: 'symbolic' }, styleName: 'symbolicStyle' },
      { label: '3', action: { keyboardType: 'emoji' }, styleName: 'emojiStyle' },
      { label: '4', action: { keyboardType: 'emojis' }, styleName: 'emojisStyle' },  // 内置键盘
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
      notification: [
        'spaceButtonPreeditNotification',
      ],
    },
    spaceButtonPreeditNotification: {
      notificationType: 'preeditChanged',
      backgroundStyle: 'alphabeticBackgroundStyle',
      foregroundStyle: [
        'spaceButtonForegroundStyle',
        'spaceButtonForegroundStyle1',
      ],
      swipeUpAction: { shortcut: '#次选上屏' },
      swipeDownAction: { shortcut: '#三选上屏' },
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
      text: '万象',
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
      foregroundStyle: 'spaceFirstButtonForegroundStyle',
      backgroundStyle: 'alphabeticBackgroundStyle',
      action: 'space',
      notification: [
        'spaceFirstButtonPreeditNotification',
      ],
    },
    spaceFirstButtonPreeditNotification: {
      notificationType: 'preeditChanged',
      backgroundStyle: 'alphabeticBackgroundStyle',
      foregroundStyle: 'spaceFirstButtonForegroundStyle',
      swipeUpAction: { shortcut: '#次选上屏' },
      swipeDownAction: { shortcut: '#三选上屏' },
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
      notification: [
        'spaceSecondButtonPreeditNotification',
      ],
    },
    spaceSecondButtonPreeditNotification: {
      notificationType: 'preeditChanged',
      backgroundStyle: 'alphabeticBackgroundStyle',
      foregroundStyle: [
        'spaceSecondButtonForegroundStyle',
        'spaceSecondButtonForegroundStyle1',
      ],
      swipeUpAction: { shortcut: '#次选上屏' },
      swipeDownAction: { shortcut: '#三选上屏' },
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
      text: '万象',
      normalColor: color[theme]['划动字符颜色'],
      highlightColor: color[theme]['划动字符颜色'],
      fontSize: fontSize['按键前景文字大小'] - 10,
      center: { x: 0.85, y: 0.8 },
    },
    // local srBtn = createButton(
    //   'spaceRight',
    //   if orientation == 'portrait' then
    //     keyboardLayout['竖屏按键尺寸']['spaceRight键size']
    //   else
    //     keyboardLayout['横屏按键尺寸']['spaceRight键size'],
    //   {},
    //   $,
    //   false
    // ),
    // spaceRightButton: srBtn {
    //   foregroundStyle: [
    //     'spaceRightButtonForegroundStyle',
    //     // 'spaceRightButtonForegroundStyle2',
    //   ],
    //   action: {
    //     character: '.',
    //   },
    // },
    spaceRightButton: createButton(
      'spaceRight',
      if orientation == 'portrait' then
        keyboardLayout['竖屏按键尺寸']['spaceRight键size']
      else
        keyboardLayout['横屏按键尺寸']['spaceRight键size'],
      {},
      $,
      false
    ) + {
      backgroundStyle: 'alphabeticBackgroundStyle',
      action: { character: '.' },
      repeatAction: { character: '.' },
      notification: [
        'spaceRightButtonPreeditNotification',
      ],
    },
    spaceRightButtonPreeditNotification: {
      notificationType: 'preeditChanged',
      backgroundStyle: 'alphabeticBackgroundStyle',
      foregroundStyle: 'spaceRightButtonPreeditForegroundStyle',
      action: { sendKeys: 'Break' },
    },
    spaceRightButtonPreeditForegroundStyle: {
      buttonStyleType: 'systemImage',
      systemImageName: 'plus.bubble',
      normalColor: color[theme]['按键前景颜色'],
      highlightColor: color[theme]['按键前景颜色'],
      fontSize: fontSize['按键前景文字大小'],
    },

    spaceRightButtonForegroundStyle: {
      buttonStyleType: 'text',
      text: '。',
      normalColor: color[theme]['按键前景颜色'],
      highlightColor: color[theme]['按键前景颜色'],
      fontSize: fontSize['按键前景文字大小'],
      // center: { x: 0.64, y: 0.45 },
    },
    spaceRightButtonForegroundStyle2: {
      buttonStyleType: 'text',
      text: '。',
      normalColor: color[theme]['按键前景颜色'],
      highlightColor: color[theme]['按键前景颜色'],
      fontSize: fontSize['按键前景文字大小'] - 2,
      // center: { x: 0.6, y: 0.3 },
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
    spaceLeftButton: slBtn {
      foregroundStyle: [
        'spaceLeftButtonForegroundStyle',
        'spaceLeftButtonForegroundStyle2',
      ],
      action: {
        character: ',',
      },
    },
    // spaceLeftButton: createButton(
    //   'spaceLeft',
    //   if orientation == 'portrait' then
    //     keyboardLayout['竖屏按键尺寸']['spaceLeft键size']
    //   else
    //     keyboardLayout['横屏按键尺寸']['spaceLeft键size'],
    //   {},
    //   $,
    //   false
    // ) + {
    //   backgroundStyle: 'alphabeticBackgroundStyle',
    //   action: { character: ',' },
    //   repeatAction: { character: ',' },
    // },

    spaceLeftButtonForegroundStyle: {
      buttonStyleType: 'text',
      text: '，',
      normalColor: color[theme]['按键前景颜色'],
      highlightColor: color[theme]['按键前景颜色'],
      fontSize: fontSize['按键前景文字大小'],
      center: { x: 0.62, y: 0.5 },
    },
    spaceLeftButtonForegroundStyle2: {
      buttonStyleType: 'text',
      text: '。',
      normalColor: color[theme]['按键前景颜色'],
      highlightColor: color[theme]['按键前景颜色'],
      fontSize: fontSize['按键前景文字大小'] - 2,
      center: { x: 0.6, y: 0.3 },
    },

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
      text: '回车',
      normalColor: color[theme]['按键前景颜色'],
      highlightColor: color[theme]['按键前景颜色'],
      fontSize: fontSize['按键前景文字大小'] - 3,
      center: center['功能键前景文字偏移'],
    },
    enterButtonForegroundStyle6: {
      buttonStyleType: 'text',
      text: '搜索',
      normalColor: color[theme]['长按选中字体颜色'],
      highlightColor: color[theme]['长按非选中字体颜色'],
      fontSize: fontSize['按键前景文字大小'] - 3,
      center: center['功能键前景文字偏移'],
    },
    // 白色文字
    enterButtonForegroundStyle7: {
      buttonStyleType: 'text',
      text: '发送',
      normalColor: color[theme]['长按选中字体颜色'],
      highlightColor: color[theme]['长按非选中字体颜色'],
      fontSize: fontSize['按键前景文字大小'] - 3,
      center: center['功能键前景文字偏移'],
    },
    enterButtonForegroundStyle14: {
      buttonStyleType: 'text',
      text: '前往',
      normalColor: color[theme]['长按选中字体颜色'],
      highlightColor: color[theme]['长按非选中字体颜色'],
      fontSize: fontSize['按键前景文字大小'] - 3,
      center: center['功能键前景文字偏移'],
    },
    enterButtonForegroundStyle9: {
      buttonStyleType: 'text',
      text: '完成',
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
      buttonStyleType: 'geometry',
      insets: if orientation == 'portrait' then { top: 5, left: 3, bottom: 5, right: 3 } else { top: 3, left: 2, bottom: 3, right: 2 },
      normalColor: color[theme]['字母键背景颜色-普通'],
      highlightColor: color[theme]['字母键背景颜色-高亮'],
      cornerRadius: 7,
      normalLowerEdgeColor: color[theme]['底边缘颜色-普通'],
      highlightLowerEdgeColor: color[theme]['底边缘颜色-高亮'],
    },
    systemButtonBackgroundStyle: {
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
