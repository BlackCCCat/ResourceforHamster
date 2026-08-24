// 在手机数字九键结果上叠加平板尺寸、工具栏和高度配置。
local Settings = import '../../Custom.libsonnet';
local appearance = import '../../design/appearance.libsonnet';
local center = appearance.center;
local color = appearance.color;
local fontSize = appearance.fontSize;
local keyStyles = import '../../components/key/factory.libsonnet';
local others = appearance.others;
local iPadToolbar = import '../../components/toolbar/iPad.libsonnet';
local numeric9 = import './keyboard.libsonnet';


local ipad_fontSize = fontSize {
  // iPad 数字字号使用较大基准，并与 Custom.numeric_digit_font_size 联动。
  '数字键盘数字前景字体大小': fontSize['数字键盘数字前景字体大小'] + 4,
  'toolbar按键前景sf符号大小': 20,
};

local ipad_others = others {
  '竖屏': others['竖屏'] { 'preedit高度': 20, 'toolbar高度': Settings.toolbar_config.ipad.toolbar_height, 'keyboard高度': 240 },
  '横屏': others['横屏'] { 'preedit高度': 20, 'toolbar高度': Settings.toolbar_config.ipad.toolbar_height, 'keyboard高度': 350 },
};

local base = numeric9.layout('iPad');

local ipad_keyboard(theme, orientation) =
  local base_orientation = if orientation == 'landscape' then 'portrait' else orientation;
  local base_def = base.new(theme, base_orientation);
  local toolbar_def = iPadToolbar.getToolBar(theme);

  local ipad_overrides =
    toolbar_def +
    keyStyles.genNumberStyles(ipad_fontSize, color, theme, center) +
    {
      preeditHeight: ipad_others[if orientation == 'portrait' then '竖屏' else '横屏']['preedit高度'],
      toolbarHeight: ipad_others[if orientation == 'portrait' then '竖屏' else '横屏']['toolbar高度'],
      keyboardHeight: ipad_others[if orientation == 'portrait' then '竖屏' else '横屏']['keyboard高度'],
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
