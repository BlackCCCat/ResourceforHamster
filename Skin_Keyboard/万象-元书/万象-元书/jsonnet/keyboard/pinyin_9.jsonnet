local deviceType = 'iPhone';
local Settings = import '../custom/Custom.libsonnet';
// Import shared layout libraries
local keyboardLayoutFuncRow = import '../lib/keyboardLayout.libsonnet';
local keyboardLayoutWithoutFuncRow = import '../lib/keyboardLayoutWithoutFuncRow.libsonnet';
local p26 = import 'pinyin_26.jsonnet';

local chooseLayout(selector, theme) =
  if selector then keyboardLayoutFuncRow.getKeyboardLayout(theme)
  else keyboardLayoutWithoutFuncRow.getKeyboardLayout(theme);

local animation = import '../lib/animation.libsonnet';
local center = import '../lib/center.libsonnet';
local collectionData = import '../lib/collectionData.libsonnet';
local color = import '../lib/color.libsonnet';
local fontSize = import '../lib/fontSize.libsonnet';
local hintSymbolsData = import '../lib/hintSymbolsData.libsonnet';
local others = import '../lib/others.libsonnet';
local swipeData = import '../lib/swipeData.libsonnet';
local toolbar = import '../lib/toolbar.libsonnet';
local utils = import '../lib/utils.libsonnet';
local hintSymbolsStyles = import '../lib/hintSymbolsStyles.libsonnet';

local swipeStyles = import '../lib/swipeStyle.libsonnet';

// 123Button的前景
local slideForeground = import '../lib/slideForeground.libsonnet';

// 功能按键
local functions = import '../lib/functionButton.libsonnet';

// 上下和下划的数据

local swipe_up = if std.objectHas(swipeData.genSwipeData(deviceType), 'swipe_up_9') then swipeData.genSwipeData(deviceType).swipe_up_9 else {};
local swipe_down = if std.objectHas(swipeData.genSwipeData(deviceType), 'swipe_down_9') then swipeData.genSwipeData(deviceType).swipe_down_9 else {};

// T9 Mapping
local t9_letters_upper = {
  '2': 'ABC',
  '3': 'DEF',
  '4': 'GHI',
  '5': 'JKL',
  '6': 'MNO',
  '7': 'PQRS',
  '8': 'TUV',
  '9': 'WXYZ',
};

local t9_letters_lower = {
  '2': 'abc',
  '3': 'def',
  '4': 'ghi',
  '5': 'jkl',
  '6': 'mno',
  '7': 'pqrs',
  '8': 'tuv',
  '9': 'wxyz',
};

local t9_letters = if Settings.is_letter_capital then t9_letters_upper else t9_letters_lower;

local swipe_up = if std.objectHas(swipeData.genSwipeData(deviceType), 'swipe_up_9') then swipeData.genSwipeData(deviceType).swipe_up_9 else {};
local swipe_down = if std.objectHas(swipeData.genSwipeData(deviceType), 'swipe_down_9') then swipeData.genSwipeData(deviceType).swipe_down_9 else {};

// Custom button creator
local createButton(key, size, bounds, root, isUpper=true) =
  local styleKey = if std.length(key) == 1 then 'number' + key else key;
  {
  [if size != {} then 'size']: size,
  backgroundStyle: if std.length(key) == 1 then 'numberButtonBackgroundStyle' else key + 'ButtonBackgroundStyle',
  foregroundStyle: std.flattenArrays(std.filter(
    function(x) x != null,
    [
      // Main foreground: Letters only for 2-9 in center, others standard
      if std.length(key) == 1 then
        if std.objectHas(t9_letters, key) then 
           ['number' + key + 'LettersStyle']
        else 
           ['number' + key + 'ButtonForegroundStyle']
      else 
           [key + 'ButtonForegroundStyle'],

      // Swipe hints overlap
      if Settings.show_swipe then
        if std.objectHas(swipe_up, key) then ['number' + key + 'ButtonUpForegroundStyle'] else null
      else null,
      if Settings.show_swipe then
        if std.objectHas(swipe_down, key) then ['number' + key + 'ButtonDownForegroundStyle'] else null
      else null,
    ]
  )),
  hintStyle: styleKey + 'ButtonHintStyle',
  [styleKey + 'ButtonHintStyle']: {
    backgroundStyle: 'alphabeticHintBackgroundStyle',
    foregroundStyle: styleKey + 'ButtonHintForegroundStyle',
    swipeUpForegroundStyle: styleKey + 'ButtonSwipeUpHintForegroundStyle',
    swipeDownForegroundStyle: styleKey + 'ButtonSwipeDownHintForegroundStyle',
  },
  action: {
    character: key,
  },
  animation: [
    'ButtonScaleAnimation',
  ],
  [if std.objectHas(swipe_up, key) then 'swipeUpAction']: swipe_up[key].action,
  [if std.objectHas(swipe_down, key) then 'swipeDownAction']: swipe_down[key].action,
  [if std.objectHas(root, styleKey + 'ButtonHintSymbolsStyle') then 'hintSymbolsStyle']: styleKey + 'ButtonHintSymbolsStyle',
};

// Helper for T9 styles (Layered: Digit + Letters)
local genT9Styles(fontSize, color, theme, center) = {
  // Styles used by createButton
  ['number' + key + 'LettersStyle']: {
    buttonStyleType: 'text',
    text: t9_letters[key],
    normalColor: color[theme]['按键前景颜色'],
    highlightColor: color[theme]['按键前景颜色'],
    fontSize: fontSize['中文九键字符键前景文字大小'], // Use larger size for main letters
    fontWeight: 0,
    center: center['中文九键字符前景偏移'], // Center align
  }
  for key in std.objectFields(t9_letters)
};

local genHintConfig(configs) = {
  foregroundStyle: [
    {
      styleName: 'cn2enButtonHintSymbolsForegroundStyleOf' + c.id,
      conditionKey: c.key,
      conditionValue: c.val,
    }
    for c in configs
  ],
};

local keyboard(theme, orientation) =
  local p26Layout = p26.keyboard(theme, orientation, chooseLayout(Settings.with_functions_row[deviceType], theme));
  slideForeground.slideForeground(theme) +
  hintSymbolsStyles.getStyle(theme, hintSymbolsData.pinyin_9) +
  {
    preeditHeight: others[if orientation == 'portrait' then '竖屏' else '横屏']['preedit高度'],
    toolbarHeight: others[if orientation == 'portrait' then '竖屏' else '横屏']['toolbar高度'],
    keyboardHeight: others[if orientation == 'portrait' then '竖屏' else '横屏']['keyboard高度'],

    // Mixin the selected layout and styles from the library
     } + chooseLayout(Settings.with_functions_row[deviceType], theme)['竖屏中文9键'] + 
      hintSymbolsStyles.getStyle(theme, { [k]: hintSymbolsData.pinyin_9[k] for k in std.objectFields(hintSymbolsData.pinyin_9) if k != 'cn2en' }) +
     swipeStyles.getStyle('number', theme, swipe_up, swipe_down) +
     {

    collection: {
      size: {
        height: '3/4',
      },
      insets: { top: 6, bottom: 6 },
      backgroundStyle: 'collectionBackgroundStyle',
      type: 't9Symbols',
      dataSource: 'symbols',
      cellStyle: 'collectionCellStyle',
    },
    collectionBackgroundStyle: {
      buttonStyleType: 'geometry',
      insets: if orientation == 'portrait' then Settings.button_insets.portrait else Settings.button_insets.landscape,
      normalColor: color[theme]['符号键盘左侧collection背景颜色'],
      cornerRadius: Settings.cornerRadius,
      normalLowerEdgeColor: color[theme]['符号键盘左侧collection背景下边缘颜色'],
    },
    collectionCellStyle: {
      backgroundStyle: 'collectionCellBackgroundStyle',
      foregroundStyle: 'collectionCellForegroundStyle',
    },
    collectionCellBackgroundStyle: {
      buttonStyleType: 'geometry',
      insets: if orientation == 'portrait' then Settings.button_insets.portrait else Settings.button_insets.landscape,
      highlightColor: color[theme]['字母键背景颜色-普通'],
      normalColor: 'ffffff00',
      cornerRadius: Settings.cornerRadius,
    },

    collectionCellForegroundStyle: {
      buttonStyleType: 'text',
      normalColor: color[theme]['collection前景颜色'],
      fontSize: fontSize['collection前景字体大小'],
      fontWeight: 0,
    },
    alphabeticHintSymbolsBackgroundStyle: hintSymbolsStyles['长按背景样式'],
    alphabeticHintSymbolsSelectedStyle: hintSymbolsStyles['长按选中背景样式'],

    createButton(key, size, bounds, root, isUpper=true)::
      local styleKey = if std.length(key) == 1 then 'number' + key else key;
      createButton(key, size, bounds, root, isUpper) + {
        [if std.objectHas(root, styleKey + 'ButtonHintSymbolsStyle') then 'hintSymbolsStyle']: styleKey + 'ButtonHintSymbolsStyle',
      },

    number1Button: $.createButton('1', {}, {}, $, false) + {
       foregroundStyle: std.filter(function(x) x != null, [
         'number1ButtonSpecialForegroundStyle',
         if Settings.show_swipe then (if std.objectHas(swipe_up, '1') then 'number1ButtonUpForegroundStyle' else null) else null,
         if Settings.show_swipe then (if std.objectHas(swipe_down, '1') then 'number1ButtonDownForegroundStyle' else null) else null,
       ]),
       action: {character: '@'},
       notification: 'number1ButtonNotification',
    },
    number1ButtonSpecialForegroundStyle: {
      buttonStyleType: 'text',
      text: '@!:',
      normalColor: color[theme]['按键前景颜色'],
      highlightColor: color[theme]['按键前景颜色'],
      fontSize: fontSize['中文九键字符键前景文字大小'], 
      center: center['中文九键字符前景偏移'],
    },
    number1ButtonNotification: {
      notificationType: 'preeditChanged',
      backgroundStyle: 'alphabeticBackgroundStyle',
      foregroundStyle: 'number1ButtonPreeditForegroundStyle',
      action: {character: "'"},
    },
    number1ButtonPreeditForegroundStyle: {
      buttonStyleType: 'text',
      text: '分词',
      normalColor: color[theme]['按键前景颜色'],
      highlightColor: color[theme]['按键前景颜色'],
      fontSize: fontSize['中文九键字符键前景文字大小'], 
      center: center['中文九键字符前景偏移'],
    },
    // 2-9 buttons are created with T9 style via createButton logic
    number2Button: createButton('2', {}, {}, $, false),
    number3Button: createButton('3', {}, {}, $, false),
    number4Button: createButton('4', {}, {}, $, false),
    number5Button: createButton('5', {}, {}, $, false),
    number6Button: createButton('6', {}, {}, $, false),
    number7Button: createButton('7', {}, {}, $, false),
    number8Button: createButton('8', {}, {}, $, false),
    number9Button: createButton('9', {}, {}, $, false),

    symbolButton: createButton('symbol', chooseLayout(Settings.with_functions_row[deviceType], theme)['竖屏中文9键']['竖屏按键尺寸']['symbolButton'], {}, $, false) +{
      backgroundStyle: 'systemButtonBackgroundStyle',
      type: 'horizontalSymbols',
      maxColumns: 1,
      insets: { left: 3, right: 3 },
      contentRightToLeft: false,
      dataSource: 'symbolButtonSymbolsDataSource',
    },
    symbolButtonSymbolsDataSource: [
      { label: '1', action: { keyboardType: 'symbolic' }, styleName: 'symbolicStyle' },
      { label: '3', action: { keyboardType: 'emojis' }, styleName: 'emojisStyle' },
    ],
    // symbolButton: createButton('symbol', chooseLayout(Settings.with_functions_row[deviceType], theme)['竖屏中文9键']['竖屏按键尺寸']['symbolButton'], {}, $, false) + {
    //   backgroundStyle: 'systemButtonBackgroundStyle',
    //   foregroundStyle: 'symbolButtonForegroundStyle',
    //   action: { keyboardType: 'symbolic' },
    // },
    // symbolButtonForegroundStyle: {
    //   buttonStyleType: 'systemImage',
    //   systemImageName: 'command.circle.fill',
    //   normalColor: color[theme]['按键前景颜色'],
    //   highlightColor: color[theme]['按键前景颜色'],
    //   fontSize: fontSize['按键前景文字大小'] - 3,
    //   center: center['功能键前景文字偏移'] { y: 0.5 },
    // },

    '123Button': createButton('123', chooseLayout(Settings.with_functions_row[deviceType], theme)['竖屏中文9键']['竖屏按键尺寸']['123Button'], {}, $, false) + {
      backgroundStyle: 'systemButtonBackgroundStyle',
      foregroundStyle: '123ButtonForegroundStyle',
      action: { keyboardType: 'numeric' },
    },
    '123ButtonForegroundStyle': {
      buttonStyleType: 'systemImage',
      systemImageName: if Settings.fix_sf_symbol then 'textformat.123' else 'numbers',
      normalColor: color[theme]['按键前景颜色'],
      highlightColor: color[theme]['按键前景颜色'],
      fontSize: fontSize['按键前景文字大小'] - 3,
      center: center['功能键前景文字偏移'] { y: 0.5 },
    },
    emojiButton: createButton('emoji', chooseLayout(Settings.with_functions_row[deviceType], theme)['竖屏中文9键']['竖屏按键尺寸']['emojiButton'], {}, $, false) + {
      backgroundStyle: 'systemButtonBackgroundStyle',
      foregroundStyle: 'emojiButtonForegroundStyle',
      action: { keyboardType: 'emojis' },
    },
    emojiButtonForegroundStyle: {
      buttonStyleType: 'systemImage',
      systemImageName: 'face.smiling',
      normalColor: color[theme]['按键前景颜色'],
      highlightColor: color[theme]['按键前景颜色'],
      fontSize: fontSize['按键前景文字大小'] - 3,
      center: center['功能键前景文字偏移'] { y: 0.5 },
    },

    cn2enButton: p26Layout.cn2enButton,
    cn2enButtonForegroundStyle: p26Layout.cn2enButtonForegroundStyle,
    cn2enButtonHintSymbolsStyle: super['cn2enButtonHintSymbolsStyle'] + {
      symbolStyles: [
        'cn2enButtonHintSymbolsStyleOf0',
        'cn2enButtonHintSymbolsStyleOf4',
        'cn2enButtonHintSymbolsStyleOf6',
      ],
    },
    cn2enButtonHintSymbolsStyleOf0: p26Layout.cn2enButtonHintSymbolsStyleOf0,
    cn2enButtonHintSymbolsStyleOf4: p26Layout.cn2enButtonHintSymbolsStyleOf4,
    cn2enButtonHintSymbolsStyleOf6: p26Layout.cn2enButtonHintSymbolsStyleOf6,



    spaceRightButtonPreeditNotification: {
      notificationType: 'preeditChanged',
      backgroundStyle: 'alphabeticBackgroundStyle',
      foregroundStyle: 'spaceRightButtonPreeditForegroundStyle',
      action: Settings.tips_button_action,
      hintSymbolsStyle: 'cn2enButtonHintSymbolsStyle',  // 预编辑通知的长按菜单复用普通状态的长按菜单
    },

    spaceRightButtonPreeditForegroundStyle: {
      buttonStyleType: 'systemImage',
      systemImageName: 'plus.bubble',
      normalColor: color[theme]['按键前景颜色'],
      highlightColor: color[theme]['按键前景颜色'],
      fontSize: fontSize['按键前景文字大小'],
    },

    cleanButton: createButton('clean', chooseLayout(Settings.with_functions_row[deviceType], theme)['竖屏中文9键']['竖屏按键尺寸']['cleanButton'], {}, $, false) + {
       backgroundStyle: 'systemButtonBackgroundStyle',
       action: { shortcut: '#换行' },
       notification: [
        'cleanButtonPreeditNotification',
       ],
    },
    cleanButtonForegroundStyle: {
       buttonStyleType: 'text',
       text: '换行',
       normalColor: color[theme]['按键前景颜色'],
       highlightColor: color[theme]['按键前景颜色'],
       fontSize: fontSize['按键前景文字大小'] - 3,
    },
    cleanButtonPreeditNotification: {
      notificationType: 'preeditChanged',
      backgroundStyle: 'systemButtonBackgroundStyle',
      foregroundStyle: 'cleanButtonPreeditForegroundStyle',
      action: if Settings.with_functions_row[deviceType] then {  shortcut: '#重输' } else {  shortcut: '#rimeNextPage' },
      [if Settings.with_functions_row[deviceType] then null else 'swipeUpAction']: { shortcut: '#rimePreviousPage' },
      [if Settings.with_functions_row[deviceType] then null else 'swipeDownAction']: { shortcut: '#rimeNextPage' },
    },
    cleanButtonPreeditForegroundStyle: if Settings.with_functions_row[deviceType] 
    then 
    {
      buttonStyleType: 'text',
      text: '重输',
      normalColor: color[theme]['按键前景颜色'],
      highlightColor: color[theme]['按键前景颜色'],
      fontSize: fontSize['按键前景文字大小'] - 3,
    } else 
    {
        buttonStyleType: 'systemImage',
        systemImageName: if Settings.fix_sf_symbol then 'arrow.up.arrow.down' else 'chevron.compact.up.chevron.compact.down',
        normalColor: color[theme]['按键前景颜色'],
        highlightColor: color[theme]['按键前景颜色'],
        fontSize: fontSize['数字键盘数字前景字体大小'],
    },

    spaceButton: p26Layout.spaceButton + {
        size: chooseLayout(Settings.with_functions_row[deviceType], theme)['竖屏中文9键']['竖屏按键尺寸']['spaceButton'],
        [if std.objectHas(swipe_up, 'space') then 'swipeUpAction']: swipe_up['space'].action,
    },
    spaceButtonForegroundStyle: p26Layout.spaceButtonForegroundStyle,
    spaceButtonForegroundStyle1: if std.objectHas(p26Layout, 'spaceButtonForegroundStyle1') then p26Layout.spaceButtonForegroundStyle1 else {},
    spaceButtonPreeditNotification: p26Layout.spaceButtonPreeditNotification,

    backspaceButton: createButton(
      'backspace', chooseLayout(Settings.with_functions_row[deviceType], theme)['竖屏中文9键']['竖屏按键尺寸']['backspaceButton'], {}, $, false
    ) + {
      backgroundStyle: 'systemButtonBackgroundStyle',
      action: 'backspace',
      repeatAction: 'backspace',
      swipeUpAction: { shortcut: '#deleteText' },
      swipeDownAction: { shortcut: '#undo' },
    },
    backspaceButtonForegroundStyle: {
      buttonStyleType: 'systemImage',
      systemImageName: 'delete.left',
      normalColor: color[theme]['按键前景颜色'],
      highlightColor: color[theme]['按键前景颜色'],
      fontSize: fontSize['数字键盘数字前景字体大小'] - 3,
    },


    enterButton: createButton(
      'enter', chooseLayout(Settings.with_functions_row[deviceType], theme)['竖屏中文9键']['竖屏按键尺寸']['enterButton'], {}, $, false
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
    },
    enterButtonForegroundStyle0: {
      buttonStyleType: 'text',
      text: '回车',
      insets: { top: 4, left: 3, bottom: 4, right: 3 },
      normalColor: color[theme]['按键前景颜色'],
      highlightColor: color[theme]['按键前景颜色'],
      fontSize: fontSize['按键前景文字大小'] - 3,
      center: center['功能键前景文字偏移'],
    },
    enterButtonForegroundStyle6: {
      buttonStyleType: 'text',
      text: '搜索',
      insets: { top: 4, left: 3, bottom: 4, right: 3 },
      normalColor: color[theme]['长按选中字体颜色'],
      highlightColor: color[theme]['长按非选中字体颜色'],
      fontSize: fontSize['按键前景文字大小'] - 3,
      center: center['功能键前景文字偏移'],
    },
    enterButtonForegroundStyle7: {
      buttonStyleType: 'text',
      text: '发送',
      insets: { top: 4, left: 3, bottom: 4, right: 3 },
      normalColor: color[theme]['长按选中字体颜色'],
      highlightColor: color[theme]['长按非选中字体颜色'],
      fontSize: fontSize['按键前景文字大小'] - 3,
      center: center['功能键前景文字偏移'],
    },
    enterButtonForegroundStyle14: {
      buttonStyleType: 'text',
      text: '前往',
      insets: { top: 4, left: 3, bottom: 4, right: 3 },
      normalColor: color[theme]['长按选中字体颜色'],
      highlightColor: color[theme]['长按非选中字体颜色'],
      fontSize: fontSize['按键前景文字大小'] - 3,
      center: center['功能键前景文字偏移'],
    },
    enterButtonForegroundStyle9: {
      buttonStyleType: 'text',
      text: '完成',
      insets: { top: 4, left: 3, bottom: 4, right: 3 },
      normalColor: color[theme]['长按选中字体颜色'],
      highlightColor: color[theme]['长按非选中字体颜色'],
      fontSize: fontSize['按键前景文字大小'] - 3,
      center: center['功能键前景文字偏移'],
    },
    enterButtonBlueBackgroundStyle: {
      buttonStyleType: 'geometry',
      insets: if orientation == 'portrait' then Settings.button_insets.portrait else Settings.button_insets.landscape,
      normalColor: color[theme]['enter键背景(蓝色)'],
      highlightColor: color[theme]['功能键背景颜色-高亮'],
      cornerRadius: Settings.cornerRadius,
      normalLowerEdgeColor: color[theme]['底边缘颜色-普通'],
      highlightLowerEdgeColor: color[theme]['底边缘颜色-高亮'],
    },

    numberButtonBackgroundStyle: {
      buttonStyleType: 'geometry',
      insets: if orientation == 'portrait' then Settings.button_insets.portrait else Settings.button_insets.landscape,
      normalColor: color[theme]['字母键背景颜色-普通'],
      highlightColor: color[theme]['字母键背景颜色-高亮'],
      cornerRadius: Settings.cornerRadius,
      normalLowerEdgeColor: color[theme]['底边缘颜色-普通'],
      highlightLowerEdgeColor: color[theme]['底边缘颜色-高亮'],
    },

    functionBackgroundStyle: {
      buttonStyleType: 'geometry',
      insets: if orientation == 'portrait' then Settings.button_insets.portrait else Settings.button_insets.landscape,
      normalColor: color[theme]['字母键背景颜色-普通'],
      highlightColor: color[theme]['字母键背景颜色-高亮'],
      cornerRadius: Settings.cornerRadius,
      normalLowerEdgeColor: color[theme]['底边缘颜色-普通'],
      highlightLowerEdgeColor: color[theme]['底边缘颜色-高亮'],
    },
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

    ButtonScaleAnimation: animation['26键按键动画'],
    symbols: [
        { label: ',', action: { character: ',' } },
        { label: '.', action: { character: '.' } },
        { label: '?', action: { character: '?' } },
        { label: '!', action: { character: '!' } },
        { label: '@', action: { character: '@' } },
    ],
  } + genT9Styles(fontSize, color, theme, center);

{
  new(theme, orientation)::
    keyboard(theme, orientation) +
    toolbar.getToolBar(theme) +
    utils.genNumberStyles(fontSize, color, theme, center) +
    utils.genFuncKeyStyles(fontSize, color, theme, center) +
    functions.makeFunctionButtons(orientation, {}, 'numeric')
  ,
}
