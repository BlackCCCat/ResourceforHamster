// 暴露拼音系统键集合，汇总拆分后的系统键模块。
local pinyinSystemKeysBackspace = import 'systemKeysBackspace.libsonnet';
local pinyinSystemKeysCn2en = import 'systemKeysCn2en.libsonnet';
local pinyinSystemKeysEnter = import 'systemKeysEnter.libsonnet';
local pinyinSystemKeysSpace = import 'systemKeysSpace.libsonnet';
local pinyinSystemKeysShift = import 'systemKeysShift.libsonnet';
local pinyinSystemKeysSwitcher = import 'systemKeysSwitcher.libsonnet';

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
