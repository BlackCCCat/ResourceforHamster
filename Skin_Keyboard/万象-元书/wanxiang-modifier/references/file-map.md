# File Map

Use this map to decide where to edit.

## Root

Resolve everything relative to one selected `<keyboard-root>`.

Inside `<keyboard-root>`:

- config entry:
  - `jsonnet/Custom.libsonnet`
- output entry:
  - `jsonnet/main.jsonnet`
- maintenance docs:
  - `README.md`
  - `MODULES.md`

## Keyboard entry files

- `jsonnet/keyboard/pinyin_26.jsonnet`
- `jsonnet/keyboard/alphabetic_26.jsonnet`
- `jsonnet/keyboard/pinyin_18.jsonnet`
- `jsonnet/keyboard/pinyin_14.jsonnet`
- `jsonnet/keyboard/pinyin_9.jsonnet`
- `jsonnet/keyboard/numeric_9.jsonnet`
- `jsonnet/keyboard/ipad_pinyin_26.jsonnet`
- `jsonnet/keyboard/ipad_alphabetic_26.jsonnet`
- `jsonnet/keyboard/ipad_numeric_9.jsonnet`
- `jsonnet/keyboard/panel.jsonnet`

Edit these only when changing entry wiring or adding a new keyboard type.

## Builders

- `jsonnet/lib/builders/keyboard26Builder.libsonnet`
- `jsonnet/lib/builders/keyboard26AlphabeticBuilder.libsonnet`
- `jsonnet/lib/builders/keyboard26ButtonFactory.libsonnet`
- `jsonnet/lib/builders/compactKeyboardBuilder.libsonnet`
- `jsonnet/lib/builders/pinyin9Builder.libsonnet`
- `jsonnet/lib/builders/pinyin9ButtonFactory.libsonnet`
- `jsonnet/lib/builders/numeric9Builder.libsonnet`
- `jsonnet/lib/builders/ipad26Builder.libsonnet`

Edit builders when a spec-only change is not enough.

## Function buttons

- `jsonnet/lib/functionButtons/index.libsonnet`
- `jsonnet/lib/functionButtons/specs.libsonnet`
- `jsonnet/lib/functionButtons/builder.libsonnet`
- `jsonnet/lib/functionButtons/styles.libsonnet`
- `jsonnet/lib/functionButtons/styleSpecs.libsonnet`

Typical edits:

- button order
- button actions
- notification behavior
- function-row generation
- function-button-only foreground styles

If order changes do not appear, also inspect:

- `jsonnet/lib/layout/keyboardLayoutFuncRowPatch.libsonnet`

## Toolbar

- `jsonnet/lib/toolbar/index.libsonnet`
- `jsonnet/lib/toolbar/ipad.libsonnet`
- `jsonnet/lib/toolbar/en.libsonnet`
- `jsonnet/lib/toolbar/shared.libsonnet`
- `jsonnet/lib/toolbar/registry.libsonnet`
- `jsonnet/lib/toolbar/iPhoneRenderer.libsonnet`
- `jsonnet/lib/toolbar/ipadRenderer.libsonnet`

Typical edits:

- new toolbar button IDs
- toolbar action mapping
- iPhone or iPad ordering rules
- toolbar menu behavior

## Layout

- `jsonnet/lib/layout/keyboardLayouts.libsonnet`
- `jsonnet/lib/layout/keyboardLayoutBase.libsonnet`
- `jsonnet/lib/layout/keyboardLayoutBaseData.libsonnet`
- `jsonnet/lib/layout/keyboardLayoutFuncRowPatch.libsonnet`
- `jsonnet/lib/layout/numericLayout.libsonnet`

Edit layout files when button placement changes.

## Specs

- `jsonnet/lib/specs/compact14.libsonnet`
- `jsonnet/lib/specs/compact18.libsonnet`
- `jsonnet/lib/specs/compactShared.libsonnet`
- `jsonnet/lib/specs/letter26Shared.libsonnet`
- `jsonnet/lib/specs/pinyin9T9.libsonnet`
- `jsonnet/lib/specs/systemKeysPinyin26.libsonnet`
- `jsonnet/lib/specs/systemKeysAlphabetic26.libsonnet`
- `jsonnet/lib/specs/pinyinSystemKeysShift.libsonnet`
- `jsonnet/lib/specs/pinyinSystemKeysBackspace.libsonnet`
- `jsonnet/lib/specs/pinyinSystemKeysCn2en.libsonnet`
- `jsonnet/lib/specs/pinyinSystemKeysSwitcher.libsonnet`
- `jsonnet/lib/specs/pinyinSystemKeysSpace.libsonnet`
- `jsonnet/lib/specs/pinyinSystemKeysEnter.libsonnet`

Prefer editing specs before editing builders.

## Shared key helpers

- `jsonnet/lib/keys/keyBuilders.libsonnet`
- `jsonnet/lib/keys/letterKeySpecs.libsonnet`
- `jsonnet/lib/keys/pinyinCompact.libsonnet`
- `jsonnet/lib/keys/pinyinSystemKeys.libsonnet`

## Shared style and data

- `jsonnet/lib/shared/color.libsonnet`
- `jsonnet/lib/shared/fontSize.libsonnet`
- `jsonnet/lib/shared/center.libsonnet`
- `jsonnet/lib/shared/animation.libsonnet`
- `jsonnet/lib/shared/hintSymbolsStyles.libsonnet`
- `jsonnet/lib/shared/keyboardBaseStyles.libsonnet`
- `jsonnet/lib/shared/others.libsonnet`
- `jsonnet/lib/shared/slideForeground.libsonnet`
- `jsonnet/lib/data/hintSymbolsData.libsonnet`
- `jsonnet/lib/data/swipeData.libsonnet`
- `jsonnet/lib/data/swipeData-en.libsonnet`
- `jsonnet/lib/data/collectionData.libsonnet`

Use these for pure style or data updates.

## iPad-specific helpers

- `jsonnet/lib/ipad/common.libsonnet`
- `jsonnet/lib/builders/ipad26Builder.libsonnet`

## Documentation

Update both when changing public configuration or maintenance-facing structure:

- `<keyboard-root>/README.md`
- `<keyboard-root>/MODULES.md`
