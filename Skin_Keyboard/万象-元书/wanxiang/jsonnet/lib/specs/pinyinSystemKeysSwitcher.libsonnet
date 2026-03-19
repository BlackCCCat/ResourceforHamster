// Define the pinyin 123 switcher key so keyboard switching can use slide, long-press, or swipe without leaking logic into other system keys.
local hintSymbolsStyles = import '../shared/hintSymbolsStyles.libsonnet';

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

local hintData = {
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
};

{
  build(theme, orientation, keyboardLayout, settings, createButton, baseHintStyles):: (
    local slideEnabled = enableSlide(settings);
    local useHintSymbols = !slideEnabled && secondaryActionMode(settings) == 'hint_symbols';
    local useSwipeActions = !slideEnabled && secondaryActionMode(settings) == 'swipe';
    local swipeTargets = swipeMapping(settings);
    local extraHintStyles = if useHintSymbols then hintSymbolsStyles.getStyle(theme, hintData) else {};
    local rootStyles = baseHintStyles + extraHintStyles;
    {
      '123Button': createButton(
        '123',
        if orientation == 'portrait' then
          keyboardLayout['竖屏按键尺寸']['123键size']
        else
          keyboardLayout['横屏按键尺寸']['123键size'],
        {},
        rootStyles,
        false
      ) + {
        backgroundStyle: 'systemButtonBackgroundStyle',
        [if slideEnabled then 'type']: 'horizontalSymbols',
        [if slideEnabled then 'maxColumns']: 1,
        [if slideEnabled then 'insets']: { left: 3, right: 3 },
        [if slideEnabled then 'contentRightToLeft']: false,
        [if slideEnabled then 'dataSource']: '123ButtonSymbolsDataSource',
        [if !slideEnabled then 'action']: { keyboardType: 'numeric' },
        [if !slideEnabled then 'foregroundStyle']: ['123ButtonForegroundStyle'],
        [if useHintSymbols then 'hintSymbolsStyle']: '123ButtonHintSymbolsStyle',
        [if useSwipeActions then 'swipeUpAction']: { keyboardType: swipeTargets.up },
        [if useSwipeActions then 'swipeDownAction']: { keyboardType: swipeTargets.down },
        [if !slideEnabled && !useSwipeActions then 'swipeUpAction']:: null,
        [if !slideEnabled && !useSwipeActions then 'swipeDownAction']:: null,
      },
      '123ButtonSymbolsDataSource': [
        { label: '1', action: { keyboardType: 'numeric' }, styleName: 'numericStyle' },
        { label: '2', action: { keyboardType: 'symbolic' }, styleName: 'symbolicStyle' },
        { label: '4', action: { keyboardType: 'emojis' }, styleName: 'emojisStyle' },
      ],
    } + extraHintStyles
  ),
}
