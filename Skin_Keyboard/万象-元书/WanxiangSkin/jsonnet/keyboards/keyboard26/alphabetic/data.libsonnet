// 集中维护英文 26 键的长按菜单与上下划动作。
local Settings = import '../../../Custom.libsonnet';

{
  alphabetic: {
    q: {
      selectedIndex: 1,  // 长按菜单默认选中项索引。
      list: [
        { action: { symbol: 'q' }, label: { text: 'q' } },  // action 定义触发动作，label 支持 text 或 systemImageName。
        { action: { symbol: 'Q' }, label: { text: 'Q' } },
      ],
    },
    w: {
      selectedIndex: 1,
      list: [
        { action: { symbol: 'w' }, label: { text: 'w' } },
        { action: { symbol: 'W' }, label: { text: 'W' } },
      ],
    },
    e: {
      selectedIndex: 1,
      list: [
        { action: { symbol: 'e' }, label: { text: 'e' } },
        { action: { symbol: 'E' }, label: { text: 'E' } },
      ],
    },
    r: {
      selectedIndex: 1,
      list: [
        { action: { symbol: 'r' }, label: { text: 'r' } },
        { action: { symbol: 'R' }, label: { text: 'R' } },
      ],
    },
    t: {
      selectedIndex: 1,
      list: [
        { action: { symbol: 't' }, label: { text: 't' } },
        { action: { symbol: 'T' }, label: { text: 'T' } },
      ],
    },
    y: {
      selectedIndex: 1,
      list: [
        { action: { symbol: 'y' }, label: { text: 'y' } },
        { action: { symbol: 'Y' }, label: { text: 'Y' } },
      ],
    },
    u: {
      selectedIndex: 1,
      list: [
        { action: { symbol: 'u' }, label: { text: 'u' } },
        { action: { symbol: 'U' }, label: { text: 'U' } },
      ],
    },
    i: {
      selectedIndex: 1,
      list: [
        { action: { symbol: 'i' }, label: { text: 'i' } },
        { action: { symbol: 'I' }, label: { text: 'I' } },
      ],
    },
    o: {
      selectedIndex: 1,
      list: [
        { action: { symbol: 'o' }, label: { text: 'o' } },
        { action: { symbol: 'O' }, label: { text: 'O' } },
      ],
    },
    p: {
      selectedIndex: 1,
      list: [
        { action: { symbol: 'p' }, label: { text: 'p' } },
        { action: { symbol: 'P' }, label: { text: 'P' } },
      ],
    },

    a: {
      selectedIndex: 1,
      list: [
        { action: { symbol: 'a' }, label: { text: 'a' } },
        { action: { symbol: 'A' }, label: { text: 'A' } },
      ],
    },


    s: {
      selectedIndex: 1,
      list: [
        { action: { symbol: 's' }, label: { text: 's' } },
        { action: { symbol: 'S' }, label: { text: 'S' } },
      ],
    },


    d: {
      selectedIndex: 1,
      list: [
        { action: { symbol: 'd' }, label: { text: 'd' } },
        { action: { symbol: 'D' }, label: { text: 'D' } },
      ],
    },


    f: {
      selectedIndex: 1,
      list: [
        { action: { symbol: 'f' }, label: { text: 'f' } },
        { action: { symbol: 'F' }, label: { text: 'F' } },
      ],
    },


    g: {
      selectedIndex: 1,
      list: [
        { action: { symbol: 'g' }, label: { text: 'g' } },
        { action: { symbol: 'G' }, label: { text: 'G' } },
      ],
    },


    h: {
      selectedIndex: 1,
      list: [
        { action: { symbol: 'h' }, label: { text: 'h' } },
        { action: { symbol: 'H' }, label: { text: 'H' } },
      ],
    },


    j: {
      selectedIndex: 1,
      list: [
        { action: { symbol: 'j' }, label: { text: 'j' } },
        { action: { symbol: 'J' }, label: { text: 'J' } },
      ],
    },


    k: {
      selectedIndex: 1,
      list: [
        { action: { symbol: 'k' }, label: { text: 'k' } },
        { action: { symbol: 'K' }, label: { text: 'K' } },
      ],
    },


    l: {
      selectedIndex: 1,
      list: [
        { action: { symbol: 'l' }, label: { text: 'l' } },
        { action: { symbol: 'L' }, label: { text: 'L' } },
      ],
    },


    z: {
      selectedIndex: 1,
      list: [
        { action: { symbol: 'z' }, label: { text: 'z' } },
        { action: { symbol: 'Z' }, label: { text: 'Z' } },
      ],
    },


    x: {
      selectedIndex: 1,
      list: [
        { action: { symbol: 'x' }, label: { text: 'x' } },
        { action: { symbol: 'X' }, label: { text: 'X' } },
      ],
    },


    c: {
      selectedIndex: 1,
      list: [
        { action: { symbol: 'c' }, label: { text: 'c' } },
        { action: { symbol: 'C' }, label: { text: 'C' } },
      ],
    },


    v: {
      selectedIndex: 1,
      list: [
        { action: { symbol: 'v' }, label: { text: 'v' } },
        { action: { symbol: 'V' }, label: { text: 'V' } },
      ],
    },


    b: {
      selectedIndex: 1,
      list: [
        { action: { symbol: 'b' }, label: { text: 'b' } },
        { action: { symbol: 'B' }, label: { text: 'B' } },
      ],
    },


    n: {
      selectedIndex: 1,
      list: [
        { action: { symbol: 'n' }, label: { text: 'n' } },
        { action: { symbol: 'N' }, label: { text: 'N' } },
      ],
    },


    m: {
      selectedIndex: 1,
      list: [
        { action: { symbol: 'm' }, label: { text: 'm' } },
        { action: { symbol: 'M' }, label: { text: 'M' } },
      ],
    },
    // '123': {
    //   selectedIndex: 1,
    //   size: { width: 40, height: 53 },
    //   list: [
    //     { action: { sendKeys: 'Control+Shift+t' }, label: { text: '简中' } },  //0*
    //     { action: { sendKeys: 'Control+Shift+t' }, label: { text: '繁中' } },  //1
    //     { action: { sendKeys: 'Control+Shift+t' }, label: { text: '港中' } },  //2
    //     { action: { sendKeys: 'Control+Shift+t' }, label: { text: '台中' } },  //3
    //     { action: { sendKeys: 'Control+Shift+f' }, label: { text: '翻译' } },  //4
    //     { action: { sendKeys: 'Control+Shift+f' }, label: { text: '原文' } },  //5
    //     { action: { sendKeys: 'Control+Shift+m' }, label: { text: '拆分' } },  //6*
    //     { action: { sendKeys: 'Control+Shift+m' }, label: { text: '拆关' } },  //7
    //     { action: { sendKeys: 'Control+Shift+s' }, label: { text: '提示' } },  //8*
    //     { action: { sendKeys: 'Control+Shift+s' }, label: { text: '提关' } },  //9
    //   ],
    // },
    enter: {
      size: { width: 50, height: 53 },
      selectedIndex: 0,
      list: [
        { action: { shortcut: '#换行' }, label: { text: '换行' }, fontSize: 16 },
      ],
    },
    symbol: {
      selectedIndex: 0,
      list: [
        { action: 'nextKeyboard', label: { systemImageName: 'globe' } },
      ],
    },
    // 其他可用字段名:
    // 除上方已经出现的剩下26字母,
    // "backspace": 退格键。
    // "symbol": 切到符号键盘的按键
    // "shift": 切到shift键盘的按键
    // "spaceRight": 空格右侧的按键,
  },
  genSwipeenData(deviceType): {
    swipe_up: {
      q: { action: { symbol: '1' }, label: { text: '1' } },  // label 支持 text 或 systemImageName，text 为空字符串时隐藏标签。
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

      x: if Settings.function_button_config.with_functions_row[deviceType] then {
        action: { sendKeys: 'onl' },
        label: { systemImageName: 'clock.arrow.circlepath' },
        // center: { x: 0.5, y: 0.8 },
      } else {
        action: { shortcut: '#cut' },
        label: { systemImageName: 'scissors' },
        // center: { x: 0.5, y: 0.8 },
      },
      c: if Settings.function_button_config.with_functions_row[deviceType] then {
        action: { sendKeys: 'orq' },
        label: { systemImageName: 'calendar' },
        // center: { x: 0.5, y: 0.8 },
      } else {
        action: { shortcut: '#copy' },
        label: { systemImageName: 'arrow.up.doc.on.clipboard' },
        // center: { x: 0.5, y: 0.8 },
      },
      v: if Settings.function_button_config.with_functions_row[deviceType] then {
        action: { sendKeys: 'osj' },
        label: { systemImageName: 'clock.circle' },
        // center: { x: 0.5, y: 0.8 },
      } else {
        action: { shortcut: '#paste' },
        label: { systemImageName: 'doc.on.clipboard.fill' },
        // center: { x: 0.5, y: 0.8 },
      },
      b: if Settings.function_button_config.with_functions_row[deviceType] then {
        action: { sendKeys: 'R' },
        label: { systemImageName: if Settings.fix_sf_symbol then 'dollarsign.square.fill' else 'chineseyuanrenminbisign.square.fill' },
        // center: { x: 0.5, y: 0.8 },
      } else {
        action: { shortcut: '#selectText' },
        label: { systemImageName: 'selection.pin.in.out' },
        // center: { x: 0.5, y: 0.8 },
      },
      n: if Settings.function_button_config.with_functions_row[deviceType] then {
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
  },
}
