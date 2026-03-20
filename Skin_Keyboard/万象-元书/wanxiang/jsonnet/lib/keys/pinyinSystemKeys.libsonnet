// Expose the assembled pinyin system-key definitions from the split specs modules.
local pinyinSystemKeysBackspace = import '../specs/pinyinSystemKeysBackspace.libsonnet';
local Settings = import '../../Custom.libsonnet';
local pinyinSystemKeysCn2en = import '../specs/pinyinSystemKeysCn2en.libsonnet';
local pinyinSystemKeysEnter = import '../specs/pinyinSystemKeysEnter.libsonnet';
local pinyinSystemKeysSpace = import '../specs/pinyinSystemKeysSpace.libsonnet';
local pinyinSystemKeysShift = import '../specs/pinyinSystemKeysShift.libsonnet';
local pinyinSystemKeysSwitcher = import '../specs/pinyinSystemKeysSwitcher.libsonnet';

// System / function key definitions for 26-key pinyin.
{
  build(theme, orientation, keyboardLayout, Settings, color, fontSize, center, createButton, baseHintStyles):: {
    } +
    pinyinSystemKeysShift.build(theme, orientation, keyboardLayout, Settings, color, fontSize, createButton, baseHintStyles) +
    pinyinSystemKeysBackspace.build(theme, orientation, keyboardLayout, color, fontSize, createButton, baseHintStyles) +
    pinyinSystemKeysCn2en.build(theme, orientation, keyboardLayout, Settings, color, fontSize, center, createButton, baseHintStyles) +
    pinyinSystemKeysSwitcher.build(theme, orientation, keyboardLayout, Settings, createButton, baseHintStyles) +
    pinyinSystemKeysSpace.build(theme, orientation, keyboardLayout, Settings, color, fontSize, center, createButton, baseHintStyles) +
  pinyinSystemKeysEnter.build(theme, orientation, keyboardLayout, Settings, color, fontSize, center, createButton, baseHintStyles),
}
