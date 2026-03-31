// 组装拼音 26 键键盘，汇合共享上下文、布局数据和样式注册。
local animation = import '../../shared/styles/animation.libsonnet';
local keyboard26ButtonFactory = import '../common/keyboard26/buttonFactory.libsonnet';
local center = import '../../shared/styles/center.libsonnet';
local color = import '../../shared/styles/color.libsonnet';
local fontSize = import '../../shared/styles/fontSize.libsonnet';
local hintSymbolsData = import '../../shared/data/hintSymbolsData.libsonnet';
local hintSymbolsStyles = import '../../shared/styles/hintSymbolsStyles.libsonnet';
local keyHelpers = import '../../shared/buttonHelpers/key.libsonnet';
local baseKeyStyles = import '../../shared/styles/baseKeyStyles.libsonnet';
local letter26KeysSpecs = import '../common/keyboard26/letters.libsonnet';
local others = import '../../shared/styles/others.libsonnet';
local slideButtonStyles = import '../../shared/styles/slideButtonStyles.libsonnet';
local systemKeysPinyin26 = import '../common/systemKeys26/systemKeysSpec.libsonnet';
local swipeData = import '../../shared/data/swipeData.libsonnet';
local swipeKeyStyles = import '../../shared/styles/swipeKeyStyles.libsonnet';
local toolbar = import '../../shared/toolbar/iPhone.libsonnet';
local utils = import '../../shared/styles/keyStyles.libsonnet';
local functions = import '../../shared/functionButtons/iPhone.libsonnet';
local functionButtonStyles = import '../../shared/functionButtons/styles.libsonnet';

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
    local includeSemicolon = settings.keyboard_layout == 27;
    local swipeDataRoot = swipeData.genSwipeData(context.deviceType);
    local swipeUp = if std.objectHas(swipeDataRoot, 'swipe_up') then swipeDataRoot.swipe_up else {};
    local swipeDown = if std.objectHas(swipeDataRoot, 'swipe_down') then swipeDataRoot.swipe_down else {};
    local letterSpecs = letter26KeysSpecs.get26KeySpecs(orientation, keyboardLayout, includeSemicolon);
    local letterKeys = [spec.key for spec in letterSpecs];
    local hintStyles = hintSymbolsStyles.getStyle(theme, hintSymbolsData.pinyin);
    local extra27HintStyles =
      if includeSemicolon then
        {
          ';ButtonHintForegroundStyle': utils.makeTextStyle(
            ';',
            fontSize['26键字母前景文字大小'],
            color[theme]['按键前景颜色'],
            color[theme]['按键前景颜色'],
            center['划动气泡文字偏移']
          ),
        }
      else
        {};
    local createButton = self.createButtonFactory(context, swipeUp, swipeDown, letter26KeysSpecs.getLetters(includeSemicolon));
    keyboardLayout[if orientation == 'portrait' then '竖屏中文26键' else '横屏中文26键'] +
    swipeKeyStyles.getStyle('cn', theme, swipeUp, swipeDown) +
    hintStyles +
    toolbar.getToolBar(theme) +
    utils.genPinyinStyles(fontSize, color, theme, center) +
    functionButtonStyles.genFuncKeyStyles(fontSize, color, theme, center) +
    slideButtonStyles.slideButtonStyles(theme) +
    functions.makeFunctionButtons(orientation, keyboardLayout, 'pinyin') +
    baseKeyStyles.baseStyles(theme, orientation, settings, color, animation, hintSymbolsStyles) +
    {
      preeditHeight: others[if orientation == 'portrait' then '竖屏' else '横屏']['preedit高度'],
      toolbarHeight: others[if orientation == 'portrait' then '竖屏' else '横屏']['toolbar高度'],
      keyboardHeight: others[if orientation == 'portrait' then '竖屏' else '横屏']['keyboard高度'],
    } +
    keyHelpers.letterButtons(letterSpecs, createButton, hintStyles) +
    keyHelpers.hintStyles(letterKeys) +
    extra27HintStyles +
    systemKeysPinyin26.build(theme, orientation, keyboardLayout, settings, color, fontSize, center, createButton, hintStyles, letterSpecs),
}
