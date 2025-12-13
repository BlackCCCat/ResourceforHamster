local config = {
  author: 'BlackCCCat',
  name: '万象键盘',
  pinyin: {
    iPhone: {
      portrait: 'pinyin_26_portrait',
      landscape: 'pinyin_26_landscape',
    },
    iPad: {
      portrait: 'pinyin_26_portrait',
      landscape: 'pinyin_26_portrait',
      floating: 'pinyin_26_portrait',
    },
  },
  alphabetic: {
    iPhone: {
      portrait: 'alphabetic_26_portrait',
      landscape: 'alphabetic_26_landscape',
    },
    iPad: {
      portrait: 'alphabetic_26_portrait',
      landscape: 'alphabetic_26_portrait',
      floating: 'alphabetic_26_portrait',
    },
  },
  numeric: {
    iPhone: {
      portrait: 'numeric_9_portrait',
      landscape: 'numeric_9_landscape',
    },
    iPad: {
      portrait: 'numeric_9_portrait',
      landscape: 'numeric_9_landscape',
      floating: 'numeric_9_portrait',
    },
  },

  panel: {
    iPhone: {
      portrait: 'panel_portrait',
      landscape: 'panel_landscape',
    },
  },
};

local pinyin = import 'keyboard/pinyin_26.jsonnet';
local alphabetic = import 'keyboard/alphabetic_26.jsonnet';
local numeric = import 'keyboard/numeric_9.jsonnet';
local panel = import 'keyboard/panel.jsonnet';

// 拼音
local lightPinyinPortrait = pinyin.new('light', 'portrait');
local darkPinyinPortrait = pinyin.new('dark', 'portrait');
local lightPinyinLandscape = pinyin.new('light', 'landscape');
local darkPinyinLandscape = pinyin.new('dark', 'landscape');

// 字母
local lightAlphabeticPortrait = alphabetic.new('light', 'portrait');
local darkAlphabeticPortrait = alphabetic.new('dark', 'portrait');
local lightAlphabeticLandscape = alphabetic.new('light', 'landscape');
local darkAlphabeticLandscape = alphabetic.new('dark', 'landscape');

// 数字
local lightNumericPortrait = numeric.new('light', 'portrait');
local darkNumericPortrait = numeric.new('dark', 'portrait');
local lightNumericLandscape = numeric.new('light', 'landscape');
local darkNumericLandscape = numeric.new('dark', 'landscape');


// 面板
local lightPanelPortrait = panel.new('light', 'portrait');
local darkPanelPortrait = panel.new('dark', 'portrait');
local lightPanelLandscape = panel.new('light', 'landscape');
local darkPanelLandscape = panel.new('dark', 'landscape');

{
  'config.yaml': std.manifestYamlDoc(config, indent_array_in_object=true, quote_keys=false),
  // 拼音
  'light/pinyin_26_portrait.yaml': std.toString(lightPinyinPortrait),
  'dark/pinyin_26_portrait.yaml': std.toString(darkPinyinPortrait),
  'light/pinyin_26_landscape.yaml': std.toString(lightPinyinLandscape),
  'dark/pinyin_26_landscape.yaml': std.toString(darkPinyinLandscape),

  // 字母
  'light/alphabetic_26_portrait.yaml': std.toString(lightAlphabeticPortrait),
  'dark/alphabetic_26_portrait.yaml': std.toString(darkAlphabeticPortrait),
  'light/alphabetic_26_landscape.yaml': std.toString(lightAlphabeticLandscape),
  'dark/alphabetic_26_landscape.yaml': std.toString(darkAlphabeticLandscape),

  // 数字
  'light/numeric_9_portrait.yaml': std.toString(lightNumericPortrait),
  'dark/numeric_9_portrait.yaml': std.toString(darkNumericPortrait),
  'light/numeric_9_landscape.yaml': std.toString(lightNumericLandscape),
  'dark/numeric_9_landscape.yaml': std.toString(darkNumericLandscape),

  // 面板
  'light/panel_portrait.yaml': std.toString(lightPanelPortrait),
  'dark/panel_portrait.yaml': std.toString(darkPanelPortrait),
  'light/panel_landscape.yaml': std.toString(lightPanelLandscape),
  'dark/panel_landscape.yaml': std.toString(darkPanelLandscape),
}
