# Playbooks

All playbooks assume you already resolved one `<keyboard-root>`.

## Add or change a Custom option

1. Edit `jsonnet/Custom.libsonnet`.
2. Update all readers of that option with `rg`.
3. If the option changes behavior, compile the affected entry file.
4. Update `README.md` and `MODULES.md`.

Notes:

- If the option changes button placement instead of button behavior, update the owning layout file instead of a builder.
- Example:
  - `swap_9_123_symbol`
  - reader: `jsonnet/keyboards/pinyin9/layout.libsonnet`
  - affected entry: `jsonnet/entries/pinyin_9.jsonnet`
- Example:
  - `swap_numeric_return_symbol`
  - reader: `jsonnet/keyboards/numeric9/layout.libsonnet`
  - affected entry: `jsonnet/entries/numeric_9.jsonnet`
- Example:
  - `function_button_config.with_functions_row.iPhone`
  - may also affect dedicated landscape 9-key and numeric split layouts
  - readers:
    - `jsonnet/keyboards/pinyin9/layout.libsonnet`
    - `jsonnet/keyboards/numeric9/layout.libsonnet`
  - affected entries:
    - `jsonnet/entries/pinyin_9.jsonnet`
    - `jsonnet/entries/numeric_9.jsonnet`
- Example:
  - `button_123_config`
  - readers:
    - `jsonnet/shared/buttonHelpers/buttonInteraction.libsonnet`
    - `jsonnet/keyboards/common/systemKeys26/systemKeysSwitcher.libsonnet`
    - `jsonnet/keyboards/alphabetic26/systemKeys.libsonnet`
    - `jsonnet/keyboards/common/keyboard26/iPadBuilder.libsonnet`
  - affected entries:
    - `jsonnet/entries/pinyin_26.jsonnet`
    - `jsonnet/entries/pinyin_18.jsonnet`
    - `jsonnet/entries/pinyin_14.jsonnet`
    - `jsonnet/entries/alphabetic_26.jsonnet`
    - `jsonnet/entries/ipad_pinyin_26.jsonnet`
  - note:
    - `button_123_config.show_swipe_indicators` only controls the corner indicators
    - it must not change `swipeUpAction` or `swipeDownAction`
- Example:
  - `button_symbol_config`
  - readers:
    - `jsonnet/shared/buttonHelpers/buttonInteraction.libsonnet`
    - `jsonnet/keyboards/pinyin9/builder.libsonnet`
    - `jsonnet/keyboards/numeric9/builder.libsonnet`
  - affected entries:
    - `jsonnet/entries/pinyin_9.jsonnet`
    - `jsonnet/entries/numeric_9.jsonnet`

## Add or change a function button

1. Edit `jsonnet/shared/functionButtons/specs.libsonnet` first.
2. If order is involved, also inspect `jsonnet/shared/functionButtons/functionRowPatch.libsonnet`.
3. If the function row still does not appear in the final layout, inspect `jsonnet/keyboards/common/layoutAssembly/keyboardLayoutAssembly.libsonnet` together with `jsonnet/shared/data/layoutData.libsonnet`.
3. If the change is only about function-button foreground styles or SF Symbols, prefer `jsonnet/shared/functionButtons/styles.libsonnet`.
4. Only edit `jsonnet/shared/functionButtons/iPhone.libsonnet` if the current build logic cannot express the new button.
5. Compile one keyboard with function row enabled.
6. If buttons are removed from `function_button_config.order`, ensure the function-row layout still auto-distributes width across the remaining buttons.

## Change toolbar buttons

1. Edit `jsonnet/shared/toolbar/registry.libsonnet` for IDs, styles, and actions.
2. Edit `jsonnet/shared/toolbar/config.libsonnet` for config parsing.
3. Edit `jsonnet/shared/toolbar/iPhoneRenderer.libsonnet` or `jsonnet/shared/toolbar/iPadRenderer.libsonnet` when changing layout rules or horizontalSymbols direction, such as `content_right_to_left`.
4. If the change affects toolbar height, also inspect the reader path that applies `toolbar_config.toolbar_height` or `toolbar_config.ipad.toolbar_height`.
5. If the change affects the horizontal candidate trailing button, inspect `horizon_candidate_button` in `jsonnet/Custom.libsonnet` and the branch in `jsonnet/shared/toolbar/iPhone.libsonnet`.
6. Update `Custom.libsonnet` docs if a new public button ID becomes available, including IDs such as `simplified_traditional`, `undo`, and `redo`.
7. If the new button uses the standard toolbar system-image foreground style pattern, prefer extending the local helper in `jsonnet/shared/toolbar/iPhone.libsonnet` instead of duplicating style objects.

## Add a compact layout

1. Add a new spec file under the owning keyboard directory.
2. Reuse `jsonnet/keyboards/common/pinyin14_18/iPhone.libsonnet` if possible.
3. Add a new entry under `jsonnet/entries/`.
4. Update `jsonnet/main.jsonnet` if a new output is required.
5. Update docs.

## Change a 26-key system key

1. Locate the right module under `jsonnet/keyboards/pinyin26/` or `jsonnet/keyboards/alphabetic26/`.
2. Prefer changing the most specific split module, such as shift, space, enter, or switcher.
3. If the change affects both Chinese and English 26-key shared layout, letters, or iPad overlay assembly, inspect `jsonnet/keyboards/common/keyboard26/`.
4. If the change affects shared 26-key system-key modules or assembly, inspect `jsonnet/keyboards/common/systemKeys26/`.
5. Only touch the top-level 26-key builder if the change affects assembly outside the shared system-key modules.

## Change 123Button interaction

1. If the interaction should be user-configurable, expose it in:
   - `jsonnet/Custom.libsonnet`
2. For Chinese 26-key and the compact 14/18 reuse path, edit:
   - `jsonnet/keyboards/common/systemKeys26/systemKeysSwitcher.libsonnet`
3. If English 26-key should match, also edit:
   - `jsonnet/keyboards/alphabetic26/systemKeys.libsonnet`
4. If iPad 26-key should match, also edit:
   - `jsonnet/keyboards/common/keyboard26/iPadBuilder.libsonnet`
5. Keep the behavior split clear:
   - slide mode -> `type: 'horizontalSymbols'` + dataSource
   - long-press mode -> `hintSymbolsStyle`
   - swipe mode -> `swipeUpAction` / `swipeDownAction`
   - `show_swipe_indicators` -> only control `123ButtonUpForegroundStyle` / `123ButtonDownForegroundStyle`
   - if the user wants no click bubble, remove the 123Button `hintStyle` instead of touching swipe actions
6. Validate with:
   - `jsonnet -e "(import '<keyboard-root>/jsonnet/entries/pinyin_26.jsonnet').new('light','portrait')"`
   - `jsonnet -e "(import '<keyboard-root>/jsonnet/entries/pinyin_18.jsonnet').new('light','portrait')"`
   - `jsonnet -e "(import '<keyboard-root>/jsonnet/entries/pinyin_14.jsonnet').new('light','portrait')"`
7. If English 26-key also changed, additionally validate:
   - `jsonnet -e "(import '<keyboard-root>/jsonnet/entries/alphabetic_26.jsonnet').new('light','portrait')"`
8. If iPad also changed, additionally validate:
   - `jsonnet -e "(import '<keyboard-root>/jsonnet/entries/ipad_pinyin_26.jsonnet').new('light','portrait')"`

## Change 9-key bottom-row button order

1. If the change is user-configurable, expose it in `jsonnet/Custom.libsonnet`.
2. Implement the position swap in `jsonnet/keyboards/pinyin9/layout.libsonnet`.
3. Treat this as a slot/layout change, not a button-action change.
4. If the swapped buttons have different widths, swap the slot definitions together with the button names.
5. Validate with:
   - `jsonnet -e "(import '<keyboard-root>/jsonnet/entries/pinyin_9.jsonnet').new('light','portrait')"`
6. Update:
   - `README.md`
   - `MODULES.md`

## Change 9-key / numeric symbolButton interaction

1. If the interaction should be user-configurable, expose it in:
   - `jsonnet/Custom.libsonnet`
2. Edit:
   - `jsonnet/keyboards/pinyin9/builder.libsonnet`
   - `jsonnet/keyboards/numeric9/builder.libsonnet`
3. Keep the behavior split clear:
   - slide mode -> `type: 'horizontalSymbols'` + dataSource
   - long-press mode -> `hintSymbolsStyle`, and the menu should only expose the secondary target
   - swipe mode -> `swipeUpAction` only when the primary click action already occupies the base keyboard
4. Do not break:
   - `swap_9_123_symbol`
   - `swap_numeric_return_symbol`
5. Validate with:
   - `jsonnet -e "(import '<keyboard-root>/jsonnet/entries/pinyin_9.jsonnet').new('light','portrait')"`
   - `jsonnet -e "(import '<keyboard-root>/jsonnet/entries/numeric_9.jsonnet').new('light','portrait')"`
6. Update:
   - `README.md`
   - `MODULES.md`

## Change landscape 9-key split layout

1. Treat this as a layout-layer task first.
2. Edit:
   - `jsonnet/keyboards/pinyin9/layout.libsonnet`
3. Only edit:
   - `jsonnet/keyboards/pinyin9/panels.libsonnet`
   - `jsonnet/keyboards/pinyin9/builder.libsonnet`
   when changing component definitions such as `collection`, `verticalCandidates`, or candidate cell style.
4. Keep these responsibilities separate:
   - button placement, left/right split, spacer width, function-row visibility -> layout
   - `type: 't9Symbols'`, `type: 'verticalCandidates'`, candidate appearance -> panels/builder
5. If the landscape layout should follow a Custom option, update:
   - `jsonnet/Custom.libsonnet`
   - all readers with `rg`
6. Validate with:
   - `jsonnet -e "(import '<keyboard-root>/jsonnet/entries/pinyin_9.jsonnet').new('light','landscape')"`
7. Then run full compile if the change touches shared layout data:
   - `jsonnet '<keyboard-root>/jsonnet/main.jsonnet' >/tmp/wanxiang_restructured_main.json`

## Change landscape numeric split layout

1. Treat this as a layout-layer task first.
2. Edit:
   - `jsonnet/keyboards/numeric9/layout.libsonnet`
3. Only edit:
   - `jsonnet/keyboards/numeric9/panels.libsonnet`
   - `jsonnet/keyboards/numeric9/builder.libsonnet`
   when changing component definitions such as `collection`, `landscapeNumericSymbols`, or symbol panel type.
4. Keep these responsibilities separate:
   - left/right split, spacer width, function-row visibility, slot swapping -> layout
   - `type: 'symbols'`, `type: 't9Symbols'`, `type: 'categorySymbols'`, symbol data source -> panels/builder
5. Preserve existing tuned component settings unless the user explicitly asks to change them, especially:
   - `jsonnet/keyboards/pinyin9/builder.libsonnet` -> `verticalCandidates.insets`
   - `jsonnet/keyboards/numeric9/panels.libsonnet` -> `landscapeNumericSymbols` component settings
6. If the layout should follow a Custom option, update:
   - `jsonnet/Custom.libsonnet`
   - all readers with `rg`
7. Validate with:
   - `jsonnet -e "(import '<keyboard-root>/jsonnet/entries/numeric_9.jsonnet').new('light','landscape')"`
8. Then run full compile if shared layout or config changed:
   - `jsonnet '<keyboard-root>/jsonnet/main.jsonnet' >/tmp/wanxiang_restructured_main.json`

## Change a key SF Symbol

1. First identify the button type:
   - function button
   - toolbar button
   - 26-key system key
   - shift preedit symbol from Custom
   - shared symbol style used by multiple buttons

2. Change the narrowest layer that owns the symbol:
   - function buttons:
     - `jsonnet/shared/functionButtons/specs.libsonnet`
     - or `jsonnet/shared/functionButtons/iPhone.libsonnet` if symbol rendering is built there
   - toolbar buttons:
     - `jsonnet/shared/toolbar/registry.libsonnet`
   - 26-key system keys:
     - `jsonnet/keyboards/common/systemKeys26/*.libsonnet`
     - or `jsonnet/keyboards/alphabetic26/systemKeys.libsonnet`
   - config-driven symbol:
     - `jsonnet/Custom.libsonnet`

3. If the SF Symbol should become user-configurable, expose it in `jsonnet/Custom.libsonnet` instead of hard-coding it.

4. If you change any user-facing configuration, update:
   - `README.md`
   - `MODULES.md`

5. Validate with a targeted compile for the affected entry.

## Fix regressions

1. Reproduce the failure with a targeted `jsonnet -e` command.
2. Trace upward from the failing file:
   - entry file
   - keyboard-level module
   - shared helper or style
   - runtime/layout
3. Keep the fix local.
4. Re-run targeted compile.
