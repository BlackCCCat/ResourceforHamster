// 集中维护中文 26/27 键的长按菜单与上下划动作。
local Settings = import '../../../Custom.libsonnet';
local inputModeData = import '../../../components/systemKeys/longPressData.libsonnet';

{
  pinyin: {
    q: {
      selectedIndex: 1,  // 长按菜单默认选中项索引。
      list: [
        { action: { character: 'q' }, label: { text: 'q' } },  // action 定义触发动作，label 支持 text 或 systemImageName。
        { action: { character: 'Q' }, label: { text: 'Q' } },
        { action: { sendKeys: 'KP_1' }, label: { text: '₁' } },
      ],
    },
    w: {
      selectedIndex: 1,
      list: [
        { action: { character: 'w' }, label: { text: 'w' } },
        { action: { character: 'W' }, label: { text: 'W' } },
        { action: { sendKeys: 'KP_2' }, label: { text: '₂' } },
      ],
    },
    e: {
      selectedIndex: 1,
      list: [
        { action: { character: 'e' }, label: { text: 'e' } },
        { action: { character: 'E' }, label: { text: 'E' } },
        { action: { sendKeys: 'KP_3' }, label: { text: '₃' } },
      ],
    },
    r: {
      selectedIndex: 1,
      list: [
        { action: { character: 'r' }, label: { text: 'r' } },
        { action: { character: 'R' }, label: { text: 'R' } },
        { action: { sendKeys: 'KP_4' }, label: { text: '₄' } },
      ],
    },
    t: {
      selectedIndex: 1,
      list: [
        { action: { character: 't' }, label: { text: 't' } },
        { action: { character: 'T' }, label: { text: 'T' } },
        { action: { sendKeys: 'KP_5' }, label: { text: '₅' } },
      ],
    },
    y: {
      selectedIndex: 1,
      list: [
        { action: { sendKeys: 'KP_6' }, label: { text: '₆' } },
        { action: { character: 'Y' }, label: { text: 'Y' } },
        { action: { character: 'y' }, label: { text: 'y' } },
      ],
    },
    u: {
      selectedIndex: 1,
      list: [
        { action: { sendKeys: 'KP_7' }, label: { text: '₇' } },
        { action: { character: 'U' }, label: { text: 'U' } },
        { action: { character: 'u' }, label: { text: 'u' } },
      ],
    },
    i: {
      selectedIndex: 1,
      list: [
        { action: { sendKeys: 'KP_8' }, label: { text: '₈' } },
        { action: { character: 'I' }, label: { text: 'I' } },
        { action: { character: 'i' }, label: { text: 'i' } },
      ],
    },
    o: {
      selectedIndex: 1,
      list: [
        { action: { sendKeys: 'KP_9' }, label: { text: '₉' } },
        { action: { character: 'O' }, label: { text: 'O' } },
        { action: { character: 'o' }, label: { text: 'o' } },
      ],
    },
    p: {
      selectedIndex: 1,
      list: [
        { action: { sendKeys: 'KP_0' }, label: { text: '₀' } },
        { action: { character: 'P' }, label: { text: 'P' } },
        { action: { character: 'p' }, label: { text: 'p' } },
      ],
    },

    a: {
      selectedIndex: 1,
      list: [
        { action: { character: 'a' }, label: { text: 'a' } },
        { action: { character: 'A' }, label: { text: 'A' } },
      ],
    },


    s: {
      selectedIndex: 1,
      list: [
        { action: { character: 's' }, label: { text: 's' } },
        { action: { character: 'S' }, label: { text: 'S' } },
      ],
    },


    d: {
      selectedIndex: 1,
      list: [
        { action: { character: 'd' }, label: { text: 'd' } },
        { action: { character: 'D' }, label: { text: 'D' } },
      ],
    },


    f: {
      selectedIndex: 1,
      list: [
        { action: { character: 'f' }, label: { text: 'f' } },
        { action: { character: 'F' }, label: { text: 'F' } },
      ],
    },


    g: {
      selectedIndex: 1,
      list: [
        { action: { character: 'g' }, label: { text: 'g' } },
        { action: { character: 'G' }, label: { text: 'G' } },
      ],
    },


    h: {
      selectedIndex: 1,
      list: [
        { action: { character: 'h' }, label: { text: 'h' } },
        { action: { character: 'H' }, label: { text: 'H' } },
      ],
    },


    j: {
      selectedIndex: 1,
      list: [
        { action: { character: 'j' }, label: { text: 'j' } },
        { action: { character: 'J' }, label: { text: 'J' } },
      ],
    },


    k: {
      selectedIndex: 1,
      list: [
        { action: { character: 'k' }, label: { text: 'k' } },
        { action: { character: 'K' }, label: { text: 'K' } },
      ],
    },


    l: {
      selectedIndex: 1,
      list: [
        { action: { character: 'l' }, label: { text: 'l' } },
        { action: { character: 'L' }, label: { text: 'L' } },
      ],
    },


    z: {
      selectedIndex: 1,
      list: [
        { action: { character: 'z' }, label: { text: 'z' } },
        { action: { character: 'Z' }, label: { text: 'Z' } },
      ],
    },


    x: {
      selectedIndex: 1,
      list: [
        { action: { character: 'x' }, label: { text: 'x' } },
        { action: { character: 'X' }, label: { text: 'X' } },
      ],
    },


    c: {
      selectedIndex: 1,
      list: [
        { action: { character: 'c' }, label: { text: 'c' } },
        { action: { character: 'C' }, label: { text: 'C' } },
      ],
    },


    v: {
      selectedIndex: 1,
      list: [
        { action: { character: 'v' }, label: { text: 'v' } },
        { action: { character: 'V' }, label: { text: 'V' } },
      ],
    },


    b: {
      selectedIndex: 1,
      list: [
        { action: { character: 'b' }, label: { text: 'b' } },
        { action: { character: 'B' }, label: { text: 'B' } },
      ],
    },


    n: {
      selectedIndex: 1,
      list: [
        { action: { character: 'n' }, label: { text: 'n' } },
        { action: { character: 'N' }, label: { text: 'N' } },
      ],
    },


    m: {
      selectedIndex: 1,
      list: [
        { action: { character: 'm' }, label: { text: 'm' } },
        { action: { character: 'M' }, label: { text: 'M' } },
      ],
    },
    spaceLeft: inputModeData.spaceLeft,
    cn2en: inputModeData.cn2en,
    enter: inputModeData.enter,
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
  genSwipeData(deviceType): {
    swipe_up: {
      q: { action: { character: '1' }, label: { text: '1' } },  // label 支持 text 或 systemImageName，text 为空字符串时隐藏标签。
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
      h: { action: if Settings.function_button_config.with_functions_row[deviceType] && Settings.function_button_config.enable_notification then { symbol: '\\' } else { character: '\\' }, label: { text: '\\' } },
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
      spaceLeft: { action: { character: '.' } },
      spaceRight: { action: { symbol: '.' } },
      // space: { action: { shortcut: '#次选上屏' } },
      // spaceSecond: { action: { shortcut: '#次选上屏' } },
      backspace: { action: { shortcut: '#deleteText' } },
      enter: { action: { shortcut: '#换行' } },
      // shift: { action: { character: "'" } },
      // "symbol": {"action": { "character": "。" }, "label": {"text": "。"}},
      // 长按条目由 action、label 与可选 fontSize 组成。

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
        // center: { x: 0.5, y: 0.8 },  // 可单独指定偏移，例如 zxcvbnm 的下划位于按键正下方。
      },
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
        action: { sendKeys: 'orc' },
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
        action: { shortcut: '#rimePreviousPage' },
        label: { systemImageName: 'chevron.up' },
        // center: { x: 0.5, y: 0.8 },
      },
      m: if Settings.function_button_config.with_functions_row[deviceType] then {
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
  },
}
