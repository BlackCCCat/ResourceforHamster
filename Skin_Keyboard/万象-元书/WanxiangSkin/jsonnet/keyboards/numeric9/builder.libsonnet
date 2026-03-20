// 组装数字 9 键键盘，汇合共享上下文、布局数据和样式注册。
local hintSymbolsData = import '../../shared/data/hintSymbolsData.libsonnet';
local swipeData = import '../../shared/data/swipeData.libsonnet';
local functions = import '../../shared/functionButtons/iPhone.libsonnet';
local functionButtonStyles = import '../../shared/functionButtons/styles.libsonnet';
local animation = import '../../shared/styles/animation.libsonnet';
local center = import '../../shared/styles/center.libsonnet';
local color = import '../../shared/styles/color.libsonnet';
local fontSize = import '../../shared/styles/fontSize.libsonnet';
local hintSymbolsStyles = import '../../shared/styles/hintSymbolsStyles.libsonnet';
local others = import '../../shared/styles/others.libsonnet';
local slideButtonStyles = import '../../shared/styles/slideButtonStyles.libsonnet';
local panels = import 'panels.libsonnet';
local swipeKeyStyles = import '../../shared/styles/swipeKeyStyles.libsonnet';
local buttonInteraction = import '../../shared/buttonHelpers/buttonInteraction.libsonnet';
local styleFactories = import '../../shared/styles/styleFactories.libsonnet';
local returnKeyHelpers = import '../../shared/buttonHelpers/returnKey.libsonnet';
local toolbar = import '../../shared/toolbar/iPhone.libsonnet';
local utils = import '../../shared/styles/keyStyles.libsonnet';

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
    local makeButtonBackground(normalKey, highlightKey) =
      // 生成数字键盘中的通用按键背景。
      styleFactories.makeGeometryStyle(color[theme][normalKey], {
        insets: if orientation == 'portrait' then context.Settings.button_insets.portrait else context.Settings.button_insets.landscape,
        highlightColor: color[theme][highlightKey],
        cornerRadius: context.Settings.cornerRadius,
        normalLowerEdgeColor: color[theme]['底边缘颜色-普通'],
        highlightLowerEdgeColor: color[theme]['底边缘颜色-高亮'],
      });
    local makeFunctionTextForegroundStyle(textValue, fontSizeValue, centerValue={}, extra={}) =
      // 生成数字键盘功能键共用的文字前景。
      styleFactories.makeTextStyle(
        textValue,
        fontSizeValue,
        color[theme]['按键前景颜色'],
        color[theme]['按键前景颜色'],
        centerValue
      ) + extra;
    local makeFunctionSystemImageForegroundStyle(systemImageName, fontSizeValue, centerValue={}, extra={}) =
      // 生成数字键盘功能键共用的系统图标前景。
      styleFactories.makeSystemImageStyle(
        systemImageName,
        fontSizeValue,
        color[theme]['按键前景颜色'],
        color[theme]['按键前景颜色'],
        centerValue
      ) + extra;
    local makeEnterForegroundStyle(textValue, useBlueText=false, withCenter=true, withInsets=true) =
      returnKeyHelpers.makeForeground(
        styleFactories,
        theme,
        color,
        fontSize,
        center,
        textValue,
        (if useBlueText then {
          normalColor: color[theme]['长按选中字体颜色'],
          highlightColor: color[theme]['长按非选中字体颜色'],
        } else {}) +
        (if withCenter then { center: center['功能键前景文字偏移'] } else {}) +
        (if withInsets then { insets: { top: 4, left: 3, bottom: 4, right: 3 } } else {})
      );
    local landscapeShowFunctions = context.Settings.function_button_config.with_functions_row.iPhone;
    local landscapeTopHeight = if landscapeShowFunctions then 0.17 else 0;
    local landscapeBottomHeight = if landscapeShowFunctions then 0.83 else 1;
    local swipeDataRoot = swipeData.genSwipeData(context.deviceType);
    local swipeUp = if std.objectHas(swipeDataRoot, 'number_swipe_up') then swipeDataRoot.number_swipe_up else {};
    local swipeDown = if std.objectHas(swipeDataRoot, 'number_swipe_up') then swipeDataRoot.number_swipe_down else {};
    local symbolButtonHelper = buttonInteraction.symbolButton;
    local slideEnabled = symbolButtonHelper.enableSlide(context.Settings);
    local useHintSymbols = !slideEnabled && symbolButtonHelper.secondaryActionMode(context.Settings) == 'hint_symbols';
    local useSwipeActions = !slideEnabled && symbolButtonHelper.secondaryActionMode(context.Settings) == 'swipe';
    local swipeTargets = symbolButtonHelper.swipeMapping(context.Settings);
    local createButton = self.createButtonFactory(context, swipeUp, swipeDown);
    local createNotification = self.createNotification;
    slideButtonStyles.slideButtonStyles(theme) +
    (if useHintSymbols then hintSymbolsStyles.getStyle(theme, symbolButtonHelper.hintData) else {}) +
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
      CenterStackStyle: {
        size: {
          width: '375/549',
        },
      },
      VStackStyle2: {
        size: {
          width: '125/549',
        },
      },
      landscapeNumericLeftColumnStyle: {
        size: {
          width: '2/5',
        },
      },
      landscapeNumericSpacerColumnStyle: {
        size: {
          width: '1/5',
        },
      },
      landscapeNumericRightColumnStyle: {
        size: {
          width: '2/5',
        },
      },
      landscapeNumericTopRowStyle: {
        size: {
          height: { percentage: landscapeTopHeight },
        },
      },
      landscapeNumericBottomRowStyle: {
        size: {
          height: { percentage: landscapeBottomHeight },
        },
      },
      landscapeNumericCollectionColumnStyle: {
        size: {
          width: '29/154',
          height: '1',
        },
      },
      landscapeNumericSymbolsColumnStyle: {
        size: {
          width: '125/154',
          height: '1',
        },
      },
      landscapeNumericInputAreaStyle: {
        size: {
          width: '125/154',
        },
      },
      landscapeNumericRightActionColumnStyle: {
        size: {
          width: '29/154',
        },
      },
      landscapeNumericInputMatrixStyle: {
        size: {
          height: '3/4',
        },
      },
      landscapeNumericInputBottomRowStyle: {
        size: {
          height: '1/4',
        },
      },
      returnButton: createButton('return', {}, {}, $) + {
        backgroundStyle: 'systemButtonBackgroundStyle',
        action: 'returnPrimaryKeyboard',
      },
      returnButtonForegroundStyle:
        // 生成返回键前景。
        makeFunctionTextForegroundStyle('返回', fontSize['按键前景文字大小'] - 3),
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
        [if slideEnabled then 'type']: 'horizontalSymbols',
        [if slideEnabled then 'maxColumns']: 1,
        [if slideEnabled then 'insets']: { left: 3, right: 3 },
        [if slideEnabled then 'contentRightToLeft']: false,
        [if slideEnabled then 'dataSource']: 'symbolButtonSymbolsDataSource',
        [if !slideEnabled then 'foregroundStyle']: 'symbolicButtonForegroundStyle',
        [if !slideEnabled then 'action']: { keyboardType: 'symbolic' },
        [if useHintSymbols then 'hintSymbolsStyle']: 'symbolButtonHintSymbolsStyle',
        [if useSwipeActions then 'swipeUpAction']: { keyboardType: swipeTargets.up },
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
      spaceButtonForegroundStyle:
        // 生成空格键前景。
        makeFunctionSystemImageForegroundStyle('space', fontSize['按键前景文字大小'] - 3),
      backspaceButton: createButton('backspace', {}, {}, $) + {
        backgroundStyle: 'systemButtonBackgroundStyle',
        action: 'backspace',
        repeatAction: 'backspace',
        swipeUpAction: { shortcut: '#deleteText' },
        swipeDownAction: { shortcut: '#undo' },
      },
      backspaceButtonForegroundStyle:
        // 生成退格键前景。
        makeFunctionSystemImageForegroundStyle('delete.left', fontSize['数字键盘数字前景字体大小'] - 3),
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
      spaceRightButtonForegroundStyle:
        // 生成右侧句号前景。
        makeFunctionTextForegroundStyle('.', fontSize['数字键盘数字前景字体大小']),
      atButton: createButton('at', {}, {}, $) + {
        backgroundStyle: 'systemButtonBackgroundStyle',
        action: {
          character: '=',
        },
        swipeUpAction: { character: 'V' },
      },
      atButtonForegroundStyle:
        // 生成等号键前景。
        makeFunctionTextForegroundStyle('=', fontSize['collection前景字体大小'], {}, { fontWeight: 0 }),
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
      // 回车键前景
      enterButtonForegroundStyle: makeEnterForegroundStyle('换行', false, false),
      enterButtonForegroundStyle0: makeEnterForegroundStyle('回车'),
      enterButtonForegroundStyle6: makeEnterForegroundStyle('搜索', true),
      enterButtonForegroundStyle7: makeEnterForegroundStyle('发送', true),
      enterButtonForegroundStyle14: makeEnterForegroundStyle('前往', true),
      enterButtonForegroundStyle9: makeEnterForegroundStyle('完成', true),
      enterButtonBlueBackgroundStyle: makeButtonBackground('enter键背景(蓝色)', '功能键背景颜色-高亮'),
      numberButtonBackgroundStyle: makeButtonBackground('字母键背景颜色-普通', '字母键背景颜色-高亮'),
      functionBackgroundStyle: makeButtonBackground('字母键背景颜色-普通', '字母键背景颜色-高亮'),
      systemButtonBackgroundStyle: makeButtonBackground('功能键背景颜色-普通', '功能键背景颜色-高亮'),
      alphabeticHintSymbolsBackgroundStyle: hintSymbolsStyles['长按背景样式'],
      alphabeticHintSymbolsSelectedStyle: hintSymbolsStyles['长按选中背景样式'],
      ButtonScaleAnimation: animation['26键按键动画'],
    } +
    panels.build(context, theme, orientation) +
    swipeKeyStyles.getStyle('number', theme, swipeUp, swipeDown) +
    hintSymbolsStyles.getStyle(theme, hintSymbolsData.number) +
    toolbar.getToolBar(theme) +
    utils.genNumberStyles(fontSize, color, theme, center) +
    functionButtonStyles.genFuncKeyStyles(fontSize, color, theme, center) +
    functions.makeFunctionButtons('', {}, 'numeric'),
}
