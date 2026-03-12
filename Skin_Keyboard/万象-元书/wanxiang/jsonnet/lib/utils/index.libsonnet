// Generate shared foreground styles for letter keys and numeric keys from reusable specs.
local Settings = import '../../Custom.libsonnet';
local styleShared = import 'shared.libsonnet';
local styleSpecs = import 'specs.libsonnet';

local genPinyinStyles(fontSize, color, theme, center) =
  local keyMap = styleSpecs.keyMap;
  local capKeyMap = styleSpecs.capKeyMap;
  styleShared.genTextStates(
    keyMap,
    if Settings.is_letter_capital then capKeyMap else keyMap,
    'ButtonForegroundStyle',
    fontSize['26键字母前景文字大小'],
    color[theme]['按键前景颜色'],
    color[theme]['按键前景颜色'],
    center['26键中文前景偏移']
  ) + styleShared.genTextStates(
    keyMap,
    styleSpecs.symbolKeyMap,
    'ButtonBackslashForegroundStyle',
    fontSize['26键字母前景文字大小'],
    color[theme]['按键前景颜色'],
    color[theme]['按键前景颜色'],
    center['26键中文前景偏移']
  ) + styleShared.genTextStates(
    keyMap,
    capKeyMap,
    'ButtonUppercasedStateForegroundStyle',
    fontSize['26键字母前景文字大小'],
    color[theme]['按键前景颜色'],
    color[theme]['按键前景颜色'],
    center['26键中文前景偏移']
  );

local genAlphabeticStyles(fontSize, color, theme, center) =
  local keyMap = styleSpecs.keyMap;
  styleShared.genTextStates(
    keyMap,
    styleSpecs.lowerKeyTextMap(keyMap),
    'ButtonForegroundStyle',
    fontSize['26键字母前景文字大小'],
    color[theme]['按键前景颜色'],
    color[theme]['按键前景颜色'],
    center['26键中文前景偏移']
  ) + styleShared.genTextStates(
    keyMap,
    styleSpecs.capKeyMap,
    'ButtonUppercasedStateForegroundStyle',
    fontSize['26键字母前景文字大小'],
    color[theme]['按键前景颜色'],
    color[theme]['按键前景颜色'],
    center['26键中文前景偏移']
  );

local genNumberStyles(fontSize, color, theme, center) =
  styleShared.genNumberStates(
    'number',
    'ButtonForegroundStyle',
    styleSpecs.numberTextMap,
    fontSize['数字键盘数字前景字体大小'],
    color[theme]['按键前景颜色'],
    color[theme]['按键前景颜色'],
    center['数字键盘数字前景偏移']
  );

{
  makeImageStyle(contentMode, normalFile, highlightFile, normalImage, highlightImage, center, insets):
    styleShared.makeImageStyle(contentMode, normalFile, highlightFile, normalImage, highlightImage, center, insets),
  makeTextStyle(text, fontSize, normalColor, highlightColor, center):
    styleShared.makeTextStyle(text, fontSize, normalColor, highlightColor, center),
  genPinyinStyles(fontSize, color, theme, center):
    genPinyinStyles(fontSize, color, theme, center),
  genAlphabeticStyles(fontSize, color, theme, center):
    genAlphabeticStyles(fontSize, color, theme, center),
  genNumberStyles(fontSize, color, theme, center):
    genNumberStyles(fontSize, color, theme, center),
}
