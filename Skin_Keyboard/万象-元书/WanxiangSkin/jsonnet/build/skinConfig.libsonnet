// 定义皮肤元信息，以及各输入类型在不同设备方向下对应的输出键盘名。
local Settings = import '../Custom.libsonnet';
local supportedLayouts = [9, 14, 17, 18, 26, 27];
local defaultLayout = if std.member(supportedLayouts, Settings.keyboard_layout) then Settings.keyboard_layout else 26;
local activeLayouts = if Settings.enable_layout_switcher then supportedLayouts else [defaultLayout];

// iPhone 中文拼音与英文返回布局槽位：文件名由布局编号直接决定。
local pinyinSlot(layout) = {
  iPhone: {
    portrait: 'pinyin_' + std.toString(layout) + '_portrait',
    landscape: 'pinyin_' + std.toString(layout) + '_landscape',
  },
};
local alphabeticSlot(layout) = {
  iPhone: {
    portrait: 'alphabetic_' + std.toString(layout) + '_portrait',
    landscape: 'alphabetic_' + std.toString(layout) + '_landscape',
  },
};

// 仅注册本次实际输出的直达槽位；关闭布局切换时只保留默认布局的返回链路。
local directLayoutSlots = std.foldl(
  function(acc, layout)
    local suffix = std.toString(layout);
    acc + {
      ['pinyin' + suffix]: pinyinSlot(layout),
      ['alphabetic' + suffix]: alphabeticSlot(layout),
    },
  activeLayouts,
  {}
);

local layoutSwitcherSlot = if Settings.enable_layout_switcher then {
  keyboard_switcher: {
    iPhone: {
      portrait: 'keyboard_switcher_portrait',
      landscape: 'keyboard_switcher_landscape',
    },
  },
} else {};

{
  activeLayouts:: activeLayouts,
  layoutSwitcherEnabled:: Settings.enable_layout_switcher,
  author: 'BlackCCCat',
  name: '万象键盘',
  // 主槽：跟随 Custom.keyboard_layout，保持「默认布局」语义不变。
  pinyin: {
    iPhone: {
      portrait: 'pinyin_' + std.toString(defaultLayout) + '_portrait',
      landscape: 'pinyin_' + std.toString(defaultLayout) + '_landscape',
    },
    iPad: {
      portrait: 'ipad_pinyin_26_portrait',
      landscape: 'ipad_pinyin_26_landscape',
      floating: 'pinyin_' + std.toString(defaultLayout) + '_portrait',
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
      portrait: 'alphabetic_' + std.toString(defaultLayout) + '_portrait',
      landscape: 'alphabetic_' + std.toString(defaultLayout) + '_landscape',
    },
    iPad: {
      portrait: 'ipad_alphabetic_26_portrait',
      landscape: 'ipad_alphabetic_26_landscape',
      floating: 'alphabetic_' + std.toString(defaultLayout) + '_portrait',
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
} + directLayoutSlots + layoutSwitcherSlot
