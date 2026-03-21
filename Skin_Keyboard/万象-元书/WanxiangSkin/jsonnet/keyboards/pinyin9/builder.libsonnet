// 组装拼音九键键盘，汇合共享布局上下文、九键分组规格和样式注册。
local buttonInteraction = import '../../shared/buttonHelpers/buttonInteraction.libsonnet';
local hintSymbolsData = import '../../shared/data/hintSymbolsData.libsonnet';
local swipeData = import '../../shared/data/swipeData.libsonnet';
local functions = import '../../shared/functionButtons/iPhone.libsonnet';
local functionButtonStyles = import '../../shared/functionButtons/styles.libsonnet';
local animation = import '../../shared/styles/animation.libsonnet';
local center = import '../../shared/styles/center.libsonnet';
local color = import '../../shared/styles/color.libsonnet';
local fontSize = import '../../shared/styles/fontSize.libsonnet';
local hintSymbolsStyles = import '../../shared/styles/hintSymbolsStyles.libsonnet';
local utils = import '../../shared/styles/keyStyles.libsonnet';
local others = import '../../shared/styles/others.libsonnet';
local slideButtonStyles = import '../../shared/styles/slideButtonStyles.libsonnet';
local styleFactories = import '../../shared/styles/styleFactories.libsonnet';
local swipeKeyStyles = import '../../shared/styles/swipeKeyStyles.libsonnet';
local toolbar = import '../../shared/toolbar/iPhone.libsonnet';
local panels = import 'panels.libsonnet';
local pinyin9T9 = import 't9.libsonnet';

{
  createButtonFactory(context, swipeUp, swipeDown, t9Letters)::
    function(key, size, bounds, root, isUpper=true)
      local styleKey = if std.length(key) == 1 then 'number' + key else key;
      {
        [if size != {} then 'size']: size,
        backgroundStyle: if std.length(key) == 1 then 'numberButtonBackgroundStyle' else key + 'ButtonBackgroundStyle',
        foregroundStyle: std.flattenArrays(std.filter(
          function(x) x != null,
          [
            if std.length(key) == 1 then
              if std.objectHas(t9Letters, key) then
                ['number' + key + 'LettersStyle']
              else
                ['number' + key + 'ButtonForegroundStyle']
            else
              [key + 'ButtonForegroundStyle'],
            if context.Settings.show_swipe then
              if std.objectHas(swipeUp, key) then ['number' + key + 'ButtonUpForegroundStyle'] else null
            else null,
            if context.Settings.show_swipe then
              if std.objectHas(swipeDown, key) then ['number' + key + 'ButtonDownForegroundStyle'] else null
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
        [if std.objectHas(swipeUp, key) then 'swipeUpAction']: swipeUp[key].action,
        [if std.objectHas(swipeDown, key) then 'swipeDownAction']: swipeDown[key].action,
        [if std.objectHas(root, styleKey + 'ButtonHintSymbolsStyle') then 'hintSymbolsStyle']: styleKey + 'ButtonHintSymbolsStyle',
      },

  build(context, layoutRoot, p26Layout)::
    local theme = context.theme;
    local orientation = context.orientation;
    local makeButtonBackground(normalKey, highlightKey) =
      // 生成九键中的通用按键背景。
      styleFactories.makeGeometryStyle(color[theme][normalKey], {
        insets: if orientation == 'portrait' then context.Settings.button_insets.portrait else context.Settings.button_insets.landscape,
        highlightColor: color[theme][highlightKey],
        cornerRadius: context.Settings.cornerRadius,
        normalLowerEdgeColor: color[theme]['底边缘颜色-普通'],
        highlightLowerEdgeColor: color[theme]['底边缘颜色-高亮'],
      });
    local makeFunctionTextForegroundStyle(textValue, fontSizeValue, centerValue={}, extra={}) =
      // 生成功能键与提示文案共用的文字前景。
      styleFactories.makeTextStyle(
        textValue,
        fontSizeValue,
        color[theme]['按键前景颜色'],
        color[theme]['按键前景颜色'],
        centerValue
      ) + extra;
    local makeFunctionSystemImageForegroundStyle(systemImageName, fontSizeValue, centerValue={}, extra={}) =
      // 生成功能键与提示图标共用的系统图标前景。
      styleFactories.makeSystemImageStyle(
        systemImageName,
        fontSizeValue,
        color[theme]['按键前景颜色'],
        color[theme]['按键前景颜色'],
        centerValue
      ) + extra;
    local layoutName = if orientation == 'portrait' then '竖屏中文9键' else '横屏中文9键';
    local sizeName = if orientation == 'portrait' then '竖屏按键尺寸' else '横屏按键尺寸';
    local swipeDataRoot = swipeData.genSwipeData(context.deviceType);
    local swipeUp = if std.objectHas(swipeDataRoot, 'swipe_up_9') then swipeDataRoot.swipe_up_9 else {};
    local swipeDown = if std.objectHas(swipeDataRoot, 'swipe_down_9') then swipeDataRoot.swipe_down_9 else {};
    local t9Letters = pinyin9T9.getLetters(context.Settings.is_letter_capital);
    local createBaseButton = self.createButtonFactory(context, swipeUp, swipeDown, t9Letters);
    local createButtonWithHints = function(key, size, bounds, root, isUpper=true)
      local styleKey = if std.length(key) == 1 then 'number' + key else key;
      createBaseButton(key, size, bounds, root, isUpper) + {
        // 9 键长按样式由 pinyin_9 hint 数据决定，不能依赖当前对象层的字段可见性判断。
        [if std.objectHas(hintSymbolsData.pinyin_9, styleKey) then 'hintSymbolsStyle']: styleKey + 'ButtonHintSymbolsStyle',
      };
    local layout = layoutRoot[layoutName];
    local hintDataOnlyCn2en = { cn2en: hintSymbolsData.pinyin_9.cn2en };
    local hintDataWithoutCn2en = {
      [k]: hintSymbolsData.pinyin_9[k]
      for k in std.objectFields(hintSymbolsData.pinyin_9)
      if k != 'cn2en'
    };
    local symbolButtonHelper = buttonInteraction.symbolButton;
    local slideEnabled = symbolButtonHelper.enableSlide(context.Settings);
    local useHintSymbols = !slideEnabled && symbolButtonHelper.secondaryActionMode(context.Settings) == 'hint_symbols';
    local useSwipeActions = !slideEnabled && symbolButtonHelper.secondaryActionMode(context.Settings) == 'swipe';
    local swipeTargets = symbolButtonHelper.swipeMapping(context.Settings);
    local symbolHintStyles = if useHintSymbols then hintSymbolsStyles.getStyle(theme, symbolButtonHelper.hintData) else {};
    slideButtonStyles.slideButtonStyles(theme) +
    hintSymbolsStyles.getStyle(theme, hintDataOnlyCn2en) +
    {
      preeditHeight: others[if orientation == 'portrait' then '竖屏' else '横屏']['preedit高度'],
      toolbarHeight: others[if orientation == 'portrait' then '竖屏' else '横屏']['toolbar高度'],
      keyboardHeight: others[if orientation == 'portrait' then '竖屏' else '横屏']['keyboard高度'],
    } +
    layout +
    hintSymbolsStyles.getStyle(theme, hintDataWithoutCn2en) +
    symbolHintStyles +
    swipeKeyStyles.getStyle('number', theme, swipeUp, swipeDown) +
    {
      number1Button: createButtonWithHints('1', {}, {}, $, false) + {
        foregroundStyle: std.filter(function(x) x != null, [
          'number1ButtonSpecialForegroundStyle',
          if context.Settings.show_swipe then (if std.objectHas(swipeUp, '1') then 'number1ButtonUpForegroundStyle' else null) else null,
          if context.Settings.show_swipe then (if std.objectHas(swipeDown, '1') then 'number1ButtonDownForegroundStyle' else null) else null,
        ]),
        action: { character: '@' },
        notification: 'number1ButtonNotification',
      },
      number1ButtonSpecialForegroundStyle:
        // 生成 1 键字符组合前景。
        makeFunctionTextForegroundStyle('@!:', fontSize['中文九键字符键前景文字大小'], center['中文九键字符前景偏移']),
      number1ButtonNotification: {
        notificationType: 'preeditChanged',
        backgroundStyle: 'alphabeticBackgroundStyle',
        foregroundStyle: 'number1ButtonPreeditForegroundStyle',
        action: { character: "'" },
      },
      number1ButtonPreeditForegroundStyle:
        // 生成 1 键预编辑文案前景。
        makeFunctionTextForegroundStyle('分词', fontSize['中文九键字符键前景文字大小'], center['中文九键字符前景偏移']),
    } +
    {
      ['number' + key + 'Button']: createButtonWithHints(key, {}, {}, $, false)
      for key in pinyin9T9.digitKeys
    } +
    {
      symbolButton: createButtonWithHints('symbol', layout[sizeName].symbolButton, {}, $, false) + {
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
      '123Button': createButtonWithHints('123', layout[sizeName]['123Button'], {}, $, false) + {
        backgroundStyle: 'systemButtonBackgroundStyle',
        foregroundStyle: '123ButtonForegroundStyle',
        action: { keyboardType: 'numeric' },
      },
      '123ButtonForegroundStyle':
        // 生成 123 键前景。
        makeFunctionSystemImageForegroundStyle(
          if context.Settings.fix_sf_symbol then 'textformat.123' else 'numbers',
          fontSize['按键前景文字大小'] - 3,
          center['功能键前景文字偏移'] { y: 0.5 }
        ),
      emojiButton: createButtonWithHints('emoji', layout[sizeName].emojiButton, {}, $, false) + {
        backgroundStyle: 'systemButtonBackgroundStyle',
        foregroundStyle: 'emojiButtonForegroundStyle',
        action: { keyboardType: 'emojis' },
      },
      emojiButtonForegroundStyle:
        // 生成 emoji 键前景。
        makeFunctionSystemImageForegroundStyle(
          'face.smiling',
          fontSize['按键前景文字大小'] - 3,
          center['功能键前景文字偏移'] { y: 0.5 }
        ),
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
      spaceRightButtonPreeditNotification: {
        notificationType: 'preeditChanged',
        backgroundStyle: 'alphabeticBackgroundStyle',
        foregroundStyle: 'spaceRightButtonPreeditForegroundStyle',
        action: context.Settings.tips_button_action,
        hintSymbolsStyle: 'cn2enButtonHintSymbolsStyle',
      },
      spaceRightButtonPreeditForegroundStyle:
        // 生成提示灯泡前景。
        makeFunctionSystemImageForegroundStyle(
          if context.Settings.fix_sf_symbol then 'lightbulb' else 'lightbulb.max',
          fontSize['按键前景文字大小']
        ),
      cleanButton: createButtonWithHints('clean', layout[sizeName].cleanButton, {}, $, false) + {
        backgroundStyle: 'systemButtonBackgroundStyle',
        action: { shortcut: '#换行' },
        notification: ['cleanButtonPreeditNotification'],
      },
      cleanButtonForegroundStyle:
        // 生成换行键前景。
        makeFunctionTextForegroundStyle('换行', fontSize['按键前景文字大小'] - 3),
      cleanButtonPreeditNotification: {
        notificationType: 'preeditChanged',
        backgroundStyle: 'systemButtonBackgroundStyle',
        foregroundStyle: 'cleanButtonPreeditForegroundStyle',
        action: if context.withFunctionsRow then { shortcut: '#重输' } else { shortcut: '#rimeNextPage' },
        [if context.withFunctionsRow then null else 'swipeUpAction']: { shortcut: '#rimePreviousPage' },
        [if context.withFunctionsRow then null else 'swipeDownAction']: { shortcut: '#rimeNextPage' },
      },
      cleanButtonPreeditForegroundStyle:
        if context.withFunctionsRow then
          // 生成功能行开启时的重输前景。
          makeFunctionTextForegroundStyle('重输', fontSize['按键前景文字大小'] - 3)
        else
          // 生成功能行关闭时的翻页图标前景。
          makeFunctionSystemImageForegroundStyle(
            if context.Settings.fix_sf_symbol then 'arrow.up.arrow.down' else 'chevron.compact.up.chevron.compact.down',
            fontSize['数字键盘数字前景字体大小']
          ),
      spaceButton: p26Layout.spaceButton {
        size: layout[sizeName].spaceButton,
        [if std.objectHas(swipeUp, 'space') then 'swipeUpAction']: swipeUp.space.action,
      },
      spaceButtonForegroundStyle: p26Layout.spaceButtonForegroundStyle,
      spaceButtonForegroundStyle1: if std.objectHas(p26Layout, 'spaceButtonForegroundStyle1') then p26Layout.spaceButtonForegroundStyle1 else {},
      spaceButtonPreeditNotification: p26Layout.spaceButtonPreeditNotification,
      backspaceButton: createButtonWithHints('backspace', layout[sizeName].backspaceButton, {}, $, false) + {
        backgroundStyle: 'systemButtonBackgroundStyle',
        action: 'backspace',
        repeatAction: 'backspace',
        swipeUpAction: { shortcut: '#deleteText' },
        swipeDownAction: { shortcut: '#undo' },
      },
      backspaceButtonForegroundStyle:
        // 生成退格键前景。
        makeFunctionSystemImageForegroundStyle('delete.left', fontSize['数字键盘数字前景字体大小'] - 3),
      enterButton: createButtonWithHints('enter', layout[sizeName].enterButton, {}, $, false) + {
        backgroundStyle: [
          { styleName: 'systemButtonBackgroundStyle', conditionKey: '$returnKeyType', conditionValue: [0, 2, 3, 5, 8, 10, 11] },
          { styleName: 'enterButtonBlueBackgroundStyle', conditionKey: '$returnKeyType', conditionValue: [1, 4, 6, 7, 9] },
        ],
        foregroundStyle: [
          { styleName: 'enterButtonForegroundStyle0', conditionKey: '$returnKeyType', conditionValue: [0, 2, 3, 5, 8, 10, 11] },
          { styleName: 'enterButtonForegroundStyle14', conditionKey: '$returnKeyType', conditionValue: [1, 4] },
          { styleName: 'enterButtonForegroundStyle6', conditionKey: '$returnKeyType', conditionValue: [6] },
          { styleName: 'enterButtonForegroundStyle7', conditionKey: '$returnKeyType', conditionValue: [7] },
          { styleName: 'enterButtonForegroundStyle9', conditionKey: '$returnKeyType', conditionValue: [9] },
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
      enterButtonBlueBackgroundStyle: makeButtonBackground('enter键背景(蓝色)', '功能键背景颜色-高亮'),
      numberButtonBackgroundStyle: makeButtonBackground('字母键背景颜色-普通', '字母键背景颜色-高亮'),
      functionBackgroundStyle: makeButtonBackground('字母键背景颜色-普通', '字母键背景颜色-高亮'),
      alphabeticBackgroundStyle: makeButtonBackground('字母键背景颜色-普通', '字母键背景颜色-高亮'),
      systemButtonBackgroundStyle: makeButtonBackground('功能键背景颜色-普通', '功能键背景颜色-高亮'),
      ButtonScaleAnimation: animation['26键按键动画'],
      symbols: pinyin9T9.symbols,
    } +
    {
      ['number' + key + 'LettersStyle']: {
        buttonStyleType: 'text',
        text: t9Letters[key],
        normalColor: color[theme]['按键前景颜色'],
        highlightColor: color[theme]['按键前景颜色'],
        fontSize: fontSize['中文九键字符键前景文字大小'],
        fontWeight: 0,
        center: center['中文九键字符前景偏移'],
      }
      for key in std.objectFields(t9Letters)
    } +
    toolbar.getToolBar(theme) +
    panels.build(context, theme, orientation) +
    utils.genNumberStyles(fontSize, color, theme, center) +
    functionButtonStyles.genFuncKeyStyles(fontSize, color, theme, center) +
    functions.makeFunctionButtons(orientation, {}, 't9'),
}
