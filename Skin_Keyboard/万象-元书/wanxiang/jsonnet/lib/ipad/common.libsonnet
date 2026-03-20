// Provide shared iPad-specific keyboard override helpers.
local center = import '../shared/center.libsonnet';
local color = import '../shared/color.libsonnet';
local fontSize = import '../shared/fontSize.libsonnet';
local Settings = import '../../Custom.libsonnet';

local config(settings) =
  if std.objectHas(settings, 'button_123_config') then settings.button_123_config else {};

local enableSlide(settings) =
  if std.objectHas(config(settings), 'enable_slide') then config(settings).enable_slide else true;

local secondaryActionMode(settings) =
  if std.objectHas(config(settings), 'secondary_action_mode') then config(settings).secondary_action_mode else 'hint_symbols';

local normalizeKeyboardType(value, fallback) =
  if value == 'symbolic' || value == 'emojis' then value else fallback;

local swipeMapping(settings) =
  local conf = config(settings);
  local up = normalizeKeyboardType(
    if std.objectHas(conf, 'swipe_up_keyboard') then conf.swipe_up_keyboard else 'symbolic',
    'symbolic'
  );
  local downDefault = if up == 'symbolic' then 'emojis' else 'symbolic';
  local down = normalizeKeyboardType(
    if std.objectHas(conf, 'swipe_down_keyboard') then conf.swipe_down_keyboard else downDefault,
    downDefault
  );
  if down == up then
    {
      up: up,
      down: if up == 'symbolic' then 'emojis' else 'symbolic',
    }
  else
    {
      up: up,
      down: down,
    };

{
  getOverrides(theme, keyboardLayout, createButtonFunc, hintRoot):: (
    local slideEnabled = enableSlide(Settings);
    local useHintSymbols = !slideEnabled && secondaryActionMode(Settings) == 'hint_symbols';
    local useSwipeActions = !slideEnabled && secondaryActionMode(Settings) == 'swipe';
    local swipeTargets = swipeMapping(Settings);
    {
    // 移除 iPhone 的 123Button
    '123Button':: null,

    // iPad 专属的 nextButton (地球键)
    nextButton: createButtonFunc(
      'next',
      keyboardLayout['竖屏按键尺寸']['next键size'], // iPad 横竖屏尺寸一致
      {},
      hintRoot,
      false
    ) + {
      backgroundStyle: 'systemButtonBackgroundStyle',
      foregroundStyle: 'nextButtonForegroundStyle',
      action: 'nextKeyboard',
    },
    nextButtonForegroundStyle: {
      buttonStyleType: 'systemImage',
      systemImageName: 'globe',
      normalColor: color[theme]['按键前景颜色'],
      highlightColor: color[theme]['按键前景颜色'],
      fontSize: fontSize['按键前景文字大小'] - 3,
      center: center['功能键前景文字偏移'] { y: 0.5 },
    },

    // 修改 ipad123Button 定义
    ipad123Button: createButtonFunc(
      'ipad123', // 注意：这里 key 叫 ipad123
      keyboardLayout['竖屏按键尺寸']['ipad123键size'],
      {},
      hintRoot,
      false
    ) + {
      backgroundStyle: 'systemButtonBackgroundStyle',
      [if slideEnabled then 'type']: 'horizontalSymbols',
      [if slideEnabled then 'maxColumns']: 1,
      [if slideEnabled then 'contentRightToLeft']: false,
      [if slideEnabled then 'dataSource']: 'ipad123ButtonSymbolsDataSource',
      [if !slideEnabled then 'action']: { keyboardType: 'numeric' },
      [if !slideEnabled then 'foregroundStyle']: ['123ButtonForegroundStyle'],
      [if useHintSymbols then 'hintSymbolsStyle']: '123ButtonHintSymbolsStyle',
      [if useSwipeActions then 'swipeUpAction']: { keyboardType: swipeTargets.up },
      [if useSwipeActions then 'swipeDownAction']: { keyboardType: swipeTargets.down },
    },
    ipad123ButtonSymbolsDataSource: [
        { label: '1', action: { keyboardType: 'numeric' }, styleName: 'numericStyle' },
        { label: '2', action: { keyboardType: 'symbolic' }, styleName: 'symbolicStyle' },
        { label: '4', action: { keyboardType: 'emojis' }, styleName: 'emojisStyle' },
      ],
    }
  ),
}
