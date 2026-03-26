// 定义英文 26 键系统键及其共享背景样式。
local animation = import '../../shared/styles/animation.libsonnet';
local center = import '../../shared/styles/center.libsonnet';
local color = import '../../shared/styles/color.libsonnet';
local fontSize = import '../../shared/styles/fontSize.libsonnet';
local hintSymbolsStyles = import '../../shared/styles/hintSymbolsStyles.libsonnet';
local keyHelpers = import '../../shared/buttonHelpers/key.libsonnet';
local swipeKeyStyles = import '../../shared/styles/swipeKeyStyles.libsonnet';
local styleFactories = import '../../shared/styles/styleFactories.libsonnet';
local buttonInteraction = import '../../shared/buttonHelpers/buttonInteraction.libsonnet';
local returnKeyHelpers = import '../../shared/buttonHelpers/returnKey.libsonnet';

{
  build(theme, orientation, keyboardLayout, settings, createButton, hintStyles):: (
    local makeAlphabeticSystemImageForegroundStyle(systemImageName, fontSizeDelta=0, extraCenter={}) =
      // 生成英文 26 键系统图标前景。
      styleFactories.makeSystemImageStyle(
        systemImageName,
        fontSize['按键前景文字大小'] + fontSizeDelta,
        color[theme]['按键前景颜色'],
        color[theme]['按键前景颜色'],
        extraCenter
      );
    local makeAlphabeticAssetImageForegroundStyle(assetImageName, fontSizeDelta=0, extraCenter={}) =
      // 生成英文 26 键资源图前景。
      {
        buttonStyleType: 'assetImage',
        assetImageName: assetImageName,
        normalColor: color[theme]['按键前景颜色'],
        highlightColor: color[theme]['按键前景颜色'],
        fontSize: fontSize['按键前景文字大小'] + fontSizeDelta,
        center: extraCenter,
      };
    local makeAlphabeticTextForegroundStyle(textValue, normalColor, fontSizeDelta=0, extraCenter={}) =
      // 生成英文 26 键文字前景。
      styleFactories.makeTextStyle(
        textValue,
        fontSize['按键前景文字大小'] + fontSizeDelta,
        normalColor,
        normalColor,
        extraCenter
      );
    local makeSpaceForegroundStyle() =
      // 生成主空格图标前景。
      makeAlphabeticSystemImageForegroundStyle('space', -3, center['功能键前景文字偏移']);
    local makeAlphabeticSpaceMarkerStyle(posX) =
      // 生成英文主空格角标前景。
      makeAlphabeticTextForegroundStyle('A', color[theme]['划动字符颜色'], -10, { x: posX, y: 0.8 });
    local makeSpaceTextForegroundStyle(textValue, sizeDelta=0, extraCenter={}) =
      // 生成空格侧键文字前景。
      makeAlphabeticTextForegroundStyle(textValue, color[theme]['按键前景颜色'], sizeDelta, extraCenter);
    local button123 = buttonInteraction.button123;
    local slideEnabled = button123.enableSlide(settings);
    local useHintSymbols = !slideEnabled && button123.secondaryActionMode(settings) == 'hint_symbols';
    local useSwipeActions = !slideEnabled && button123.secondaryActionMode(settings) == 'swipe';
    local showIndicators = settings.show_swipe && useSwipeActions && button123.showSwipeIndicators(settings);
    local swipeTargets = button123.swipeMapping(settings);
    local extraHintStyles = if useHintSymbols then hintSymbolsStyles.getStyle(theme, button123.hintData) else {};
    local extraSwipeStyles =
      if useSwipeActions then
        swipeKeyStyles.getStyle(
          'cn',
          theme,
          { '123': button123.keyboardSwipeStyleData(swipeTargets.up) },
          { '123': button123.keyboardSwipeStyleData(swipeTargets.down) }
        )
      else
        {};
    local makeButtonBackground(normalKey, highlightKey) =
      // 生成英文 26 键中的通用按键背景。
      styleFactories.makeGeometryStyle(color[theme][normalKey], {
        insets: if orientation == 'portrait' then settings.button_insets.portrait else settings.button_insets.landscape,
        highlightColor: color[theme][highlightKey],
        cornerRadius: settings.cornerRadius,
        normalLowerEdgeColor: color[theme]['底边缘颜色-普通'],
        highlightLowerEdgeColor: color[theme]['底边缘颜色-高亮'],
      });
    local makeHintBackground() =
      // 生成英文 26 键长按气泡背景。
      styleFactories.makeGeometryStyle(color[theme]['气泡背景颜色'], {
        highlightColor: color[theme]['气泡高亮颜色'],
        cornerRadius: settings.cornerRadius,
        shadowColor: color[theme]['长按背景阴影颜色'],
        shadowOffset: { x: 0, y: 5 },
      });
    local makeEnterForegroundStyle(textValue, useBlueText=false) =
      returnKeyHelpers.makeForeground(
        styleFactories,
        theme,
        color,
        fontSize,
        center,
        textValue,
        if useBlueText then {
          normalColor: color[theme]['长按选中字体颜色'],
          highlightColor: color[theme]['长按非选中字体颜色'],
        } else {}
      );
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
    shiftButtonForegroundStyle: makeAlphabeticSystemImageForegroundStyle('shift'),
    shiftButtonUppercasedForegroundStyle: makeAlphabeticSystemImageForegroundStyle('shift.fill'),
    shiftButtonCapsLockedForegroundStyle: makeAlphabeticSystemImageForegroundStyle('capslock.fill'),

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
    backspaceButtonForegroundStyle: makeAlphabeticSystemImageForegroundStyle('delete.left') + { targetScale: 0.7 },

    en2cnButton: createButton(
      'en2cn',
      if orientation == 'portrait' then keyboardLayout['竖屏按键尺寸']['en2cn键size'] else keyboardLayout['横屏按键尺寸']['en2cn键size'],
      {},
      $,
      false
    ) + {
      action: { keyboardType: 'pinyin' },
      [if settings.keyboard_layout != 26 then 'swipeUpAction']: { keyboardType: 'temp_pinyin' },
    },
    en2cnButtonForegroundStyle:
      // 生成中英切换按钮前景。
      makeAlphabeticAssetImageForegroundStyle('englishState', -3, center['功能键前景文字偏移'] { y: 0.5 }),

    '123Button': createButton(
      '123',
      if orientation == 'portrait' then keyboardLayout['竖屏按键尺寸']['123键size'] else keyboardLayout['横屏按键尺寸']['123键size'],
      {},
      $ + extraHintStyles + extraSwipeStyles + keyHelpers.hintStyle('123'),
      false
    ) + {
      backgroundStyle: 'systemButtonBackgroundStyle',
      [if slideEnabled then 'type']: 'horizontalSymbols',
      [if slideEnabled then 'maxColumns']: 1,
      [if slideEnabled then 'contentRightToLeft']: false,
      [if slideEnabled then 'insets']: { left: 3, right: 3 },
      [if slideEnabled then 'dataSource']: '123ButtonSymbolsDataSource',
      [if !slideEnabled then 'action']: { keyboardType: 'numeric' },
      [if !slideEnabled then 'foregroundStyle']:
        ['123ButtonForegroundStyle'] +
        (if showIndicators then ['123ButtonUpForegroundStyle', '123ButtonDownForegroundStyle'] else []),
      hintStyle:: null,
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
    } + extraHintStyles + extraSwipeStyles + keyHelpers.hintStyle('123') + {

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
      [if settings.keyboard_layout != 26 then 'swipeUpAction']: { sendKeys: 'Shift+space' },
    },
    // 主空格键
    spaceButtonForegroundStyle: makeSpaceForegroundStyle(),
    spaceButtonForegroundStyle1: makeAlphabeticSpaceMarkerStyle(0.9),

    spaceFirstButton: createButton(
      'spaceFirst',
      if orientation == 'portrait' then keyboardLayout['竖屏按键尺寸']['space键size'] else keyboardLayout['横屏按键尺寸']['spaceFirst键size'],
      {},
      $,
      false
    ) + {
      backgroundStyle: 'alphabeticBackgroundStyle',
      action: 'space',
      [if settings.keyboard_layout != 26 then 'swipeUpAction']: { sendKeys: 'Shift+space' },
    },
    // 左侧空格键
    spaceFirstButtonForegroundStyle: makeSpaceForegroundStyle(),

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
      [if settings.keyboard_layout != 26 then 'swipeUpAction']: { sendKeys: 'Shift+space' },
    },
    // 右侧空格键
    spaceSecondButtonForegroundStyle: makeSpaceForegroundStyle(),
    spaceSecondButtonForegroundStyle1: makeAlphabeticSpaceMarkerStyle(0.9),

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
    // 右侧标点键
    spaceRightButtonForegroundStyle: makeSpaceTextForegroundStyle('.'),
    spaceRightButtonForegroundStyle2: makeSpaceTextForegroundStyle('.'),

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
    // 左侧标点键
    spaceLeftButtonForegroundStyle: makeSpaceTextForegroundStyle(',', 0, { y: 0.5 }),
    spaceLeftButtonForegroundStyle2: makeSpaceTextForegroundStyle('.', 0, { y: 0.3 }),

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
    // 回车键前景
    enterButtonForegroundStyle0: makeEnterForegroundStyle('Enter'),
    enterButtonForegroundStyle6: makeEnterForegroundStyle('Search', true),
    enterButtonForegroundStyle7: makeEnterForegroundStyle('Send', true),
    enterButtonForegroundStyle14: makeEnterForegroundStyle('Go', true),
    enterButtonForegroundStyle9: makeEnterForegroundStyle('Done', true),
    enterButtonBlueBackgroundStyle: makeButtonBackground('enter键背景(蓝色)', '功能键背景颜色-高亮'),

    alphabeticBackgroundStyle: makeButtonBackground('字母键背景颜色-普通', '字母键背景颜色-高亮'),
    systemButtonBackgroundStyle: makeButtonBackground('功能键背景颜色-普通', '功能键背景颜色-高亮'),
    ButtonScaleAnimation: animation['26键按键动画'],
    alphabeticHintBackgroundStyle: makeHintBackground(),
    alphabeticHintSymbolsBackgroundStyle: hintSymbolsStyles['长按背景样式'],
    alphabeticHintSymbolsSelectedStyle: hintSymbolsStyles['长按选中背景样式'],

    // returnKeyType 通知
    garyReturnKeyTypeNotification: returnKeyHelpers.makeNotification([0, 2, 3, 5, 8, 10, 11], 'systemButtonBackgroundStyle', 'enterButtonForegroundStyle0'),
    blueReturnKeyTypeNotification14: returnKeyHelpers.makeNotification([1, 4], 'enterButtonBlueBackgroundStyle', 'enterButtonForegroundStyle14'),
    blueReturnKeyTypeNotification6: returnKeyHelpers.makeNotification([6], 'enterButtonBlueBackgroundStyle', 'enterButtonForegroundStyle6'),
    blueReturnKeyTypeNotification7: returnKeyHelpers.makeNotification([7], 'enterButtonBlueBackgroundStyle', 'enterButtonForegroundStyle7'),
    blueReturnKeyTypeNotification9: returnKeyHelpers.makeNotification([9], 'enterButtonBlueBackgroundStyle', 'enterButtonForegroundStyle9'),
    }
  ),
}
