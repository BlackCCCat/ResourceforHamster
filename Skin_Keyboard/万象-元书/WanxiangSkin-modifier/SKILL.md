---
name: wanxiang-skin-maintainer
description: Use when modifying the restructured Wanxiang keyboard under ResourceforHamster, especially for Custom.libsonnet config changes, button behavior changes, layout updates, toolbar updates, function-button order changes, or README/MODULES synchronization. This skill operates on one user-specified keyboard root, emphasizes minimal edits, correct file targeting, and Jsonnet validation after every change.
---

# Wanxiang Restructured Maintainer

Use this skill for exactly one Wanxiang keyboard root per task.

Preferred input from the user:

- a concrete keyboard root such as `Skin_Keyboard/万象-元书/WanxiangSkin`

Treat that keyboard root as `<keyboard-root>`. All edits, validation, and documentation updates must stay inside that one root unless the user explicitly asks for cross-directory comparison or migration.

If the user does not provide `<keyboard-root>`, resolve it before editing:

1. search for candidate directories named `WanxiangSkin` under the repo
2. if there is exactly one clear candidate, use it
3. if there are multiple candidates, ask the user which one to use

Do not assume a stable root or a second comparison root by default.

## What this skill is for

Use it when the user asks to:

- add or modify keyboard buttons
- change button actions, swipe actions, or notifications
- reorder function buttons or toolbar buttons
- add or change `Custom.libsonnet` options
- expose or adjust 9-key bottom-row position options such as swapping `123` and symbol
- expose or adjust numeric keyboard bottom-row position options such as swapping return and the switch-keyboard button
- expose or adjust `button_123_config` to switch 26-key / 14-key / 18-key / iPad `123Button` between slide, long-press menu, and swipe actions
- expose or adjust `button_123_config.show_swipe_indicators` to control only the 123Button swipe-corner indicators
- expose or adjust `button_symbol_config` to switch 9-key / numeric `symbolButton` between slide, long-press menu, and swipe actions
- adjust the dedicated landscape 9-key split layout, including function-row visibility, `collection`, and `verticalCandidates`
- adjust the dedicated landscape numeric split layout, including function-row visibility, left-side symbol panels, and slot swapping
- add a new layout such as a compact layout variant
- adjust toolbar structure or available toolbar IDs
- add or adjust toolbar buttons such as `simplified_traditional` for `#简繁切换`, or `undo` / `redo` for `#undo` and `#redo`
- adjust toolbar slide direction such as `content_right_to_left`
- adjust `toolbar_config.toolbar_height` or `toolbar_config.ipad.toolbar_height`
- adjust `horizon_candidate_button` for the horizontal candidate trailing button
- adjust non-26 English keyboard escape paths such as swiping `en2cnButton` into `temp_pinyin`
- add or adjust temporary keyboard wrappers such as `temp_pinyin`
- adjust `temp_pinyin`-specific space-key marker text or swipe behavior
- update README or module documentation after code changes
- fix regressions inside the selected keyboard root

## Workflow

1. Resolve `<keyboard-root>` first.
2. Identify the request type:
   - config
   - function button
   - toolbar
   - 26-key button/system key
   - compact 14/18 layout
   - 9-key or numeric layout
   - iPad overlay
   - docs only
3. Change the narrowest layer first:
   - `jsonnet/Custom.libsonnet` for exposed configuration
   - `jsonnet/keyboards/*/systemKeys*.libsonnet` or `jsonnet/keyboards/*/specs.libsonnet` for declarative behavior
   - `jsonnet/shared/buttonHelpers/buttonInteraction.libsonnet` or `jsonnet/shared/buttonHelpers/returnKey.libsonnet` when the same button behavior is reused across keyboards
   - `jsonnet/keyboards/common/keyboard26/*` when the same 26-key layout, letters, or iPad overlay logic is reused across Chinese and English keyboards
   - `jsonnet/keyboards/common/systemKeys26/*` when 26-key system-key modules or assembly should be shared across keyboards
   - `jsonnet/keyboards/*/builder.libsonnet` only if specs are not enough
   - `jsonnet/keyboards/*/layout.libsonnet` only if button placement changes
   - `jsonnet/keyboards/tempPinyin/iPhone.libsonnet` when a temporary wrapper keyboard should reuse pinyin 26-key output but override only a few buttons
   - `jsonnet/shared/toolbar/*` for toolbar behavior or rendering
   - `jsonnet/keyboards/common/layoutAssembly/keyboardLayoutAssembly.libsonnet` only when the shared layout assembly path itself changes
   - `jsonnet/shared/functionButtons/*` for function-row behavior or styling, including `functionRowPatch.libsonnet` when the function row is inserted into layout
   - docs only after code is settled
   - for 9-key bottom-row swaps, prefer `jsonnet/Custom.libsonnet` + `jsonnet/keyboards/pinyin9/layout.libsonnet`
   - for numeric bottom-row swaps, prefer `jsonnet/Custom.libsonnet` + `jsonnet/keyboards/numeric9/layout.libsonnet`
   - for `123Button` interaction changes on 26-key / 14-key / 18-key, prefer `jsonnet/Custom.libsonnet` + `jsonnet/keyboards/common/systemKeys26/systemKeysSwitcher.libsonnet`; only touch `jsonnet/keyboards/alphabetic26/systemKeys.libsonnet` when English 26-key should match
   - for iPad `123Button`, use `jsonnet/keyboards/common/keyboard26/iPadBuilder.libsonnet`
- for iPad 26-key row structure changes such as Tab, dual Shift, dual 123, bottom-row comma placement, swipe-up period, or dismiss-key placement, edit `jsonnet/keyboards/common/keyboard26/layout.libsonnet` and `jsonnet/keyboards/common/keyboard26/iPadBuilder.libsonnet` together
- for iPad 26-key shift notification parity, bottom-row comma display, or landscape-only spacing, prefer `jsonnet/keyboards/common/keyboard26/iPadBuilder.libsonnet`
- for iPad Chinese/English 26-key letter-size alignment, edit both `jsonnet/keyboards/pinyin26/iPad.libsonnet` and `jsonnet/keyboards/alphabetic26/iPad.libsonnet`
   - for iPad 26-key edge spacing or per-key width adjustments such as the second-row `a` gap or enter width, edit `jsonnet/keyboards/common/keyboard26/layout.libsonnet` and `jsonnet/keyboards/common/keyboard26/iPadBuilder.libsonnet` together
   - for non-26 English keyboard swipes back into pinyin 26-key, prefer `jsonnet/keyboards/alphabetic26/systemKeys.libsonnet` plus a thin wrapper under `jsonnet/keyboards/tempPinyin/`
- when matching iPad row-2 letter visuals, keep all visible letter widths aligned; only `a` should use extra outer width with right-aligned bounds for left-side gap
- for iPad third-row edge-balance changes, keep the middle seven letter keys stable and adjust only left Shift / Tab / right Shift in `jsonnet/keyboards/common/keyboard26/layout.libsonnet` and `jsonnet/keyboards/common/keyboard26/iPadBuilder.libsonnet`
   - `button_123_config.show_swipe_indicators` only controls 123Button swipe-corner indicators; it must not change swipe actions themselves
   - for 9-key / numeric `symbolButton` interaction changes, prefer `jsonnet/Custom.libsonnet` + `jsonnet/shared/buttonHelpers/buttonInteraction.libsonnet` + `jsonnet/keyboards/pinyin9/builder.libsonnet` / `jsonnet/keyboards/numeric9/builder.libsonnet`; do not touch bottom-row swap logic unless placement itself changes
   - for shared layout assembly changes, prefer `jsonnet/keyboards/common/layoutAssembly/keyboardLayoutAssembly.libsonnet` + `jsonnet/shared/data/layoutData.libsonnet`; only touch `jsonnet/shared/functionButtons/functionRowPatch.libsonnet` when the function-row insertion rule itself changes
   - for landscape 9-key split layout changes, prefer `jsonnet/keyboards/pinyin9/layout.libsonnet`; only touch `jsonnet/keyboards/pinyin9/panels.libsonnet` or `jsonnet/keyboards/pinyin9/builder.libsonnet` when the component type definition itself changes
   - for landscape numeric split layout changes, prefer `jsonnet/keyboards/numeric9/layout.libsonnet`; only touch `jsonnet/keyboards/numeric9/panels.libsonnet` or `jsonnet/keyboards/numeric9/builder.libsonnet` when the symbol panel or collection component definition itself changes
4. Before editing, inspect the relevant mapping in `references/file-map.md`.
5. Keep behavior stable unless the user explicitly asks for a behavior change.
6. After every code change, validate with Jsonnet.
   - For a targeted change, compile the affected entry file first.
   - For broader changes, compile `jsonnet/main.jsonnet`.
7. If you change any public configuration or maintenance-facing structure, update:
   - `<keyboard-root>/README.md`
   - `<keyboard-root>/MODULES.md`

## Validation rules

Always prefer targeted validation first.

### Targeted compile commands

```bash
jsonnet -e "(import '<keyboard-root>/jsonnet/entries/pinyin_26.jsonnet').new('light','portrait')"
jsonnet -e "(import '<keyboard-root>/jsonnet/entries/alphabetic_26.jsonnet').new('light','portrait')"
jsonnet -e "(import '<keyboard-root>/jsonnet/entries/pinyin_18.jsonnet').new('light','portrait')"
jsonnet -e "(import '<keyboard-root>/jsonnet/entries/pinyin_14.jsonnet').new('light','portrait')"
jsonnet -e "(import '<keyboard-root>/jsonnet/entries/pinyin_9.jsonnet').new('light','portrait')"
jsonnet -e "(import '<keyboard-root>/jsonnet/entries/numeric_9.jsonnet').new('light','portrait')"
jsonnet -e "(import '<keyboard-root>/jsonnet/entries/ipad_pinyin_26.jsonnet').new('light','portrait')"
jsonnet -e "(import '<keyboard-root>/jsonnet/entries/ipad_alphabetic_26.jsonnet').new('light','portrait')"
jsonnet -e "(import '<keyboard-root>/jsonnet/entries/ipad_numeric_9.jsonnet').new('light','portrait')"
```

### Full compile

```bash
jsonnet '<keyboard-root>/jsonnet/main.jsonnet' >/tmp/wanxiang_restructured_main.json
```

## Guardrails

- Operate on one resolved `<keyboard-root>` only.
- Do not infer a second root unless the user asks.
- Do not invent new architecture unless the user explicitly asks for another refactor.
- Do not rename files casually; this repo already has a restructured layout.
- If you change order-related behavior, inspect both the generator layer and the layout layer.
- If you change config structure, update all readers and docs in the same task.
- If a builder and layout disagree, fix the mismatch instead of adding a second source of truth.
- Preserve user-tuned component settings unless explicitly asked to change them, especially:
  - `jsonnet/keyboards/pinyin9/builder.libsonnet` -> `verticalCandidates.insets`
  - `jsonnet/keyboards/numeric9/panels.libsonnet` / component settings for `landscapeNumericSymbols`

## File map

Read `references/file-map.md` before editing if the target location is not obvious.

## Common task playbooks

Read `references/playbooks.md` for concrete patterns for:

- adding a function button
- exposing a new Custom option
- changing toolbar buttons
- adding a compact layout
- changing system keys
