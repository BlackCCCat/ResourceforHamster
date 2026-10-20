// 组装英文 26 键键盘，汇合共享上下文、布局数据和系统键模块。
local appearance = import '../../../design/appearance.libsonnet';
local center = appearance.center;
local color = appearance.color;
local fontSize = appearance.fontSize;
local alphabeticData = import './data.libsonnet';
local hintSymbolsStyles = import '../../../components/key/longPress.libsonnet';
local keyFactory = import '../../../components/key/factory.libsonnet';
local letter26KeysSpecs = import '../base/letters.libsonnet';
local others = appearance.others;
local swipeStyles = import '../../../components/key/swipe.libsonnet';
local toolbar = import '../../../components/toolbar/iPhone.libsonnet';
local functionRow = import '../../../components/functionRow/index.libsonnet';
local systemKeysAlphabetic26 = import './systemKeys.libsonnet';
local functionButtonStyles = import '../../../components/functionRow/styles.libsonnet';
local toolbarOverrides = {
  switchKeyboardType: 'pinyin',
  switchKeyboardAsset: 'englishState',
};

{
  createButtonFactory(context, swipeUp, swipeDown)::
    keyFactory.createKeyboardButton(context, swipeUp, swipeDown, {
      actionFactory(key): { [if std.objectHas(others, '英文键盘方案') then 'character' else 'symbol']: key },
      uppercasedActionFactory(key): { [if std.objectHas(others, '英文键盘方案') then 'character' else 'symbol']: std.asciiUpper(key) },
    }),

  build(context, keyboardLayout)::
    local theme = context.theme;
    local orientation = context.orientation;
    local swipeDataRoot = alphabeticData.genSwipeenData(context.deviceType);
    local swipeUp = if std.objectHas(swipeDataRoot, 'swipe_up') then swipeDataRoot.swipe_up else {};
    local swipeDown = if std.objectHas(swipeDataRoot, 'swipe_down') then swipeDataRoot.swipe_down else {};
    local hintStyles = hintSymbolsStyles.getStyle(theme, alphabeticData.alphabetic);
    local letterSpecs = letter26KeysSpecs.get26KeySpecs(orientation, keyboardLayout);
    local letterKeys = [spec.key for spec in letterSpecs];
    local createButton = self.createButtonFactory(context, swipeUp, swipeDown);
    keyboardLayout[if orientation == 'portrait' then '竖屏英文26键' else '横屏英文26键'] +
    swipeStyles.getStyle('en', theme, swipeUp, swipeDown) +
    hintStyles +
    toolbar.getToolBar(theme, toolbarOverrides) +
    keyFactory.genAlphabeticStyles(fontSize, color, theme, center) +
    functionButtonStyles.genFuncKeyStyles(fontSize, color, theme, center) +
    swipeStyles.slideButtonStyles(theme) +
    functionRow.makeFunctionButtons(orientation, keyboardLayout, 'alphabetic') +
    {
      preeditHeight: others[if orientation == 'portrait' then '竖屏' else '横屏']['preedit高度'],
      toolbarHeight: others[if orientation == 'portrait' then '竖屏' else '横屏']['toolbar高度'],
      keyboardHeight: others[if orientation == 'portrait' then '竖屏' else '横屏']['keyboard高度'],
    } +
    keyFactory.letterButtons(letterSpecs, createButton, hintStyles) +
    keyFactory.hintStyles(letterKeys) +
    systemKeysAlphabetic26.build(theme, orientation, keyboardLayout, context.Settings, createButton, hintStyles),
}
