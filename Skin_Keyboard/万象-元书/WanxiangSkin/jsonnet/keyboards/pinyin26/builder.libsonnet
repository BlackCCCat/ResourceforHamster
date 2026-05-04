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

  extractHintAssistParts(baseList, key):: {
    lower:
      std.filter(
        function(item) std.objectHas(item.action, 'character') && item.action.character == key,
        baseList
      )[0],
    upper:
      std.filter(
        function(item) std.objectHas(item.action, 'character') && item.action.character == std.asciiUpper(key),
        baseList
      )[0],
    kp:
      local matches = std.filter(
        function(item) std.objectHas(item.action, 'sendKeys') && std.substr(item.action.sendKeys, 0, 3) == 'KP_',
        baseList
      );
      if std.length(matches) > 0 then matches[0] else null,
  },

  buildHintAssistItem(sourceMap, key)::
    if std.objectHas(sourceMap, key) && std.objectHas(sourceMap[key], 'label') then
      {
        action: sourceMap[key].action,
        label: sourceMap[key].label,
      } + if std.objectHas(sourceMap[key], 'fontSize') then { fontSize: sourceMap[key].fontSize } else {}
    else
      null,

  orderHintAssistList(key, parts, upItem, downItem, mode)::
    local row1Left = ['q', 'w', 'e', 'r', 't'];
    local row1Right = ['y', 'u', 'i', 'o', 'p'];
    local row2Left = ['a', 's', 'd', 'f'];
    local row2CenterLeft = ['g'];
    local row2Right = ['j', 'k', 'l'];
    local row3Left = ['z', 'x', 'c'];
    local row3CenterLeft = ['v'];
    local row3Right = ['n', 'm'];
    local withItems(items) = std.filter(function(item) item != null, items);
    if std.member(row1Left, key) then
      withItems([parts.lower, parts.upper, parts.kp, upItem, downItem])
    else if std.member(row1Right, key) then
      withItems([downItem, upItem, parts.kp, parts.upper, parts.lower])
    else if std.member(row2Left, key) || std.member(row3Left, key) then
      withItems([parts.lower, parts.upper, upItem, downItem])
    else if std.member(row2CenterLeft, key) || std.member(row3CenterLeft, key) then
      withItems([parts.lower, upItem, downItem, parts.upper])
    else if key == 'h' || key == 'b' || std.member(row2Right, key) || std.member(row3Right, key) then
      withItems([downItem, upItem, parts.upper, parts.lower])
    else
      withItems([parts.lower, parts.upper, parts.kp, upItem, downItem]),

  selectedHintAssistIndex(key, parts, mode)::
    local row1Left = ['q', 'w', 'e', 'r', 't'];
    local row1Right = ['y', 'u', 'i', 'o', 'p'];
    local row2Left = ['a', 's', 'd', 'f'];
    local row2CenterLeft = ['g'];
    local row2Right = ['h', 'j', 'k', 'l'];
    local row3Left = ['z', 'x', 'c'];
    local row3CenterLeft = ['v'];
    local row3Right = ['b', 'n', 'm'];
    local hasKp = parts.kp != null;
    if mode == 'all' then
      if std.member(row1Left, key) || std.member(row2Left, key) || std.member(row3Left, key) then
        if hasKp then 3 else 2
      else if std.member(row2CenterLeft, key) || std.member(row3CenterLeft, key) then
        1
      else if std.member(row1Right, key) || std.member(row2Right, key) || std.member(row3Right, key) then
        1
      else
        1
    else if mode == 'up' then
      if std.member(row1Left, key) || std.member(row2Left, key) || std.member(row3Left, key) then
        if hasKp then 3 else 2
      else if std.member(row2CenterLeft, key) || std.member(row3CenterLeft, key) then
        1
      else
        0
    else if mode == 'down' then
      if std.member(row1Left, key) || std.member(row2Left, key) || std.member(row3Left, key) then
        if hasKp then 3 else 2
      else if std.member(row2CenterLeft, key) || std.member(row3CenterLeft, key) then
        1
      else
        0
    else
      1,

  extendHintDataForSwipeAssist(baseHintData, sourceMaps, letters, mode):: {
    [key]:
      if mode != 'none' && std.member(letters, key) then
        local parts = $.extractHintAssistParts(baseHintData[key].list, key);
        local upItem = if std.member(['up', 'all'], mode) then $.buildHintAssistItem(sourceMaps[0], key) else null;
        local downItem =
          if mode == 'down' then
            $.buildHintAssistItem(sourceMaps[0], key)
          else if mode == 'all' then
            $.buildHintAssistItem(sourceMaps[1], key)
          else
            null;
        baseHintData[key] {
          selectedIndex: $.selectedHintAssistIndex(key, parts, mode),
          list: $.orderHintAssistList(key, parts, upItem, downItem, mode),
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
