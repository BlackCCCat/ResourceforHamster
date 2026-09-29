// 定义皮肤元信息，以及各输入类型在不同设备方向下对应的输出键盘名。
local Settings = import '../Custom.libsonnet';

// iPhone 中文拼音布局槽位：文件名由布局编号直接决定。
local pinyinSlot(layout) = {
  iPhone: {
    portrait: 'pinyin_' + std.toString(layout) + '_portrait',
    landscape: 'pinyin_' + std.toString(layout) + '_landscape',
  },
};

{
  author: 'BlackCCCat',
  name: '万象键盘',
  // 主槽：跟随 Custom.keyboard_layout，保持「默认布局」语义不变。
  pinyin: {
    iPhone: {
      portrait: 'pinyin_' + std.toString(Settings.keyboard_layout) + '_portrait',
      landscape: 'pinyin_' + std.toString(Settings.keyboard_layout) + '_landscape',
    },
    iPad: {
      portrait: 'ipad_pinyin_26_portrait',
      landscape: 'ipad_pinyin_26_landscape',
      floating: 'pinyin_26_portrait',
    },
  },
  // 布局直达槽位，供布局切换面板的 keyboardType 使用。
  pinyin9: pinyinSlot(9),
  pinyin14: pinyinSlot(14),
  pinyin17: pinyinSlot(17),
  pinyin18: pinyinSlot(18),
  pinyin26: pinyinSlot(26),
  pinyin27: pinyinSlot(27),
  // 布局切换浮动面板，由工具栏 keyboard_switcher 打开。
  keyboard_switcher: {
    iPhone: {
      portrait: 'keyboard_switcher_portrait',
      landscape: 'keyboard_switcher_landscape',
    },
  },
  temp_pinyin: {
    iPhone: {
      portrait: 'temp_pinyin_portrait',
      landscape: 'temp_pinyin_landscape',
    },
  },
  alphabetic: {
    iPhone: {
      portrait: 'alphabetic_26_portrait',
      landscape: 'alphabetic_26_landscape',
    },
    iPad: {
      portrait: 'ipad_alphabetic_26_portrait',
      landscape: 'ipad_alphabetic_26_landscape',
      floating: 'alphabetic_26_portrait',
    },
  },
  numeric: {
    iPhone: {
      portrait: 'numeric_9_portrait',
      landscape: 'numeric_9_landscape',
    },
    iPad: {
      portrait: 'ipad_numeric_9_portrait',
      landscape: 'ipad_numeric_9_landscape',
      floating: 'numeric_9_portrait',
    },
  },
  panel: {
    iPhone: {
      portrait: 'panel_portrait',
      landscape: 'panel_landscape',
    },
  },
}
