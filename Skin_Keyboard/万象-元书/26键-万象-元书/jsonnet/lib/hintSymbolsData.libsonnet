{
  /*
  说明:
    pinyin9为中文九键(不是九键的皮肤就不用管)的长按数据
    number为数字九键的长按数据

  */
  pinyin: {
    q: {
      selectedIndex: 1,  // 默认选中的索引，具体见仓皮肤文档
      list: [
        { action: { character: 'q' }, label: { text: 'q' } },  // action同仓皮肤定义，label可选text/systemImageName, 具体见仓皮肤文档
        { action: { character: 'Q' }, label: { text: 'Q' } },
      ],
    },
    w: {
      selectedIndex: 1,
      list: [
        { action: { character: 'w' }, label: { text: 'w' } },
        { action: { character: 'W' }, label: { text: 'W' } },
      ],
    },
    e: {
      selectedIndex: 1,
      list: [
        { action: { character: 'e' }, label: { text: 'e' } },
        { action: { character: 'E' }, label: { text: 'E' } },
      ],
    },
    r: {
      selectedIndex: 1,
      list: [
        { action: { character: 'r' }, label: { text: 'r' } },
        { action: { character: 'R' }, label: { text: 'R' } },
      ],
    },
    t: {
      selectedIndex: 1,
      list: [
        { action: { character: 't' }, label: { text: 't' } },
        { action: { character: 'T' }, label: { text: 'T' } },
      ],
    },
    y: {
      selectedIndex: 1,
      list: [
        { action: { character: 'y' }, label: { text: 'y' } },
        { action: { character: 'Y' }, label: { text: 'Y' } },
      ],
    },
    u: {
      selectedIndex: 1,
      list: [
        { action: { character: 'u' }, label: { text: 'u' } },
        { action: { character: 'U' }, label: { text: 'U' } },
      ],
    },
    i: {
      selectedIndex: 1,
      list: [
        { action: { character: 'i' }, label: { text: 'i' } },
        { action: { character: 'I' }, label: { text: 'I' } },
      ],
    },
    o: {
      selectedIndex: 1,
      list: [
        { action: { character: 'o' }, label: { text: 'o' } },
        { action: { character: 'O' }, label: { text: 'O' } },
      ],
    },
    p: {
      selectedIndex: 1,
      list: [
        { action: { character: 'p' }, label: { text: 'p' } },
        { action: { character: 'P' }, label: { text: 'P' } },
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
    cn2en: {
      selectedIndex: 1,
      size: { width: 50, height: 53 },
      list: [
        { action: { sendKeys: 'Control+Shift+4' }, label: { text: '简中' } },  //0*
        { action: { sendKeys: 'Control+Shift+4' }, label: { text: '繁中' } },  //1
        { action: { sendKeys: 'Control+Shift+4' }, label: { text: '港中' } },  //2
        { action: { sendKeys: 'Control+Shift+4' }, label: { text: '台中' } },  //3
        { action: { sendKeys: 'Control+e' }, label: { text: '翻译' } },  //4*
        { action: { sendKeys: 'Control+e' }, label: { text: '原文' } },  //5
        { action: { sendKeys: 'Control+c' }, label: { text: '拆分' } },  //6*
        { action: { sendKeys: 'Control+c' }, label: { text: '拆关' } },  //7
        { action: { sendKeys: 'Control+t' }, label: { text: '提示' } },  //8*
        { action: { sendKeys: 'Control+t' }, label: { text: '提关' } },  //9
        { action: { sendKeys: 'Control+q' }, label: { text: '混合' } },  //10*
        { action: { sendKeys: 'Control+q' }, label: { text: '中文' } },  //11
        { action: { sendKeys: 'Control+q' }, label: { text: '英文' } },  //12
      ],
    },
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
    // "backspace"(不推荐),
    // "symbol": 切到符号键盘的按键
    // "shift": 切到shift键盘的按键
    // "spaceRight": 空格右侧的按键,
  },

  alphabetic: {
    q: {
      selectedIndex: 1,  // 默认选中的索引，具体见仓皮肤文档
      list: [
        { action: { symbol: 'q' }, label: { text: 'q' } },  // action同仓皮肤定义，label可选text/systemImageName, 具体见仓皮肤文档
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
    // "backspace"(不推荐),
    // "symbol": 切到符号键盘的按键
    // "shift": 切到shift键盘的按键
    // "spaceRight": 空格右侧的按键,
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
  number: {
    number1: {
      selectedIndex: 1,
      size: { width: 42, height: 53 },
      list: [
        { action: { symbol: '一' }, label: { text: '一' }, fontSize: 17 },
        { action: { symbol: '壹' }, label: { text: '壹' }, fontSize: 17 },
        { action: { symbol: '➀' }, label: { text: '➀' } },
      ],
    },
    number2: {
      selectedIndex: 1,
      size: { width: 42, height: 53 },
      list: [
        { action: { symbol: '二' }, label: { text: '二' }, fontSize: 17 },
        { action: { symbol: '贰' }, label: { text: '贰' }, fontSize: 17 },
        { action: { symbol: '➁' }, label: { text: '➁' } },
      ],
    },
    number3: {
      selectedIndex: 1,
      size: { width: 42, height: 53 },
      list: [
        { action: { symbol: '三' }, label: { text: '三' }, fontSize: 17 },
        { action: { symbol: '叁' }, label: { text: '叁' }, fontSize: 17 },
        { action: { symbol: '➂' }, label: { text: '➂' } },
      ],
    },
    number4: {
      selectedIndex: 1,
      size: { width: 42, height: 53 },
      list: [
        { action: { symbol: '四' }, label: { text: '四' }, fontSize: 17 },
        { action: { symbol: '肆' }, label: { text: '肆' }, fontSize: 17 },
        { action: { symbol: '➃' }, label: { text: '➃' } },
      ],
    },
    number5: {
      selectedIndex: 1,
      size: { width: 42, height: 53 },
      list: [
        { action: { symbol: '五' }, label: { text: '五' }, fontSize: 17 },
        { action: { symbol: '伍' }, label: { text: '伍' }, fontSize: 17 },
        { action: { symbol: '➄' }, label: { text: '➄' } },
      ],
    },
    number6: {
      selectedIndex: 1,
      size: { width: 42, height: 53 },
      list: [
        { action: { symbol: '六' }, label: { text: '六' }, fontSize: 17 },
        { action: { symbol: '陆' }, label: { text: '陆' }, fontSize: 17 },
        { action: { symbol: '➅' }, label: { text: '➅' } },
      ],
    },
    number7: {
      selectedIndex: 1,
      size: { width: 42, height: 53 },
      list: [
        { action: { symbol: '七' }, label: { text: '七' }, fontSize: 17 },
        { action: { symbol: '柒' }, label: { text: '柒' }, fontSize: 17 },
        { action: { symbol: '➆' }, label: { text: '➆' } },
      ],
    },
    number8: {
      selectedIndex: 1,
      size: { width: 42, height: 53 },
      list: [
        { action: { symbol: '八' }, label: { text: '八' }, fontSize: 17 },
        { action: { symbol: '捌' }, label: { text: '捌' }, fontSize: 17 },
        { action: { symbol: '➇' }, label: { text: '➇' } },
      ],
    },
    number9: {
      selectedIndex: 1,
      size: { width: 42, height: 53 },
      list: [
        { action: { symbol: '九' }, label: { text: '九' }, fontSize: 17 },
        { action: { symbol: '玖' }, label: { text: '玖' }, fontSize: 17 },
        { action: { symbol: '➈' }, label: { text: '➈' } },
      ],
    },
    number0: {
      selectedIndex: 1,
      size: { width: 42, height: 53 },
      list: [
        { action: { symbol: '零' }, label: { text: '零' }, fontSize: 17 },
        { action: { symbol: '〇' }, label: { text: '〇' }, fontSize: 17 },
        { action: { symbol: '➉' }, label: { text: '➉' } },
      ],
    },
    // 其他可用字段名:
    // 除上方已经出现的剩下数字0-9,
    // 其他按键同上
  },
}
