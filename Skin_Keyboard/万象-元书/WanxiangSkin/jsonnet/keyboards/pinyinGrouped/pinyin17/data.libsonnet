// 描述「乱序 17 键」键位规格，并维护该布局专用的长按与上下划数据。
local groupedSpecFactory = import '../base/specFactory.libsonnet';

local Settings = import '../../../Custom.libsonnet';
local familyData = {
  getSpec(context, keyboardLayout)::
    local isPortrait = context.isPortrait;
    {
      layoutName: if isPortrait then '竖屏中文17键' else '横屏中文17键',
      hintData: 'pinyin_17',
      swipeUpName: 'swipe_up_17',
      swipeDownName: 'swipe_down_17',
      sizes: {
        shift: if isPortrait then keyboardLayout['竖屏按键尺寸']['shift键size'].width else keyboardLayout['横屏按键尺寸']['17键横屏shift键size'].width,
        backspace: if isPortrait then keyboardLayout['竖屏按键尺寸']['backspace键size'].width else keyboardLayout['横屏按键尺寸']['17键横屏backspace键size'].width,
        oneTwoThree: if isPortrait then keyboardLayout['竖屏按键尺寸']['123键size'].width else keyboardLayout['横屏按键尺寸']['123键size'].width,
        space: if isPortrait then keyboardLayout['竖屏按键尺寸']['space键size'].width else keyboardLayout['横屏按键尺寸']['space键size'].width,
        spaceLeft: if isPortrait then keyboardLayout['竖屏按键尺寸']['spaceLeft键size'].width else keyboardLayout['横屏按键尺寸']['spaceLeft键size'].width,
        enter: if isPortrait then keyboardLayout['竖屏按键尺寸']['enter键size'].width else keyboardLayout['横屏按键尺寸']['enter键size'].width,
      },
      keys: groupedSpecFactory.buildKeys(
        [
          ['hp', 'h', '17r1', 'hp'],
          ['s', 's', '17r1', 'Sh'],
          ['z', 'z', '17r1', 'Zh'],
          ['b', 'b', '17r1', 'b'],
          ['x', 'x', '17r1', 'x'],
          ['ms', 'm', '17r1', 'ms'],
          ['l', 'l', '17r2', 'l'],
          ['d', 'd', '17r2', 'd'],
          ['y', 'y', '17r2', 'y'],
          ['wz', 'w', '17r2', 'wz'],
          ['jk', 'j', '17r2', 'jk'],
          ['nr', 'n', '17r2', 'nr'],
          ['c', 'c', '17r3', 'Ch'],
          ['q', 'q', '17r3', 'q~'],
          ['g', 'g', '17r3', 'g'],
          ['fc', 'f', '17r3', 'fc'],
          ['t', 't', '17r3', 't'],
        ],
        context,
        keyboardLayout
      ),
    },
};

familyData {
  pinyin_17: {
    hp: {
      selectedIndex: 1,  // 长按菜单默认选中项索引。
      list: [
        { action: { character: 'h' }, label: { text: 'h' } },  // action 定义触发动作，label 支持 text 或 systemImageName。
        { action: { character: 'p' }, label: { text: 'p' } },
        { action: { character: 'a' }, label: { text: 'a' } },
        { action: { sendKeys: 'KP_1' }, label: { text: '₁' } },
      ],
    },
    s: {
      selectedIndex: 1,
      list: [
        { action: { character: 's' }, label: { text: 's' } },
        { action: { sendKeys: 'KP_2' }, label: { text: '₂' } },
      ],
    },
    z: {
      selectedIndex: 1,
      list: [
        { action: { character: 'z' }, label: { text: 'z' } },
        { action: { sendKeys: 'KP_3' }, label: { text: '₃' } },

      ],
    },
    b: {
      selectedIndex: 1,
      list: [
        { action: { character: 'b' }, label: { text: 'b' } },
      ],
    },
    x: {
      selectedIndex: 1,
      list: [
        { action: { character: 'x' }, label: { text: 'x' } },
        { action: { character: 'o' }, label: { text: 'o' } },
        { action: { character: 'v' }, label: { text: 'v' } },
      ],
    },
    ms: {
      selectedIndex: 1,
      list: [
        { action: { character: 'm' }, label: { text: 'm' } },
        { action: { character: 's' }, label: { text: 's' } },
      ],
    },


    l: {
      selectedIndex: 1,
      list: [
        { action: { character: 'l' }, label: { text: 'l' } },
        { action: { sendKeys: 'KP_4' }, label: { text: '₄' } },
      ],
    },
    d: {
      selectedIndex: 1,
      list: [
        { action: { character: 'd' }, label: { text: 'd' } },
        { action: { character: 'u' }, label: { text: 'u' } },
        { action: { sendKeys: 'KP_5' }, label: { text: '₅' } },
      ],
    },
    y: {
      selectedIndex: 1,
      list: [
        { action: { character: 'y' }, label: { text: 'y' } },
        { action: { sendKeys: 'KP_6' }, label: { text: '₆' } },
      ],
    },
    wz: {
      selectedIndex: 1,
      list: [
        { action: { character: 'w' }, label: { text: 'w' } },
        { action: { character: 'z' }, label: { text: 'z' } },
        { action: { character: 'e' }, label: { text: 'e' } },
        { action: { sendKeys: 'KP_0' }, label: { text: '₀' } },
      ],
    },
    jk: {
      selectedIndex: 1,
      list: [
        { action: { character: 'j' }, label: { text: 'j' } },
        { action: { character: 'k' }, label: { text: 'k' } },
        { action: { character: 'i' }, label: { text: 'i' } },
      ],
    },
    nr: {
      selectedIndex: 1,
      list: [
        { action: { character: 'n' }, label: { text: 'n' } },
        { action: { character: 'r' }, label: { text: 'r' } },
      ],
    },

    c: {
      selectedIndex: 1,
      list: [
        { action: { character: 'c' }, label: { text: 'c' } },
        { action: { sendKeys: 'KP_7' }, label: { text: '₇' } },
      ],
    },
    q: {
      selectedIndex: 1,
      list: [
        { action: { character: 'q' }, label: { text: 'q' } },
        { action: { sendKeys: 'KP_8' }, label: { text: '₈' } },
      ],
    },
    g: {
      selectedIndex: 1,
      list: [
        { action: { character: 'g' }, label: { text: 'g' } },
        { action: { sendKeys: 'KP_9' }, label: { text: '₉' } },
      ],
    },
    fc: {
      selectedIndex: 1,
      list: [
        { action: { character: 'f' }, label: { text: 'f' } },
        { action: { character: 'c' }, label: { text: 'c' } },
      ],
    },
    t: {
      selectedIndex: 1,
      list: [
        { action: { character: 't' }, label: { text: 't' } },
      ],
    },

    spaceLeft: {
      selectedIndex: 1,
      list: [
        { action: { symbol: ',' }, label: { text: ',' } },
        { action: { symbol: '.' }, label: { text: '.' } },
      ],
    },
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
    enter: {
      size: { width: 50, height: 53 },
      selectedIndex: 0,
      list: [
        { action: { shortcut: '#换行' }, label: { text: '换行' }, fontSize: 16 },
      ],
    },
  },
  genSwipeData(deviceType): {
    swipe_up_17: {
      hp: { action: { character: '1' }, label: { text: '1' } },
      s: { action: { character: '2' }, label: { text: '2' } },
      z: { action: { character: '3' }, label: { text: '3' } },
      b: { action: { character: '@' }, label: { text: '@' } },
      x: { action: { character: '^' }, label: { text: '^' } },
      ms: { action: { character: '\\' }, label: { text: '\\' } },
      l: { action: { character: '4' }, label: { text: '4' } },
      d: { action: { character: '5' }, label: { text: '5' } },
      y: { action: { character: '6' }, label: { text: '6' } },
      wz: { action: { character: '0' }, label: { text: '0' } },
      jk: { action: { character: ':' }, label: { text: ':' } },
      nr: { action: { character: '"' }, label: { text: '"' } },
      c: { action: { character: '7' }, label: { text: '7' } },
      q: { action: { character: '8' }, label: { text: '8' } },
      g: { action: { character: '9' }, label: { text: '9' } },
      fc: { action: { character: '!' }, label: { text: '!' } },
      t: { action: { character: '?' }, label: { text: '?' } },
    },
    swipe_down_17: {
      backspace: { action: { shortcut: '#undo' } },
    },
  },
}
