# File Map

Use this map to decide where to edit.

## Root

Resolve everything relative to one selected `<keyboard-root>`.

Inside `<keyboard-root>`:

- config entry:
  - `jsonnet/Custom.libsonnet`
  - public layout toggles such as `swap_9_123_symbol` and `swap_numeric_return_symbol`
  - public `123Button` interaction config such as `button_123_config`
  - `button_123_config.show_swipe_indicators` only affects 123Button swipe-corner indicator visibility
  - public 9-key / numeric symbol-button interaction config such as `button_symbol_config`
- output entry:
  - `jsonnet/main.jsonnet`
- maintenance docs:
  - `README.md`
  - `MODULES.md`

## Entry files

- `jsonnet/entries/pinyin_26.jsonnet`
- `jsonnet/entries/alphabetic_26.jsonnet`
- `jsonnet/entries/pinyin_18.jsonnet`
- `jsonnet/entries/pinyin_14.jsonnet`
- `jsonnet/entries/pinyin_9.jsonnet`
- `jsonnet/entries/numeric_9.jsonnet`
- `jsonnet/entries/ipad_pinyin_26.jsonnet`
- `jsonnet/entries/ipad_alphabetic_26.jsonnet`
- `jsonnet/entries/ipad_numeric_9.jsonnet`
- `jsonnet/entries/panel.jsonnet`
  - 浮动面板入口；完整实现位于 `jsonnet/keyboards/float/panel.libsonnet`

Edit these only when changing entry wiring or adding a new keyboard type.

## Keyboards

### `jsonnet/keyboards/pinyin26/`

Main files:
- `iPhone.libsonnet`
- `iPad.libsonnet`
- `builder.libsonnet`

Use for:
- Chinese 26-key entry and assembly
- wiring shared 26-key layout, letters, and system-key modules into the final keyboard

### `jsonnet/keyboards/tempPinyin/`

Main files:
- `iPhone.libsonnet`

Use for:
- temporary pinyin 26-key wrapper output
- overriding only `cn2enButton` action, notification, and foreground when non-26 English keyboards swipe back into pinyin 26-key
- overriding temp-pinyin space-key marker text and swipe actions independently of `show_wanxiang`

### `jsonnet/keyboards/common/keyboard26/`

Main files:
- `buttonFactory.libsonnet`
- `layout.libsonnet`
- `letters.libsonnet`
- `iPadBuilder.libsonnet`

Use for:
- shared 26-key button factory
- shared 26-key layout
- shared 26-key letter spec
- shared iPad 26-key overlay assembly
- iPad 26-key row structure such as Tab, dual Shift, dual 123, bottom-row comma placement, swipe-up period, and dismiss key
- iPad-specific right Shift notification parity and landscape spacing

### `jsonnet/keyboards/pinyin26/iPad.libsonnet` and `jsonnet/keyboards/alphabetic26/iPad.libsonnet`

Use for:
- iPad Chinese/English 26-key entry-level font-size overrides
- keeping Chinese and English iPad letter size consistent

### `jsonnet/keyboards/common/systemKeys26/`

Main files:
- `systemKeys.libsonnet`
- `systemKeysSpec.libsonnet`
- `systemKeysSwitcher.libsonnet`
- `systemKeysShift.libsonnet`
- `systemKeysBackspace.libsonnet`
- `systemKeysCn2en.libsonnet`
- `systemKeysSpace.libsonnet`
- `systemKeysEnter.libsonnet`

Use for:
- shared 26-key system-key modules and assembly
- `123Button`, `shift`, `backspace`, `space`, `enter`, and `cn2en` system-key behavior

### `jsonnet/keyboards/alphabetic26/`

Main files:
- `iPhone.libsonnet`
- `iPad.libsonnet`
- `builder.libsonnet`
- `letters.libsonnet`
- `systemKeys.libsonnet`

Use for:
- English 26-key system keys
- English 26-key `123Button` behavior
- English 26-key 123Button swipe indicators and click-bubble behavior
- non-26 English keyboard `en2cnButton` swipe-up and space-key swipe-up behavior

### `jsonnet/keyboards/pinyin14/`

Main files:
- `iPhone.libsonnet`
- `layout.libsonnet`
- `specs.libsonnet`

Use for:
- 14-key layout and key spec changes

### `jsonnet/keyboards/pinyin18/`

Main files:
- `iPhone.libsonnet`
- `layout.libsonnet`
- `specs.libsonnet`

Use for:
- 18-key layout and key spec changes

### `jsonnet/keyboards/common/pinyin14_18/`

Main files:
- `iPhone.libsonnet`
- `buttons.libsonnet`
- `compactSpecFactory.libsonnet`

Use for:
- 14/18 shared pinyin build logic

### `jsonnet/keyboards/pinyin9/`

Main files:
- `iPhone.libsonnet`
- `layout.libsonnet`
- `builder.libsonnet`
- `panels.libsonnet`
- `t9.libsonnet`

Use for:
- 9-key layout changes
- `collection`, `verticalCandidates`, and `symbolButton`
- 9-key landscape split layout
- 9-key symbol-button assembly；共用配置解析位于 `jsonnet/shared/buttonHelpers/buttonInteraction.libsonnet`

### `jsonnet/keyboards/numeric9/`

Main files:
- `iPhone.libsonnet`
- `iPad.libsonnet`
- `layout.libsonnet`
- `builder.libsonnet`
- `panels.libsonnet`

Use for:
- numeric keyboard layout changes
- numeric keyboard return/switch slot swap
- `collection` and `landscapeNumericSymbols`
- iPad numeric keyboard entry behavior
- numeric symbol-button assembly；共用配置解析位于 `jsonnet/shared/buttonHelpers/buttonInteraction.libsonnet`


### `jsonnet/keyboards/float/`

Main files:
- `panel.libsonnet`

Use for:
- floating panel keyboard layout and button configuration

## Shared layout assembly

- `jsonnet/keyboards/common/layoutAssembly/keyboardLayoutAssembly.libsonnet`
- `jsonnet/shared/data/layoutData.libsonnet`
- `jsonnet/shared/functionButtons/functionRowPatch.libsonnet`

Use for:
- shared layout runtime context and final layout assembly
- shared base layout data
- function-row patching

## Function buttons

- `jsonnet/shared/functionButtons/iPhone.libsonnet`
- `jsonnet/shared/functionButtons/specs.libsonnet`
- `jsonnet/shared/functionButtons/styles.libsonnet`

Typical edits:
- button order
- button actions
- notification behavior
- function-button-only foreground styles

If order changes do not appear, also inspect:
- `jsonnet/shared/functionButtons/functionRowPatch.libsonnet`

## Toolbar

- `jsonnet/shared/toolbar/iPhone.libsonnet`
- `jsonnet/shared/toolbar/iPad.libsonnet`
- `jsonnet/shared/toolbar/config.libsonnet`
- `jsonnet/shared/toolbar/registry.libsonnet`
- `jsonnet/shared/toolbar/iPhoneRenderer.libsonnet`
- `jsonnet/shared/toolbar/iPadRenderer.libsonnet`

Typical edits:
- new toolbar button IDs
- toolbar action mapping
- toolbar foreground style objects such as `simplified_traditional`, `undo`, and `redo` in `iPhone.libsonnet`
- iPhone or iPad ordering rules
- toolbar menu behavior
- horizontal candidate trailing button controlled by `horizon_candidate_button` in `jsonnet/Custom.libsonnet` and rendered in `jsonnet/shared/toolbar/iPhone.libsonnet`
- horizontalSymbols content direction such as `content_right_to_left`
- toolbar height such as `toolbar_config.toolbar_height` or `toolbar_config.ipad.toolbar_height`

## Shared styles and helpers

- `jsonnet/shared/buttonHelpers/key.libsonnet`
- `jsonnet/shared/buttonHelpers/buttonInteraction.libsonnet`
- `jsonnet/shared/buttonHelpers/returnKey.libsonnet`
- `jsonnet/shared/styles/baseKeyStyles.libsonnet`
- `jsonnet/shared/styles/keyStyles.libsonnet`
- `jsonnet/shared/styles/styleFactories.libsonnet`
- `jsonnet/shared/styles/slideButtonStyles.libsonnet`
- `jsonnet/shared/styles/swipeKeyStyles.libsonnet`
- `jsonnet/shared/styles/hintSymbolsStyles.libsonnet`
- `jsonnet/shared/styles/color.libsonnet`
- `jsonnet/shared/styles/fontSize.libsonnet`
- `jsonnet/shared/styles/center.libsonnet`
- `jsonnet/shared/styles/others.libsonnet`
- `jsonnet/shared/styles/animation.libsonnet`

Use these when changing reusable styles, foreground generation, or helper logic.

`jsonnet/shared/buttonHelpers/buttonInteraction.libsonnet` is the shared source of truth for `button123` and `symbolButton` config parsing, long-press menu data, and swipe-target normalization.

`jsonnet/shared/buttonHelpers/returnKey.libsonnet` is the shared source of truth for reusable enter-key foreground and `returnKeyType` notification assembly.

## Shared data

- `jsonnet/shared/data/hintSymbolsData.libsonnet`
- `jsonnet/shared/data/swipeData.libsonnet`
- `jsonnet/shared/data/swipeDataEn.libsonnet`

Use these for pure shared data updates.

## Documentation

Update both when changing public configuration or maintenance-facing structure:

- `<keyboard-root>/README.md`
- `<keyboard-root>/MODULES.md`
