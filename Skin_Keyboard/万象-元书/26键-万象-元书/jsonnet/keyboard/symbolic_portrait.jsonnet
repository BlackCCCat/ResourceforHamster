local animation = import '../lib/animation.libsonnet';
local center = import '../lib/center.libsonnet';
local collectionData = import '../lib/collectionData.libsonnet';
local color = import '../lib/color.libsonnet';
local fontSize = import '../lib/fontSize.libsonnet';
local others = import '../lib/others.libsonnet';
local swipeData = import '../lib/swipeData.libsonnet';
local swipeStyles = import '../lib/swipeStyle.libsonnet';
local toolbar = import '../lib/toolbar.libsonnet';
local utils = import '../lib/utils.libsonnet';
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
  // utils.genFuncKeyStyles(fontSize, color, theme, center) + // 自定义按钮
  // toolbar.getToolBar(theme) +  // 工具栏
  {
    keyboardHeight: others['竖屏']['键盘总高度'],
    // toolbarHeight: others['竖屏']['toolbar高度'] + others['竖屏']['preedit高度'],
    keyboardLayout:
      [
        // {
        //   HStack: {
        //     style: 'rowofFunctionStyle',
        //     subviews: [
        //       { Cell: 'leftButton' },
        //       { Cell: 'headButton' },
        //       { Cell: 'selectButton' },
        //       { Cell: 'cutButton' },
        //       { Cell: 'copyButton' },
        //       { Cell: 'pasteButton' },
        //       { Cell: 'tailButton' },
        //       { Cell: 'rightButton' },
        //     ],
        //   },
        // },
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
        {
          HStack: {
            style: 'HStackStyle2',
            subviews: [
              {
                Cell: 'returnButton',
              },
              {
                Cell: 'pageUpButton',
              },
              {
                Cell: 'pageDownButton',
              },
              {
                Cell: 'lockButton',
              },
              {
                Cell: 'backspaceButton',
              },
            ],
          },
        },
      ],
    // rowofFunctionStyle: {
    //   size: {
    //     height: 45,
    //   },
    //   backgroundStyle: 'keyboardBackgroundStyle',
    // },
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

    HStackStyle1: {
      size: {
        height: '195/240',  // '182/281',
      },
    },
    HStackStyle2: {
      size: {
        height: '50/240',
      },
    },
    categoryCollection: {
      size: {
        width: '56/375',
      },
      insets: { top: 6, bottom: 6 },
      backgroundStyle: 'listBackgroundStyle',
      type: 'classifiedSymbols',
      dataSource: 'category',
      cellStyle: 'collectionCellStyle',
    },
    listBackgroundStyle: {
      buttonStyleType: 'geometry',
      insets: { top: 3, left: 3, bottom: 3, right: 3 },
      normalColor: color[theme]['符号键盘左侧collection背景颜色'],
      cornerRadius: 7,
      normalShadowColor: color[theme]['符号键盘左侧collection背景下边缘颜色'],
      normalLowerEdgeColor: color[theme]['符号键盘左侧collection背景下边缘颜色'],
    },
    collectionCellStyle: {
      backgroundStyle: 'collectionCellBackgroundStyle',
      foregroundStyle: 'collectionCellForegroundStyle',
    },
    collectionCellBackgroundStyle: {
      buttonStyleType: 'geometry',
      insets: { top: 7, left: 4, bottom: 7, right: 4 },
      normalColor: '00000000',
      highlightColor: color[theme]['字母键背景颜色-普通'],
      cornerRadius: 7,
    },
    collectionCellForegroundStyle: {
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
      // 调整内边距
      insets: { bottom: 8, left: 8, right: 8, top: 8 },
      // 横线开关
      // displaySeparatorLine: 'false',
      // 横线颜色
      // separatorLineColor: '#fe6f5e',
      backgroundStyle: 'descriptionCollectionBackgroundStyle',
      type: 'subClassifiedSymbols',
      cellStyle: 'descriptionCollectionCellStyle',
    },
    descriptionCollectionBackgroundStyle: {
      buttonStyleType: 'geometry',
      insets: { top: 3, left: 3, bottom: 3, right: 3 },
      normalColor: color[theme]['符号键盘右侧collection背景颜色'],
      cornerRadius: 7,
      normalLowerEdgeColor: color[theme]['符号键盘右侧collection背景下边缘颜色'],
    },
    descriptionCollectionCellStyle: {
      // insets: { top: 3, left: 3, bottom: 3, right: 3 },
      backgroundStyle: 'collectionCellBackgroundStyle',
      foregroundStyle: 'descriptionCollectionCellForegroundStyle',
    },
    descriptionCollectionCellForegroundStyle: {
      buttonStyleType: 'text',
      normalColor: color[theme]['列表未选中字体颜色'],
      highlightColor: color[theme]['列表选中字体颜色'],
      fontSize: fontSize['符号键盘右侧collection前景字体大小'],
      fontWeight: 0,
    },

    returnButton: {
      size: {
        width: '56/375',
      },
      backgroundStyle: 'systemButtonBackgroundStyle',
      foregroundStyle: [
        'returnButtonForegroundStyle',
      ],
      action: 'returnLastKeyboard',
    },

    returnButtonForegroundStyle: {
      buttonStyleType: 'text',
      text: '返回',
      normalColor: color[theme]['按键前景颜色'],
      highlightColor: color[theme]['按键前景颜色'],
      fontSize: fontSize['按键前景文字大小'] - 3,
      // center: center['26键中文前景偏移'],
    },
    pageUpButton: {
      size: {
        width: '79.75/375',
      },
      backgroundStyle: 'systemButtonBackgroundStyle',
      foregroundStyle: 'pageUpButtonForegroundStyle',
      action: { shortcut: '#subCollectionPageUp' },
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
        width: '79.75/375',
      },
      backgroundStyle: 'systemButtonBackgroundStyle',
      foregroundStyle: 'pageDownButtonForegroundStyle',
      action: { shortcut: '#subCollectionPageDown' },
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
        width: '79.75/375',
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
      notification: 'symbolicKeyboardLockStateNotification',
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
    backspaceButton: {
      size: {
        width: '79.75/375',
      },
      backgroundStyle: 'systemButtonBackgroundStyle',
      foregroundStyle: [
        'backspaceButtonForegroundStyle',
      ],
      action: 'backspace',
      repeatAction: 'backspace',
      swipteUpAction: { shortcut: '#deleteText' },
    },

    backspaceButtonForegroundStyle: {
      buttonStyleType: 'systemImage',
      systemImageName: 'delete.left',
      normalColor: color[theme]['按键前景颜色'],
      highlightColor: color[theme]['按键前景颜色'],
      fontSize: fontSize['数字键盘数字前景字体大小'] - 3,
      // center: { y: 0.53 },
    },
    systemButtonBackgroundStyle: {
      buttonStyleType: 'geometry',
      insets: { top: 4, left: 3, bottom: 4, right: 3 },
      normalColor: color[theme]['功能键背景颜色-普通'],
      highlightColor: color[theme]['功能键背景颜色-高亮'],
      cornerRadius: 7,
      normalLowerEdgeColor: color[theme]['底边缘颜色-普通'],
      highlightLowerEdgeColor: color[theme]['底边缘颜色-高亮'],
    },
    ButtonScaleAnimation: animation['26键按键动画'],

    symbolicKeyboardLockStateNotification: {
      notificationType: 'symbolicKeyboardLockedState',
      lockedState: true,
      backgroundStyle: 'systemButtonBackgroundStyle',
      foregroundStyle: 'lockButtonForegroundStyle',
    },
    functionBackgroundStyle: {
      buttonStyleType: 'geometry',
      insets: { top: 5, left: 3, bottom: 5, right: 3 },
      normalColor: color[theme]['字母键背景颜色-普通'],
      highlightColor: color[theme]['字母键背景颜色-高亮'],
      cornerRadius: 7,
      normalLowerEdgeColor: color[theme]['底边缘颜色-普通'],
      highlightLowerEdgeColor: color[theme]['底边缘颜色-高亮'],
    },
  };
{
  new(theme): keyboard(theme) + collectionData.symbolicDataSource,  // 符号数据源
  getKeyboard(theme): keyboard(theme),  // 给emoji键盘使用，提供无符号数据源的键盘配置
}
