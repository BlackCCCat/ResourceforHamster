local numeric9 = import './numeric_9.jsonnet';
local toolbar_ipad = import '../lib/toolbar-ipad.libsonnet';
local utils = import '../lib/utils.libsonnet';
local color = import '../lib/color.libsonnet';
local center = import '../lib/center.libsonnet';
local fontSize = import '../lib/fontSize.libsonnet';

local ipad_fontSize = fontSize + {
  '数字键盘数字前景字体大小': 24,
};

local base = numeric9.layout('iPad');
{
  new(theme, orientation):: base.new(theme, orientation) + toolbar_ipad.getToolBar(theme) + utils.genNumberStyles(ipad_fontSize, color, theme, center),
}