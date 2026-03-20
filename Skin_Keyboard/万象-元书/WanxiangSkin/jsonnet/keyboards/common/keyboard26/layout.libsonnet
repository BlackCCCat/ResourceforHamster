// 定义拼音与英文 26 键共用的布局集合。
local color = import '../../../shared/styles/color.libsonnet';
local styleFactories = import '../../../shared/styles/styleFactories.libsonnet';

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
                      { Cell: 'nextButton' },
                      { Cell: 'ipad123Button' },
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
                      { Cell: 'nextButton' },
                      { Cell: 'ipad123Button' },
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
