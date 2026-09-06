// 创建一次构建所需的设备上下文，并解析各键盘族共用的布局数据。
local appearance = import '../design/appearance.libsonnet';
local color = appearance.color;

// 基础尺寸与背景只在布局解析阶段使用，直接收口在构建上下文中。
local keyboardLayoutBaseData = {
  getKeyboardLayout(theme)::
    {
      '竖屏按键尺寸': {
        '自定义键size': {
          width: {
            percentage: 1 / 8,
          },
        },
        '普通键size': {
          width: {
            percentage: 0.1,
          },
        },
        'a键size和bounds': {
          size: {
            width: {
              percentage: 0.15,
            },
          },
          bounds: {
            width: '2/3',
            alignment: 'right',
          },
        },
        'l键size和bounds': {
          size: {
            width: {
              percentage: 0.15,
            },
          },
          bounds: {
            width: '2/3',
            alignment: 'left',
          },
        },
        'shift键size': {
          width: {
            percentage: 0.15,
          },
        },
        'backspace键size': {
          width: {
            percentage: 0.15,
          },
        },
        'en2cn键size': {
          width: {
            percentage: 0.1,
          },
        },
        'cn2en键size': {
          width: {
            percentage: 0.1,
          },
        },
        'spaceLeft键size': {
          width: {
            percentage: 0.1,
          },
        },
        '123键size': {
          width: {
            percentage: 0.2,  // 0.12,
          },
        },
        'ipad123键size': {
          width: {
            percentage: 0.1,
          },
        },
        'next键size': {
          width: {
            percentage: 0.1,
          },
        },
        'space键size': {
          width: {
            percentage: 0.4,
          },
        },
        'spaceRight键size': {
          width: {
            percentage: 0.1,
          },
        },
        // "EnZh键size": {
        //   "width": {
        //     "percentage": 0.1
        //   }
        // },
        'enter键size': {
          width: {
            percentage: 0.2,
          },
        },
      },

      '横屏按键尺寸': {
        '自定义键size': {
          width: {
            percentage: 1 / 4,
          },
          height: {
            percentage: 0.1,
          },
        },
        '普通键size': {
          width: '146/784',
        },
        't键size和bounds': {
          size: {
            width: '200/784',
          },
          bounds: {
            width: '146/200',
            alignment: 'left',
          },
        },
        'y键size和bounds': {
          size: {
            width: '200/784',
          },
          bounds: {
            width: '146/200',
            alignment: 'right',
          },
        },
        'a键size和bounds': {
          size: {
            width: '200/784',
          },
          bounds: {
            width: '146/200',
            alignment: 'right',
          },
        },
        'l键size和bounds': {
          size: {
            width: '200/784',
          },
          bounds: {
            width: '146/200',
            alignment: 'left',
          },
        },
        'shift键size': {
          width: '200/784',
        },
        'backspace键size': {
          width: '200/784',
        },
        'en2cn键size': {
          width: '146/784',
        },
        'cn2en键size': {
          width: '146/784',
        },
        'spaceLeft键size': {
          width: '146/784',
        },
        '123键size': {
          width: '273/784',  // '173/784',
        },
        'space键size': {
          width: '365/784',
        },
        'spaceFirst键size': {
          width: '365/784',
        },
        'spaceSecond键size': {
          width: '365/784',
        },
        'spaceRight键size': {
          width: '146/784',
        },
        // "EnZh键size": {
        //   "width": "173/784"
        // },
        'enter键size': {
          width: '273/784',
        },
      },
    },
};
local functionRow = import '../components/functionRow/index.libsonnet';
local keyboard26IPhoneLayout = import '../keyboards/keyboard26/base/iPhoneLayout.libsonnet';
local keyboard26IPadLayout = import '../keyboards/keyboard26/base/iPadLayout.libsonnet';
local pinyin18Layout = import '../keyboards/pinyin14_18/pinyin18/layout.libsonnet';
local pinyin17Layout = import '../keyboards/pinyin14_18/pinyin17/layout.libsonnet';
local pinyin14Layout = import '../keyboards/pinyin14_18/pinyin14/layout.libsonnet';

{
  new(Settings, theme, orientation, deviceType='iPhone'):: {
    Settings: Settings,
    theme: theme,
    orientation: orientation,
    deviceType: deviceType,
    isPortrait: orientation == 'portrait',
    withFunctionsRow: Settings.function_button_config.with_functions_row[deviceType],
  },

  getKeyboardLayout(context)::
    local pinyin18LandscapeRows = pinyin18Layout.getLandscapePatchRows();
    local pinyin17LandscapeRows = pinyin17Layout.getLandscapePatchRows();
    local pinyin14LandscapeRows = pinyin14Layout.getLandscapePatchRows();
    local baseLayout =
      keyboardLayoutBaseData.getKeyboardLayout(context.theme) +
      keyboard26IPhoneLayout.getKeyboardLayout(context.theme, context.Settings) +
      keyboard26IPadLayout.getKeyboardLayout(context.theme, context.Settings) +
      pinyin18Layout.getKeyboardLayout(context.theme) +
      pinyin17Layout.getKeyboardLayout(context.theme) +
      pinyin14Layout.getKeyboardLayout(context.theme);
    if context.withFunctionsRow then
      baseLayout + functionRow.getPatch(
        baseLayout,
        pinyin18LandscapeRows,
        pinyin17LandscapeRows,
        pinyin14LandscapeRows
      )
    else
      baseLayout,
}
