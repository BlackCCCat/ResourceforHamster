// 定义 123Button 与符号按钮共用的交互配置辅助逻辑。
local normalizeKeyboardType(value, fallback) =
  if value == 'symbolic' || value == 'emojis' then value else fallback;

local button123Config(settings) =
  if std.objectHas(settings, 'button_123_config') then settings.button_123_config else {};

local button123SwipeMapping(settings) =
  local conf = button123Config(settings);
  local up = normalizeKeyboardType(
    if std.objectHas(conf, 'swipe_up_keyboard') then conf.swipe_up_keyboard else 'symbolic',
    'symbolic'
  );
  local downDefault = if up == 'symbolic' then 'emojis' else 'symbolic';
  local down = normalizeKeyboardType(
    if std.objectHas(conf, 'swipe_down_keyboard') then conf.swipe_down_keyboard else downDefault,
    downDefault
  );
  if down == up then {
    up: up,
    down: if up == 'symbolic' then 'emojis' else 'symbolic',
  } else {
    up: up,
    down: down,
  };

local symbolButtonConfig(settings) =
  if std.objectHas(settings, 'button_symbol_config') then settings.button_symbol_config else {};

local symbolButtonSwipeMapping(settings) =
  local conf = symbolButtonConfig(settings);
  local up = normalizeKeyboardType(
    if std.objectHas(conf, 'swipe_up_keyboard') then conf.swipe_up_keyboard else 'emojis',
    'emojis'
  );
  {
    up: if up == 'symbolic' then 'emojis' else up,
  };

{
  button123: {
    config(settings): button123Config(settings),

    enableSlide(settings):
      local conf = button123Config(settings);
      if std.objectHas(conf, 'enable_slide') then conf.enable_slide else true,

    secondaryActionMode(settings):
      local conf = button123Config(settings);
      if std.objectHas(conf, 'secondary_action_mode') then conf.secondary_action_mode else 'hint_symbols',

    showSwipeIndicators(settings):
      local conf = button123Config(settings);
      if std.objectHas(conf, 'show_swipe_indicators') then conf.show_swipe_indicators else false,

    normalizeKeyboardType(value, fallback): normalizeKeyboardType(value, fallback),

    swipeMapping(settings): button123SwipeMapping(settings),

    hintData: {
      '123': {
        selectedIndex: 0,
        list: [
          {
            action: { keyboardType: 'symbolic' },
            label: { systemImageName: 'command.circle.fill' },
            fontSize: 16,
          },
          {
            action: { keyboardType: 'emojis' },
            label: { systemImageName: 'face.dashed' },
            fontSize: 16,
          },
        ],
      },
    },

    keyboardLabel(keyboardType):
      if keyboardType == 'symbolic' then
        { systemImageName: 'command.circle.fill' }
      else
        { systemImageName: 'face.dashed' },

    keyboardSwipeStyleData(keyboardType): {
      action: { keyboardType: keyboardType },
      label: if keyboardType == 'symbolic' then { systemImageName: 'command.circle.fill' } else { systemImageName: 'face.dashed' },
    },
  },

  symbolButton: {
    config(settings): symbolButtonConfig(settings),

    enableSlide(settings):
      local conf = symbolButtonConfig(settings);
      if std.objectHas(conf, 'enable_slide') then conf.enable_slide else true,

    secondaryActionMode(settings):
      local conf = symbolButtonConfig(settings);
      if std.objectHas(conf, 'secondary_action_mode') then conf.secondary_action_mode else 'hint_symbols',

    normalizeKeyboardType(value, fallback): normalizeKeyboardType(value, fallback),

    swipeMapping(settings): symbolButtonSwipeMapping(settings),

    hintData: {
      symbol: {
        selectedIndex: 0,
        list: [
          {
            action: { keyboardType: 'emojis' },
            label: { systemImageName: 'face.dashed' },
            fontSize: 16,
          },
        ],
      },
    },
  },
}
