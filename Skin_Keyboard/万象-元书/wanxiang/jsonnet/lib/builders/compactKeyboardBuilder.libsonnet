// Build compact pinyin keyboards by combining a layout spec with shared 26-key system keys and style registries.
local animation = import '../shared/animation.libsonnet';
local center = import '../shared/center.libsonnet';
local color = import '../shared/color.libsonnet';
local fontSize = import '../shared/fontSize.libsonnet';
local hintSymbolsData = import '../data/hintSymbolsData.libsonnet';
local hintSymbolsStyles = import '../shared/hintSymbolsStyles.libsonnet';
local keyBuilders = import '../keys/keyBuilders.libsonnet';
local keyboardBaseStyles = import '../shared/keyboardBaseStyles.libsonnet';
local others = import '../shared/others.libsonnet';
local pinyinCompact = import '../keys/pinyinCompact.libsonnet';
local slideForeground = import '../shared/slideForeground.libsonnet';
local swipeData = import '../data/swipeData.libsonnet';
local swipeStyles = import '../swipe/index.libsonnet';
local toolbar = import '../toolbar/index.libsonnet';
local utils = import '../utils/index.libsonnet';
local functions = import '../functionButtons/index.libsonnet';
local functionButtonStyles = import '../functionButtons/styles.libsonnet';

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
    swipeStyles.getStyle('cn', theme, swipeUp, swipeDown) +
    toolbar.getToolBar(theme) +
    utils.genPinyinStyles(fontSize, color, theme, center) +
    functionButtonStyles.genFuncKeyStyles(fontSize, color, theme, center) +
    slideForeground.slideForeground(theme) +
    hintStyles +
    functions.makeFunctionButtons(orientation, keyboardLayout, 'pinyin') +
    keyboardBaseStyles.baseStyles(theme, orientation, context.Settings, color, animation, hintSymbolsStyles) +
    {
      preeditHeight: others[if orientation == 'portrait' then '竖屏' else '横屏']['preedit高度'],
      toolbarHeight: others[if orientation == 'portrait' then '竖屏' else '横屏']['toolbar高度'],
      keyboardHeight: others[if orientation == 'portrait' then '竖屏' else '横屏']['keyboard高度'],
    } +
    pinyinCompact.compactButtons(spec.keys, createButton, hintStyles, theme) +
    pinyinCompact.compactForegroundStyles(spec.keys, fontSize, color, theme) +
    pinyinCompact.commonFromP26(p26Layout, spec.sizes, hintStyles) +
    keyBuilders.hintStyles([k.id for k in spec.keys]),
}
