local numeric9 = import './numeric_9.jsonnet';
local toolbar_ipad = import '../lib/toolbar-ipad.libsonnet';

local base = numeric9.layout('iPad');
{
  new(theme, orientation):: base.new(theme, orientation) + toolbar_ipad.getToolBar(theme),
}