local numeric9 = import './numeric_9.jsonnet';
local toolbar_ipad = import '../lib/toolbar-ipad.libsonnet';
local utils = import '../lib/utils.libsonnet';
local color = import '../lib/color.libsonnet';
local center = import '../lib/center.libsonnet';
local fontSize = import '../lib/fontSize.libsonnet';
local others = import '../lib/others.libsonnet';

local ipad_fontSize = fontSize + {
  '数字键盘数字前景字体大小': 24,
  'toolbar按键前景sf符号大小': 20,
};

local ipad_others = others + {
  '竖屏': others['竖屏'] + { 'preedit高度': 20, 'toolbar高度': 57 },
  '横屏': others['横屏'] + { 'preedit高度': 20, 'toolbar高度': 57 },
};

local base = numeric9.layout('iPad');

local ipad_keyboard(theme, orientation) =
  local base_def = base.new(theme, orientation);
  local toolbar_def = toolbar_ipad.getToolBar(theme);

  local ipad_overrides =
    toolbar_def +
    utils.genNumberStyles(ipad_fontSize, color, theme, center) +
    {
      preeditHeight: ipad_others[if orientation == 'portrait' then '竖屏' else '横屏']['preedit高度'],
      toolbarHeight: ipad_others[if orientation == 'portrait' then '竖屏' else '横屏']['toolbar高度'],
    } +
    {
      [key]+: { fontSize: ipad_fontSize['toolbar按键前景sf符号大小'] }
      for key in std.objectFields(toolbar_def)
      if std.startsWith(key, 'toolbarButton')
    };

  base_def + ipad_overrides;

{
  new(theme, orientation):: ipad_keyboard(theme, orientation),
}