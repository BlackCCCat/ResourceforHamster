# Playbooks

All playbooks assume you already resolved one `<keyboard-root>`.

## Add or change a Custom option

1. Edit `jsonnet/Custom.libsonnet`.
2. Update all readers of that option with `rg`.
3. If the option changes behavior, compile the affected entry file.
4. Update `README.md` and `MODULES.md`.

## Add or change a function button

1. Edit `jsonnet/lib/functionButtons/specs.libsonnet` first.
2. If order is involved, also inspect `jsonnet/lib/layout/keyboardLayoutFuncRowPatch.libsonnet`.
3. Only edit `jsonnet/lib/functionButtons/builder.libsonnet` if the current build logic cannot express the new button.
4. Compile one keyboard with function row enabled.

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
