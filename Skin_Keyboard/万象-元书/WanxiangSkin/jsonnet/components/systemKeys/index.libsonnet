// 暴露拼音系统键集合，汇总拆分后的系统键模块。
local appearance = import '../../design/appearance.libsonnet';
local keyFactory = import '../key/factory.libsonnet';
local longPress = import '../key/longPress.libsonnet';
local editingKeys = import './editing.libsonnet';
local inputModeKeys = import './inputMode.libsonnet';
local pinyinSystemKeysSwitcher = import './keyboardSwitch.libsonnet';
local longPressData = import './longPressData.libsonnet';
local swipeData = import './swipeData.libsonnet';

// 按职责组合拼音 26 键使用的系统键，不在入口重复装配各按钮。
{
  // 使用统一按钮工厂生成各拼音布局可直接复用的系统键集合。
  buildReusable(context, keyboardLayout, baseHintStyles=null)::
    local hintStyles =
      if baseHintStyles == null then
        longPress.getStyle(context.theme, longPressData)
      else
        baseHintStyles;
    local createButton = keyFactory.createKeyboardButton(
      context,
      swipeData.swipeUp,
      swipeData.swipeDown,
      {
        actionFactory(key): { character: key },
        uppercasedActionFactory(key): { character: std.asciiUpper(key) },
      }
    );
    self.build(
      context.theme,
      context.orientation,
      keyboardLayout,
      context.Settings,
      appearance.color,
      appearance.fontSize,
      appearance.center,
      createButton,
      hintStyles
    ),

  build(theme, orientation, keyboardLayout, Settings, color, fontSize, center, createButton, baseHintStyles):: {
                                                                                                               } +
                                                                                                               inputModeKeys.buildShift(theme, orientation, keyboardLayout, Settings, color, fontSize, createButton, baseHintStyles) +
                                                                                                               editingKeys.buildBackspace(theme, orientation, keyboardLayout, color, fontSize, createButton, baseHintStyles) +
                                                                                                               inputModeKeys.build(theme, orientation, keyboardLayout, Settings, color, fontSize, center, createButton, baseHintStyles) +
                                                                                                               pinyinSystemKeysSwitcher.build(theme, orientation, keyboardLayout, Settings, createButton, baseHintStyles) +
                                                                                                               editingKeys.buildSpace(theme, orientation, keyboardLayout, Settings, color, fontSize, center, createButton, baseHintStyles) +
                                                                                                               editingKeys.buildEnter(theme, orientation, keyboardLayout, Settings, color, fontSize, center, createButton, baseHintStyles),
}
