// 定义拼音与英文 26 键共用的布局集合。
local color = import '../../../shared/styles/color.libsonnet';
local styleFactories = import '../../../shared/styles/styleFactories.libsonnet';
local ipadRow1LetterSize = { width: { percentage: 0.085 } };
local ipadRow1SystemSize = { width: { percentage: 0.15 } };
local ipadRow2AButtonSize = { width: { percentage: 1.5 / 11 } };
local ipadRow2LetterSize = { width: { percentage: 1 / 11 } };
local ipadRow2EnterSize = { width: { percentage: 1.5/11 } };
local ipadRow3LetterSize = { width: { percentage: 0.085 } };
local ipadRow3TabSize = { width: { percentage: 1/11 } };
local ipadRow3LeftShiftSize = { width: { percentage: 1.5/11 } };
local ipadRow3RightShiftSize = { width: { percentage: 1.5/11 } };
local ipadBottomSmallSize = { width: { percentage: 1 / 11 } };
local ipadBottomSpaceSize = { width: { percentage: 5 / 11 } };

{
  getKeyboardLayout(theme)::
    local makeKeyboardBackgroundStyle() =
      // 生成键盘区域背景。
      styleFactories.makeGeometryStyle(color[theme]['键盘背景颜色']);
    {
      '竖屏中文26键': {
        keyboardLayout: [
          {
            HStack: {
              style: 'keyboardStyle',
              subviews: [
                {
                  HStack: {
                    subviews: [
                      { Cell: 'qButton' },
                      { Cell: 'wButton' },
                      { Cell: 'eButton' },
                      { Cell: 'rButton' },
                      { Cell: 'tButton' },
                      { Cell: 'yButton' },
                      { Cell: 'uButton' },
                      { Cell: 'iButton' },
                      { Cell: 'oButton' },
                      { Cell: 'pButton' },
                    ],
                  },
                },
                {
                  HStack: {
                    subviews: [
                      { Cell: 'aButton' },
                      { Cell: 'sButton' },
                      { Cell: 'dButton' },
                      { Cell: 'fButton' },
                      { Cell: 'gButton' },
                      { Cell: 'hButton' },
                      { Cell: 'jButton' },
                      { Cell: 'kButton' },
                      { Cell: 'lButton' },
                    ],
                  },
                },
                {
                  HStack: {
                    subviews: [
                      { Cell: 'shiftButton' },
                      { Cell: 'zButton' },
                      { Cell: 'xButton' },
                      { Cell: 'cButton' },
                      { Cell: 'vButton' },
                      { Cell: 'bButton' },
                      { Cell: 'nButton' },
                      { Cell: 'mButton' },
                      { Cell: 'backspaceButton' },
                    ],
                  },
                },
                {
                  HStack: {
                    subviews: [
                      { Cell: '123Button' },
                      // { Cell: 'cn2enButton' },
                      { Cell: 'spaceLeftButton' },
                      { Cell: 'spaceButton' },
                      { Cell: 'cn2enButton' },
                      // { Cell: 'spaceRightButton' },
                      { Cell: 'enterButton' },
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

      '横屏中文26键': {
        keyboardLayout: [
          {
            HStack: {
              style: 'keyboardStyle',
              subviews: [
                {
                  VStack: {
                    style: 'columnStyle1',
                    subviews: [
                      {
                        HStack: {
                          subviews: [
                            { Cell: 'qButton' },
                            { Cell: 'wButton' },
                            { Cell: 'eButton' },
                            { Cell: 'rButton' },
                            { Cell: 'tButton' },
                          ],
                        },
                      },
                      {
                        HStack: {
                          subviews: [
                            { Cell: 'aButton' },
                            { Cell: 'sButton' },
                            { Cell: 'dButton' },
                            { Cell: 'fButton' },
                            { Cell: 'gButton' },
                          ],
                        },
                      },
                      {
                        HStack: {
                          subviews: [
                            { Cell: 'shiftButton' },
                            { Cell: 'zButton' },
                            { Cell: 'xButton' },
                            { Cell: 'cButton' },
                            { Cell: 'vButton' },
                          ],
                        },
                      },
                      {
                        HStack: {
                          subviews: [
                            { Cell: '123Button' },
                            // { Cell: 'cn2enButton' },
                            { Cell: 'spaceLeftButton' },
                            { Cell: 'spaceFirstButton' },
                          ],
                        },
                      },
                    ],
                  },
                },
                {
                  VStack: {
                    style: 'columnStyle2',
                  },
                },
                {
                  VStack: {
                    style: 'columnStyle3',
                    subviews: [
                      {
                        HStack: {
                          subviews: [
                            { Cell: 'yButton' },
                            { Cell: 'uButton' },
                            { Cell: 'iButton' },
                            { Cell: 'oButton' },
                            { Cell: 'pButton' },
                          ],
                        },
                      },
                      {
                        HStack: {
                          subviews: [
                            { Cell: 'gButton' },
                            { Cell: 'hButton' },
                            { Cell: 'jButton' },
                            { Cell: 'kButton' },
                            { Cell: 'lButton' },
                          ],
                        },
                      },
                      {
                        HStack: {
                          subviews: [
                            { Cell: 'vButton' },
                            { Cell: 'bButton' },
                            { Cell: 'nButton' },
                            { Cell: 'mButton' },
                            { Cell: 'backspaceButton' },
                          ],
                        },
                      },
                      {
                        HStack: {
                          subviews: [
                            { Cell: 'spaceSecondButton' },
                            { Cell: 'cn2enButton' },
                            // { Cell: 'spaceRightButton' },
                            { Cell: 'enterButton' },
                          ],
                        },
                      },
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
        columnStyle1: {
          size: {
            width: '2/5',
          },
        },
        columnStyle2: {
          size: {
            width: '1/5',
          },
        },
        columnStyle3: {
          size: {
            width: '2/5',
          },
        },
      },

      '竖屏英文26键': {
        keyboardLayout: [
          {
            HStack: {
              style: 'keyboardStyle',
              subviews: [
                {
                  HStack: {
                    subviews: [
                      { Cell: 'qButton' },
                      { Cell: 'wButton' },
                      { Cell: 'eButton' },
                      { Cell: 'rButton' },
                      { Cell: 'tButton' },
                      { Cell: 'yButton' },
                      { Cell: 'uButton' },
                      { Cell: 'iButton' },
                      { Cell: 'oButton' },
                      { Cell: 'pButton' },
                    ],
                  },
                },
                {
                  HStack: {
                    subviews: [
                      { Cell: 'aButton' },
                      { Cell: 'sButton' },
                      { Cell: 'dButton' },
                      { Cell: 'fButton' },
                      { Cell: 'gButton' },
                      { Cell: 'hButton' },
                      { Cell: 'jButton' },
                      { Cell: 'kButton' },
                      { Cell: 'lButton' },
                    ],
                  },
                },
                {
                  HStack: {
                    subviews: [
                      { Cell: 'shiftButton' },
                      { Cell: 'zButton' },
                      { Cell: 'xButton' },
                      { Cell: 'cButton' },
                      { Cell: 'vButton' },
                      { Cell: 'bButton' },
                      { Cell: 'nButton' },
                      { Cell: 'mButton' },
                      { Cell: 'backspaceButton' },
                    ],
                  },
                },
                {
                  HStack: {
                    subviews: [
                      { Cell: '123Button' },
                      // { Cell: 'en2cnButton' },
                      { Cell: 'spaceLeftButton' },
                      { Cell: 'spaceButton' },
                      { Cell: 'en2cnButton' },
                      // { Cell: 'spaceRightButton' },
                      { Cell: 'enterButton' },
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

      '横屏英文26键': {
        keyboardLayout: [
          {
            HStack: {
              style: 'keyboardStyle',
              subviews: [
                {
                  VStack: {
                    style: 'columnStyle1',
                    subviews: [
                      {
                        HStack: {
                          subviews: [
                            { Cell: 'qButton' },
                            { Cell: 'wButton' },
                            { Cell: 'eButton' },
                            { Cell: 'rButton' },
                            { Cell: 'tButton' },
                          ],
                        },
                      },
                      {
                        HStack: {
                          subviews: [
                            { Cell: 'aButton' },
                            { Cell: 'sButton' },
                            { Cell: 'dButton' },
                            { Cell: 'fButton' },
                            { Cell: 'gButton' },
                          ],
                        },
                      },
                      {
                        HStack: {
                          subviews: [
                            { Cell: 'shiftButton' },
                            { Cell: 'zButton' },
                            { Cell: 'xButton' },
                            { Cell: 'cButton' },
                            { Cell: 'vButton' },
                          ],
                        },
                      },
                      {
                        HStack: {
                          subviews: [
                            { Cell: '123Button' },
                            // { Cell: 'en2cnButton' },
                            { Cell: 'spaceLeftButton' },
                            { Cell: 'spaceFirstButton' },
                          ],
                        },
                      },
                    ],
                  },
                },
                {
                  VStack: {
                    style: 'columnStyle2',
                  },
                },
                {
                  VStack: {
                    style: 'columnStyle3',
                    subviews: [
                      {
                        HStack: {
                          subviews: [
                            { Cell: 'yButton' },
                            { Cell: 'uButton' },
                            { Cell: 'iButton' },
                            { Cell: 'oButton' },
                            { Cell: 'pButton' },
                          ],
                        },
                      },
                      {
                        HStack: {
                          subviews: [
                            { Cell: 'gButton' },
                            { Cell: 'hButton' },
                            { Cell: 'jButton' },
                            { Cell: 'kButton' },
                            { Cell: 'lButton' },
                          ],
                        },
                      },
                      {
                        HStack: {
                          subviews: [
                            { Cell: 'vButton' },
                            { Cell: 'bButton' },
                            { Cell: 'nButton' },
                            { Cell: 'mButton' },
                            { Cell: 'backspaceButton' },
                          ],
                        },
                      },
                      {
                        HStack: {
                          subviews: [
                            { Cell: 'spaceSecondButton' },
                            { Cell: 'en2cnButton' },
                            // { Cell: 'spaceRightButton' },
                            { Cell: 'enterButton' },
                          ],
                        },
                      },
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
        columnStyle1: {
          size: {
            width: '2/5',
          },
        },
        columnStyle2: {
          size: {
            width: '1/5',
          },
        },
        columnStyle3: {
          size: {
            width: '2/5',
          },
        },
      },
    },
}
