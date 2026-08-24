// 汇总退格、空格和回车三类编辑系统键，并保留独立构建入口。
local backspaceModule = (
  local styleFactories = import '../../design/styleFactories.libsonnet';

  {
    build(theme, orientation, keyboardLayout, color, fontSize, createButton, baseHintStyles)::
      local makeBackspaceForegroundStyle() =
        // 生成退格键图标前景。
        styleFactories.makeSystemImageStyle(
          'delete.left',
          fontSize['按键前景文字大小'],
          color[theme]['按键前景颜色'],
          color[theme]['按键前景颜色'],
          {}
        ) + { targetScale: 0.7 };
      {
        backspaceButton: createButton(
          'backspace',
          if orientation == 'portrait' then
            keyboardLayout['竖屏按键尺寸']['backspace键size']
          else
            keyboardLayout['横屏按键尺寸']['backspace键size'],
          {},
          baseHintStyles,
          false
        ) + {
          backgroundStyle: 'systemButtonBackgroundStyle',
          action: 'backspace',
          repeatAction: 'backspace',
        },
        backspaceButtonForegroundStyle: makeBackspaceForegroundStyle(),
      },
  }
);

local spaceModule = (
  local styleFactories = import '../../design/styleFactories.libsonnet';

  {
    build(theme, orientation, keyboardLayout, Settings, color, fontSize, center, createButton, baseHintStyles)::
      local makeSystemImageForegroundStyle(systemImageName, fontSizeDelta=0, extraCenter={}) =
        // 生成空格键族共用的系统图标前景。
        styleFactories.makeSystemImageStyle(
          systemImageName,
          fontSize['按键前景文字大小'] + fontSizeDelta,
          color[theme]['按键前景颜色'],
          color[theme]['按键前景颜色'],
          if extraCenter == {} then center['功能键前景文字偏移'] else extraCenter
        );
      local makeTextForegroundStyle(textValue, normalColor, fontSizeDelta=0, extraCenter={}) =
        // 生成空格键族共用的文字前景。
        styleFactories.makeTextStyle(
          textValue,
          fontSize['按键前景文字大小'] + fontSizeDelta,
          normalColor,
          normalColor,
          extraCenter
        );
      local makeSpaceForegroundStyle() =
        // 生成主空格图标前景。
        makeSystemImageForegroundStyle('space', -3);
      local makeWanxiangForegroundStyle(posX) =
        // 生成“万象”角标前景。
        makeTextForegroundStyle('万象', color[theme]['划动字符颜色'], -10, { x: posX, y: 0.8 });
      local makeSpacePreeditNotification(foregroundStyle) = {
        notificationType: 'preeditChanged',
        backgroundStyle: 'alphabeticBackgroundStyle',
        foregroundStyle: foregroundStyle,
        swipeUpAction: { shortcut: '#次选上屏' },
        swipeDownAction: { shortcut: '#三选上屏' },
      };
      {
        spaceButton: createButton(
          'space',
          if orientation == 'portrait' then
            keyboardLayout['竖屏按键尺寸']['space键size']
          else
            keyboardLayout['横屏按键尺寸']['space键size'],
          {},
          baseHintStyles,
          false
        ) + {
          foregroundStyle: [
            'spaceButtonForegroundStyle',
            if Settings.show_wanxiang then 'spaceButtonForegroundStyle1' else null,
          ],
          action: 'space',
          [if Settings.keyboard_layout == 26 then 'swipeUpAction']: { sendKeys: 'Shift+space' },
          notification: [
            'spaceButtonPreeditNotification',
          ],
        },
        // 主空格键
        spaceButtonPreeditNotification: makeSpacePreeditNotification([
          'spaceButtonForegroundStyle',
          if Settings.show_wanxiang then 'spaceButtonForegroundStyle1' else null,
        ]),
        spaceButtonForegroundStyle: makeSpaceForegroundStyle(),
        spaceButtonForegroundStyle1: makeWanxiangForegroundStyle(0.9),

        spaceFirstButton: createButton(
          'spaceFirst',
          if orientation == 'portrait' then
            keyboardLayout['竖屏按键尺寸']['space键size']
          else
            keyboardLayout['横屏按键尺寸']['spaceFirst键size'],
          {},
          baseHintStyles,
          false
        ) + {
          foregroundStyle: 'spaceFirstButtonForegroundStyle',
          action: 'space',
          [if Settings.keyboard_layout == 26 then 'swipeUpAction']: { sendKeys: 'Shift+space' },
          notification: [
            'spaceFirstButtonPreeditNotification',
          ],
        },
        // 左侧空格键
        spaceFirstButtonPreeditNotification: makeSpacePreeditNotification('spaceFirstButtonForegroundStyle'),
        spaceFirstButtonForegroundStyle: makeSpaceForegroundStyle(),

        spaceSecondButton: createButton(
          'spaceSecond',
          if orientation == 'portrait' then
            keyboardLayout['竖屏按键尺寸']['space键size']
          else
            keyboardLayout['横屏按键尺寸']['spaceSecond键size'],
          {},
          baseHintStyles,
          false
        ) + {
          foregroundStyle: [
            'spaceSecondButtonForegroundStyle',
            if Settings.show_wanxiang then 'spaceSecondButtonForegroundStyle1' else null,
          ],
          action: 'space',
          [if Settings.keyboard_layout == 26 then 'swipeUpAction']: { sendKeys: 'Shift+space' },
          notification: [
            'spaceSecondButtonPreeditNotification',
          ],
        },
        // 右侧空格键
        spaceSecondButtonPreeditNotification: makeSpacePreeditNotification([
          'spaceSecondButtonForegroundStyle',
          if Settings.show_wanxiang then 'spaceSecondButtonForegroundStyle1' else null,
        ]),
        spaceSecondButtonForegroundStyle: makeSpaceForegroundStyle(),
        spaceSecondButtonForegroundStyle1: makeWanxiangForegroundStyle(0.85),

        spaceRightButton: createButton(
          'spaceRight',
          if orientation == 'portrait' then
            keyboardLayout['竖屏按键尺寸']['spaceRight键size']
          else
            keyboardLayout['横屏按键尺寸']['spaceRight键size'],
          {},
          baseHintStyles,
          false
        ) + {
          action: { character: '.' },
          repeatAction: { character: '.' },
          notification: [
            'spaceRightButtonPreeditNotification',
          ],
        },
        spaceRightButtonPreeditNotification: {
          notificationType: 'preeditChanged',
          backgroundStyle: 'alphabeticBackgroundStyle',
          foregroundStyle: 'spaceRightButtonPreeditForegroundStyle',
          action: Settings.tips_button_action,
          swipeUpAction: { character: '.' },
          hintSymbolsStyle: 'cn2enButtonHintSymbolsStyle',
        },
        spaceRightButtonPreeditForegroundStyle:
          // 生成提示灯泡前景。
          makeSystemImageForegroundStyle(if Settings.fix_sf_symbol then 'lightbulb' else 'lightbulb.max', 0, {}),
        spaceRightButtonForegroundStyle:
          // 生成右侧句号前景。
          makeTextForegroundStyle('。', color[theme]['按键前景颜色']),
        spaceRightButtonForegroundStyle2:
          // 生成右侧句号紧凑前景。
          makeTextForegroundStyle('。', color[theme]['按键前景颜色'], -2),

        local slBtn = createButton(
          'spaceLeft',
          if orientation == 'portrait' then
            keyboardLayout['竖屏按键尺寸']['spaceRight键size']
          else
            keyboardLayout['横屏按键尺寸']['spaceRight键size'],
          {},
          baseHintStyles,
          false
        ),
        spaceLeftButton: slBtn {
          foregroundStyle: [
            'spaceLeftButtonForegroundStyle',
            'spaceLeftButtonForegroundStyle2',
          ],
          action: {
            character: ',',
          },
        },
        spaceLeftButtonForegroundStyle:
          // 生成左侧逗号前景。
          makeTextForegroundStyle(',', color[theme]['按键前景颜色'], 0, { x: 0.5, y: 0.5 }),
        spaceLeftButtonForegroundStyle2:
          // 生成左侧句号前景。
          makeTextForegroundStyle('.', color[theme]['按键前景颜色'], -2, { x: 0.5, y: 0.3 }),
      },
  }
);

local enterModule = (
  local styleFactories = import '../../design/styleFactories.libsonnet';
  local returnKeyHelpers = import '../key/factory.libsonnet';

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
);

{
  buildBackspace(theme, orientation, keyboardLayout, color, fontSize, createButton, baseHintStyles)::
    backspaceModule.build(theme, orientation, keyboardLayout, color, fontSize, createButton, baseHintStyles),

  buildSpace(theme, orientation, keyboardLayout, Settings, color, fontSize, center, createButton, baseHintStyles)::
    spaceModule.build(theme, orientation, keyboardLayout, Settings, color, fontSize, center, createButton, baseHintStyles),

  buildEnter(theme, orientation, keyboardLayout, Settings, color, fontSize, center, createButton, baseHintStyles)::
    enterModule.build(theme, orientation, keyboardLayout, Settings, color, fontSize, center, createButton, baseHintStyles),
}
