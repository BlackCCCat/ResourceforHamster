// 描述 14 键键位规格，并维护该布局专用的长按与上下划数据。
local compactShared = import '../base/specFactory.libsonnet';

local Settings = import '../../../Custom.libsonnet';
local familyData = {
  getSpec(context, keyboardLayout)::
    local isPortrait = context.isPortrait;
    {
      layoutName: if isPortrait then '竖屏中文14键' else '横屏中文14键',
      hintData: 'pinyin_14',
      swipeUpName: 'swipe_up_14',
      swipeDownName: 'swipe_down_14',
      wanxiangSetting: 'is_wanxiang_14',
      sizes: {
        shift: if isPortrait then keyboardLayout['竖屏按键尺寸']['shift键size'].width else keyboardLayout['横屏按键尺寸']['14键横屏shift键size'].width,
        backspace: if isPortrait then keyboardLayout['竖屏按键尺寸']['backspace键size'].width else keyboardLayout['横屏按键尺寸']['14键横屏backspace键size'].width,
        oneTwoThree: if isPortrait then keyboardLayout['竖屏按键尺寸']['123键size'].width else keyboardLayout['横屏按键尺寸']['123键size'].width,
        space: if isPortrait then keyboardLayout['竖屏按键尺寸']['space键size'].width else keyboardLayout['横屏按键尺寸']['space键size'].width,
        spaceLeft: if isPortrait then keyboardLayout['竖屏按键尺寸']['spaceLeft键size'].width else keyboardLayout['横屏按键尺寸']['spaceLeft键size'].width,
        enter: if isPortrait then keyboardLayout['竖屏按键尺寸']['enter键size'].width else keyboardLayout['横屏按键尺寸']['enter键size'].width,
      },
      keys: compactShared.buildKeys(
        [
          ['qw', 'q', '14r1'],
          ['er', 'e', '14r1'],
          ['ty', 't', '14r1'],
          ['ui', 'u', '14r1'],
          ['op', 'o', '14r1'],
          ['as', 'a', '14as'],
          ['df', 'd', '14r2'],
          ['gh', 'g', '14r2'],
          ['jk', 'j', '14r2'],
          ['l', 'l', '14l'],
          ['zx', 'z', '14r3'],
          ['cv', 'c', '14r3'],
          ['bn', 'b', '14r3'],
          ['m', 'm', '14r3'],
        ],
        context,
        keyboardLayout
      ),
    },
};

familyData {
  pinyin_14: {
    qw: {
      selectedIndex: 1,  // 长按菜单默认选中项索引。
      list: [
        { action: { character: 'q' }, label: { text: 'q' } },  // action 定义触发动作，label 支持 text 或 systemImageName。
        { action: { character: 'Q' }, label: { text: 'Q' } },
        { action: { character: 'w' }, label: { text: 'w' } },
        { action: { character: 'W' }, label: { text: 'W' } },
        { action: { sendKeys: 'KP_1' }, label: { text: '₁' } },
      ],
    },
    er: {
      selectedIndex: 1,
      list: [

        { action: { character: 'e' }, label: { text: 'e' } },
        { action: { character: 'E' }, label: { text: 'E' } },
        { action: { character: 'r' }, label: { text: 'r' } },
        { action: { character: 'R' }, label: { text: 'R' } },
        { action: { sendKeys: 'KP_2' }, label: { text: '₂' } },
      ],
    },
    ty: {
      selectedIndex: 1,
      list: [
        { action: { character: 't' }, label: { text: 't' } },
        { action: { character: 'T' }, label: { text: 'T' } },
        { action: { character: 'y' }, label: { text: 'y' } },
        { action: { character: 'Y' }, label: { text: 'Y' } },
        { action: { sendKeys: 'KP_3' }, label: { text: '₃' } },

      ],
    },
    ui: {
      selectedIndex: 1,
      list: [
        { action: { character: 'u' }, label: { text: 'u' } },
        { action: { character: 'U' }, label: { text: 'U' } },
        { action: { character: 'i' }, label: { text: 'i' } },
        { action: { character: 'I' }, label: { text: 'I' } },
        { action: { sendKeys: 'KP_4' }, label: { text: '₄' } },
      ],
    },
    op: {
      selectedIndex: 1,
      list: [
        { action: { character: 'o' }, label: { text: 'o' } },
        { action: { character: 'O' }, label: { text: 'O' } },
        { action: { character: 'p' }, label: { text: 'p' } },
        { action: { character: 'P' }, label: { text: 'P' } },
        { action: { sendKeys: 'KP_5' }, label: { text: '₅' } },
      ],
    },


    as: {
      selectedIndex: 1,
      list: [
        { action: { character: 'a' }, label: { text: 'a' } },
        { action: { character: 'A' }, label: { text: 'A' } },
        { action: { character: 's' }, label: { text: 's' } },
        { action: { character: 'S' }, label: { text: 'S' } },
        { action: { sendKeys: 'KP_6' }, label: { text: '₆' } },
      ],
    },

    df: {
      selectedIndex: 1,
      list: [
        { action: { character: 'd' }, label: { text: 'd' } },
        { action: { character: 'D' }, label: { text: 'D' } },
        { action: { character: 'f' }, label: { text: 'f' } },
        { action: { character: 'F' }, label: { text: 'F' } },
        { action: { sendKeys: 'KP_7' }, label: { text: '₇' } },

      ],
    },


    gh: {
      selectedIndex: 1,
      list: [
        { action: { character: 'g' }, label: { text: 'g' } },
        { action: { character: 'G' }, label: { text: 'G' } },
        { action: { character: 'h' }, label: { text: 'h' } },
        { action: { character: 'H' }, label: { text: 'H' } },
        { action: { sendKeys: 'KP_8' }, label: { text: '₈' } },
      ],
    },

    jk: {
      selectedIndex: 1,
      list: [
        { action: { character: 'j' }, label: { text: 'j' } },
        { action: { character: 'J' }, label: { text: 'J' } },
        { action: { character: 'k' }, label: { text: 'k' } },
        { action: { character: 'K' }, label: { text: 'K' } },
        { action: { sendKeys: 'KP_9' }, label: { text: '₉' } },
      ],
    },

    l: {
      selectedIndex: 1,
      list: [
        { action: { character: 'l' }, label: { text: 'l' } },
        { action: { character: 'L' }, label: { text: 'L' } },
        { action: { sendKeys: 'KP_0' }, label: { text: '₀' } },
      ],
    },

    zx: {
      selectedIndex: 1,
      list: [
        { action: { character: 'z' }, label: { text: 'z' } },
        { action: { character: 'Z' }, label: { text: 'Z' } },
        { action: { character: 'x' }, label: { text: 'x' } },
        { action: { character: 'X' }, label: { text: 'X' } },
      ],
    },

    cv: {
      selectedIndex: 1,
      list: [
        { action: { character: 'c' }, label: { text: 'c' } },
        { action: { character: 'C' }, label: { text: 'C' } },
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
    swipe_up_14: {
      qw: { action: { character: '1' }, label: { text: '1' } },
      er: { action: { character: '2' }, label: { text: '2' } },
      ty: { action: { character: '3' }, label: { text: '3' } },
      ui: { action: { character: '4' }, label: { text: '4' } },
      op: { action: { character: '5' }, label: { text: '5' } },
      as: { action: { character: '6' }, label: { text: '6' } },
      df: { action: { character: '7' }, label: { text: '7' } },
      gh: { action: { character: '8' }, label: { text: '8' } },
      jk: { action: { character: '/' }, label: { text: '/' } },
      l: { action: { character: ':' }, label: { text: ':' } },
      zx: { action: { character: '9' }, label: { text: '9' } },
      cv: { action: { character: '0' }, label: { text: '0' } },
      bn: { action: { character: '!' }, label: { text: '!' } },
      m: { action: { character: '?' }, label: { text: '?' } },
    },
    swipe_down_14: {
      qw: { action: { character: '-' }, label: { text: '-' } },
      er: { action: { character: '+' }, label: { text: '+' } },
      ty: { action: { character: '*' }, label: { text: '*' } },
      ui: { action: { character: '=' }, label: { text: '=' } },
      op: if Settings.function_button_config.with_functions_row[deviceType] then {
        action: { character: '%' },
        label: { text: '%' },
      } else {
        action: { shortcut: '#paste' },
        label: { systemImageName: 'doc.on.clipboard.fill' },
      },
      as: if Settings.function_button_config.with_functions_row[deviceType] then {
        action: { character: '^' },
        label: { text: '^' },
      } else {
        action: { shortcut: '#selectText' },
        label: { systemImageName: 'selection.pin.in.out' },
      },
      df: { action: { character: '_' }, label: { text: '_' } },
      gh: { action: { character: '#' }, label: { text: '#' } },
      jk: { action: if Settings.function_button_config.with_functions_row[deviceType] && Settings.function_button_config.enable_notification then { symbol: '\\' } else { character: '\\' }, label: { text: '\\' } },
      l: { action: { character: ';' }, label: { text: ';' } },
      zx: if Settings.function_button_config.with_functions_row[deviceType] then {
        action: { sendKeys: 'orc' },
        label: { systemImageName: 'calendar' },
        // center: { x: 0.5, y: 0.8 },
      } else {
        action: { shortcut: '#cut' },
        label: { systemImageName: 'scissors' },
        // center: { x: 0.5, y: 0.8 },
      },
      cv: if Settings.function_button_config.with_functions_row[deviceType] then {
        action: { character: 'V' },
        label: { systemImageName: 'av.remote.fill' },
        // center: { x: 0.5, y: 0.8 },
      } else {
        action: { shortcut: '#copy' },
        label: { systemImageName: 'arrow.up.doc.on.clipboard' },
      },
      bn: if Settings.function_button_config.with_functions_row[deviceType] then {
        action: { sendKeys: 'osj' },
        label: { systemImageName: 'clock.circle' },
      } else {
        action: { shortcut: '#rimePreviousPage' },
        label: { systemImageName: 'chevron.up' },
      },
      m: if Settings.function_button_config.with_functions_row[deviceType] then {
        action: { character: '`' },
        label: { systemImageName: 'rectangle.3.group.fill' },
      } else {
        action: { shortcut: '#rimeNextPage' },
        label: { systemImageName: 'chevron.down' },
      },
      backspace: { action: { shortcut: '#undo' } },
    },
  },
}
