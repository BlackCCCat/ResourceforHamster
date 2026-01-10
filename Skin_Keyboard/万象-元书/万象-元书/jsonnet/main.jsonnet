local config = {
  author: 'BlackCCCat',
  name: '万象键盘',
  pinyin: {
    iPhone: {
      portrait: 'pinyin_26_portrait',
      landscape: 'pinyin_26_landscape',
    },
    iPad: {
      portrait: 'ipad_pinyin_26_portrait',
      landscape: 'ipad_pinyin_26_landscape',
      floating: 'ipad_pinyin_26_portrait',
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
      floating: 'ipad_alphabetic_26_portrait',
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
      floating: 'ipad_numeric_9_portrait',
    },
  },

  panel: {
    iPhone: {
      portrait: 'panel_portrait',
      landscape: 'panel_landscape',
    },
  },
};

local Settings = import 'custom/Custom.libsonnet';

local pinyin = 
if Settings.keyboard_layout == 18 then import 'keyboard/pinyin_18.jsonnet' 
else if Settings.keyboard_layout == 14 then import 'keyboard/pinyin_14.jsonnet' 
else if Settings.keyboard_layout == 9 then import 'keyboard/pinyin_9.jsonnet'
else import 'keyboard/pinyin_26.jsonnet';
local alphabetic = import 'keyboard/alphabetic_26.jsonnet';
local numeric = import 'keyboard/numeric_9.jsonnet';
local panel = import 'keyboard/panel.jsonnet';

local ipad_pinyin = import 'keyboard/ipad_pinyin_26.jsonnet';
local ipad_alphabetic = import 'keyboard/ipad_alphabetic_26.jsonnet';
local ipad_numeric = import 'keyboard/ipad_numeric_9.jsonnet';


// 拼音
local lightPinyinPortrait = pinyin.new('light', 'portrait');
local darkPinyinPortrait = pinyin.new('dark', 'portrait');
local lightPinyinLandscape = pinyin.new('light', 'landscape');
local darkPinyinLandscape = pinyin.new('dark', 'landscape');

// ipad拼音
local ipadlightPinyinPortrait = ipad_pinyin.new('light', 'portrait');
local ipaddarkPinyinPortrait = ipad_pinyin.new('dark', 'portrait');
local ipadlightPinyinLandscape = ipad_pinyin.new('light', 'landscape');
local ipaddarkPinyinLandscape = ipad_pinyin.new('dark', 'landscape');


// 字母
local lightAlphabeticPortrait = alphabetic.new('light', 'portrait');
local darkAlphabeticPortrait = alphabetic.new('dark', 'portrait');
local lightAlphabeticLandscape = alphabetic.new('light', 'landscape');
local darkAlphabeticLandscape = alphabetic.new('dark', 'landscape');

// ipad字母
local ipadlightAlphabeticPortrait = ipad_alphabetic.new('light', 'portrait');
local ipaddarkAlphabeticPortrait = ipad_alphabetic.new('dark', 'portrait');
local ipadlightAlphabeticLandscape = ipad_alphabetic.new('light', 'landscape');
local ipaddarkAlphabeticLandscape = ipad_alphabetic.new('dark', 'landscape');

// 数字
local lightNumericPortrait = numeric.new('light', 'portrait');
local darkNumericPortrait = numeric.new('dark', 'portrait');
local lightNumericLandscape = numeric.new('light', 'landscape');
local darkNumericLandscape = numeric.new('dark', 'landscape');

// ipad数字
local ipad_lightNumericPortrait = ipad_numeric.new('light', 'portrait');
local ipad_darkNumericPortrait = ipad_numeric.new('dark', 'portrait');
local ipad_lightNumericLandscape = ipad_numeric.new('light', 'landscape');
local ipad_darkNumericLandscape = ipad_numeric.new('dark', 'landscape');


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

  // ipad拼音
  'light/ipad_pinyin_26_portrait.yaml': std.toString(ipadlightPinyinPortrait),
  'dark/ipad_pinyin_26_portrait.yaml': std.toString(ipaddarkPinyinPortrait),
  'light/ipad_pinyin_26_landscape.yaml': std.toString(ipadlightPinyinLandscape),
  'dark/ipad_pinyin_26_landscape.yaml': std.toString(ipaddarkPinyinLandscape),

  // 字母
  'light/alphabetic_26_portrait.yaml': std.toString(lightAlphabeticPortrait),
  'dark/alphabetic_26_portrait.yaml': std.toString(darkAlphabeticPortrait),
  'light/alphabetic_26_landscape.yaml': std.toString(lightAlphabeticLandscape),
  'dark/alphabetic_26_landscape.yaml': std.toString(darkAlphabeticLandscape),

  // ipad字母
  'light/ipad_alphabetic_26_portrait.yaml': std.toString(ipadlightAlphabeticPortrait),
  'dark/ipad_alphabetic_26_portrait.yaml': std.toString(ipaddarkAlphabeticPortrait),
  'light/ipad_alphabetic_26_landscape.yaml': std.toString(ipadlightAlphabeticLandscape),
  'dark/ipad_alphabetic_26_landscape.yaml': std.toString(ipaddarkAlphabeticLandscape),

  // 数字
  'light/numeric_9_portrait.yaml': std.toString(lightNumericPortrait),
  'dark/numeric_9_portrait.yaml': std.toString(darkNumericPortrait),
  'light/numeric_9_landscape.yaml': std.toString(lightNumericLandscape),
  'dark/numeric_9_landscape.yaml': std.toString(darkNumericLandscape),

  // ipad数字
  'light/ipad_numeric_9_portrait.yaml': std.toString(ipad_lightNumericPortrait),
  'dark/ipad_numeric_9_portrait.yaml': std.toString(ipad_darkNumericPortrait),
  'light/ipad_numeric_9_landscape.yaml': std.toString(ipad_lightNumericLandscape),
  'dark/ipad_numeric_9_landscape.yaml': std.toString(ipad_darkNumericLandscape),

  // 面板
  'light/panel_portrait.yaml': std.toString(lightPanelPortrait),
  'dark/panel_portrait.yaml': std.toString(darkPanelPortrait),
  'light/panel_landscape.yaml': std.toString(lightPanelLandscape),
  'dark/panel_landscape.yaml': std.toString(darkPanelLandscape),
}
