// Define the English 26-key system keys and shared background styles so the alphabetic builder stays focused on assembly.
local animation = import '../shared/animation.libsonnet';
local center = import '../shared/center.libsonnet';
local color = import '../shared/color.libsonnet';
local fontSize = import '../shared/fontSize.libsonnet';
local hintSymbolsStyles = import '../shared/hintSymbolsStyles.libsonnet';

local config(settings) =
  if std.objectHas(settings, 'button_123_config') then settings.button_123_config else {};

local enableSlide(settings) =
  if std.objectHas(config(settings), 'enable_slide') then config(settings).enable_slide else true;

local secondaryActionMode(settings) =
  if std.objectHas(config(settings), 'secondary_action_mode') then config(settings).secondary_action_mode else 'hint_symbols';

local normalizeKeyboardType(value, fallback) =
  if value == 'symbolic' || value == 'emojis' then value else fallback;

local swipeMapping(settings) =
  local conf = config(settings);
  local up = normalizeKeyboardType(
    if std.objectHas(conf, 'swipe_up_keyboard') then conf.swipe_up_keyboard else 'symbolic',
    'symbolic'
  );
  local downDefault = if up == 'symbolic' then 'emojis' else 'symbolic';
  local down = normalizeKeyboardType(
    if std.objectHas(conf, 'swipe_down_keyboard') then conf.swipe_down_keyboard else downDefault,
    downDefault
  );
  if down == up then
    {
      up: up,
      down: if up == 'symbolic' then 'emojis' else 'symbolic',
    }
  else
    {
      up: up,
      down: down,
    };

local hintData = {
  '123': {
    selectedIndex: 0,
    list: [
      {
        action: { keyboardType: 'symbolic' },
        label: { systemImageName: 'command.circle.fill' },
        fontSize: 16,
      },
      {
        action: { keyboardType: 'emojis' },
        label: { systemImageName: 'face.dashed' },
        fontSize: 16,
      },
    ],
  },
};

{
  build(theme, orientation, keyboardLayout, settings, createButton, hintStyles):: (
    local slideEnabled = enableSlide(settings);
    local useHintSymbols = !slideEnabled && secondaryActionMode(settings) == 'hint_symbols';
    local useSwipeActions = !slideEnabled && secondaryActionMode(settings) == 'swipe';
    local swipeTargets = swipeMapping(settings);
    local extraHintStyles = if useHintSymbols then hintSymbolsStyles.getStyle(theme, hintData) else {};
    {
    shiftButton: createButton(
      'shift',
      if orientation == 'portrait' then keyboardLayout['竖屏按键尺寸']['shift键size'] else keyboardLayout['横屏按键尺寸']['shift键size'],
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
    },
    shiftButtonUppercasedForegroundStyle: {
      buttonStyleType: 'systemImage',
      systemImageName: 'shift.fill',
      normalColor: color[theme]['按键前景颜色'],
      highlightColor: color[theme]['按键前景颜色'],
      fontSize: fontSize['按键前景文字大小'],
    },
    shiftButtonCapsLockedForegroundStyle: {
      buttonStyleType: 'systemImage',
      systemImageName: 'capslock.fill',
      normalColor: color[theme]['按键前景颜色'],
      highlightColor: color[theme]['按键前景颜色'],
      fontSize: fontSize['按键前景文字大小'],
    },

    backspaceButton: createButton(
      'backspace',
      if orientation == 'portrait' then keyboardLayout['竖屏按键尺寸']['backspace键size'] else keyboardLayout['横屏按键尺寸']['backspace键size'],
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
    },

    en2cnButton: createButton(
      'en2cn',
      if orientation == 'portrait' then keyboardLayout['竖屏按键尺寸']['en2cn键size'] else keyboardLayout['横屏按键尺寸']['en2cn键size'],
      {},
      $,
      false
    ) + {
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
      if orientation == 'portrait' then keyboardLayout['竖屏按键尺寸']['123键size'] else keyboardLayout['横屏按键尺寸']['123键size'],
      {},
      $ + extraHintStyles,
      false
    ) + {
      backgroundStyle: 'systemButtonBackgroundStyle',
      [if slideEnabled then 'type']: 'horizontalSymbols',
      [if slideEnabled then 'maxColumns']: 1,
      [if slideEnabled then 'contentRightToLeft']: false,
      [if slideEnabled then 'insets']: { left: 3, right: 3 },
      [if slideEnabled then 'dataSource']: '123ButtonSymbolsDataSource',
      [if !slideEnabled then 'action']: { keyboardType: 'numeric' },
      [if !slideEnabled then 'foregroundStyle']: ['123ButtonForegroundStyle'],
      [if useHintSymbols then 'hintSymbolsStyle']: '123ButtonHintSymbolsStyle',
      [if useSwipeActions then 'swipeUpAction']: { keyboardType: swipeTargets.up },
      [if useSwipeActions then 'swipeDownAction']: { keyboardType: swipeTargets.down },
      [if !slideEnabled && !useSwipeActions then 'swipeUpAction']:: null,
      [if !slideEnabled && !useSwipeActions then 'swipeDownAction']:: null,
    },
    '123ButtonSymbolsDataSource': [
      { label: '1', action: { keyboardType: 'numeric' }, styleName: 'numericStyle' },
      { label: '2', action: { keyboardType: 'symbolic' }, styleName: 'symbolicStyle' },
      { label: '4', action: { keyboardType: 'emojis' }, styleName: 'emojisStyle' },
    ],
    } + extraHintStyles + {

    spaceButton: createButton(
      'space',
      if orientation == 'portrait' then keyboardLayout['竖屏按键尺寸']['space键size'] else keyboardLayout['横屏按键尺寸']['space键size'],
      {},
      $,
      false
    ) + {
      backgroundStyle: 'alphabeticBackgroundStyle',
      foregroundStyle: [
        'spaceButtonForegroundStyle',
        if settings.show_wanxiang then 'spaceButtonForegroundStyle1' else null,
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

    spaceFirstButton: createButton(
      'spaceFirst',
      if orientation == 'portrait' then keyboardLayout['竖屏按键尺寸']['space键size'] else keyboardLayout['横屏按键尺寸']['spaceFirst键size'],
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

    spaceSecondButton: createButton(
      'spaceSecond',
      if orientation == 'portrait' then keyboardLayout['竖屏按键尺寸']['space键size'] else keyboardLayout['横屏按键尺寸']['spaceSecond键size'],
      {},
      $,
      false
    ) + {
      backgroundStyle: 'alphabeticBackgroundStyle',
      foregroundStyle: [
        'spaceSecondButtonForegroundStyle',
        if settings.show_wanxiang then 'spaceSecondButtonForegroundStyle1' else null,
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
      if orientation == 'portrait' then keyboardLayout['竖屏按键尺寸']['spaceRight键size'] else keyboardLayout['横屏按键尺寸']['spaceRight键size'],
      {},
      $,
      false
    ),
    spaceRightButton: srBtn {
      foregroundStyle: [
        'spaceRightButtonForegroundStyle',
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
    },
    spaceRightButtonForegroundStyle2: {
      buttonStyleType: 'text',
      text: '.',
      normalColor: color[theme]['按键前景颜色'],
      highlightColor: color[theme]['按键前景颜色'],
      fontSize: fontSize['按键前景文字大小'],
    },

    local slBtn = createButton(
      'spaceLeft',
      if orientation == 'portrait' then keyboardLayout['竖屏按键尺寸']['spaceRight键size'] else keyboardLayout['横屏按键尺寸']['spaceRight键size'],
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

    enterButton: createButton(
      'enter',
      if orientation == 'portrait' then keyboardLayout['竖屏按键尺寸']['enter键size'] else keyboardLayout['横屏按键尺寸']['enter键size'],
      {},
      $,
      false
    ) + {
      [if std.objectHas(hintStyles, 'enterButtonHintSymbolsStyle') then 'hintSymbolsStyle']: 'enterButtonHintSymbolsStyle',
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
      insets: if orientation == 'portrait' then settings.button_insets.portrait else settings.button_insets.landscape,
      normalColor: color[theme]['enter键背景(蓝色)'],
      highlightColor: color[theme]['功能键背景颜色-高亮'],
      cornerRadius: settings.cornerRadius,
      normalLowerEdgeColor: color[theme]['底边缘颜色-普通'],
      highlightLowerEdgeColor: color[theme]['底边缘颜色-高亮'],
    },

    alphabeticBackgroundStyle: {
      buttonStyleType: 'geometry',
      insets: if orientation == 'portrait' then settings.button_insets.portrait else settings.button_insets.landscape,
      normalColor: color[theme]['字母键背景颜色-普通'],
      highlightColor: color[theme]['字母键背景颜色-高亮'],
      cornerRadius: settings.cornerRadius,
      normalLowerEdgeColor: color[theme]['底边缘颜色-普通'],
      highlightLowerEdgeColor: color[theme]['底边缘颜色-高亮'],
    },
    systemButtonBackgroundStyle: {
      buttonStyleType: 'geometry',
      insets: if orientation == 'portrait' then settings.button_insets.portrait else settings.button_insets.landscape,
      normalColor: color[theme]['功能键背景颜色-普通'],
      highlightColor: color[theme]['功能键背景颜色-高亮'],
      cornerRadius: settings.cornerRadius,
      normalLowerEdgeColor: color[theme]['底边缘颜色-普通'],
      highlightLowerEdgeColor: color[theme]['底边缘颜色-高亮'],
    },
    ButtonScaleAnimation: animation['26键按键动画'],
    alphabeticHintBackgroundStyle: {
      buttonStyleType: 'geometry',
      normalColor: color[theme]['气泡背景颜色'],
      highlightColor: color[theme]['气泡高亮颜色'],
      cornerRadius: settings.cornerRadius,
      shadowColor: color[theme]['长按背景阴影颜色'],
      shadowOffset: { x: 0, y: 5 },
    },
    alphabeticHintSymbolsBackgroundStyle: hintSymbolsStyles['长按背景样式'],
    alphabeticHintSymbolsSelectedStyle: hintSymbolsStyles['长按选中背景样式'],

    garyReturnKeyTypeNotification: {
      notificationType: 'returnKeyType',
      returnKeyType: [0, 2, 3, 5, 8, 10, 11],
      backgroundStyle: 'systemButtonBackgroundStyle',
      foregroundStyle: 'enterButtonForegroundStyle0',
    },
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
    }
  ),
}
