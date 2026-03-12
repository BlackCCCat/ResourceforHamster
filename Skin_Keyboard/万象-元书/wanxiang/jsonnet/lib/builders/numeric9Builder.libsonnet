// Build the numeric 9-key keyboard from shared context, layout data, and the existing style registries.
local animation = import '../shared/animation.libsonnet';
local center = import '../shared/center.libsonnet';
local collectionData = import '../data/collectionData.libsonnet';
local color = import '../shared/color.libsonnet';
local fontSize = import '../shared/fontSize.libsonnet';
local hintSymbolsData = import '../data/hintSymbolsData.libsonnet';
local hintSymbolsStyles = import '../shared/hintSymbolsStyles.libsonnet';
local others = import '../shared/others.libsonnet';
local slideForeground = import '../shared/slideForeground.libsonnet';
local swipeData = import '../data/swipeData.libsonnet';
local swipeStyles = import '../swipe/index.libsonnet';
local toolbar = import '../toolbar/index.libsonnet';
local utils = import '../utils/index.libsonnet';
local functions = import '../functionButtons/index.libsonnet';
local functionButtonStyles = import '../functionButtons/styles.libsonnet';

{
  createButtonFactory(context, swipeUp, swipeDown)::
    function(key, size, bounds, root)
      {
        [if size != {} then 'size']: size,
        backgroundStyle: if std.length(key) == 1 then 'numberButtonBackgroundStyle' else key + 'ButtonBackgroundStyle',
        foregroundStyle: std.filter(
          function(x) x != null,
          [
            if std.length(key) == 1 then 'number' + key + 'ButtonForegroundStyle' else key + 'ButtonForegroundStyle',
            if std.objectHas(swipeUp, key) then 'number' + key + 'ButtonUpForegroundStyle' else null,
            if std.objectHas(swipeDown, key) then 'number' + key + 'ButtonDownForegroundStyle' else null,
          ]
        ),
        action: if context.Settings.keyboard_layout == 9 then { symbol: key } else { character: key },
        [if std.objectHas(swipeUp, key) then 'swipeUpAction']: swipeUp[key].action,
        [if std.objectHas(swipeDown, key) then 'swipeDownAction']: swipeDown[key].action,
        [if std.length(key) == 1 && std.objectHas(hintSymbolsData.number, 'number' + key) then 'hintSymbolsStyle']: 'number' + key + 'ButtonHintSymbolsStyle',
        [if context.Settings.keyboard_layout == 9 && std.length(key) == 1 then 'notification']: [
          'number' + key + 'ButtonNotification',
        ],
      },

  createNotification(key, bounds={}):: {
    notificationType: 'preeditChanged',
    [if bounds != {} then 'bounds']: bounds,
    backgroundStyle: 'numberButtonBackgroundStyle',
    foregroundStyle: 'number' + key + 'ButtonForegroundStyle',
    action: { character: key },
  },

  build(context, layoutSpec)::
    local theme = context.theme;
    local orientation = context.orientation;
    local swipeDataRoot = swipeData.genSwipeData(context.deviceType);
    local swipeUp = if std.objectHas(swipeDataRoot, 'number_swipe_up') then swipeDataRoot.number_swipe_up else {};
    local swipeDown = if std.objectHas(swipeDataRoot, 'number_swipe_up') then swipeDataRoot.number_swipe_down else {};
    local createButton = self.createButtonFactory(context, swipeUp, swipeDown);
    local createNotification = self.createNotification;
    slideForeground.slideForeground(theme) +
    {
      preeditHeight: others[if orientation == 'portrait' then '竖屏' else '横屏']['preedit高度'],
      toolbarHeight: others[if orientation == 'portrait' then '竖屏' else '横屏']['toolbar高度'],
      keyboardHeight: others[if orientation == 'portrait' then '竖屏' else '横屏']['keyboard高度'],

      keyboardLayout: layoutSpec,
      rowofFunctionStyle: {
        size: {
          height: { percentage: if orientation == 'portrait' then 0.17 else 0.185 },
        },
        backgroundStyle: 'keyboardBackgroundStyle',
      },
      keyboardStyle: {
        size: {
          height: { percentage: 0.73 },
        },
        insets: {
          top: 3,
          bottom: 3,
          left: 4,
          right: 4,
        },
      },
      keyboardBackgroundStyle: {
        normalImage: {
          file: 'bg',
          image: 'IMG1',
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
      },
      collectionBackgroundStyle: {
        buttonStyleType: 'geometry',
        insets: if orientation == 'portrait' then context.Settings.button_insets.portrait else context.Settings.button_insets.landscape,
        normalColor: color[theme]['符号键盘左侧collection背景颜色'],
        cornerRadius: context.Settings.cornerRadius,
        normalLowerEdgeColor: color[theme]['符号键盘左侧collection背景下边缘颜色'],
      },
      collectionCellStyle: {
        backgroundStyle: 'collectionCellBackgroundStyle',
        foregroundStyle: 'collectionCellForegroundStyle',
      },
      collectionCellBackgroundStyle: {
        buttonStyleType: 'geometry',
        insets: if orientation == 'portrait' then context.Settings.button_insets.portrait else context.Settings.button_insets.landscape,
        highlightColor: color[theme]['字母键背景颜色-普通'],
        normalColor: 'ffffff00',
        cornerRadius: context.Settings.cornerRadius,
      },
      collectionCellForegroundStyle: {
        buttonStyleType: 'text',
        normalColor: color[theme]['collection前景颜色'],
        fontSize: fontSize['collection前景字体大小'],
        fontWeight: 0,
      },
      returnButton: createButton('return', {}, {}, $) + {
        backgroundStyle: 'systemButtonBackgroundStyle',
        action: 'returnPrimaryKeyboard',
      },
      returnButtonForegroundStyle: {
        buttonStyleType: 'text',
        text: '返回',
        normalColor: color[theme]['按键前景颜色'],
        highlightColor: color[theme]['按键前景颜色'],
        fontSize: fontSize['按键前景文字大小'] - 3,
      },
    } +
    {
      ['number' + std.toString(num) + 'Button']: createButton(std.toString(num), {}, {}, $)
      for num in std.range(0, 9)
    } +
    {
      ['number' + std.toString(num) + 'ButtonNotification']: createNotification(std.toString(num))
      for num in std.range(0, 9)
    } +
    {
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
        { label: '3', action: { keyboardType: 'emojis' }, styleName: 'emojisStyle' },
      ],
      spaceButton: createButton('space', {}, {}, $) + {
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
      },
      backspaceButton: createButton('backspace', {}, {}, $) + {
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
      spaceRightButton: createButton('spaceRight', {}, {}, $) + {
        backgroundStyle: 'systemButtonBackgroundStyle',
        action: {
          symbol: '.',
        },
        notification: [
          'spaceRightButtonPreeditNotification',
        ],
      },
      spaceRightButtonPreeditNotification: {
        notificationType: 'preeditChanged',
        backgroundStyle: 'systemButtonBackgroundStyle',
        foregroundStyle: 'spaceRightButtonForegroundStyle',
        action: { character: '.' },
      },
      spaceRightButtonForegroundStyle: {
        buttonStyleType: 'text',
        text: '.',
        normalColor: color[theme]['按键前景颜色'],
        highlightColor: color[theme]['按键前景颜色'],
        fontSize: fontSize['数字键盘数字前景字体大小'],
      },
      atButton: createButton('at', {}, {}, $) + {
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
      },
      enterButton: createButton('enter', {}, {}, $) + {
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
        insets: { top: 4, left: 3, bottom: 4, right: 3 },
        normalColor: color[theme]['按键前景颜色'],
        highlightColor: color[theme]['按键前景颜色'],
        fontSize: fontSize['按键前景文字大小'] - 3,
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
        insets: if orientation == 'portrait' then context.Settings.button_insets.portrait else context.Settings.button_insets.landscape,
        normalColor: color[theme]['enter键背景(蓝色)'],
        highlightColor: color[theme]['功能键背景颜色-高亮'],
        cornerRadius: context.Settings.cornerRadius,
        normalLowerEdgeColor: color[theme]['底边缘颜色-普通'],
        highlightLowerEdgeColor: color[theme]['底边缘颜色-高亮'],
      },
      numberButtonBackgroundStyle: {
        buttonStyleType: 'geometry',
        insets: if orientation == 'portrait' then context.Settings.button_insets.portrait else context.Settings.button_insets.landscape,
        normalColor: color[theme]['字母键背景颜色-普通'],
        highlightColor: color[theme]['字母键背景颜色-高亮'],
        cornerRadius: context.Settings.cornerRadius,
        normalLowerEdgeColor: color[theme]['底边缘颜色-普通'],
        highlightLowerEdgeColor: color[theme]['底边缘颜色-高亮'],
      },
      functionBackgroundStyle: {
        buttonStyleType: 'geometry',
        insets: if orientation == 'portrait' then context.Settings.button_insets.portrait else context.Settings.button_insets.landscape,
        normalColor: color[theme]['字母键背景颜色-普通'],
        highlightColor: color[theme]['字母键背景颜色-高亮'],
        cornerRadius: context.Settings.cornerRadius,
        normalLowerEdgeColor: color[theme]['底边缘颜色-普通'],
        highlightLowerEdgeColor: color[theme]['底边缘颜色-高亮'],
      },
      systemButtonBackgroundStyle: {
        buttonStyleType: 'geometry',
        insets: if orientation == 'portrait' then context.Settings.button_insets.portrait else context.Settings.button_insets.landscape,
        normalColor: color[theme]['功能键背景颜色-普通'],
        highlightColor: color[theme]['功能键背景颜色-高亮'],
        cornerRadius: context.Settings.cornerRadius,
        normalLowerEdgeColor: color[theme]['底边缘颜色-普通'],
        highlightLowerEdgeColor: color[theme]['底边缘颜色-高亮'],
      },
      alphabeticHintSymbolsBackgroundStyle: hintSymbolsStyles['长按背景样式'],
      alphabeticHintSymbolsSelectedStyle: hintSymbolsStyles['长按选中背景样式'],
      ButtonScaleAnimation: animation['26键按键动画'],
      symbols: collectionData.numericSymbols,
    } +
    swipeStyles.getStyle('number', theme, swipeUp, swipeDown) +
    hintSymbolsStyles.getStyle(theme, hintSymbolsData.number) +
    toolbar.getToolBar(theme) +
    utils.genNumberStyles(fontSize, color, theme, center) +
    functionButtonStyles.genFuncKeyStyles(fontSize, color, theme, center) +
    functions.makeFunctionButtons('', {}, 'numeric'),
}
