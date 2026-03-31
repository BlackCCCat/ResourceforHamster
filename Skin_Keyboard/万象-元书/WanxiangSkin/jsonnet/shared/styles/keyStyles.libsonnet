// 基于共享工厂与局部规格生成可复用的按键前景样式。
local Settings = import '../../Custom.libsonnet';
local styleFactories = import 'styleFactories.libsonnet';

local keyMap = {
  q: 'q',
  w: 'w',
  e: 'e',
  r: 'r',
  t: 't',
  y: 'y',
  u: 'u',
  i: 'i',
  o: 'o',
  p: 'p',
  a: 'a',
  s: 's',
  d: 'd',
  f: 'f',
  g: 'g',
  h: 'h',
  j: 'j',
  k: 'k',
  l: 'l',
  ';': ';',
  z: 'z',
  x: 'x',
  c: 'c',
  v: 'v',
  b: 'b',
  n: 'n',
  m: 'm',
};

local capKeyMap = {
  q: 'Q',
  w: 'W',
  e: 'E',
  r: 'R',
  t: 'T',
  y: 'Y',
  u: 'U',
  i: 'I',
  o: 'O',
  p: 'P',
  a: 'A',
  s: 'S',
  d: 'D',
  f: 'F',
  g: 'G',
  h: 'H',
  j: 'J',
  k: 'K',
  l: 'L',
  ';': ';',
  z: 'Z',
  x: 'X',
  c: 'C',
  v: 'V',
  b: 'B',
  n: 'N',
  m: 'M',
};

local symbolKeyMap = {
  a: '[a]',
  b: '【b】',
  c: '❲c❳',
  d: '〔d〕',
  e: '⟮e⟯',
  f: '⟦f⟧',
  g: '「g」',
  h: '#',
  i: '『i』',
  j: '<j>',
  k: '《k》',
  l: '〈l〉',
  ';': ';',
  m: '‹m›',
  n: '«n»',
  o: '⦅o⦆',
  p: '⦇p⦈',
  q: '(q)',
  r: '儿',
  s: '［s］',
  t: '⟨t⟩',
  u: '〈u〉',
  v: '❰v❱',
  w: '（w）',
  x: '｛x｝',
  y: '⟪y⟫',
  z: '{z}',
};

local lowerKeyTextMap(source) = {
  [key]: std.asciiLower(source[key])
  for key in std.objectFields(source)
};

local numberTextMap = {
  '0': '0',
  '1': '1',
  '2': '2',
  '3': '3',
  '4': '4',
  '5': '5',
  '6': '6',
  '7': '7',
  '8': '8',
  '9': '9',
};

local genPinyinStyles(fontSize, color, theme, center) =
  styleFactories.genTextStates(
    keyMap,
    if Settings.is_letter_capital then capKeyMap else keyMap,
    'ButtonForegroundStyle',
    fontSize['26键字母前景文字大小'],
    color[theme]['按键前景颜色'],
    color[theme]['按键前景颜色'],
    center['26键中文前景偏移']
  ) + styleFactories.genTextStates(
    keyMap,
    symbolKeyMap,
    'ButtonBackslashForegroundStyle',
    fontSize['26键字母前景文字大小'],
    color[theme]['按键前景颜色'],
    color[theme]['按键前景颜色'],
    center['26键中文前景偏移']
  ) + styleFactories.genTextStates(
    keyMap,
    capKeyMap,
    'ButtonUppercasedStateForegroundStyle',
    fontSize['26键字母前景文字大小'],
    color[theme]['按键前景颜色'],
    color[theme]['按键前景颜色'],
    center['26键中文前景偏移']
  );

local genAlphabeticStyles(fontSize, color, theme, center) =
  styleFactories.genTextStates(
    keyMap,
    lowerKeyTextMap(keyMap),
    'ButtonForegroundStyle',
    fontSize['26键字母前景文字大小'],
    color[theme]['按键前景颜色'],
    color[theme]['按键前景颜色'],
    center['26键中文前景偏移']
  ) + styleFactories.genTextStates(
    keyMap,
    capKeyMap,
    'ButtonUppercasedStateForegroundStyle',
    fontSize['26键字母前景文字大小'],
    color[theme]['按键前景颜色'],
    color[theme]['按键前景颜色'],
    center['26键中文前景偏移']
  );

local genNumberStyles(fontSize, color, theme, center) =
  styleFactories.genNumberStates(
    'number',
    'ButtonForegroundStyle',
    numberTextMap,
    fontSize['数字键盘数字前景字体大小'],
    color[theme]['按键前景颜色'],
    color[theme]['按键前景颜色'],
    center['数字键盘数字前景偏移']
  );

{
  makeImageStyle(contentMode, normalFile, highlightFile, normalImage, highlightImage, center, insets):
    styleFactories.makeImageStyle(contentMode, normalFile, highlightFile, normalImage, highlightImage, center, insets),
  makeTextStyle(text, fontSize, normalColor, highlightColor, center):
    styleFactories.makeTextStyle(text, fontSize, normalColor, highlightColor, center),
  genPinyinStyles(fontSize, color, theme, center):
    genPinyinStyles(fontSize, color, theme, center),
  genAlphabeticStyles(fontSize, color, theme, center):
    genAlphabeticStyles(fontSize, color, theme, center),
  genNumberStyles(fontSize, color, theme, center):
    genNumberStyles(fontSize, color, theme, center),
}
