local Settings = import '../custom/Custom.libsonnet';


local genSwipeData(deviceType) = 
{
  /*
  说明:
    swipe_up和swipe_down为中文26键盘的划动数据
    下面对应的pinyin9(如果当前皮肤不是九键皮肤，就不用管)和number为中文九键和数字九键的划动数据
  格式说明:
    action: 必需， 格式同仓文档
    label:  非必需， 不设置这个不会生成对应前景，也就是不会显示在按键上，具体格式也见文档
  */

  swipe_up: {
    q: { action: { character: '1' }, label: { text: '1' } },  // action同仓皮肤定义，label可选text/systemImageName, 具体见仓皮肤文档，若不想显示，可设置为text: ""
    w: { action: { character: '2' }, label: { text: '2' } },
    e: { action: { character: '3' }, label: { text: '3' } },
    r: { action: { character: '4' }, label: { text: '4' } },
    t: { action: { character: '5' }, label: { text: '5' } },
    y: { action: { character: '6' }, label: { text: '6' } },
    u: { action: { character: '7' }, label: { text: '7' } },
    i: { action: { character: '8' }, label: { text: '8' } },
    o: { action: { character: '9' }, label: { text: '9' } },
    p: { action: { character: '0' }, label: { text: '0' } },
    a: { action: { character: '、' }, label: { text: '、' } },
    s: { action: { character: '-' }, label: { text: '-' } },
    d: { action: { character: '=' }, label: { text: '=' } },
    f: { action: { symbol: '【' }, label: { text: '[' } },
    g: { action: { symbol: '】' }, label: { text: ']' } },
    h: { action: if Settings.with_functions_row[deviceType] && Settings.enable_functions_notification then { symbol: '\\' } else { character: '\\' }, label: { text: '\\' } },
    j: { action: { character: '/' }, label: { text: '/' } },
    k: { action: { character: ':' }, label: { text: ':' } },
    l: { action: { character: '"' }, label: { text: '"' } },
    z: { action: 'tab', label: { text: '⇥' } },
    x: { action: { character: '[' }, label: { text: '〔' } },
    c: { action: { character: ']' }, label: { text: '〕' } },
    v: { action: { character: '<' }, label: { text: '<' } },
    b: { action: { character: '>' }, label: { text: '>' } },
    n: { action: { character: '!' }, label: { text: '!' } },
    m: { action: { character: '?' }, label: { text: '?' } },
    '123': { action: { keyboardType: 'symbolic' } },
    spaceLeft: { action: { character: '.' } },
    spaceRight: { action: { symbol: '.' } },
    // space: { action: { shortcut: '#次选上屏' } },
    // spaceSecond: { action: { shortcut: '#次选上屏' } },
    backspace: { action: { shortcut: '#deleteText' } },
    enter: { action: { shortcut: '#换行' } },
    // shift: { action: { character: "'" } },
    // "symbol": {"action": { "character": "。" }, "label": {"text": "。"}},
    // 可用字段见holdSymbolsData.libsonnet

  },
  swipe_down: {
    q: { action: { character: '~' }, label: { text: '~' } },
    w: { action: { character: '@' }, label: { text: '@' } },
    e: { action: { character: '#' }, label: { text: '#' } },
    r: { action: { character: '$' }, label: { text: '$' } },
    t: { action: { character: '%' }, label: { text: '%' } },
    y: { action: { character: '^' }, label: { text: '^' } },
    u: { action: { character: '&' }, label: { text: '&' } },
    i: { action: { character: '*' }, label: { text: '*' } },
    o: { action: { character: '(' }, label: { text: '(' } },
    p: { action: { character: ')' }, label: { text: ')' } },
    a: { action: { character: '`' }, label: { text: '`' } },
    s: { action: { character: '_' }, label: { text: '_' } },
    d: { action: { character: '+' }, label: { text: '+' } },
    f: { action: { character: '{' }, label: { text: '{' } },
    g: { action: { character: '}' }, label: { text: '}' } },
    h: { action: { character: '|' }, label: { text: '|' } },
    j: { action: { symbol: '.' }, label: { text: '.' } },
    k: { action: { character: ';' }, label: { text: ';' } },
    l: { action: { character: "'" }, label: { text: "'" } },
    z: {
      action: { character: 'V' },
      label: { systemImageName: 'av.remote.fill' },
      // center: { x: 0.5, y: 0.8 },  // 不同于其他按键的偏移，可这样设置，例如这里zxcvbnm的下划都在按键正下方
    },
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
      action: { shortcut: '#rimePreviousPage' },
      label: { systemImageName: 'chevron.up' },
      // center: { x: 0.5, y: 0.8 },
    },
    m: if Settings.with_functions_row[deviceType] then {
      action: { character: '`' },
      label: { systemImageName: 'rectangle.3.group.fill' },
      // center: { x: 0.5, y: 0.8 },
    } else {
      action: { shortcut: '#rimeNextPage' },
      label: { systemImageName: 'chevron.down' },
      // center: { x: 0.5, y: 0.8 },
    },
    // '123': { action: { shortcut: '#方案切换' } },
    // space: { action: { shortcut: '#三选上屏' } },
    // spaceSecond: { action: { shortcut: '#三选上屏' } },
    backspace: { action: { shortcut: '#undo' } },
  },

  // 中文九键划动
  number_swipe_up: {
    // '1': { action: { symbol: '1' }, label: { text: '1' } },
    // '2': { action: { symbol: '2' }, label: { text: '2' } },
    // '3': { action: { symbol: '3' }, label: { text: '3' } },
    // '4': { action: { symbol: '4' }, label: { text: '4' } },
    // '5': { action: { symbol: '5' }, label: { text: '5' } },
    // '6': { action: { symbol: '6' }, label: { text: '6' } },
    // '7': { action: { symbol: '7' }, label: { text: '7' } },
    // '8': { action: { symbol: '8' }, label: { text: '8' } },
    // '9': { action: { symbol: '9' }, label: { text: '9' } },
    space:{ action: { shortcut: '#次选上屏' } },
  },
  number_swipe_down: {
    // '3': { action: { sendKeys: 'dt' }, label: { text: '时间' } },
    // '4': { action: { shortcut: '#行首' }, label: { text: '行首' } },
    // '5': { action: { shortcut: '#selectText' }, label: { text: '全选' } },
    // '6': { action: { shortcut: '#行尾' }, label: { text: '行尾' } },
    // '7': { action: { shortcut: '#cut' }, label: { text: '剪切' } },
    // '8': { action: { shortcut: '#copy' }, label: { text: '复制' } },
    // '9': { action: { shortcut: '#paste' }, label: { text: '粘贴' } },
    space: { action: { shortcut: '#三选上屏' } },

  },
};


{
  genSwipeData(deviceType): genSwipeData(deviceType)
}
