// 定义拼音回车键族及其通知配置。
local styleFactories = import '../../../shared/styles/styleFactories.libsonnet';
local returnKeyHelpers = import '../../../shared/buttonHelpers/returnKey.libsonnet';

{
  build(theme, orientation, keyboardLayout, Settings, color, fontSize, center, createButton, baseHintStyles)::
    local makeEnterForegroundStyle(textValue, useBlueText=false) =
      returnKeyHelpers.makeForeground(
        styleFactories,
        theme,
        color,
        fontSize,
        center,
        textValue,
        if useBlueText then {
          normalColor: color[theme]['长按选中字体颜色'],
          highlightColor: color[theme]['长按非选中字体颜色'],
        } else {}
      );
    {
    enterButton: createButton(
      'enter',
      if orientation == 'portrait' then
        keyboardLayout['竖屏按键尺寸']['enter键size']
      else
        keyboardLayout['横屏按键尺寸']['enter键size'],
      {},
      baseHintStyles,
      false
    ) + {
      backgroundStyle: [
        {
          styleName: 'systemButtonBackgroundStyle',
          conditionKey: '$returnKeyType',
          conditionValue: [0, 2, 3, 5, 8, 10, 11],
        },
        {
          styleName: 'enterButtonBlueBackgroundStyle',
          conditionKey: '$returnKeyType',
          conditionValue: [1, 4, 6, 7, 9],
        },
      ],
      foregroundStyle: [
        {
          styleName: 'enterButtonForegroundStyle0',
          conditionKey: '$returnKeyType',
          conditionValue: [0, 2, 3, 5, 8, 10, 11],
        },
        {
          styleName: 'enterButtonForegroundStyle14',
          conditionKey: '$returnKeyType',
          conditionValue: [1, 4],
        },
        {
          styleName: 'enterButtonForegroundStyle6',
          conditionKey: '$returnKeyType',
          conditionValue: [6],
        },
        {
          styleName: 'enterButtonForegroundStyle7',
          conditionKey: '$returnKeyType',
          conditionValue: [7],
        },
        {
          styleName: 'enterButtonForegroundStyle9',
          conditionKey: '$returnKeyType',
          conditionValue: [9],
        },
      ],
      action: 'enter',
      notification: [
        'garyReturnKeyTypeNotification',
        'blueReturnKeyTypeNotification14',
        'blueReturnKeyTypeNotification6',
        'blueReturnKeyTypeNotification7',
        'blueReturnKeyTypeNotification9',
      ],
    },

    // 回车键前景
    enterButtonForegroundStyle0: makeEnterForegroundStyle('回车'),
    enterButtonForegroundStyle6: makeEnterForegroundStyle('搜索', true),
    enterButtonForegroundStyle7: makeEnterForegroundStyle('发送', true),
    enterButtonForegroundStyle14: makeEnterForegroundStyle('前往', true),
    enterButtonForegroundStyle9: makeEnterForegroundStyle('完成', true),

    // returnKeyType 通知
    garyReturnKeyTypeNotification: returnKeyHelpers.makeNotification([0, 2, 3, 5, 8, 10, 11], 'systemButtonBackgroundStyle', 'enterButtonForegroundStyle0'),
    blueReturnKeyTypeNotification14: returnKeyHelpers.makeNotification([1, 4], 'enterButtonBlueBackgroundStyle', 'enterButtonForegroundStyle14'),
    blueReturnKeyTypeNotification6: returnKeyHelpers.makeNotification([6], 'enterButtonBlueBackgroundStyle', 'enterButtonForegroundStyle6'),
    blueReturnKeyTypeNotification7: returnKeyHelpers.makeNotification([7], 'enterButtonBlueBackgroundStyle', 'enterButtonForegroundStyle7'),
    blueReturnKeyTypeNotification9: returnKeyHelpers.makeNotification([9], 'enterButtonBlueBackgroundStyle', 'enterButtonForegroundStyle9'),
  },
}
