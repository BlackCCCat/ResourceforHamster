// 定义手机端中文与英文 26/27 键的横竖屏行结构。
local appearance = import '../../../design/appearance.libsonnet';
local color = appearance.color;
local styleFactories = import '../../../design/styleFactories.libsonnet';

{
  getKeyboardLayout(theme, Settings=null)::
    local use27Key = Settings != null && std.objectHas(Settings, 'keyboard_layout') && Settings.keyboard_layout == 27;
    local makeKeyboardBackgroundStyle() =
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
                      if use27Key then { Cell: ';Button' } else {},
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
                            if use27Key then { Cell: 'hButton' } else { Cell: 'gButton' },
                            if use27Key then { Cell: 'jButton' } else { Cell: 'hButton' },
                            if use27Key then { Cell: 'kButton' } else { Cell: 'jButton' },
                            if use27Key then { Cell: 'lButton' } else { Cell: 'kButton' },
                            if use27Key then { Cell: ';Button' } else { Cell: 'lButton' },
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
