// 组装 14 键与 18 键共用的拼音键盘逻辑。
local animation = import '../../../shared/styles/animation.libsonnet';
local center = import '../../../shared/styles/center.libsonnet';
local color = import '../../../shared/styles/color.libsonnet';
local fontSize = import '../../../shared/styles/fontSize.libsonnet';
local hintSymbolsData = import '../../../shared/data/hintSymbolsData.libsonnet';
local hintSymbolsStyles = import '../../../shared/styles/hintSymbolsStyles.libsonnet';
local keyHelpers = import '../../../shared/buttonHelpers/key.libsonnet';
local baseKeyStyles = import '../../../shared/styles/baseKeyStyles.libsonnet';
local others = import '../../../shared/styles/others.libsonnet';
local compactButtons = import 'buttons.libsonnet';
local slideButtonStyles = import '../../../shared/styles/slideButtonStyles.libsonnet';
local swipeData = import '../../../shared/data/swipeData.libsonnet';
local swipeKeyStyles = import '../../../shared/styles/swipeKeyStyles.libsonnet';
local toolbar = import '../../../shared/toolbar/iPhone.libsonnet';
local utils = import '../../../shared/styles/keyStyles.libsonnet';
local functions = import '../../../shared/functionButtons/iPhone.libsonnet';
local functionButtonStyles = import '../../../shared/functionButtons/styles.libsonnet';

{
  createButtonFactory(context, swipeUp, swipeDown, wanxiangSetting)::
    function(id, actionKey, size, bounds, root, theme)
      {
        size: size,
        [if bounds != {} then 'bounds']: bounds,
        backgroundStyle: 'alphabeticBackgroundStyle',
        foregroundStyle: std.filter(
          function(x) x != null,
          [
            id + 'ButtonForegroundStyle',
            if context.Settings.show_swipe then if std.objectHas(swipeUp, id) then id + 'ButtonUpForegroundStyle' else null else null,
            if context.Settings.show_swipe then if std.objectHas(swipeDown, id) then id + 'ButtonDownForegroundStyle' else null else null,
          ]
        ),
        [if std.length(actionKey) == 1 then 'uppercasedStateForegroundStyle']: std.filter(
          function(x) x != null,
          [
            id + 'ButtonUppercasedStateForegroundStyle',
            if context.Settings.show_swipe then if std.objectHas(swipeUp, id) then id + 'ButtonUpForegroundStyle' else null else null,
            if context.Settings.show_swipe then if std.objectHas(swipeDown, id) then id + 'ButtonDownForegroundStyle' else null else null,
          ]
        ),
        [if std.length(actionKey) == 1 then 'capsLockedStateForegroundStyle']: self.uppercasedStateForegroundStyle,
        hintStyle: id + 'ButtonHintStyle',
        action: {
          character: if context.Settings[wanxiangSetting] then std.asciiUpper(actionKey) else actionKey,
        },
        [if std.length(actionKey) == 1 then 'uppercasedStateAction']: {
          character: std.asciiUpper(actionKey),
        },
        [if std.objectHas(swipeUp, id) then 'swipeUpAction']: swipeUp[id].action,
        [if std.objectHas(swipeDown, id) then 'swipeDownAction']: swipeDown[id].action,
        [if std.objectHas(root, id + 'ButtonHintSymbolsStyle') then 'hintSymbolsStyle']: id + 'ButtonHintSymbolsStyle',
        animation: [
          'ButtonScaleAnimation',
        ],
      },

  build(context, keyboardLayout, spec, p26Layout)::
    local theme = context.theme;
    local orientation = context.orientation;
    local swipeDataRoot = swipeData.genSwipeData(context.deviceType);
    local swipeUp = if std.objectHas(swipeDataRoot, spec.swipeUpName) then swipeDataRoot[spec.swipeUpName] else {};
    local swipeDown = if std.objectHas(swipeDataRoot, spec.swipeDownName) then swipeDataRoot[spec.swipeDownName] else {};
    local hintStyles = hintSymbolsStyles.getStyle(theme, hintSymbolsData[spec.hintData]);
    local createButton = self.createButtonFactory(context, swipeUp, swipeDown, spec.wanxiangSetting);
    keyboardLayout[spec.layoutName] +
    swipeKeyStyles.getStyle('cn', theme, swipeUp, swipeDown) +
    toolbar.getToolBar(theme) +
    utils.genPinyinStyles(fontSize, color, theme, center) +
    functionButtonStyles.genFuncKeyStyles(fontSize, color, theme, center) +
    slideButtonStyles.slideButtonStyles(theme) +
    hintStyles +
    functions.makeFunctionButtons(orientation, keyboardLayout, 'pinyin') +
    baseKeyStyles.baseStyles(theme, orientation, context.Settings, color, animation, hintSymbolsStyles) +
    {
      preeditHeight: others[if orientation == 'portrait' then '竖屏' else '横屏']['preedit高度'],
      toolbarHeight: others[if orientation == 'portrait' then '竖屏' else '横屏']['toolbar高度'],
      keyboardHeight: others[if orientation == 'portrait' then '竖屏' else '横屏']['keyboard高度'],
    } +
    compactButtons.compactButtons(spec.keys, createButton, hintStyles, theme) +
    compactButtons.compactForegroundStyles(spec.keys, fontSize, color, theme) +
    compactButtons.commonFromP26(p26Layout, spec.sizes, hintStyles) +
    keyHelpers.hintStyles([k.id for k in spec.keys]),
}
