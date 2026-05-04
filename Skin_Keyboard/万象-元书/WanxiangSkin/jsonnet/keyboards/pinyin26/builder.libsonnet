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
  createButtonFactory(context, swipeUp, swipeDown, letters, foregroundSwipeUp=swipeUp, foregroundSwipeDown=swipeDown)::
    keyboard26ButtonFactory.create(context, swipeUp, swipeDown, {
      actionFactory(key): { character: key },
      uppercasedActionFactory(key): { character: std.asciiUpper(key) },
      notificationFactory(key): if std.member(letters, key) then [key + 'ButtonBackslashNotification'] else null,
      foregroundSwipeUp: foregroundSwipeUp,
      foregroundSwipeDown: foregroundSwipeDown,
    }),

  resolveSwipeAssistMode(context)::
    if context.deviceType == 'iPhone' && context.Settings.keyboard_layout == 26 then
      if std.member(['up', 'down', 'all'], context.Settings.swipe_assist_mode) then context.Settings.swipe_assist_mode else 'none'
    else
      'none',

  applySwipeAssistToMap(baseMap, letters, mode):: {
    [key]:
      if mode != 'none' && std.member(letters, key) then
        baseMap[key] + { action: { character: std.asciiUpper(key) } }
      else
        baseMap[key]
    for key in std.objectFields(baseMap)
  },

  removeSwipeAssistLabels(baseMap, letters, mode):: {
    [key]:
      if mode != 'none' && std.member(letters, key) && std.objectHas(baseMap[key], 'label') then
        { [field]: baseMap[key][field] for field in std.objectFields(baseMap[key]) if field != 'label' }
      else
        baseMap[key]
    for key in std.objectFields(baseMap)
  },

  extendHintDataForSwipeAssist(baseHintData, sourceMaps, letters, mode):: {
    [key]:
      if mode != 'none' && std.member(letters, key) then
        baseHintData[key] {
          selectedIndex: 2,
          list: baseHintData[key].list + std.flattenArrays([
            if std.objectHas(sourceMap, key) && std.objectHas(sourceMap[key], 'label') then
              [
                {
                  action: sourceMap[key].action,
                  label: sourceMap[key].label,
                } + if std.objectHas(sourceMap[key], 'fontSize') then { fontSize: sourceMap[key].fontSize } else {}
              ]
            else
              []
            for sourceMap in sourceMaps
          ]),
        }
      else
        baseHintData[key]
    for key in std.objectFields(baseHintData)
  },

  build(context, keyboardLayout)::
    local theme = context.theme;
    local orientation = context.orientation;
    local settings = context.Settings;
    local includeSemicolon = settings.keyboard_layout == 27;
    local swipeAssistMode = self.resolveSwipeAssistMode(context);
    local swipeDataRoot = swipeData.genSwipeData(context.deviceType);
    local rawSwipeUp = if std.objectHas(swipeDataRoot, 'swipe_up') then swipeDataRoot.swipe_up else {};
    local rawSwipeDown = if std.objectHas(swipeDataRoot, 'swipe_down') then swipeDataRoot.swipe_down else {};
    local swipeUp =
      if std.member(['up', 'all'], swipeAssistMode) then
        self.applySwipeAssistToMap(rawSwipeUp, letter26KeysSpecs.letters, swipeAssistMode)
      else
        rawSwipeUp;
    local swipeDown =
      if std.member(['down', 'all'], swipeAssistMode) then
        self.applySwipeAssistToMap(rawSwipeDown, letter26KeysSpecs.letters, swipeAssistMode)
      else
        rawSwipeDown;
    local swipeUpHint =
      if std.member(['up', 'all'], swipeAssistMode) then
        self.removeSwipeAssistLabels(rawSwipeUp, letter26KeysSpecs.letters, swipeAssistMode)
      else
        rawSwipeUp;
    local swipeDownHint =
      if std.member(['down', 'all'], swipeAssistMode) then
        self.removeSwipeAssistLabels(rawSwipeDown, letter26KeysSpecs.letters, swipeAssistMode)
      else
        rawSwipeDown;
    local letterSpecs = letter26KeysSpecs.get26KeySpecs(orientation, keyboardLayout, includeSemicolon);
    local letterKeys = [spec.key for spec in letterSpecs];
    local hintData =
      if swipeAssistMode == 'up' then
        self.extendHintDataForSwipeAssist(hintSymbolsData.pinyin, [rawSwipeUp], letter26KeysSpecs.letters, swipeAssistMode)
      else if swipeAssistMode == 'down' then
        self.extendHintDataForSwipeAssist(hintSymbolsData.pinyin, [rawSwipeDown], letter26KeysSpecs.letters, swipeAssistMode)
      else if swipeAssistMode == 'all' then
        self.extendHintDataForSwipeAssist(hintSymbolsData.pinyin, [rawSwipeUp, rawSwipeDown], letter26KeysSpecs.letters, swipeAssistMode)
      else
        hintSymbolsData.pinyin;
    local hintStyles = hintSymbolsStyles.getStyle(theme, hintData);
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
    local enableSwipeUpHint = !std.member(['up', 'all'], swipeAssistMode);
    local enableSwipeDownHint = !std.member(['down', 'all'], swipeAssistMode);
    local createButton = self.createButtonFactory(context, swipeUp, swipeDown, letter26KeysSpecs.getLetters(includeSemicolon), rawSwipeUp, rawSwipeDown);
    keyboardLayout[if orientation == 'portrait' then '竖屏中文26键' else '横屏中文26键'] +
    swipeKeyStyles.getStyle('cn', theme, swipeUp, swipeDown, fontSize, rawSwipeUp, rawSwipeDown, swipeUpHint, swipeDownHint) +
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
    keyHelpers.hintStyles(letterKeys, 'alphabeticHintBackgroundStyle', enableSwipeUpHint, enableSwipeDownHint) +
    extra27HintStyles +
    systemKeysPinyin26.build(theme, orientation, keyboardLayout, settings, color, fontSize, center, createButton, hintStyles, letterSpecs),
}
