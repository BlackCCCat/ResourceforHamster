// Build the 26-key alphabetic keyboard from shared context, layout data, and compactly assembled system key modules.
local center = import '../shared/center.libsonnet';
local color = import '../shared/color.libsonnet';
local fontSize = import '../shared/fontSize.libsonnet';
local keyboard26ButtonFactory = import 'keyboard26ButtonFactory.libsonnet';
local hintSymbolsData = import '../data/hintSymbolsData.libsonnet';
local hintSymbolsStyles = import '../shared/hintSymbolsStyles.libsonnet';
local keyBuilders = import '../keys/keyBuilders.libsonnet';
local letter26KeysSpecs = import '../keys/letter26KeysSpecs.libsonnet';
local others = import '../shared/others.libsonnet';
local slideForeground = import '../shared/slideForeground.libsonnet';
local swipeData = import '../data/swipeDataEn.libsonnet';
local swipeStyles = import '../swipe/index.libsonnet';
local toolbar = import '../toolbar/toolbarEn.libsonnet';
local utils = import '../utils/keyStyles.libsonnet';
local functions = import '../functionButtons/index.libsonnet';
local systemKeysAlphabetic26 = import '../specs/systemKeysAlphabetic26.libsonnet';
local functionButtonStyles = import '../functionButtons/styles.libsonnet';

{
  createButtonFactory(context, swipeUp, swipeDown)::
    keyboard26ButtonFactory.create(context, swipeUp, swipeDown, {
      actionFactory(key): { [if std.objectHas(others, '英文键盘方案') then 'character' else 'symbol']: key },
      uppercasedActionFactory(key): { [if std.objectHas(others, '英文键盘方案') then 'character' else 'symbol']: std.asciiUpper(key) },
    }),

  build(context, keyboardLayout)::
    local theme = context.theme;
    local orientation = context.orientation;
    local swipeDataRoot = swipeData.genSwipeenData(context.deviceType);
    local swipeUp = if std.objectHas(swipeDataRoot, 'swipe_up') then swipeDataRoot.swipe_up else {};
    local swipeDown = if std.objectHas(swipeDataRoot, 'swipe_down') then swipeDataRoot.swipe_down else {};
    local hintStyles = hintSymbolsStyles.getStyle(theme, hintSymbolsData.alphabetic);
    local letterSpecs = letter26KeysSpecs.get26KeySpecs(orientation, keyboardLayout);
    local letterKeys = [spec.key for spec in letterSpecs];
    local createButton = self.createButtonFactory(context, swipeUp, swipeDown);
    keyboardLayout[if orientation == 'portrait' then '竖屏英文26键' else '横屏英文26键'] +
    swipeStyles.getStyle('en', theme, swipeUp, swipeDown) +
    hintStyles +
    toolbar.getToolBar(theme) +
    utils.genAlphabeticStyles(fontSize, color, theme, center) +
    functionButtonStyles.genFuncKeyStyles(fontSize, color, theme, center) +
    slideForeground.slideForeground(theme) +
    functions.makeFunctionButtons(orientation, keyboardLayout, 'alphabetic') +
    {
      preeditHeight: others[if orientation == 'portrait' then '竖屏' else '横屏']['preedit高度'],
      toolbarHeight: others[if orientation == 'portrait' then '竖屏' else '横屏']['toolbar高度'],
      keyboardHeight: others[if orientation == 'portrait' then '竖屏' else '横屏']['keyboard高度'],
    } +
    keyBuilders.letterButtons(letterSpecs, createButton, hintStyles) +
    keyBuilders.hintStyles(letterKeys) +
    systemKeysAlphabetic26.build(theme, orientation, keyboardLayout, context.Settings, createButton, hintStyles),
}
