// 维护拼音九键的字母分组、长按菜单与上下划动作。

local Settings = import '../../Custom.libsonnet';
local makeAction(instance) =
  if Settings.wanxiang_9_hintSymbol then { symbol: instance } else { character: instance };
local familyData = {
  lettersUpper: {
    '2': 'ABC',
    '3': 'DEF',
    '4': 'GHI',
    '5': 'JKL',
    '6': 'MNO',
    '7': 'PQRS',
    '8': 'TUV',
    '9': 'WXYZ',
  },

  lettersLower: {
    '2': 'abc',
    '3': 'def',
    '4': 'ghi',
    '5': 'jkl',
    '6': 'mno',
    '7': 'pqrs',
    '8': 'tuv',
    '9': 'wxyz',
  },

  getLetters(isCapital)::
    if isCapital then self.lettersUpper else self.lettersLower,

  digitKeys: [std.toString(num) for num in std.range(2, 9)],

  symbols: [
    { label: ',', action: { character: ',' } },
    { label: '.', action: { character: '.' } },
    { label: '?', action: { character: '?' } },
    { label: '!', action: { character: '!' } },
    { label: '@', action: { character: '@' } },
  ],
};

familyData {
  pinyin_9: {
    number1: { size: { width: 50, height: 55 }, selectedIndex: 0, list: [{ action: makeAction('1'), label: { text: '1' } }] },
    number2: { size: { width: 50, height: 55 }, selectedIndex: 0, list: [{ action: makeAction('2'), label: { text: '2' } }, { action: makeAction('a'), label: { text: 'a' } }, { action: makeAction('b'), label: { text: 'b' } }, { action: makeAction('c'), label: { text: 'c' } }] },
    number3: { size: { width: 50, height: 55 }, selectedIndex: 0, list: [{ action: makeAction('3'), label: { text: '3' } }, { action: makeAction('d'), label: { text: 'd' } }, { action: makeAction('e'), label: { text: 'e' } }, { action: makeAction('f'), label: { text: 'f' } }] },
    number4: { size: { width: 50, height: 55 }, selectedIndex: 0, list: [{ action: makeAction('4'), label: { text: '4' } }, { action: makeAction('g'), label: { text: 'g' } }, { action: makeAction('h'), label: { text: 'h' } }, { action: makeAction('i'), label: { text: 'i' } }] },
    number5: { size: { width: 50, height: 55 }, selectedIndex: 0, list: [{ action: makeAction('5'), label: { text: '5' } }, { action: makeAction('j'), label: { text: 'j' } }, { action: makeAction('k'), label: { text: 'k' } }, { action: makeAction('l'), label: { text: 'l' } }] },
    number6: { size: { width: 50, height: 55 }, selectedIndex: 0, list: [{ action: makeAction('6'), label: { text: '6' } }, { action: makeAction('m'), label: { text: 'm' } }, { action: makeAction('n'), label: { text: 'n' } }, { action: makeAction('o'), label: { text: 'o' } }] },
    number7: { size: { width: 50, height: 55 }, selectedIndex: 0, list: [{ action: makeAction('7'), label: { text: '7' } }, { action: makeAction('p'), label: { text: 'p' } }, { action: makeAction('q'), label: { text: 'q' } }, { action: makeAction('r'), label: { text: 'r' } }, { action: makeAction('s'), label: { text: 's' } }] },
    number8: { size: { width: 50, height: 55 }, selectedIndex: 0, list: [{ action: makeAction('8'), label: { text: '8' } }, { action: makeAction('t'), label: { text: 't' } }, { action: makeAction('u'), label: { text: 'u' } }, { action: makeAction('v'), label: { text: 'v' } }] },
    number9: { size: { width: 50, height: 55 }, selectedIndex: 0, list: [{ action: makeAction('9'), label: { text: '9' } }, { action: makeAction('w'), label: { text: 'w' } }, { action: makeAction('x'), label: { text: 'x' } }, { action: makeAction('y'), label: { text: 'y' } }, { action: makeAction('z'), label: { text: 'z' } }] },
    number0: { size: { width: 50, height: 55 }, selectedIndex: 0, list: [{ action: makeAction('0'), label: { text: '0' } }] },
    cn2en: {
      selectedIndex: 1,
      size: { width: 65, height: 53 },
      list: [
        { action: { sendKeys: 'Control+Shift+4' }, label: { text: 'rimeOptionLabel$s2s' } },  //0*
        { action: { sendKeys: 'Control+Shift+4' }, label: { text: 'rimeOptionLabel$s2t' } },  //1
        { action: { sendKeys: 'Control+Shift+4' }, label: { text: 'rimeOptionLabel$s2hk' } },  //2
        { action: { sendKeys: 'Control+Shift+4' }, label: { text: 'rimeOptionLabel$s2tw' } },  //3
        { action: { sendKeys: 'Control+e' }, label: { text: 'rimeOptionLabel$chinese_english' } },  //4*
        { action: { sendKeys: 'Control+e' }, label: { text: 'rimeOptionLabel$chinese_english' } },  //5
        { action: { sendKeys: 'Control+t' }, label: { text: 'rimeOptionLabel$super_tips' } },  //6*
        { action: { sendKeys: 'Control+t' }, label: { text: 'rimeOptionLabel$super_tips' } },  //7
        { action: { sendKeys: 'Control+q' }, label: { text: 'rimeOptionLabel$abbrev' } },
        { action: { sendKeys: 'Control+q' }, label: { text: 'rimeOptionLabel$abbrev' } },
      ],
    },
  },
  pinyin9: {
    number1: {
      selectedIndex: 1,
      size: { width: 42, height: 53 },
      list: [
        { action: { symbol: '一' }, label: { text: '一' }, fontSize: 17 },
        { action: { symbol: '壹' }, label: { text: '壹' }, fontSize: 17 },
        { action: { symbol: '➀' }, label: { text: '➀' } },
      ],
    },
  },
  genSwipeData(deviceType): {
    swipe_up_9: {
      '1': { action: { symbol: '1' }, label: { text: '1' } },
      '2': { action: { symbol: '2' }, label: { text: '2' } },
      '3': { action: { symbol: '3' }, label: { text: '3' } },
      '4': { action: { symbol: '4' }, label: { text: '4' } },
      '5': { action: { symbol: '5' }, label: { text: '5' } },
      '6': { action: { symbol: '6' }, label: { text: '6' } },
      '7': { action: { symbol: '7' }, label: { text: '7' } },
      '8': { action: { symbol: '8' }, label: { text: '8' } },
      '9': { action: { symbol: '9' }, label: { text: '9' } },
      // '0': { action: { symbol: '0' }, label: { text: '0' } },
      space: { action: { symbol: '0' }, label: { text: '0' } },
    },
    swipe_down_9: {
      '1': { action: { symbol: '!' }, label: { text: '!' } },
      '2': { action: { symbol: '@' }, label: { text: '@' } },
      '3': { action: { symbol: '#' }, label: { text: '#' } },
      '4': { action: { symbol: '$' }, label: { text: '$' } },
      '5': { action: { symbol: '%' }, label: { text: '%' } },
      '6': { action: { symbol: '^' }, label: { text: '^' } },
      '7': { action: { symbol: '(' }, label: { text: '(' } },
      '8': { action: { symbol: ')' }, label: { text: ')' } },
      '9': { action: { symbol: '*' }, label: { text: '*' } },
      // '0': { action: { symbol: ')' }, label: { text: ')' } },
    },
  },
}
