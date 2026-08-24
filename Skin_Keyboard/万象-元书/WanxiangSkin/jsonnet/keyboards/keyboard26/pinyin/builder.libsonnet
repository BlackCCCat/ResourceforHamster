// 组装拼音 26 键键盘，汇合共享上下文、布局数据和样式注册。
local appearance = import '../../../design/appearance.libsonnet';
local animation = appearance.animation;
local center = appearance.center;
local color = appearance.color;
local fontSize = appearance.fontSize;
local pinyinData = import './data.libsonnet';
local hintSymbolsStyles = import '../../../components/key/longPress.libsonnet';
local keyFactory = import '../../../components/key/factory.libsonnet';
local baseKeyStyles = import '../../../design/baseKeyStyles.libsonnet';
local letter26KeysSpecs = import '../base/letters.libsonnet';
local others = appearance.others;
local swipeStyles = import '../../../components/key/swipe.libsonnet';
local systemKeys = import '../../../components/systemKeys/index.libsonnet';
local swipeAssist = import './swipeAssist.libsonnet';
local toolbar = import '../../../components/toolbar/iPhone.libsonnet';
local functionRow = import '../../../components/functionRow/index.libsonnet';
local functionButtonStyles = import '../../../components/functionRow/styles.libsonnet';

// 生成字母键通过 backslash 动作触发的前景通知。
local createBackslashNotification(key, bounds={}) = {
  notificationType: 'keyboardAction',
  [if bounds != {} then 'bounds']: bounds,
  backgroundStyle: 'alphabeticBackgroundStyle',
  foregroundStyle: key + 'ButtonBackslashForegroundStyle',
  notificationKeyboardAction: { sendKeys: 'backslash' },
};

{
  createButtonFactory(context, swipeUp, swipeDown, letters, swipeAssistMode='none', foregroundSwipeUp=swipeUp, foregroundSwipeDown=swipeDown)::
    keyFactory.createKeyboardButton(context, swipeUp, swipeDown, {
      actionFactory(key): { character: key },
      uppercasedActionFactory(key): { character: std.asciiUpper(key) },
      notificationFactory(key):
        if std.member(letters, key) then
          std.filter(
            function(x) x != null,
            [
              if swipeAssistMode == 'none' then key + 'ButtonBackslashNotification' else null,
              if swipeAssistMode != 'none' then key + 'ButtonSwipeAssistNotification' else null,
            ]
          )
        else
          null,
      foregroundSwipeUp: foregroundSwipeUp,
      foregroundSwipeDown: foregroundSwipeDown,
    }),

  build(context, keyboardLayout)::
    local theme = context.theme;
    local orientation = context.orientation;
    local settings = context.Settings;
    local includeSemicolon = settings.keyboard_layout == 27;
    local swipeAssistMode = swipeAssist.resolveSwipeAssistMode(context);
    local swipeDataRoot = pinyinData.genSwipeData(context.deviceType);
    local rawSwipeUp = if std.objectHas(swipeDataRoot, 'swipe_up') then swipeDataRoot.swipe_up else {};
    local rawSwipeDown = if std.objectHas(swipeDataRoot, 'swipe_down') then swipeDataRoot.swipe_down else {};
    local swipeUp = rawSwipeUp;
    local swipeDown = rawSwipeDown;
    local letterSpecs = letter26KeysSpecs.get26KeySpecs(orientation, keyboardLayout, includeSemicolon);
    local letterKeys = [spec.key for spec in letterSpecs];
    local hintData =
      if swipeAssistMode == 'up' then
        swipeAssist.extendHintDataForSwipeAssist(pinyinData.pinyin, [rawSwipeUp], letter26KeysSpecs.letters, swipeAssistMode)
      else if swipeAssistMode == 'down' then
        swipeAssist.extendHintDataForSwipeAssist(pinyinData.pinyin, [rawSwipeDown], letter26KeysSpecs.letters, swipeAssistMode)
      else if swipeAssistMode == 'all' then
        swipeAssist.extendHintDataForSwipeAssist(pinyinData.pinyin, [rawSwipeUp, rawSwipeDown], letter26KeysSpecs.letters, swipeAssistMode)
      else
        pinyinData.pinyin;
    local hintStyles = hintSymbolsStyles.getStyle(theme, hintData);
    local extra27HintStyles =
      if includeSemicolon then
        {
          ';ButtonHintForegroundStyle': keyFactory.makeTextStyle(
            ';',
            fontSize['26键字母前景文字大小'],
            color[theme]['按键前景颜色'],
            color[theme]['按键前景颜色'],
            center['划动气泡文字偏移']
          ),
        }
      else
        {};
    local enableSwipeUpAssistHint = !swipeAssist.assistedDirectionEnabled(swipeAssistMode, 'up');
    local enableSwipeDownAssistHint = !swipeAssist.assistedDirectionEnabled(swipeAssistMode, 'down');
    local createButton = self.createButtonFactory(context, swipeUp, swipeDown, letter26KeysSpecs.getLetters(includeSemicolon), swipeAssistMode, rawSwipeUp, rawSwipeDown);
    keyboardLayout[if orientation == 'portrait' then '竖屏中文26键' else '横屏中文26键'] +
    swipeStyles.getStyle('cn', theme, swipeUp, swipeDown) +
    hintStyles +
    toolbar.getToolBar(theme) +
    keyFactory.genPinyinStyles(fontSize, color, theme, center) +
    functionButtonStyles.genFuncKeyStyles(fontSize, color, theme, center) +
    swipeStyles.slideButtonStyles(theme) +
    functionRow.makeFunctionButtons(orientation, keyboardLayout, 'pinyin') +
    baseKeyStyles.baseStyles(theme, orientation, settings, color, animation, hintSymbolsStyles) +
    {
      preeditHeight: others[if orientation == 'portrait' then '竖屏' else '横屏']['preedit高度'],
      toolbarHeight: others[if orientation == 'portrait' then '竖屏' else '横屏']['toolbar高度'],
      keyboardHeight: others[if orientation == 'portrait' then '竖屏' else '横屏']['keyboard高度'],
    } +
    keyFactory.letterButtons(letterSpecs, createButton, hintStyles) +
    keyFactory.hintStyles(letterKeys) +
    (if swipeAssistMode != 'none' then
       keyFactory.hintStyles(
         letterKeys,
         'alphabeticHintBackgroundStyle',
         enableSwipeUpAssistHint,
         enableSwipeDownAssistHint,
         'ButtonSwipeAssistHintStyle'
       )
     else
       {}) +
    extra27HintStyles +
    (if swipeAssistMode != 'none' then
       swipeAssist.swipeAssistNotifications(letterSpecs, settings, rawSwipeUp, rawSwipeDown, swipeAssistMode)
     else
       {}) +
    keyFactory.backslashNotifications(letterSpecs, createBackslashNotification) +
    systemKeys.buildReusable(context, keyboardLayout, hintStyles),
}
