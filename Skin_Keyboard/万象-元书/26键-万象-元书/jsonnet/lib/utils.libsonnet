local is_cap = import '../custom/Custom.libsonnet';


// 图片型

// key: 按键名, a-z, shift, space....
// contentMode: center, scaleAspectFill 更多类型见文档
// normalFile、highlightFile
local center = import './center.libsonnet';
// 单个生成函数
local makeImageStyle(contentMode, normalFile, highlightFile, normalImage, highlightImage, center, insets) = {
  [if contentMode != null then 'contentMode']: contentMode,
  buttonStyleType: 'fileImage',
  normalImage: {
    file: normalFile,
    image: normalImage,
  },
  highlightImage: {
    file: highlightFile,
    image: highlightImage,
  },
  [if insets != {} then 'insets']: insets,
  [if center != {} then 'center']: center,
};

local makeTextStyle(text, fontSize, normalColor, highlightColor, center) = {
  buttonStyleType: 'text',
  text: text,
  fontSize: fontSize,
  normalColor: normalColor,
  highlightColor: highlightColor,
  [if center != {} then 'center']: center,
};

local makesystemImageStyle(text, fontSize, normalColor, highlightColor, center) = {
  buttonStyleType: 'systemImage',
  systemImageName: text,
  fontSize: fontSize,
  normalColor: normalColor,
  highlightColor: highlightColor,
  [if center != {} then 'center']: center,
};

// 功能按键批量生成
local funcKeyMap = {
  left: 'left',
  head: 'head',
  select: 'select',
  cut: 'cut',
  copy: 'copy',
  paste: 'paste',
  tail: 'tail',
  right: 'right',
};

local funcKeysystemImageNameMap = {
  left: 'arrowshape.turn.up.left.fill',
  head: 'text.line.first.and.arrowtriangle.forward',
  select: 'selection.pin.in.out',
  cut: 'scissors',
  copy: 'arrow.up.doc.on.clipboard',
  paste: 'doc.on.clipboard.fill',
  tail: 'text.line.last.and.arrowtriangle.forward',
  right: 'arrowshape.turn.up.right.fill',
};

local funcKeyPreeditsystemImageNameMap = {
  left: 'square.filled.and.line.vertical.and.square',
  head: 'chevron.compact.up.chevron.compact.down',
  select: '1.circle',  // 'arrow.right',
  cut: '2.circle',  // 'arrow.up.right',
  copy: '3.circle',  // 'arrow.uturn.up',
  paste: '4.circle',  // 'arrow.down.right',
  tail: 'ellipsis.viewfinder',
  right: 'square.and.line.vertical.and.square.filled',
};

// 生成功能键前景
local genFuncKeyStyles(fontSize, color, theme, center) =
  {
    [keyName + 'ButtonForegroundStyle']: makesystemImageStyle(
      funcKeysystemImageNameMap[keyName],
      fontSize['功能按键sf符号大小'],
      color[theme]['按键前景颜色'],
      color[theme]['按键前景颜色'],
      center['功能键前景文字偏移']
    )
    for keyName in std.objectFields(funcKeyMap)
  } + {
    [keyName + 'ButtonPreeditForegroundStyle']: makesystemImageStyle(
      funcKeyPreeditsystemImageNameMap[keyName],
      fontSize['功能按键sf符号大小'],
      color[theme]['按键前景颜色'],
      color[theme]['按键前景颜色'],
      center['功能键前景文字偏移']
    )
    for keyName in std.objectFields(funcKeyMap)
  } + {
    [keyName + 'ButtonUppercasedStateForegroundStyle']: makesystemImageStyle(
      funcKeysystemImageNameMap[keyName],
      fontSize['功能按键sf符号大小'],
      color[theme]['按键前景颜色'],
      color[theme]['按键前景颜色'],
      center['功能键前景文字偏移']
    )
    for keyName in std.objectFields(funcKeyMap)
  };


// 按键前景批量生成
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
  z: 'z',
  x: 'x',
  c: 'c',
  v: 'v',
  b: 'b',
  n: 'n',
  m: 'm',
};

local CapkeyMap = {
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
  z: 'Z',
  x: 'X',
  c: 'C',
  v: 'V',
  b: 'B',
  n: 'N',
  m: 'M',
};

local symbolKeyMap = {
  // ===== 基本括号与引号 =====
  a: '[a]',  // 方括号
  b: '【b】',  // 黑方头括号
  c: '❲c❳',  // 双大括号 / 装饰括号
  d: '〔d〕',  // 方头括号
  e: '⟮e⟯',  // 小圆括号 / 装饰括号
  f: '⟦f⟧',  // 双方括号 / 数学集群括号
  g: '「g」',  // 直角引号
  h: '#',  //预留用于 Markdown 一级标题
  i: '『i』',  // 双直角引号
  j: '<j>',  // 尖括号
  k: '《k》',  // 书名号（双）
  l: '〈l〉',  // 书名号（单）
  m: '‹m›',  // 法文单书名号
  n: '«n»',  // 法文双书名号
  o: '⦅o⦆',  // 白圆括号
  p: '⦇p⦈',  // 白方括号
  q: '(q)',  // 圆括号
  r: '儿',  // 儿化候选
  s: '［s］',  // 全角方括号
  t: '⟨t⟩',  // 数学角括号
  u: '〈u〉',  // 数学尖括号
  v: '❰v❱',  // 装饰角括号
  w: '（w）',  // 全角圆括号
  x: '｛x｝',  // 全角花括号
  y: '⟪y⟫',  // 双角括号
  z: '{z}',  // 花括号
};

// 生成26字母键前景
local genPinyinStyles(fontSize, color, theme, center) =
  {
    [keyName + 'ButtonForegroundStyle']: makeTextStyle(
      if is_cap.is_letter_capital then CapkeyMap[keyName] else keyMap[keyName],
      fontSize['按键前景文字大小'],
      color[theme]['按键前景颜色'],
      color[theme]['按键前景颜色'],
      center['26键中文前景偏移']
    )
    for keyName in std.objectFields(keyMap)
  } + {
    [keyName + 'ButtonBackslashForegroundStyle']: makeTextStyle(
      symbolKeyMap[keyName],
      fontSize['按键前景文字大小'],
      color[theme]['按键前景颜色'],
      color[theme]['按键前景颜色'],
      center['26键中文前景偏移']
    )
    for keyName in std.objectFields(keyMap)
  } + {
    [keyName + 'ButtonUppercasedStateForegroundStyle']: makeTextStyle(
      CapkeyMap[keyName],
      fontSize['按键前景文字大小'],
      color[theme]['按键前景颜色'],
      color[theme]['按键前景颜色'],
      center['26键中文前景偏移']
    )
    for keyName in std.objectFields(keyMap)
  };

// 生成英文26键前景
local genAlphabeticStyles(fontSize, color, theme, center) =
  {
    [keyName + 'ButtonForegroundStyle']: makeTextStyle(
      std.asciiLower(keyMap[keyName]),
      fontSize['按键前景文字大小'],
      color[theme]['按键前景颜色'],
      color[theme]['按键前景颜色'],
      center['26键中文前景偏移']
    )
    for keyName in std.objectFields(keyMap)
  } + {
    [keyName + 'ButtonUppercasedStateForegroundStyle']: makeTextStyle(
      CapkeyMap[keyName],
      fontSize['按键前景文字大小'],
      color[theme]['按键前景颜色'],
      color[theme]['按键前景颜色'],
      center['26键中文前景偏移']
    )
    for keyName in std.objectFields(keyMap)
  };

local genNumberStyles(fontSize, color, theme, center) = {
  ['number' + num + 'ButtonForegroundStyle']: {
    buttonStyleType: 'text',
    text: std.toString(num),
    normalColor: color[theme]['按键前景颜色'],
    highlightColor: color[theme]['按键前景颜色'],
    fontSize: fontSize['数字键盘数字前景字体大小'],
    center: center['数字键盘数字前景偏移'],
  }
  for num in std.range(0, 9)
};


{
  makeImageStyle(contentMode, normalFile, highlightFile, normalImage, highlightImage, center, insets):
    makeImageStyle(contentMode, normalFile, highlightFile, normalImage, highlightImage, center, insets),
  makeTextStyle(text, fontSize, normalColor, highlightColor, center):
    makeTextStyle(text, fontSize, normalColor, highlightColor, center),
  genPinyinStyles(fontSize, color, theme, center):
    genPinyinStyles(fontSize, color, theme, center),
  genAlphabeticStyles(fontSize, color, theme, center):
    genAlphabeticStyles(fontSize, color, theme, center),
  genNumberStyles(fontSize, color, theme, center):
    genNumberStyles(fontSize, color, theme, center),
  genFuncKeyStyles(fontSize, color, theme, center):
    genFuncKeyStyles(fontSize, color, theme, center),
}
