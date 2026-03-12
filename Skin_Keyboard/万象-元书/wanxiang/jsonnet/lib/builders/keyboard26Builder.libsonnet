// Build the 26-key pinyin keyboard from shared context, layout data, and existing style registries.
local animation = import '../shared/animation.libsonnet';
local keyboard26ButtonFactory = import 'keyboard26ButtonFactory.libsonnet';
local center = import '../shared/center.libsonnet';
local color = import '../shared/color.libsonnet';
local fontSize = import '../shared/fontSize.libsonnet';
local hintSymbolsData = import '../data/hintSymbolsData.libsonnet';
local hintSymbolsStyles = import '../shared/hintSymbolsStyles.libsonnet';
local keyBuilders = import '../keys/keyBuilders.libsonnet';
local keyboardBaseStyles = import '../shared/keyboardBaseStyles.libsonnet';
local letterKeySpecs = import '../keys/letterKeySpecs.libsonnet';
local others = import '../shared/others.libsonnet';
local slideForeground = import '../shared/slideForeground.libsonnet';
local systemKeysPinyin26 = import '../specs/systemKeysPinyin26.libsonnet';
local swipeData = import '../data/swipeData.libsonnet';
local swipeStyles = import '../swipe/index.libsonnet';
local toolbar = import '../toolbar/index.libsonnet';
local utils = import '../utils/index.libsonnet';
local functions = import '../functionButtons/index.libsonnet';
local functionButtonStyles = import '../functionButtons/styles.libsonnet';

{
  createButtonFactory(context, swipeUp, swipeDown, letters)::
    keyboard26ButtonFactory.create(context, swipeUp, swipeDown, {
      actionFactory(key): { character: key },
      uppercasedActionFactory(key): { character: std.asciiUpper(key) },
      notificationFactory(key): if std.member(letters, key) then [key + 'ButtonBackslashNotification'] else null,
    }),

  build(context, keyboardLayout)::
    local theme = context.theme;
    local orientation = context.orientation;
    local settings = context.Settings;
    local swipeDataRoot = swipeData.genSwipeData(context.deviceType);
    local swipeUp = if std.objectHas(swipeDataRoot, 'swipe_up') then swipeDataRoot.swipe_up else {};
    local swipeDown = if std.objectHas(swipeDataRoot, 'swipe_down') then swipeDataRoot.swipe_down else {};
    local letterSpecs = letterKeySpecs.get26KeySpecs(orientation, keyboardLayout);
    local letterKeys = [spec.key for spec in letterSpecs];
    local hintStyles = hintSymbolsStyles.getStyle(theme, hintSymbolsData.pinyin);
    local createButton = self.createButtonFactory(context, swipeUp, swipeDown, letterKeySpecs.letters);
    keyboardLayout[if orientation == 'portrait' then '竖屏中文26键' else '横屏中文26键'] +
    swipeStyles.getStyle('cn', theme, swipeUp, swipeDown) +
    hintStyles +
    toolbar.getToolBar(theme) +
    utils.genPinyinStyles(fontSize, color, theme, center) +
    functionButtonStyles.genFuncKeyStyles(fontSize, color, theme, center) +
    slideForeground.slideForeground(theme) +
    functions.makeFunctionButtons(orientation, keyboardLayout, 'pinyin') +
    keyboardBaseStyles.baseStyles(theme, orientation, settings, color, animation, hintSymbolsStyles) +
    {
      preeditHeight: others[if orientation == 'portrait' then '竖屏' else '横屏']['preedit高度'],
      toolbarHeight: others[if orientation == 'portrait' then '竖屏' else '横屏']['toolbar高度'],
      keyboardHeight: others[if orientation == 'portrait' then '竖屏' else '横屏']['keyboard高度'],
    } +
    keyBuilders.letterButtons(letterSpecs, createButton, hintStyles) +
    keyBuilders.hintStyles(letterKeys) +
    systemKeysPinyin26.build(theme, orientation, keyboardLayout, settings, color, fontSize, center, createButton, hintStyles, letterSpecs),
}
