// Build the pinyin 9-key keyboard from shared layout context, T9 specs, and existing style registries.
local animation = import '../shared/animation.libsonnet';
local center = import '../shared/center.libsonnet';
local color = import '../shared/color.libsonnet';
local fontSize = import '../shared/fontSize.libsonnet';
local hintSymbolsData = import '../data/hintSymbolsData.libsonnet';
local hintSymbolsStyles = import '../shared/hintSymbolsStyles.libsonnet';
local others = import '../shared/others.libsonnet';
local pinyin9ButtonFactory = import 'pinyin9ButtonFactory.libsonnet';
local pinyin9T9 = import '../specs/pinyin9T9.libsonnet';
local slideForeground = import '../shared/slideForeground.libsonnet';
local swipeData = import '../data/swipeData.libsonnet';
local swipeStyles = import '../swipe/index.libsonnet';
local toolbar = import '../toolbar/index.libsonnet';
local utils = import '../utils/index.libsonnet';
local functions = import '../functionButtons/index.libsonnet';
local functionButtonStyles = import '../functionButtons/styles.libsonnet';

{
  createButtonFactory(context, swipeUp, swipeDown, t9Letters)::
    pinyin9ButtonFactory.create(context, swipeUp, swipeDown, t9Letters),

  build(context, layoutRoot, p26Layout)::
    local theme = context.theme;
    local orientation = context.orientation;
    local swipeDataRoot = swipeData.genSwipeData(context.deviceType);
    local swipeUp = if std.objectHas(swipeDataRoot, 'swipe_up_9') then swipeDataRoot.swipe_up_9 else {};
    local swipeDown = if std.objectHas(swipeDataRoot, 'swipe_down_9') then swipeDataRoot.swipe_down_9 else {};
    local t9Letters = pinyin9T9.getLetters(context.Settings.is_letter_capital);
    local createBaseButton = self.createButtonFactory(context, swipeUp, swipeDown, t9Letters);
    local createButtonWithHints = function(key, size, bounds, root, isUpper=true)
      local styleKey = if std.length(key) == 1 then 'number' + key else key;
      createBaseButton(key, size, bounds, root, isUpper) + {
        [if std.objectHas(root, styleKey + 'ButtonHintSymbolsStyle') then 'hintSymbolsStyle']: styleKey + 'ButtonHintSymbolsStyle',
      };
    local layout = layoutRoot['竖屏中文9键'];
    local hintDataOnlyCn2en = { cn2en: hintSymbolsData.pinyin_9.cn2en };
    local hintDataWithoutCn2en = {
      [k]: hintSymbolsData.pinyin_9[k]
      for k in std.objectFields(hintSymbolsData.pinyin_9)
      if k != 'cn2en'
    };
    slideForeground.slideForeground(theme) +
    hintSymbolsStyles.getStyle(theme, hintDataOnlyCn2en) +
    {
      preeditHeight: others[if orientation == 'portrait' then '竖屏' else '横屏']['preedit高度'],
      toolbarHeight: others[if orientation == 'portrait' then '竖屏' else '横屏']['toolbar高度'],
      keyboardHeight: others[if orientation == 'portrait' then '竖屏' else '横屏']['keyboard高度'],
    } +
    layout +
    hintSymbolsStyles.getStyle(theme, hintDataWithoutCn2en) +
    swipeStyles.getStyle('number', theme, swipeUp, swipeDown) +
    {
      collection: {
        size: { height: '3/4' },
        insets: { top: 6, bottom: 6 },
        backgroundStyle: 'collectionBackgroundStyle',
        type: 't9Symbols',
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
      alphabeticHintSymbolsBackgroundStyle: hintSymbolsStyles['长按背景样式'],
      alphabeticHintSymbolsSelectedStyle: hintSymbolsStyles['长按选中背景样式'],

      number1Button: createButtonWithHints('1', {}, {}, $, false) + {
        foregroundStyle: std.filter(function(x) x != null, [
          'number1ButtonSpecialForegroundStyle',
          if context.Settings.show_swipe then (if std.objectHas(swipeUp, '1') then 'number1ButtonUpForegroundStyle' else null) else null,
          if context.Settings.show_swipe then (if std.objectHas(swipeDown, '1') then 'number1ButtonDownForegroundStyle' else null) else null,
        ]),
        action: { character: '@' },
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
        action: { character: "'" },
      },
      number1ButtonPreeditForegroundStyle: {
        buttonStyleType: 'text',
        text: '分词',
        normalColor: color[theme]['按键前景颜色'],
        highlightColor: color[theme]['按键前景颜色'],
        fontSize: fontSize['中文九键字符键前景文字大小'],
        center: center['中文九键字符前景偏移'],
      },
    } +
    {
      ['number' + key + 'Button']: createButtonWithHints(key, {}, {}, $, false)
      for key in pinyin9T9.digitKeys
    } +
    {
      symbolButton: createButtonWithHints('symbol', layout['竖屏按键尺寸']['symbolButton'], {}, $, false) + {
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
      '123Button': createButtonWithHints('123', layout['竖屏按键尺寸']['123Button'], {}, $, false) + {
        backgroundStyle: 'systemButtonBackgroundStyle',
        foregroundStyle: '123ButtonForegroundStyle',
        action: { keyboardType: 'numeric' },
      },
      '123ButtonForegroundStyle': {
        buttonStyleType: 'systemImage',
        systemImageName: if context.Settings.fix_sf_symbol then 'textformat.123' else 'numbers',
        normalColor: color[theme]['按键前景颜色'],
        highlightColor: color[theme]['按键前景颜色'],
        fontSize: fontSize['按键前景文字大小'] - 3,
        center: center['功能键前景文字偏移'] { y: 0.5 },
      },
      emojiButton: createButtonWithHints('emoji', layout['竖屏按键尺寸']['emojiButton'], {}, $, false) + {
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
      spaceRightButtonPreeditForegroundStyle: {
        buttonStyleType: 'systemImage',
        systemImageName: if context.Settings.fix_sf_symbol then 'lightbulb' else 'lightbulb.max',
        normalColor: color[theme]['按键前景颜色'],
        highlightColor: color[theme]['按键前景颜色'],
        fontSize: fontSize['按键前景文字大小'],
      },
      cleanButton: createButtonWithHints('clean', layout['竖屏按键尺寸']['cleanButton'], {}, $, false) + {
        backgroundStyle: 'systemButtonBackgroundStyle',
        action: { shortcut: '#换行' },
        notification: ['cleanButtonPreeditNotification'],
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
        action: if context.withFunctionsRow then { shortcut: '#重输' } else { shortcut: '#rimeNextPage' },
        [if context.withFunctionsRow then null else 'swipeUpAction']: { shortcut: '#rimePreviousPage' },
        [if context.withFunctionsRow then null else 'swipeDownAction']: { shortcut: '#rimeNextPage' },
      },
      cleanButtonPreeditForegroundStyle: if context.withFunctionsRow then {
        buttonStyleType: 'text',
        text: '重输',
        normalColor: color[theme]['按键前景颜色'],
        highlightColor: color[theme]['按键前景颜色'],
        fontSize: fontSize['按键前景文字大小'] - 3,
      } else {
        buttonStyleType: 'systemImage',
        systemImageName: if context.Settings.fix_sf_symbol then 'arrow.up.arrow.down' else 'chevron.compact.up.chevron.compact.down',
        normalColor: color[theme]['按键前景颜色'],
        highlightColor: color[theme]['按键前景颜色'],
        fontSize: fontSize['数字键盘数字前景字体大小'],
      },
      spaceButton: p26Layout.spaceButton + {
        size: layout['竖屏按键尺寸']['spaceButton'],
        [if std.objectHas(swipeUp, 'space') then 'swipeUpAction']: swipeUp['space'].action,
      },
      spaceButtonForegroundStyle: p26Layout.spaceButtonForegroundStyle,
      spaceButtonForegroundStyle1: if std.objectHas(p26Layout, 'spaceButtonForegroundStyle1') then p26Layout.spaceButtonForegroundStyle1 else {},
      spaceButtonPreeditNotification: p26Layout.spaceButtonPreeditNotification,
      backspaceButton: createButtonWithHints('backspace', layout['竖屏按键尺寸']['backspaceButton'], {}, $, false) + {
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
      enterButton: createButtonWithHints('enter', layout['竖屏按键尺寸']['enterButton'], {}, $, false) + {
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
      alphabeticBackgroundStyle: {
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
      ButtonScaleAnimation: animation['26键按键动画'],
      symbols: pinyin9T9.symbols,
    } +
    pinyin9ButtonFactory.genT9Styles(t9Letters, theme, color, fontSize, center) +
    toolbar.getToolBar(theme) +
    utils.genNumberStyles(fontSize, color, theme, center) +
    functionButtonStyles.genFuncKeyStyles(fontSize, color, theme, center) +
    functions.makeFunctionButtons(orientation, {}, 'numeric'),
}
