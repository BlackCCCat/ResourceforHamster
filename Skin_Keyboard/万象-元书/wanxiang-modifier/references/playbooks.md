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
  - reader: `jsonnet/lib/layout/keyboardLayoutBaseData.libsonnet`
  - affected entry: `jsonnet/keyboard/pinyin_9.jsonnet`
- Example:
  - `swap_numeric_return_symbol`
  - reader: `jsonnet/lib/layout/numericLayout.libsonnet`
  - affected entry: `jsonnet/keyboard/numeric_9.jsonnet`
- Example:
  - `function_button_config.with_functions_row.iPhone`
  - may also affect the dedicated landscape 9-key split layout
  - reader: `jsonnet/lib/layout/keyboardLayoutBaseData.libsonnet`
  - affected entry: `jsonnet/keyboard/pinyin_9.jsonnet`

## Add or change a function button

1. Edit `jsonnet/lib/functionButtons/specs.libsonnet` first.
2. If order is involved, also inspect `jsonnet/lib/layout/keyboardLayoutFuncRowPatch.libsonnet`.
3. If the change is only about function-button foreground styles or SF Symbols, prefer `jsonnet/lib/functionButtons/styles.libsonnet` and `jsonnet/lib/functionButtons/styleSpecs.libsonnet`.
4. Only edit `jsonnet/lib/functionButtons/builder.libsonnet` if the current build logic cannot express the new button.
5. Compile one keyboard with function row enabled.
6. If buttons are removed from `function_button_config.order`, ensure the function-row layout still auto-distributes width across the remaining buttons.

## Change toolbar buttons

1. Edit `jsonnet/lib/toolbar/registry.libsonnet` for IDs, styles, and actions.
2. Edit `jsonnet/lib/toolbar/shared.libsonnet` for config parsing.
3. Edit `jsonnet/lib/toolbar/iPhoneRenderer.libsonnet` or `ipadRenderer.libsonnet` only if layout rules change.
4. Update `Custom.libsonnet` docs if a new public button ID becomes available.

## Add a compact layout

1. Add a new spec file under `jsonnet/lib/specs/`.
2. Reuse `compactKeyboardBuilder.libsonnet` if possible.
3. Add a keyboard entry under `jsonnet/keyboard/`.
4. Update `jsonnet/main.jsonnet` if a new output is required.
5. Update docs.

## Change a 26-key system key

1. Locate the right module under `jsonnet/lib/specs/`.
2. Prefer changing the most specific split module, such as shift, space, enter, or switcher.
3. Only touch `jsonnet/lib/keys/pinyinSystemKeys.libsonnet` or the 26-key builders if the change affects assembly instead of the key behavior itself.

## Change 9-key bottom-row button order

1. If the change is user-configurable, expose it in `jsonnet/Custom.libsonnet`.
2. Implement the position swap in `jsonnet/lib/layout/keyboardLayoutBaseData.libsonnet`.
3. Treat this as a slot/layout change, not a button-action change.
4. If the swapped buttons have different widths, swap the slot definitions together with the button names.
5. Validate with:
   - `jsonnet -e "(import '<keyboard-root>/jsonnet/keyboard/pinyin_9.jsonnet').new('light','portrait')"`
6. Update:
   - `README.md`
   - `MODULES.md`

## Change landscape 9-key split layout

1. Treat this as a layout-layer task first.
2. Edit:
   - `jsonnet/lib/layout/keyboardLayoutBaseData.libsonnet`
3. Only edit:
   - `jsonnet/lib/builders/pinyin9Builder.libsonnet`
   when changing component definitions such as `collection`, `verticalCandidates`, or candidate cell style.
4. Keep these responsibilities separate:
   - button placement, left/right split, spacer width, function-row visibility -> layout
   - `type: 't9Symbols'`, `type: 'verticalCandidates'`, candidate appearance -> builder
5. If the landscape layout should follow a Custom option, update:
   - `jsonnet/Custom.libsonnet`
   - all readers with `rg`
6. Validate with:
   - `jsonnet -e \"(import '<keyboard-root>/jsonnet/keyboard/pinyin_9.jsonnet').new('light','landscape')\"`
7. Then run full compile if the change touches shared layout data:
   - `jsonnet '<keyboard-root>/jsonnet/main.jsonnet' >/tmp/wanxiang_main.json`

## Change landscape numeric split layout

1. Treat this as a layout-layer task first.
2. Edit:
   - `jsonnet/lib/layout/numericLayout.libsonnet`
3. Only edit:
   - `jsonnet/lib/builders/numeric9Builder.libsonnet`
   when changing component definitions such as `collection`, `landscapeNumericSymbols`, or symbol panel type.
4. Keep these responsibilities separate:
   - left/right split, spacer width, function-row visibility, slot swapping -> layout
   - `type: 'symbols'`, `type: 't9Symbols'`, `type: 'categorySymbols'`, symbol data source -> builder
5. Preserve existing tuned component settings unless the user explicitly asks to change them, especially:
   - `pinyin9Builder.libsonnet` -> `verticalCandidates.insets`
   - `numeric9Builder.libsonnet` -> `landscapeNumericSymbols` component settings
6. If the layout should follow a Custom option, update:
   - `jsonnet/Custom.libsonnet`
   - all readers with `rg`
7. Validate with:
   - `jsonnet -e \"(import '<keyboard-root>/jsonnet/keyboard/numeric_9.jsonnet').new('light','landscape')\"`
8. Then run full compile if shared layout or config changed:
   - `jsonnet '<keyboard-root>/jsonnet/main.jsonnet' >/tmp/wanxiang_main.json`

## Change a key SF Symbol

1. First identify the button type:
   - function button
   - toolbar button
   - 26-key system key
   - shift preedit symbol from Custom
   - shared symbol style used by multiple buttons

2. Change the narrowest layer that owns the symbol:
   - function buttons:
     - `jsonnet/lib/functionButtons/specs.libsonnet`
     - or `jsonnet/lib/functionButtons/builder.libsonnet` if symbol rendering is built there
   - toolbar buttons:
     - `jsonnet/lib/toolbar/registry.libsonnet`
   - 26-key system keys:
     - `jsonnet/lib/specs/pinyinSystemKeys*.libsonnet`
     - or `jsonnet/lib/specs/systemKeysAlphabetic26.libsonnet`
   - config-driven symbol:
     - `jsonnet/Custom.libsonnet`

3. If the SF Symbol should become user-configurable, expose it in `jsonnet/Custom.libsonnet` instead of hard-coding it.

4. If you change any user-facing configuration, update:
   - `README.md`
   - `MODULES.md`

5. Validate with a targeted compile for the affected keyboard entry.

## Fix regressions

1. Reproduce the failure with a targeted `jsonnet -e` command.
2. Trace upward from the failing file:
   - entry file
   - builder
   - spec/helper
   - layout
3. Keep the fix local.
4. Re-run targeted compile.
5. Only run baseline comparison if the user explicitly provides another keyboard root or checkout to compare against.
