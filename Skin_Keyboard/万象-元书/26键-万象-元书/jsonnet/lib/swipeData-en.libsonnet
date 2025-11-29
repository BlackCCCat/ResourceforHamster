local LayoutType = import '../custom/Custom.libsonnet';
local swipeData = import 'swipeData.libsonnet';

local custom = {  // 同字母但是不同设置的，在这里加上，会覆盖掉swipeData.libsonnet中对应的按键设置以供英文键盘使用。
  swipe_up: {
    q: { action: { symbol: '1' }, label: { text: '1' } },  // action同仓皮肤定义，label可选text/systemImageName, 具体见仓皮肤文档，若不想显示，可设置为text: ""
    w: { action: { symbol: '2' }, label: { text: '2' } },
    e: { action: { symbol: '3' }, label: { text: '3' } },
    r: { action: { symbol: '4' }, label: { text: '4' } },
    t: { action: { symbol: '5' }, label: { text: '5' } },
    y: { action: { symbol: '6' }, label: { text: '6' } },
    u: { action: { symbol: '7' }, label: { text: '7' } },
    i: { action: { symbol: '8' }, label: { text: '8' } },
    o: { action: { symbol: '9' }, label: { text: '9' } },
    p: { action: { symbol: '0' }, label: { text: '0' } },
    a: { action: { symbol: '、' }, label: { text: '、' } },
    s: { action: { symbol: '-' }, label: { text: '-' } },
    d: { action: { symbol: '=' }, label: { text: '=' } },
    f: { action: { symbol: '[' }, label: { text: '[' } },
    g: { action: { symbol: ']' }, label: { text: ']' } },
    h: { action: { symbol: '\\' }, label: { text: '\\' } },
    j: { action: { symbol: '/' }, label: { text: '/' } },
    k: { action: { symbol: ':' }, label: { text: ':' } },
    l: { action: { symbol: '"' }, label: { text: '"' } },
    z: { action: 'tab', label: { text: '⇥' } },
    x: { action: { symbol: '〔' }, label: { text: '〔' } },
    c: { action: { symbol: '〕' }, label: { text: '〕' } },
    v: { action: { symbol: '<' }, label: { text: '<' } },
    b: { action: { symbol: '>' }, label: { text: '>' } },
    n: { action: { symbol: '!' }, label: { text: '!' } },
    m: { action: { symbol: '?' }, label: { text: '?' } },
    // spaceRight: { action: { symbol: ',' }, },
    // space: { action: { keyboardType: 'pinyin'} , },
  },
  swipe_down: {
    q: { action: { symbol: '~' }, label: { text: '~' } },
    w: { action: { symbol: '@' }, label: { text: '@' } },
    e: { action: { symbol: '#' }, label: { text: '#' } },
    r: { action: { symbol: '$' }, label: { text: '$' } },
    t: { action: { symbol: '%' }, label: { text: '%' } },
    y: { action: { symbol: '^' }, label: { text: '^' } },
    u: { action: { symbol: '&' }, label: { text: '&' } },
    i: { action: { symbol: '*' }, label: { text: '*' } },
    o: { action: { symbol: '(' }, label: { text: '(' } },
    p: { action: { symbol: ')' }, label: { text: ')' } },
    a: { action: { symbol: '`' }, label: { text: '`' } },
    s: { action: { symbol: '_' }, label: { text: '_' } },
    d: { action: { symbol: '+' }, label: { text: '+' } },
    f: { action: { symbol: '{' }, label: { text: '{' } },
    g: { action: { symbol: '}' }, label: { text: '}' } },
    h: { action: { symbol: '|' }, label: { text: '|' } },
    j: { action: { symbol: '·' }, label: { text: '·' } },
    k: { action: { symbol: ';' }, label: { text: ';' } },
    l: { action: { symbol: "'" }, label: { text: "'" } },
    z: { action: { symbol: '' }, label: { text: '' } },
    n: if LayoutType.with_functions_row then {
      action: { sendKeys: 'N' },
      label: { systemImageName: 'calendar.badge.exclamationmark' },
      // center: { x: 0.5, y: 0.8 },
    } else { action: { symbol: '' }, label: { text: '' } },
    m: { action: { symbol: '' }, label: { text: '' } },

  },
};

// 下面的不要动
{
  swipe_up: swipeData.swipe_up + custom.swipe_up,
  swipe_down: swipeData.swipe_down + custom.swipe_down,
}
