// 定义平板端中文与英文 26 键布局及经过调校的按键宽度。
local appearance = import '../../../design/appearance.libsonnet';
local color = appearance.color;
local styleFactories = import '../../../design/styleFactories.libsonnet';
local ipadRow1LetterSize = { width: { percentage: 0.085 } };
local ipadRow1SystemSize = { width: { percentage: 0.15 } };
local ipadRow2AButtonSize = { width: { percentage: 1.5 / 11 } };
local ipadRow2LetterSize = { width: { percentage: 1 / 11 } };
local ipadRow2EnterSize = { width: { percentage: 1.5 / 11 } };
local ipadRow3LetterSize = { width: { percentage: 0.085 } };
local ipadRow3TabSize = { width: { percentage: 1 / 11 } };
local ipadRow3LeftShiftSize = { width: { percentage: 1.5 / 11 } };
local ipadRow3RightShiftSize = { width: { percentage: 1.5 / 11 } };
local ipadBottomSmallSize = { width: { percentage: 1 / 11 } };
local ipadBottomSpaceSize = { width: { percentage: 5 / 11 } };

{
  getKeyboardLayout(theme, Settings=null)::
    local makeKeyboardBackgroundStyle() =
      styleFactories.makeGeometryStyle(color[theme]['键盘背景颜色']);
    {
      'ipad中文26键': {
        keyboardLayout: [
          {
            HStack: {
              style: 'keyboardStyle',
              subviews: [
                {
                  HStack: {
                    subviews: [
                      { Cell: 'qButton', size: ipadRow1LetterSize },
                      { Cell: 'wButton', size: ipadRow1LetterSize },
                      { Cell: 'eButton', size: ipadRow1LetterSize },
                      { Cell: 'rButton', size: ipadRow1LetterSize },
                      { Cell: 'tButton', size: ipadRow1LetterSize },
                      { Cell: 'yButton', size: ipadRow1LetterSize },
                      { Cell: 'uButton', size: ipadRow1LetterSize },
                      { Cell: 'iButton', size: ipadRow1LetterSize },
                      { Cell: 'oButton', size: ipadRow1LetterSize },
                      { Cell: 'pButton', size: ipadRow1LetterSize },
                      { Cell: 'backspaceButton', size: ipadRow1SystemSize },
                    ],
                  },
                },
                {
                  HStack: {
                    subviews: [
                      { Cell: 'aButton', size: ipadRow2AButtonSize },
                      { Cell: 'sButton', size: ipadRow2LetterSize },
                      { Cell: 'dButton', size: ipadRow2LetterSize },
                      { Cell: 'fButton', size: ipadRow2LetterSize },
                      { Cell: 'gButton', size: ipadRow2LetterSize },
                      { Cell: 'hButton', size: ipadRow2LetterSize },
                      { Cell: 'jButton', size: ipadRow2LetterSize },
                      { Cell: 'kButton', size: ipadRow2LetterSize },
                      { Cell: 'lButton', size: ipadRow2LetterSize },
                      { Cell: 'enterButton', size: ipadRow2EnterSize },
                    ],
                  },
                },
                {
                  HStack: {
                    subviews: [
                      { Cell: 'shiftButton', size: ipadRow3LeftShiftSize },
                      { Cell: 'zButton', size: ipadRow3LetterSize },
                      { Cell: 'xButton', size: ipadRow3LetterSize },
                      { Cell: 'cButton', size: ipadRow3LetterSize },
                      { Cell: 'vButton', size: ipadRow3LetterSize },
                      { Cell: 'bButton', size: ipadRow3LetterSize },
                      { Cell: 'nButton', size: ipadRow3LetterSize },
                      { Cell: 'mButton', size: ipadRow3LetterSize },
                      { Cell: 'tabButton', size: ipadRow3TabSize },
                      { Cell: 'rightShiftButton', size: ipadRow3RightShiftSize },
                    ],
                  },
                },
                {
                  HStack: {
                    subviews: [
                      { Cell: 'nextButton', size: ipadBottomSmallSize },
                      { Cell: 'ipad123Button', size: ipadBottomSmallSize },
                      { Cell: 'spaceLeftButton', size: ipadBottomSmallSize },
                      { Cell: 'spaceButton', size: ipadBottomSpaceSize },
                      { Cell: 'cn2enButton', size: ipadBottomSmallSize },
                      { Cell: 'ipad123ButtonRight', size: ipadBottomSmallSize },
                      { Cell: 'dismissButton', size: ipadBottomSmallSize },
                    ],
                  },
                },
              ],
            },
          },
        ],
        keyboardStyle: {
          size: {
            height: { percentage: 0.73 },
          },
          insets: {
            top: 3,
            bottom: 3,
            left: 4,
            right: 4,
          },
          backgroundStyle: 'keyboardBackgroundStyle',
        },
        keyboardBackgroundStyle: makeKeyboardBackgroundStyle(),
      },
      'ipad英文26键': {
        keyboardLayout: [
          {
            HStack: {
              style: 'keyboardStyle',
              subviews: [
                {
                  HStack: {
                    subviews: [
                      { Cell: 'qButton', size: ipadRow1LetterSize },
                      { Cell: 'wButton', size: ipadRow1LetterSize },
                      { Cell: 'eButton', size: ipadRow1LetterSize },
                      { Cell: 'rButton', size: ipadRow1LetterSize },
                      { Cell: 'tButton', size: ipadRow1LetterSize },
                      { Cell: 'yButton', size: ipadRow1LetterSize },
                      { Cell: 'uButton', size: ipadRow1LetterSize },
                      { Cell: 'iButton', size: ipadRow1LetterSize },
                      { Cell: 'oButton', size: ipadRow1LetterSize },
                      { Cell: 'pButton', size: ipadRow1LetterSize },
                      { Cell: 'backspaceButton', size: ipadRow1SystemSize },
                    ],
                  },
                },
                {
                  HStack: {
                    subviews: [
                      { Cell: 'aButton', size: ipadRow2AButtonSize },
                      { Cell: 'sButton', size: ipadRow2LetterSize },
                      { Cell: 'dButton', size: ipadRow2LetterSize },
                      { Cell: 'fButton', size: ipadRow2LetterSize },
                      { Cell: 'gButton', size: ipadRow2LetterSize },
                      { Cell: 'hButton', size: ipadRow2LetterSize },
                      { Cell: 'jButton', size: ipadRow2LetterSize },
                      { Cell: 'kButton', size: ipadRow2LetterSize },
                      { Cell: 'lButton', size: ipadRow2LetterSize },
                      { Cell: 'enterButton', size: ipadRow2EnterSize },
                    ],
                  },
                },
                {
                  HStack: {
                    subviews: [
                      { Cell: 'shiftButton', size: ipadRow3LeftShiftSize },
                      { Cell: 'zButton', size: ipadRow3LetterSize },
                      { Cell: 'xButton', size: ipadRow3LetterSize },
                      { Cell: 'cButton', size: ipadRow3LetterSize },
                      { Cell: 'vButton', size: ipadRow3LetterSize },
                      { Cell: 'bButton', size: ipadRow3LetterSize },
                      { Cell: 'nButton', size: ipadRow3LetterSize },
                      { Cell: 'mButton', size: ipadRow3LetterSize },
                      { Cell: 'tabButton', size: ipadRow3TabSize },
                      { Cell: 'rightShiftButton', size: ipadRow3RightShiftSize },
                    ],
                  },
                },
                {
                  HStack: {
                    subviews: [
                      { Cell: 'nextButton', size: ipadBottomSmallSize },
                      { Cell: 'ipad123Button', size: ipadBottomSmallSize },
                      { Cell: 'spaceLeftButton', size: ipadBottomSmallSize },
                      { Cell: 'spaceButton', size: ipadBottomSpaceSize },
                      { Cell: 'en2cnButton', size: ipadBottomSmallSize },
                      { Cell: 'ipad123ButtonRight', size: ipadBottomSmallSize },
                      { Cell: 'dismissButton', size: ipadBottomSmallSize },
                    ],
                  },
                },
              ],
            },
          },
        ],
        keyboardStyle: {
          size: {
            height: { percentage: 0.73 },
          },
          insets: {
            top: 3,
            bottom: 3,
            left: 4,
            right: 4,
          },
          backgroundStyle: 'keyboardBackgroundStyle',
        },
        keyboardBackgroundStyle: makeKeyboardBackgroundStyle(),
      },
    },
}
