---
name: wanxiang-keyboard-maintainer
description: Use when modifying a Wanxiang keyboard under ResourceforHamster, especially for Custom.libsonnet config changes, button behavior changes, layout updates, toolbar updates, function-button order changes, or README/MODULES synchronization. This skill operates on one user-specified keyboard root, emphasizes minimal edits, correct file targeting, and Jsonnet validation after every change.
---

# Wanxiang Keyboard Maintainer

Use this skill for exactly one Wanxiang keyboard root per task.

Preferred input from the user:

- a concrete keyboard root such as `Skin_Keyboard/万象-元书/万象键盘-重构`
- or another Wanxiang keyboard folder they want to maintain

Treat that keyboard root as `<keyboard-root>`. All edits, validation, and documentation updates must stay inside that one root unless the user explicitly asks for cross-directory comparison or migration.

If the user does not provide `<keyboard-root>`, resolve it before editing:

1. search for candidate directories named `万象键盘` or `万象键盘-重构` under the repo
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
- add a new layout such as a compact layout variant
- adjust toolbar structure or available toolbar IDs
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
   - `Custom.libsonnet` for exposed configuration
   - `specs/` for declarative behavior or ordering
   - `builders/` only if specs are not enough
   - `layout/` only if button placement changes
   - docs only after code is settled
   - for 9-key bottom-row swaps, prefer `Custom.libsonnet` + `layout/keyboardLayoutBaseData.libsonnet`
4. Before editing, inspect the relevant mapping in `references/file-map.md`.
5. Keep behavior stable unless the user explicitly asks for a behavior change.
6. After every code change, validate with Jsonnet.
   - For a targeted change, compile the affected keyboard entry first.
   - For broader changes, compile `jsonnet/main.jsonnet`.
   - Only run cross-directory or baseline comparison if the user explicitly provides another target to compare against.
7. If you change any public configuration or maintenance-facing structure, update:
   - `<keyboard-root>/README.md`
   - `<keyboard-root>/MODULES.md`

## Validation rules

Always prefer targeted validation first.

### Targeted compile commands

```bash
jsonnet -e "(import '<keyboard-root>/jsonnet/keyboard/pinyin_26.jsonnet').new('light','portrait')"
jsonnet -e "(import '<keyboard-root>/jsonnet/keyboard/pinyin_18.jsonnet').new('light','portrait')"
jsonnet -e "(import '<keyboard-root>/jsonnet/keyboard/pinyin_14.jsonnet').new('light','portrait')"
jsonnet -e "(import '<keyboard-root>/jsonnet/keyboard/pinyin_9.jsonnet').new('light','portrait')"
jsonnet -e "(import '<keyboard-root>/jsonnet/keyboard/numeric_9.jsonnet').new('light','portrait')"
jsonnet -e "(import '<keyboard-root>/jsonnet/keyboard/ipad_pinyin_26.jsonnet').new('light','portrait')"
jsonnet -e "(import '<keyboard-root>/jsonnet/keyboard/ipad_alphabetic_26.jsonnet').new('light','portrait')"
```

### Full compile

```bash
jsonnet '<keyboard-root>/jsonnet/main.jsonnet' >/tmp/wanxiang_main.json
```

### Optional baseline comparison

Use this only if the user explicitly gives you another keyboard root or another checkout to compare against.

```bash
jsonnet '<keyboard-root>/jsonnet/main.jsonnet' >/tmp/wanxiang_main.json
jsonnet '<baseline-root>/jsonnet/main.jsonnet' >/tmp/wanxiang_baseline_main.json
cmp -s /tmp/wanxiang_main.json /tmp/wanxiang_baseline_main.json && echo ALL_SAME || echo DIFF
```

## Guardrails

- Operate on one resolved `<keyboard-root>` only.
- Do not infer a second root unless the user asks.
- Do not invent new architecture unless the user explicitly asks for another refactor.
- Do not rename files casually; this repo already has a structured layout.
- If you change order-related behavior, inspect both the generator layer and the layout layer.
- If you change config structure, update all readers and docs in the same task.
- If a builder and layout disagree, fix the mismatch instead of adding a second source of truth.

## File map

Read `references/file-map.md` before editing if the target location is not obvious.

## Common task playbooks

Read `references/playbooks.md` for concrete patterns for:

- adding a function button
- exposing a new Custom option
- changing toolbar buttons
- adding a compact layout
- changing system keys
