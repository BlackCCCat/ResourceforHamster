// 描述 18 键键位规格，并维护该布局专用的长按与上下划数据。
local groupedSpecFactory = import '../base/specFactory.libsonnet';

local Settings = import '../../../Custom.libsonnet';
local familyData = {
  getSpec(context, keyboardLayout)::
    local isPortrait = context.isPortrait;
    {
      layoutName: if isPortrait then '竖屏中文18键' else '横屏中文18键',
      hintData: 'pinyin_18',
      swipeUpName: 'swipe_up_18',
      swipeDownName: 'swipe_down_18',
      wanxiangSetting: 'is_wanxiang_18',
      sizes: {
        shift: if isPortrait then keyboardLayout['竖屏按键尺寸']['shift键size'].width else keyboardLayout['横屏按键尺寸']['shift键size'].width,
        backspace: if isPortrait then keyboardLayout['竖屏按键尺寸']['backspace键size'].width else keyboardLayout['横屏按键尺寸']['backspace键size'].width,
        oneTwoThree: if isPortrait then keyboardLayout['竖屏按键尺寸']['123键size'].width else keyboardLayout['横屏按键尺寸']['123键size'].width,
        space: if isPortrait then keyboardLayout['竖屏按键尺寸']['space键size'].width else keyboardLayout['横屏按键尺寸']['space键size'].width,
        spaceLeft: if isPortrait then keyboardLayout['竖屏按键尺寸']['spaceLeft键size'].width else keyboardLayout['横屏按键尺寸']['spaceLeft键size'].width,
        enter: if isPortrait then keyboardLayout['竖屏按键尺寸']['enter键size'].width else keyboardLayout['横屏按键尺寸']['enter键size'].width,
      },
      keys: groupedSpecFactory.buildKeys(
        [
          ['q', 'q', '18r1l'],
          ['we', 'w', '18r1l'],
          ['rt', 'r', '18r1l'],
          ['y', 'y', '18r1r'],
          ['u', 'u', '18r1r'],
          ['io', 'i', '18r1r'],
          ['p', 'p', '18r1r'],
          ['a', 'a', '18a'],
          ['sd', 's', '18r2'],
          ['fg', 'f', '18r2'],
          ['h', 'h', '18r2'],
          ['jk', 'j', '18r2'],
          ['l', 'l', '18l'],
          ['z', 'z', '18r3r'],
          ['xc', 'x', '18r3r'],
          ['v', 'v', '18r3r'],
          ['bn', 'b', '18r3l'],
          ['m', 'm', '18r3l'],
        ],
        context,
        keyboardLayout
      ),
    },
};

familyData {
  pinyin_18: {
    q: {
      selectedIndex: 1,  // 长按菜单默认选中项索引。
      list: [
        { action: { character: 'q' }, label: { text: 'q' } },  // action 定义触发动作，label 支持 text 或 systemImageName。
        { action: { character: 'Q' }, label: { text: 'Q' } },
        { action: { sendKeys: 'KP_1' }, label: { text: '₁' } },
      ],
    },
    we: {
      selectedIndex: 1,
      list: [
        { action: { character: 'w' }, label: { text: 'w' } },
        { action: { character: 'W' }, label: { text: 'W' } },
        { action: { character: 'e' }, label: { text: 'e' } },
        { action: { character: 'E' }, label: { text: 'E' } },
        { action: { sendKeys: 'KP_2' }, label: { text: '₂' } },
      ],
    },
    rt: {
      selectedIndex: 1,
      list: [
        { action: { character: 'r' }, label: { text: 'r' } },
        { action: { character: 'R' }, label: { text: 'R' } },
        { action: { sendKeys: 'KP_3' }, label: { text: '₃' } },
        { action: { character: 't' }, label: { text: 't' } },
        { action: { character: 'T' }, label: { text: 'T' } },
      ],
    },
    y: {
      selectedIndex: 1,
      list: [
        { action: { character: 'y' }, label: { text: 'y' } },
        { action: { character: 'Y' }, label: { text: 'Y' } },
        { action: { sendKeys: 'KP_4' }, label: { text: '₄' } },
      ],
    },
    u: {
      selectedIndex: 1,
      list: [
        { action: { character: 'u' }, label: { text: 'u' } },
        { action: { character: 'U' }, label: { text: 'U' } },
        { action: { sendKeys: 'KP_5' }, label: { text: '₅' } },
      ],
    },
    io: {
      selectedIndex: 1,
      list: [
        { action: { character: 'i' }, label: { text: 'i' } },
        { action: { character: 'I' }, label: { text: 'I' } },
        { action: { character: 'o' }, label: { text: 'o' } },
        { action: { character: 'O' }, label: { text: 'O' } },
        { action: { sendKeys: 'KP_6' }, label: { text: '₆' } },
      ],
    },

    p: {
      selectedIndex: 1,
      list: [
        { action: { character: 'p' }, label: { text: 'p' } },
        { action: { character: 'P' }, label: { text: 'P' } },
        { action: { sendKeys: 'KP_7' }, label: { text: '₇' } },
      ],
    },

    a: {
      selectedIndex: 1,
      list: [
        { action: { character: 'a' }, label: { text: 'a' } },
        { action: { character: 'A' }, label: { text: 'A' } },
        { action: { sendKeys: 'KP_8' }, label: { text: '₈' } },

      ],
    },


    sd: {
      selectedIndex: 1,
      list: [
        { action: { character: 's' }, label: { text: 's' } },
        { action: { character: 'S' }, label: { text: 'S' } },
        { action: { character: 'd' }, label: { text: 'd' } },
        { action: { character: 'D' }, label: { text: 'D' } },
        { action: { sendKeys: 'KP_9' }, label: { text: '₉' } },
      ],
    },

    fg: {
      selectedIndex: 1,
      list: [
        { action: { character: 'f' }, label: { text: 'f' } },
        { action: { character: 'F' }, label: { text: 'F' } },
        { action: { character: 'g' }, label: { text: 'g' } },
        { action: { character: 'G' }, label: { text: 'G' } },
        { action: { sendKeys: 'KP_0' }, label: { text: '₀' } },
      ],
    },

    h: {
      selectedIndex: 1,
      list: [
        { action: { character: 'h' }, label: { text: 'h' } },
        { action: { character: 'H' }, label: { text: 'H' } },
      ],
    },


    jk: {
      selectedIndex: 1,
      list: [
        { action: { character: 'j' }, label: { text: 'j' } },
        { action: { character: 'J' }, label: { text: 'J' } },
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


    xc: {
      selectedIndex: 1,
      list: [
        { action: { character: 'x' }, label: { text: 'x' } },
        { action: { character: 'X' }, label: { text: 'X' } },
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


    bn: {
      selectedIndex: 1,
      list: [
        { action: { character: 'b' }, label: { text: 'b' } },
        { action: { character: 'B' }, label: { text: 'B' } },
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
    swipe_up_18: {
      q: { action: { character: '1' }, label: { text: '1' } },
      we: { action: { character: '2' }, label: { text: '2' } },
      rt: { action: { character: '3' }, label: { text: '3' } },
      y: { action: { character: '4' }, label: { text: '4' } },
      u: { action: { character: '5' }, label: { text: '5' } },
      io: { action: { character: '6' }, label: { text: '6' } },
      p: { action: { character: '7' }, label: { text: '7' } },
      a: { action: { character: '8' }, label: { text: '8' } },
      sd: { action: { character: '9' }, label: { text: '9' } },
      fg: { action: { character: '0' }, label: { text: '0' } },
      h: { action: { character: '-' }, label: { text: '-' } },
      jk: { action: { character: '/' }, label: { text: '/' } },
      l: { action: { character: ':' }, label: { text: ':' } },
      z: { action: 'tab', label: { text: '⇥' } },
      xc: { action: { character: '<' }, label: { text: '<' } },
      v: { action: { character: '>' }, label: { text: '>' } },
      bn: { action: { character: '!' }, label: { text: '!' } },
      m: { action: { character: '?' }, label: { text: '?' } },
    },
    swipe_down_18: {
      q: { action: { character: '~' }, label: { text: '~' } },
      we: { action: { character: '@' }, label: { text: '@' } },
      rt: { action: { character: '#' }, label: { text: '#' } },
      y: { action: { character: '$' }, label: { text: '$' } },
      u: { action: { character: '%' }, label: { text: '%' } },
      io: { action: { character: '^' }, label: { text: '^' } },
      p: { action: { character: '&' }, label: { text: '&' } },
      a: { action: { character: '*' }, label: { text: '*' } },
      sd: { action: { character: '(' }, label: { text: '(' } },
      fg: { action: { character: ')' }, label: { text: ')' } },
      h: { action: { character: '_' }, label: { text: '_' } },
      jk: { action: if Settings.function_button_config.with_functions_row[deviceType] && Settings.function_button_config.enable_notification then { symbol: '\\' } else { character: '\\' }, label: { text: '\\' } },
      l: if Settings.function_button_config.with_functions_row[deviceType] then {
        action: { character: ';' },
        label: { text: ';' },
      } else {
        action: { shortcut: '#selectText' },
        label: { systemImageName: 'selection.pin.in.out' },
      },
      z: if Settings.function_button_config.with_functions_row[deviceType] then {
        action: { character: 'V' },
        label: { systemImageName: 'av.remote.fill' },
      } else {
        action: { shortcut: '#copy' },
        label: { systemImageName: 'arrow.up.doc.on.clipboard' },
      },
      xc: if Settings.function_button_config.with_functions_row[deviceType] then {
        action: { sendKeys: 'orc' },
        label: { systemImageName: 'calendar' },
      } else {
        action: { shortcut: '#cut' },
        label: { systemImageName: 'scissors' },
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
      bn: if Settings.function_button_config.with_functions_row[deviceType] then {
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
      backspace: { action: { shortcut: '#undo' } },
    },
  },
}
