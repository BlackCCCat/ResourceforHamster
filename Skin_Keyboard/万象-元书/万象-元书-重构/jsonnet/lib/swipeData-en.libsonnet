local Settings = import '../custom/Custom.libsonnet';


local genSwipeenData(deviceType)= {  // 同字母但是不同设置的，在这里加上，会覆盖掉swipeData.libsonnet中对应的按键设置以供英文键盘使用。
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
    '123': { action: { keyboardType: 'symbolic' } },
    spaceLeft: { action: { symbol: '.' } },
    spaceRight: { action: { symbol: '.' } },
    // space: { action: { shortcut: '#次选上屏' } },
    // spaceSecond: { action: { shortcut: '#次选上屏' } },
    backspace: { action: { shortcut: '#deleteText' } },
    enter: { action: { shortcut: '#换行' } },
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

    x: if Settings.with_functions_row[deviceType] then {
      action: { sendKeys: 'onl' },
      label: { systemImageName: 'clock.arrow.circlepath' },
      // center: { x: 0.5, y: 0.8 },
    } else {
      action: { shortcut: '#cut' },
      label: { systemImageName: 'scissors' },
      // center: { x: 0.5, y: 0.8 },
    },
    c: if Settings.with_functions_row[deviceType] then {
      action: { sendKeys: 'orq' },
      label: { systemImageName: 'calendar' },
      // center: { x: 0.5, y: 0.8 },
    } else {
      action: { shortcut: '#copy' },
      label: { systemImageName: 'arrow.up.doc.on.clipboard' },
      // center: { x: 0.5, y: 0.8 },
    },
    v: if Settings.with_functions_row[deviceType] then {
      action: { sendKeys: 'osj' },
      label: { systemImageName: 'clock.circle' },
      // center: { x: 0.5, y: 0.8 },
    } else {
      action: { shortcut: '#paste' },
      label: { systemImageName: 'doc.on.clipboard.fill' },
      // center: { x: 0.5, y: 0.8 },
    },
    b: if Settings.with_functions_row[deviceType] then {
      action: { sendKeys: 'R' },
      label: { systemImageName: if Settings.fix_sf_symbol then 'dollarsign.square.fill' else 'chineseyuanrenminbisign.square.fill' },
      // center: { x: 0.5, y: 0.8 },
    } else {
      action: { shortcut: '#selectText' },
      label: { systemImageName: 'selection.pin.in.out' },
      // center: { x: 0.5, y: 0.8 },
    },
    n: if Settings.with_functions_row[deviceType] then {
      action: { sendKeys: 'N' },
      label: { systemImageName: 'calendar.badge.exclamationmark' },
      // center: { x: 0.5, y: 0.8 },
    } else {
      action: { symbol: '' }, 
      label: { text: '' },
      // center: { x: 0.5, y: 0.8 },
    },
    m: { action: { symbol: '' }, label: { text: '' } },
    // '123': { action: { shortcut: '#方案切换' } },
    // space: { action: { shortcut: '#三选上屏' } },
    // spaceSecond: { action: { shortcut: '#三选上屏' } },
    backspace: { action: { shortcut: '#undo' } },
  },
};

// 下面的不要动
{
  genSwipeenData(deviceType): genSwipeenData(deviceType)
}
