// 定义拼音 123 切换键，支持滑动、长按菜单和上下滑模式。
local hintSymbolsStyles = import '../../../shared/styles/hintSymbolsStyles.libsonnet';
local keyHelpers = import '../../../shared/buttonHelpers/key.libsonnet';
local swipeKeyStyles = import '../../../shared/styles/swipeKeyStyles.libsonnet';
local buttonInteraction = import '../../../shared/buttonHelpers/buttonInteraction.libsonnet';

{
  build(theme, orientation, keyboardLayout, settings, createButton, baseHintStyles):: (
    local button123 = buttonInteraction.button123;
    local slideEnabled = button123.enableSlide(settings);
    local useHintSymbols = !slideEnabled && button123.secondaryActionMode(settings) == 'hint_symbols';
    local useSwipeActions = !slideEnabled && button123.secondaryActionMode(settings) == 'swipe';
    local showIndicators = settings.show_swipe && useSwipeActions && button123.showSwipeIndicators(settings);
    local swipeTargets = button123.swipeMapping(settings);
    local extraHintStyles = if useHintSymbols then hintSymbolsStyles.getStyle(theme, button123.hintData) else {};
    local extraSwipeStyles =
      if useSwipeActions then
        swipeKeyStyles.getStyle(
          'cn',
          theme,
          { '123': button123.keyboardSwipeStyleData(swipeTargets.up) },
          { '123': button123.keyboardSwipeStyleData(swipeTargets.down) }
        )
      else
        {};
    local rootStyles = baseHintStyles + extraHintStyles + extraSwipeStyles + keyHelpers.hintStyle('123');
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
        [if !slideEnabled then 'foregroundStyle']:
          ['123ButtonForegroundStyle'] +
          (if showIndicators then ['123ButtonUpForegroundStyle', '123ButtonDownForegroundStyle'] else []),
        hintStyle:: null,
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
    } + extraHintStyles + extraSwipeStyles + keyHelpers.hintStyle('123')
  ),
}
