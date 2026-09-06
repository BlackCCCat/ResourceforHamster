// 组装 14 键与 18 键共用的拼音键盘逻辑。
local appearance = import '../../../design/appearance.libsonnet';
local animation = appearance.animation;
local center = appearance.center;
local color = appearance.color;
local fontSize = appearance.fontSize;
local hintSymbolsStyles = import '../../../components/key/longPress.libsonnet';
local keyFactory = import '../../../components/key/factory.libsonnet';
local baseKeyStyles = import '../../../design/baseKeyStyles.libsonnet';
local others = appearance.others;
local compactButtons = import './buttons.libsonnet';
local swipeStyles = import '../../../components/key/swipe.libsonnet';
local toolbar = import '../../../components/toolbar/iPhone.libsonnet';
local functionRow = import '../../../components/functionRow/index.libsonnet';
local functionButtonStyles = import '../../../components/functionRow/styles.libsonnet';
local systemKeys = import '../../../components/systemKeys/index.libsonnet';

{
  createButtonFactory(context, swipeUp, swipeDown, wanxiangSetting=null)::
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
          local isWanxiangSetting =
            std.type(wanxiangSetting) == "string"
            && wanxiangSetting != ""
            && std.get(context.Settings, wanxiangSetting, false),
          character: if isWanxiangSetting then std.asciiUpper(actionKey) else actionKey,
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

  build(context, keyboardLayout, spec, familyData)::
    local theme = context.theme;
    local orientation = context.orientation;
    local swipeDataRoot = familyData.genSwipeData(context.deviceType);
    local swipeUp = if std.objectHas(swipeDataRoot, spec.swipeUpName) then swipeDataRoot[spec.swipeUpName] else {};
    local swipeDown = if std.objectHas(swipeDataRoot, spec.swipeDownName) then swipeDataRoot[spec.swipeDownName] else {};
    local hintStyles = hintSymbolsStyles.getStyle(theme, familyData[spec.hintData]);
    local sharedSystemKeys = systemKeys.buildReusable(context, keyboardLayout);
    local createButton = self.createButtonFactory(context, swipeUp, swipeDown, std.get(spec, "wanxiangSetting", null));
    keyboardLayout[spec.layoutName] +
    swipeStyles.getStyle('cn', theme, swipeUp, swipeDown) +
    toolbar.getToolBar(theme) +
    keyFactory.genPinyinStyles(fontSize, color, theme, center) +
    functionButtonStyles.genFuncKeyStyles(fontSize, color, theme, center) +
    swipeStyles.slideButtonStyles(theme) +
    hintStyles +
    functionRow.makeFunctionButtons(orientation, keyboardLayout, 'pinyin') +
    baseKeyStyles.baseStyles(theme, orientation, context.Settings, color, animation, hintSymbolsStyles) +
    {
      preeditHeight: others[if orientation == 'portrait' then '竖屏' else '横屏']['preedit高度'],
      toolbarHeight: others[if orientation == 'portrait' then '竖屏' else '横屏']['toolbar高度'],
      keyboardHeight: others[if orientation == 'portrait' then '竖屏' else '横屏']['keyboard高度'],
    } +
    compactButtons.compactButtons(spec.keys, createButton, hintStyles, theme) +
    compactButtons.compactForegroundStyles(spec.keys, fontSize, color, theme) +
    compactButtons.commonSystemKeys(sharedSystemKeys, spec.sizes, hintStyles) +
    keyFactory.hintStyles([k.id for k in spec.keys]),
}
