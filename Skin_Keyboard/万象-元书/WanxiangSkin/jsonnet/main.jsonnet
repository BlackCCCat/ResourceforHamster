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

local Settings = import 'Custom.libsonnet';

local pinyin =
  if Settings.keyboard_layout == 18 then import 'keyboards/pinyin18/iPhone.libsonnet'
  else if Settings.keyboard_layout == 14 then import 'keyboards/pinyin14/iPhone.libsonnet'
  else if Settings.keyboard_layout == 9 then import 'keyboards/pinyin9/iPhone.libsonnet'
  else import 'keyboards/pinyin26/iPhone.libsonnet';
local alphabetic = import 'keyboards/alphabetic26/iPhone.libsonnet';
local numeric = import 'keyboards/numeric9/iPhone.libsonnet';
local panel = import 'entries/panel.jsonnet';

local ipad_pinyin = import 'keyboards/pinyin26/iPad.libsonnet';
local ipad_alphabetic = import 'keyboards/alphabetic26/iPad.libsonnet';
local ipad_numeric = import 'keyboards/numeric9/iPad.libsonnet';


// 输出文件生成
local themes = ['light', 'dark'];
local orientations = ['portrait', 'landscape'];

local render(module, prefix) = {
  [theme + '/' + prefix + '_' + orientation + '.yaml']: std.toString(module.new(theme, orientation))
  for theme in themes
  for orientation in orientations
};

{
  'config.yaml': std.manifestYamlDoc(config, indent_array_in_object=true, quote_keys=false),
} +
render(pinyin, 'pinyin_26') +
render(ipad_pinyin, 'ipad_pinyin_26') +
render(alphabetic, 'alphabetic_26') +
render(ipad_alphabetic, 'ipad_alphabetic_26') +
render(numeric, 'numeric_9') +
render(ipad_numeric, 'ipad_numeric_9') +
render(panel, 'panel')
