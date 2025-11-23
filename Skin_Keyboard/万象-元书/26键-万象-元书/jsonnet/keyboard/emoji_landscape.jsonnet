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

local emoji_portrait = import 'emoji_portrait.jsonnet';
local numeric_9_portrit = import 'numeric_9_portrait.jsonnet';

// 123Button的划动前景
local slideForeground = import '../lib/slideForeground.libsonnet';

// 上下和下划的数据
local swipe_up = if std.objectHas(swipeData, 'number_swipe_up') then swipeData.number_swipe_up else {};
local swipe_down = if std.objectHas(swipeData, 'number_swipe_up') then swipeData.number_swipe_down else {};


local createButton(key, size, bounds, root) = {
  [if size != {} then 'size']: size,
  backgroundStyle: if std.length(key) == 1 then 'numberButtonBackgroundStyle' else key + 'ButtonBackgroundStyle',
  foregroundStyle: std.filter(
    function(x) x != null,
    [
      if std.length(key) == 1 then 'number' + key + 'ButtonForegroundStyle' else key + 'ButtonForegroundStyle',
      if std.objectHas(swipe_up, key) then 'number' + key + 'ButtonUpForegroundStyle' else null,
      if std.objectHas(swipe_down, key) then 'number' + key + 'ButtonDownForegroundStyle' else null,
    ]
  ),
  action: {
    character: key,
  },
  [if std.objectHas(swipe_up, key) then 'swipeUpAction']: swipe_up[key].action,
  [if std.objectHas(swipe_down, key) then 'swipeDownAction']: swipe_down[key].action,
  [if std.objectHas(root, 'number' + key + 'ButtonHintSymbolsStyle') then 'hintSymbolsStyle']: 'number' + key + 'ButtonHintSymbolsStyle',
};

local keyboard(theme) =
  swipeStyles.getStyle('number', theme, swipe_up, swipe_down) +
  hintSymbolsStyles.getStyle(theme, hintSymbolsData.number) +
  toolbar.getToolBar(theme) +
  utils.genNumberStyles(fontSize, color, theme, center) +
  utils.genFuncKeyStyles(fontSize, color, theme, center) +
  slideForeground.slideForeground(theme) +
  {
    [if std.objectHas(others, '中文键盘方案') then 'rimeSchema']: others['中文键盘方案'],
    preeditHeight: others['横屏']['preedit高度'],
    toolbarHeight: others['横屏']['toolbar高度'],
    keyboardHeight: others['横屏']['keyboard高度'],
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
    keyboardLayout: [
      {
        VStack: {
          style: 'columnStyle3',
          subviews: [
            {
              HStack: {
                style: 'rowofFunctionStyle',
                subviews: [
                  { Cell: 'leftButton' },
                  { Cell: 'headButton' },
                  { Cell: 'selectButton' },
                  { Cell: 'cutButton' },
                ],
              },
            },
            {
              HStack: {
                style: 'HStackStyle1',
                subviews: [
                  {
                    Cell: 'categoryCollection',
                  },
                  {
                    Cell: 'descriptionCollection',
                  },
                ],
              },
            },
          ],
        },
      },
      {
        VStack: {
          style: 'columnStyle2',
        },
      },
      {
        VStack: {
          style: 'columnStyle1',
          subviews: [
            {
              HStack: {
                style: 'rowofFunctionStyle',
                subviews: [
                  { Cell: 'copyButton' },
                  { Cell: 'pasteButton' },
                  { Cell: 'tailButton' },
                  { Cell: 'rightButton' },
                ],
              },
            },
            {
              HStack: {
                style: 'keyboardStyle',
                subviews: [
                  {
                    VStack: {
                      style: 'VStackStyle1',
                      subviews: [
                        { Cell: 'collection' },
                        { Cell: 'returnButton' },
                      ],
                    },
                  },
                  {
                    VStack: {
                      style: 'VStackStyle2',
                      subviews: [
                        { Cell: 'number1Button' },
                        { Cell: 'number4Button' },
                        { Cell: 'number7Button' },
                        { Cell: 'symbolButton' },
                      ],
                    },
                  },
                  {
                    VStack: {
                      style: 'VStackStyle2',
                      subviews: [
                        { Cell: 'number2Button' },
                        { Cell: 'number5Button' },
                        { Cell: 'number8Button' },
                        { Cell: 'number0Button' },
                      ],
                    },
                  },
                  {
                    VStack: {
                      style: 'VStackStyle2',
                      subviews: [
                        { Cell: 'number3Button' },
                        { Cell: 'number6Button' },
                        { Cell: 'number9Button' },
                        { Cell: 'spaceButton' },
                      ],
                    },
                  },
                  {
                    VStack: {
                      style: 'VStackStyle1',
                      subviews: [
                        { Cell: 'backspaceButton' },
                        { Cell: 'spaceRightButton' },
                        { Cell: 'atButton' },
                        { Cell: 'enterButton' },
                      ],
                    },
                  },
                ],
              },
            },
          ],
        },
      },
    ],
    rowofFunctionStyle: {
      size: {
        height: 30,
      },
      backgroundStyle: 'keyboardBackgroundStyle',
    },
    keyboardStyle: {
      insets: {
        top: 3,
        bottom: 3,
        left: 4,
        right: 4,
      },
      backgroundStyle: 'keyboardBackgroundStyle',
    },
    keyboardBackgroundStyle: {
      buttonStyleType: 'geometry',
      normalColor: color[theme]['键盘背景颜色'],

    },
    columnStyle1: {
      size: {
        width: '9/20',
      },
    },
    columnStyle2: {
      size: {
        width: '2/20',
      },
    },
    columnStyle3: {
      size: {
        width: '9/20',
      },
    },
    HStackStyle1: {
      size: {
        height: '227/281',
      },
    },
    HStackStyle2: {
      size: {
        height: '54/281',
      },
    },
    VStackStyle1: {
      size: {
        width: '29/183',
      },
    },
    VStackStyle2: {
      size: {
        width: '125/549',
      },
    },
    collection: {
      size: {
        height: '3/4',
      },
      insets: { top: 6, bottom: 6 },
      backgroundStyle: 'collectionBackgroundStyle',
      type: 'symbols',
      dataSource: 'symbols',
      cellStyle: 'collectionCellStyle',
      useRimeEngine: true,
    },
    collectionBackgroundStyle: {
      buttonStyleType: 'geometry',
      insets: { top: 3, left: 2, bottom: 3, right: 2 },  //{ top: 5, left: 3, bottom: 5, right: 3 },
      normalColor: color[theme]['符号键盘左侧collection背景颜色'],
      cornerRadius: 7,
      normalLowerEdgeColor: color[theme]['符号键盘左侧collection背景下边缘颜色'],
    },

    collectionCellStyle: {
      backgroundStyle: 'collectionCellBackgroundStyle',
      foregroundStyle: 'collectionCellForegroundStyle',
    },
    collectionCellBackgroundStyle: {
      buttonStyleType: 'geometry',
      insets: { top: 3, left: 2, bottom: 3, right: 2 },  //{ top: 6, left: 3, bottom: 6, right: 3 },
      highlightColor: 'ffffff',
      normalColor: 'ffffff00',
      cornerRadius: 7,
    },
    collectionCellForegroundStyle: {
      buttonStyleType: 'text',
      normalColor: color[theme]['collection前景颜色'],
      fontSize: fontSize['collection前景字体大小'],
      fontWeight: 0,
    },
    returnButton: createButton(
      'return', {}, {}, $
    ) + {
      backgroundStyle: 'systemButtonBackgroundStyle',
      action: 'returnPrimaryKeyboard',
    },

    returnButtonForegroundStyle: {
      buttonStyleType: 'text',
      text: '返回',
      normalColor: color[theme]['按键前景颜色'],
      highlightColor: color[theme]['按键前景颜色'],
      fontSize: fontSize['按键前景文字大小'] - 3,
      // center: center['26键中文前景偏移'],
    },


    leftButton: createButton(
      'left',
      {},
      {},
      $
    ) + {
      action: 'moveCursorBackward',
      repeatAction: 'moveCursorBackward',
      swipeDownAction: { character: '[' },
      backgroundStyle: 'functionBackgroundStyle',
      notification: [
        'leftButtonPreeditNotification',
      ],
    },
    leftButtonPreeditNotification: {
      notificationType: 'preeditChanged',
      backgroundStyle: 'functionBackgroundStyle',
      foregroundStyle: 'leftButtonPreeditForegroundStyle',
      action: { sendKeys: 'Up' },
    },

    headButton: createButton(
      'head',
      {},
      {},
      $
    ) + {
      action: { shortcut: '#行首' },
      backgroundStyle: 'functionBackgroundStyle',
    },


    cutButton: createButton(
      'cut',
      {},
      {},
      $
    ) + {
      action: { shortcut: '#cut' },
      backgroundStyle: 'functionBackgroundStyle',
    },


    copyButton: createButton(
      'copy',
      {},
      {},
      $
    ) + {
      action: { shortcut: '#copy' },
      backgroundStyle: 'functionBackgroundStyle',
    },

    pasteButton: createButton(
      'paste',
      {},
      {},
      $
    ) + {
      action: { shortcut: '#paste' },
      backgroundStyle: 'functionBackgroundStyle',
    },

    selectButton: createButton(
      'select',
      {},
      {},
      $
    ) + {
      action: { shortcut: '#selectText' },
      backgroundStyle: 'functionBackgroundStyle',
    },


    tailButton: createButton(
      'tail',
      {},
      {},
      $
    ) + {
      action: { shortcut: '#行尾' },
      backgroundStyle: 'functionBackgroundStyle',
    },

    rightButton: createButton(
      'right',
      {},
      {},
      $
    ) + {
      action: 'moveCursorForward',
      repeatAction: 'moveCursorForward',
      swipeDownAction: { character: ']' },
      backgroundStyle: 'functionBackgroundStyle',
      notification: [
        'rightButtonPreeditNotification',
      ],
    },
    rightButtonPreeditNotification: {
      notificationType: 'preeditChanged',
      backgroundStyle: 'functionBackgroundStyle',
      foregroundStyle: 'rightButtonPreeditForegroundStyle',
      action: { sendKeys: 'Down' },
    },

    number1Button: createButton(
      '1',
      {},
      {},
      $
    ),

    number4Button: createButton(
      '4',
      {},
      {},
      $
    ),

    number7Button: createButton(
      '7',
      {},
      {},
      $
    ),

    symbolButton: {
      size: {
        height: '1/4',
      },
      backgroundStyle: 'systemButtonBackgroundStyle',
      type: 'horizontalSymbols',
      maxColumns: 1,
      insets: { left: 3, right: 3 },
      contentRightToLeft: false,
      dataSource: 'symbolButtonSymbolsDataSource',
    },

    symbolButtonSymbolsDataSource: [
      { label: '1', action: { keyboardType: 'symbolic' }, styleName: 'symbolicStyle' },
      { label: '2', action: { keyboardType: 'emoji' }, styleName: 'emojiStyle' },
      { label: '3', action: { keyboardType: 'emojis' }, styleName: 'emojisStyle' },
    ],

    number2Button: createButton('2', {}, {}, $),

    number5Button: createButton('5', {}, {}, $),

    number8Button: createButton('8', {}, {}, $),


    number0Button: createButton('0', {}, {}, $),


    number3Button: createButton('3', {}, {}, $),

    number6Button: createButton('6', {}, {}, $),

    number9Button: createButton('9', {}, {}, $),

    spaceButton: createButton(
      'space', {}, {}, $
    ) + {
      backgroundStyle: 'systemButtonBackgroundStyle',
      action: 'space',
      swipeUpAction: { shortcut: '#次选上屏' },
    },

    spaceButtonForegroundStyle: {
      buttonStyleType: 'systemImage',
      systemImageName: 'space',
      normalColor: color[theme]['按键前景颜色'],
      highlightColor: color[theme]['按键前景颜色'],
      fontSize: fontSize['按键前景文字大小'] - 3,
      // center: center['功能键前景文字偏移'],
    },
    backspaceButton: createButton(
      'backspace', {}, {}, $
    ) + {
      backgroundStyle: 'systemButtonBackgroundStyle',
      action: 'backspace',
      repeatAction: 'backspace',
      swipeUpAction: { shortcut: '#deleteText' },
    },

    backspaceButtonForegroundStyle: {
      buttonStyleType: 'systemImage',
      systemImageName: 'delete.left',
      normalColor: color[theme]['按键前景颜色'],
      highlightColor: color[theme]['按键前景颜色'],
      fontSize: fontSize['数字键盘数字前景字体大小'] - 3,
      // center: { y: 0.53 },
    },
    spaceRightButton: createButton(
      'spaceRight', {}, {}, $
    ) + {
      backgroundStyle: 'systemButtonBackgroundStyle',
      action: {
        character: '.',
      },
    },

    spaceRightButtonForegroundStyle: {
      buttonStyleType: 'text',
      text: '.',
      normalColor: color[theme]['按键前景颜色'],
      highlightColor: color[theme]['按键前景颜色'],
      fontSize: fontSize['数字键盘数字前景字体大小'],
      // center: {
      //   x: 0.5,
      //   y: 0.8,
      // },
    },
    atButton: createButton(
      'at', {}, {}, $
    ) + {
      backgroundStyle: 'systemButtonBackgroundStyle',
      action: {
        character: '=',
      },
      swipeUpAction: { character: 'V' },
    },

    atButtonForegroundStyle: {
      buttonStyleType: 'text',
      text: '=',
      normalColor: color[theme]['按键前景颜色'],
      highlightColor: color[theme]['按键前景颜色'],
      fontSize: fontSize['collection前景字体大小'],
      fontWeight: 0,
      // center: {
      //   x: 0.5,
      //   y: 0.8,
      // },
    },
    enterButton: createButton(
      'enter', {}, {}, $
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
    enterButtonForegroundStyle: {
      buttonStyleType: 'text',
      text: '换行',
      insets: { top: 3, left: 2, bottom: 3, right: 2 },
      normalColor: color[theme]['按键前景颜色'],
      highlightColor: color[theme]['按键前景颜色'],
      fontSize: fontSize['按键前景文字大小'] - 3,
      // center: center['功能键前景文字偏移'],
    },

    enterButtonForegroundStyle0: {
      buttonStyleType: 'text',
      text: '回车',
      insets: { top: 3, left: 2, bottom: 3, right: 2 },
      normalColor: color[theme]['按键前景颜色'],
      highlightColor: color[theme]['按键前景颜色'],
      fontSize: fontSize['按键前景文字大小'] - 3,
      center: center['功能键前景文字偏移'],
    },
    enterButtonForegroundStyle6: {
      buttonStyleType: 'text',
      text: '搜索',
      insets: { top: 3, left: 2, bottom: 3, right: 2 },
      normalColor: color[theme]['长按选中字体颜色'],
      highlightColor: color[theme]['长按非选中字体颜色'],
      fontSize: fontSize['按键前景文字大小'] - 3,
      center: center['功能键前景文字偏移'],
    },
    // 白色文字
    enterButtonForegroundStyle7: {
      buttonStyleType: 'text',
      text: '发送',
      insets: { top: 3, left: 2, bottom: 3, right: 2 },
      normalColor: color[theme]['长按选中字体颜色'],
      highlightColor: color[theme]['长按非选中字体颜色'],
      fontSize: fontSize['按键前景文字大小'] - 3,
      center: center['功能键前景文字偏移'],
    },
    enterButtonForegroundStyle14: {
      buttonStyleType: 'text',
      text: '前往',
      insets: { top: 3, left: 2, bottom: 3, right: 2 },
      normalColor: color[theme]['长按选中字体颜色'],
      highlightColor: color[theme]['长按非选中字体颜色'],
      fontSize: fontSize['按键前景文字大小'] - 3,
      center: center['功能键前景文字偏移'],
    },
    enterButtonForegroundStyle9: {
      buttonStyleType: 'text',
      text: '完成',
      insets: { top: 3, left: 2, bottom: 3, right: 2 },
      normalColor: color[theme]['长按选中字体颜色'],
      highlightColor: color[theme]['长按非选中字体颜色'],
      fontSize: fontSize['按键前景文字大小'] - 3,
      center: center['功能键前景文字偏移'],
    },

    enterButtonBlueBackgroundStyle: {
      buttonStyleType: 'geometry',
      insets: { top: 3, left: 2, bottom: 3, right: 2 },
      normalColor: color[theme]['enter键背景(蓝色)'],
      highlightColor: color[theme]['功能键背景颜色-高亮'],
      cornerRadius: 7,
      normalLowerEdgeColor: color[theme]['底边缘颜色-普通'],
      highlightLowerEdgeColor: color[theme]['底边缘颜色-高亮'],
    },

    numberButtonBackgroundStyle: {
      buttonStyleType: 'geometry',
      insets: { top: 3, left: 2, bottom: 3, right: 2 },  //{ top: 4, left: 3, bottom: 4, right: 3 },
      normalColor: color[theme]['字母键背景颜色-普通'],
      highlightColor: color[theme]['字母键背景颜色-高亮'],
      cornerRadius: 7,
      normalLowerEdgeColor: color[theme]['底边缘颜色-普通'],
      highlightLowerEdgeColor: color[theme]['底边缘颜色-高亮'],
    },
    functionBackgroundStyle: {
      buttonStyleType: 'geometry',
      insets: { top: 3, left: 2, bottom: 3, right: 2 },  //{ top: 3, left: 2, bottom: 3, right: 2 },
      normalColor: color[theme]['字母键背景颜色-普通'],
      highlightColor: color[theme]['字母键背景颜色-高亮'],
      cornerRadius: 7,
      normalLowerEdgeColor: color[theme]['底边缘颜色-普通'],
      highlightLowerEdgeColor: color[theme]['底边缘颜色-高亮'],
    },
    systemButtonBackgroundStyle: {
      buttonStyleType: 'geometry',
      insets: { top: 3, left: 2, bottom: 3, right: 2 },  //{ top: 4, left: 3, bottom: 4, right: 3 },
      normalColor: color[theme]['功能键背景颜色-普通'],
      highlightColor: color[theme]['功能键背景颜色-高亮'],
      cornerRadius: 7,
      normalLowerEdgeColor: color[theme]['底边缘颜色-普通'],
      highlightLowerEdgeColor: color[theme]['底边缘颜色-高亮'],
    },
    ButtonScaleAnimation: animation['26键按键动画'],
    categoryCollection: {
      size: {
        width: '56/375',
      },
      insets: { top: 6, bottom: 6 },
      backgroundStyle: 'listBackgroundStyle',
      type: 'classifiedSymbols',
      dataSource: 'category',
      cellStyle: 'symbolcollectionCellStyle',
    },
    listBackgroundStyle: {
      buttonStyleType: 'geometry',
      insets: { top: 3, left: 2, bottom: 3, right: 2 },  //{ top: 5, left: 3, bottom: 5, right: 3 },
      normalColor: color[theme]['符号键盘左侧collection背景颜色'],
      cornerRadius: 7,
      normalShadowColor: color[theme]['符号键盘左侧collection背景下边缘颜色'],
      normalLowerEdgeColor: color[theme]['符号键盘左侧collection背景下边缘颜色'],
    },
    symbolcollectionCellStyle: {
      backgroundStyle: 'symbolcollectionCellBackgroundStyle',
      foregroundStyle: 'symbolcollectionCellForegroundStyle',
    },
    symbolcollectionCellBackgroundStyle: {
      buttonStyleType: 'geometry',
      insets: { top: 3, left: 2, bottom: 3, right: 2 },  //{ top: 4, bottom: 4, left: 5, right: 5 },
      normalColor: '00000000',
      highlightColor: color[theme]['字母键背景颜色-普通'],
      cornerRadius: 7,
    },
    symbolcollectionCellForegroundStyle: {
      buttonStyleType: 'text',
      normalColor: color[theme]['列表未选中字体颜色'],
      highlightColor: color[theme]['列表选中字体颜色'],
      fontSize: fontSize['符号键盘左侧collection前景字体大小'],
      fontWeight: 0,
    },
    descriptionCollection: {
      size: {
        width: '319/375',
      },
      insets: { top: 6, bottom: 6 },
      backgroundStyle: 'descriptionCollectionBackgroundStyle',
      type: 'subClassifiedSymbols',
      cellStyle: 'descriptionCollectionCellStyle',
    },
    descriptionCollectionBackgroundStyle: {
      buttonStyleType: 'geometry',
      insets: { top: 3, left: 2, bottom: 3, right: 2 },  //{ top: 5, left: 5, bottom: 5, right: 5 },
      normalColor: color[theme]['符号键盘右侧collection背景颜色'],
      cornerRadius: 12,
      normalLowerEdgeColor: color[theme]['符号键盘右侧collection背景下边缘颜色'],
    },
    descriptionCollectionCellStyle: {
      backgroundStyle: 'symbolcollectionCellBackgroundStyle',
      foregroundStyle: 'descriptionCollectionCellForegroundStyle',
    },
    descriptionCollectionCellForegroundStyle: {
      buttonStyleType: 'text',
      normalColor: color[theme]['列表未选中字体颜色'],
      highlightColor: color[theme]['列表选中字体颜色'],
      fontSize: fontSize['符号键盘右侧collection前景字体大小'],
      fontWeight: 0,
    },
    symbolreturnButton: {
      size: {
        width: '56/375',
      },
      backgroundStyle: 'systemButtonBackgroundStyle',
      foregroundStyle: [
        'symbolreturnButtonForegroundStyle',
      ],
      action: 'returnPrimaryKeyboard',
    },

    symbolreturnButtonForegroundStyle: {
      text: '返回',
      normalColor: color[theme]['按键前景颜色'],
      highlightColor: color[theme]['按键前景颜色'],
      fontSize: fontSize['按键前景文字大小'] - 3,
      // center: center['26键中文前景偏移'],
    },
    pageUpButton: {
      size: {
        width: '87/375',
      },
      backgroundStyle: 'systemButtonBackgroundStyle',
      foregroundStyle: 'pageUpButtonForegroundStyle',
      action: 'pageUp',
    },
    pageUpButtonForegroundStyle: {
      buttonStyleType: 'systemImage',
      systemImageName: 'chevron.up',
      normalColor: color[theme]['按键前景颜色'],
      highlightColor: color[theme]['按键前景颜色'],
      fontSize: fontSize['数字键盘数字前景字体大小'] - 3,
      // center: { y: 0.53 },
    },
    pageDownButton: {
      size: {
        width: '87/375',
      },
      backgroundStyle: 'systemButtonBackgroundStyle',
      foregroundStyle: 'pageDownButtonForegroundStyle',
      action: 'pageDown',
    },
    pageDownButtonForegroundStyle: {
      buttonStyleType: 'systemImage',
      systemImageName: 'chevron.down',
      normalColor: color[theme]['按键前景颜色'],
      highlightColor: color[theme]['按键前景颜色'],
      fontSize: fontSize['数字键盘数字前景字体大小'] - 3,
      // center: { y: 0.53 },
    },
    lockButton: {
      size: {
        width: '87/375',
      },
      backgroundStyle: 'systemButtonBackgroundStyle',
      foregroundStyle: [
        {
          styleName: 'unlockButtonForegroundStyle',
          conditionKey: '$symbolicKeyboardLockState',
          conditionValue: false,
        },
        {
          styleName: 'lockButtonForegroundStyle',
          conditionKey: '$symbolicKeyboardLockState',
          conditionValue: true,
        },
      ],
      action: 'symbolicKeyboardLockStateToggle',
    },

    lockButtonForegroundStyle: {
      buttonStyleType: 'systemImage',
      systemImageName: 'lock',
      normalColor: color[theme]['按键前景颜色'],
      highlightColor: color[theme]['按键前景颜色'],
      fontSize: fontSize['按键前景sf符号大小'],
      targetScale: 0.6,
    },
    unlockButtonForegroundStyle: {
      buttonStyleType: 'systemImage',
      systemImageName: 'lock.open',
      normalColor: color[theme]['按键前景颜色'],
      highlightColor: color[theme]['按键前景颜色'],
      fontSize: fontSize['按键前景sf符号大小'],
      targetScale: 0.6,
    },
    symbolbackspaceButton: {
      size: {
        width: '60/375',
      },
      backgroundStyle: 'backspaceButtonBackgroundStyle',
      foregroundStyle: [
        'symbolbackspaceButtonForegroundStyle',
      ],
      action: 'backspace',
      repeatAction: 'backspace',
    },

    symbolbackspaceButtonForegroundStyle: {
      buttonStyleType: 'systemImage',
      systemImageName: 'delete.left',
      normalColor: color[theme]['按键前景颜色'],
      highlightColor: color[theme]['按键前景颜色'],
      fontSize: fontSize['数字键盘数字前景字体大小'] - 3,
      // center: { y: 0.53 },
    },
    // 左侧符号列表数据来源
    symbols: collectionData.numericSymbols,
  };

{
  new(theme):
    // 先用竖屏的，后面的拼接后会覆盖
    numeric_9_portrit.keyboard(theme) +
    emoji_portrait.new(theme) +
    keyboard(theme) +
    swipeStyles.getStyle('number', theme, swipe_up, swipe_down) +
    hintSymbolsStyles.getStyle(theme, hintSymbolsData.number) +
    toolbar.getToolBar(theme) +
    utils.genNumberStyles(fontSize, color, theme, center) +
    utils.genFuncKeyStyles(fontSize, color, theme, center),
}
