// 暴露浮动面板键盘入口。
local panel = import '../keyboards/float/panel.libsonnet';

{
  new(theme, orientation): panel.new(theme, orientation),
}
