local color = import 'color.libsonnet';

{
  getKeyboardLayout(theme)::
    {
      '竖屏中文9键': {
        '竖屏按键尺寸': {
          'symbolButton': { width: { percentage: 1.5/7 } },
          'spaceButton': { width: { percentage: 4/7 } },
          'cn2enButton': { width: { percentage: 1.5/7 } },
          '123Button': { width: { percentage: 1/4 } },
          'emojiButton': { width: { percentage: 1/4 } },
          'backspaceButton': { height: { percentage: 1/4 } },
          'cleanButton': { height: { percentage: 1/4 } },
          'enterButton': { height: { percentage: 1/4 } },

        },
        keyboardLayout: [
          {
            HStack: {
              style: 'rowofFunctionStyle',
              subviews: [
                { Cell: 'leftButton' },
                { Cell: 'headButton' },
                { Cell: 'selectButton' },
                { Cell: 'cutButton' },
                { Cell: 'copyButton' },
                { Cell: 'pasteButton' },
                { Cell: 'tailButton' },
                { Cell: 'rightButton' },
              ],
            },
          },
          {
            HStack: {
              style: 'keyboardStyle',
              subviews: [
                {
                  VStack: {
                    style: 'VStackStyle1',
                    subviews: [
                      { Cell: 'collection' },
                      { Cell: '123Button' },
                      // { Cell: 'emojiButton' },
                    ],
                  },
                },
                {
                  VStack: {
                    style: 'CenterStackStyle',
                    subviews: [
                      {
                        HStack: {
                          style: 'HStackStyle1',
                          subviews: [
                            { VStack: { subviews: [ { Cell: 'number1Button' }, { Cell: 'number4Button' }, { Cell: 'number7Button' } ] } },
                            { VStack: { subviews: [ { Cell: 'number2Button' }, { Cell: 'number5Button' }, { Cell: 'number8Button' } ] } },
                            { VStack: { subviews: [ { Cell: 'number3Button' }, { Cell: 'number6Button' }, { Cell: 'number9Button' } ] } },
                          ],
                        },
                      },
                      {
                        HStack: {
                          style: 'HStackStyle2',
                          subviews: [
                            { Cell: 'symbolButton' },
                            { Cell: 'spaceButton' },
                            { Cell: 'cn2enButton' },
                          ],
                        },
                      },
                    ],
                  },
                },
                {
                  VStack: {
                    style: 'VStackStyle1',
                    subviews: [
                      { Cell: 'backspaceButton' },
                      { Cell: 'cleanButton' },
                      { Cell: 'enterButton' },
                    ],
                  },
                },
              ],
            },
          },
        ],
        rowofFunctionStyle: {
          size: {
            height: { percentage: 0.17 },
          },
          backgroundStyle: 'keyboardBackgroundStyle',
        },
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
        keyboardBackgroundStyle: {
          buttonStyleType: 'geometry',
          normalColor: color[theme]['键盘背景颜色'],
        },
        VStackStyle1: {
          size: {
            width: '29/183',
          },
        },
        CenterStackStyle: {
          size: {
            width: '375/549',
          },
        },
        HStackStyle1: {
          size: {
            height: '3/4',
          },
        },
        HStackStyle2: {
          size: {
            height: '1/4',
          },
        },
      },
      '竖屏中文26键': {
        keyboardLayout: [
          {
            HStack: {
              style: 'rowofFunctionStyle',
              subviews: [
                { Cell: 'leftButton' },
                { Cell: 'headButton' },
                { Cell: 'selectButton' },
                { Cell: 'cutButton' },
                { Cell: 'copyButton' },
                { Cell: 'pasteButton' },
                { Cell: 'tailButton' },
                { Cell: 'rightButton' },
              ],
            },
          },
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
        rowofFunctionStyle: {
          size: {
            height: { percentage: 0.17 },
          },
          backgroundStyle: 'keyboardBackgroundStyle',
        },
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
        keyboardBackgroundStyle: {
          buttonStyleType: 'geometry',
          normalColor: color[theme]['键盘背景颜色'],
        },
      },
      // 18-key Layout (7+6+5+Functional)
      '竖屏中文18键': {
        keyboardLayout: [
          {
            HStack: {
              style: 'rowofFunctionStyle',
              subviews: [
                { Cell: 'leftButton' },
                { Cell: 'headButton' },
                { Cell: 'selectButton' },
                { Cell: 'cutButton' },
                { Cell: 'copyButton' },
                { Cell: 'pasteButton' },
                { Cell: 'tailButton' },
                { Cell: 'rightButton' },
              ],
            },
          },
          {
            HStack: {
              style: 'keyboardStyle',
              subviews: [
                {
                  HStack: {
                    subviews: [
                      { Cell: 'qButton' },
                      { Cell: 'weButton' },
                      { Cell: 'rtButton' },
                      { Cell: 'yButton' },
                      { Cell: 'uButton' },
                      { Cell: 'ioButton' },
                      { Cell: 'pButton' },
                    ],
                  },
                },
                {
                  HStack: {
                    subviews: [
                      { Cell: 'aButton' },
                      { Cell: 'sdButton' },
                      { Cell: 'fgButton' },
                      { Cell: 'hButton' },
                      { Cell: 'jkButton' },
                      { Cell: 'lButton' },
                    ],
                  },
                },
                {
                  HStack: {
                    subviews: [
                      { Cell: 'shiftButton' },
                      { Cell: 'zButton' },
                      { Cell: 'xcButton' },
                      { Cell: 'vButton' },
                      { Cell: 'bnButton' },
                      { Cell: 'mButton' },
                      { Cell: 'backspaceButton' },
                    ],
                  },
                },
                {
                  HStack: {
                    subviews: [
                      { Cell: '123Button' },
                      { Cell: 'spaceLeftButton' },
                      { Cell: 'spaceButton' },
                      { Cell: 'cn2enButton' },
                      { Cell: 'enterButton' },
                    ],
                  },
                },
              ],
            },
          },
        ],
        rowofFunctionStyle: {
          size: {
            height: { percentage: 0.17 },
          },
          backgroundStyle: 'keyboardBackgroundStyle',
        },
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
        keyboardBackgroundStyle: {
          buttonStyleType: 'geometry',
          normalColor: color[theme]['键盘背景颜色'],
        },
      },
      // 14-key Layout (5+5+4+Functional)
      '竖屏中文14键': {
        keyboardLayout: [
          {
            HStack: {
              style: 'rowofFunctionStyle',
              subviews: [
                { Cell: 'leftButton' },
                { Cell: 'headButton' },
                { Cell: 'selectButton' },
                { Cell: 'cutButton' },
                { Cell: 'copyButton' },
                { Cell: 'pasteButton' },
                { Cell: 'tailButton' },
                { Cell: 'rightButton' },
              ],
            },
          },
          {
            HStack: {
              style: 'keyboardStyle',
              subviews: [
                {
                  HStack: {
                    subviews: [
                      { Cell: 'qwButton' },
                      { Cell: 'erButton' },
                      { Cell: 'tyButton' },
                      { Cell: 'uiButton' },
                      { Cell: 'opButton' },
                    ],
                  },
                },
                {
                  HStack: {
                    subviews: [
                      { Cell: 'asButton' },
                      { Cell: 'dfButton' },
                      { Cell: 'ghButton' },
                      { Cell: 'jkButton' },
                      { Cell: 'lButton' },
                    ],
                  },
                },
                {
                  HStack: {
                    subviews: [
                      { Cell: 'shiftButton' },
                      { Cell: 'zxButton' },
                      { Cell: 'cvButton' },
                      { Cell: 'bnButton' },
                      { Cell: 'mButton' },
                      { Cell: 'backspaceButton' },
                    ],
                  },
                },
                {
                  HStack: {
                    subviews: [
                      { Cell: '123Button' },
                      { Cell: 'spaceLeftButton' },
                      { Cell: 'spaceButton' },
                      { Cell: 'cn2enButton' },
                      { Cell: 'enterButton' },
                    ],
                  },
                },
              ],
            },
          },
        ],
        rowofFunctionStyle: {
          size: {
            height: { percentage: 0.17 },
          },
          backgroundStyle: 'keyboardBackgroundStyle',
        },
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
        keyboardBackgroundStyle: {
          buttonStyleType: 'geometry',
          normalColor: color[theme]['键盘背景颜色'],
        },
      },
      // Revisit 26-key landscape for 18/14 keys as fallback or duplicate 26 logic for now since explicit landscape 18/14 was not strictly defined but should exist.
      // I will map them to the same layout as 26 key for landscape or define them simple.
      // Actually, typically landscape stays 26 keys even for "9 key" inputs on some IMEs, but here user might want consistent.
      // However, creating compressed keys for landscape is weird because there is so much space.
      // I will Alias landscape 18/14 to 26 key layout for now to avoid bad UX, as 14 keys on landscape is huge buttons.
      '横屏中文18键': {
        keyboardLayout: [
          {
            HStack: {
              style: 'rowofFunctionStyle',
              subviews: [
                { VStack: { style: 'columnStyle1', subviews: [{ HStack: { subviews: [{ Cell: 'leftButton' }, { Cell: 'headButton' }, { Cell: 'selectButton' }, { Cell: 'cutButton' }] } }] } },
                { VStack: { style: 'columnStyle2' } },
                { VStack: { style: 'columnStyle3', subviews: [{ HStack: { subviews: [{ Cell: 'copyButton' }, { Cell: 'pasteButton' }, { Cell: 'tailButton' }, { Cell: 'rightButton' }] } }] } },
              ],
            },
          },
          {
            HStack: {
              style: 'keyboardStyle',
              subviews: [
                {
                  VStack: {
                    style: 'columnStyle1',
                    subviews: [
                      { HStack: { subviews: [{ Cell: 'qButton' }, { Cell: 'weButton' }, { Cell: 'rtButton' }, { Cell: 'yButton' }] } },
                      { HStack: { subviews: [{ Cell: 'aButton' }, { Cell: 'sdButton' }, { Cell: 'fgButton' }] } },
                      { HStack: { subviews: [{ Cell: 'shiftButton' }, { Cell: 'zButton' }, { Cell: 'xcButton' }, { Cell: 'vButton' }] } },
                      { HStack: { subviews: [{ Cell: '123Button' }, { Cell: 'spaceLeftButton' }, { Cell: 'spaceFirstButton' }] } },
                    ],
                  },
                },
                { VStack: { style: 'columnStyle2' } },
                {
                  VStack: {
                    style: 'columnStyle3',
                    subviews: [
                      { HStack: { subviews: [{ Cell: 'yButton' }, { Cell: 'uButton' }, { Cell: 'ioButton' }, { Cell: 'pButton' }] } },
                      { HStack: { subviews: [{ Cell: 'hButton' }, { Cell: 'jkButton' }, { Cell: 'lButton' }] } },
                      { HStack: { subviews: [{ Cell: 'vButton' }, { Cell: 'bnButton' }, { Cell: 'mButton' }, { Cell: 'backspaceButton' }] } },
                      { HStack: { subviews: [{ Cell: 'spaceSecondButton' }, { Cell: 'cn2enButton' }, { Cell: 'enterButton' }] } },
                    ],
                  },
                },
              ],
            },
          },
        ],
        rowofFunctionStyle: { size: { height: { percentage: 0.17 } }, backgroundStyle: 'keyboardBackgroundStyle' },
        keyboardStyle: { size: { height: { percentage: 0.73 } }, insets: { top: 3, bottom: 3, left: 4, right: 4 }, backgroundStyle: 'keyboardBackgroundStyle' },
        keyboardBackgroundStyle: { buttonStyleType: 'geometry', normalColor: color[theme]['键盘背景颜色'] },
        columnStyle1: { size: { width: '2/5' } },
        columnStyle2: { size: { width: '1/5' } },
        columnStyle3: { size: { width: '2/5' } },
      },
      '横屏中文14键': {
        keyboardLayout: [
          {
            HStack: {
              style: 'rowofFunctionStyle',
              subviews: [
                { VStack: { style: 'columnStyle1', subviews: [{ HStack: { subviews: [{ Cell: 'leftButton' }, { Cell: 'headButton' }, { Cell: 'selectButton' }, { Cell: 'cutButton' }] } }] } },
                { VStack: { style: 'columnStyle2' } },
                { VStack: { style: 'columnStyle3', subviews: [{ HStack: { subviews: [{ Cell: 'copyButton' }, { Cell: 'pasteButton' }, { Cell: 'tailButton' }, { Cell: 'rightButton' }] } }] } },
              ],
            },
          },
          {
            HStack: {
              style: 'keyboardStyle',
              subviews: [
                {
                  VStack: {
                    style: 'columnStyle1',
                    subviews: [
                      { HStack: { subviews: [{ Cell: 'qwButton' }, { Cell: 'erButton' }, { Cell: 'tyButton' }] } },
                      { HStack: { subviews: [{ Cell: 'asButton' }, { Cell: 'dfButton' }, { Cell: 'ghButton' }] } },
                      { HStack: { subviews: [{ Cell: 'shiftButton' }, { Cell: 'zxButton' }, { Cell: 'cvButton' }] } },
                      { HStack: { subviews: [{ Cell: '123Button' }, { Cell: 'spaceLeftButton' }, { Cell: 'spaceFirstButton' }] } },
                    ],
                  },
                },
                { VStack: { style: 'columnStyle2' } },
                {
                  VStack: {
                    style: 'columnStyle3',
                    subviews: [
                      { HStack: { subviews: [{ Cell: 'tyButton' }, { Cell: 'uiButton' }, { Cell: 'opButton' }] } },
                      { HStack: { subviews: [{ Cell: 'ghButton' }, { Cell: 'jkButton' }, { Cell: 'lButton' }] } },
                      { HStack: { subviews: [{ Cell: 'bnButton' }, { Cell: 'mButton' }, { Cell: 'backspaceButton' }] } },
                      { HStack: { subviews: [{ Cell: 'spaceSecondButton' }, { Cell: 'cn2enButton' }, { Cell: 'enterButton' }] } },
                    ],
                  },
                },
              ],
            },
          },
        ],
        rowofFunctionStyle: { size: { height: { percentage: 0.17 } }, backgroundStyle: 'keyboardBackgroundStyle' },
        keyboardStyle: { size: { height: { percentage: 0.73 } }, insets: { top: 3, bottom: 3, left: 4, right: 4 }, backgroundStyle: 'keyboardBackgroundStyle' },
        keyboardBackgroundStyle: { buttonStyleType: 'geometry', normalColor: color[theme]['键盘背景颜色'] },
        columnStyle1: { size: { width: '2/5' } },
        columnStyle2: { size: { width: '1/5' } },
        columnStyle3: { size: { width: '2/5' } },
      },
      'ipad中文26键': {
        keyboardLayout: [
          {
            HStack: {
              style: 'rowofFunctionStyle',
              subviews: [
                { Cell: 'leftButton' },
                { Cell: 'headButton' },
                { Cell: 'selectButton' },
                { Cell: 'cutButton' },
                { Cell: 'copyButton' },
                { Cell: 'pasteButton' },
                { Cell: 'tailButton' },
                { Cell: 'rightButton' },
              ],
            },
          },
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
        rowofFunctionStyle: {
          size: {
            height: { percentage: 0.17 },
          },
          backgroundStyle: 'keyboardBackgroundStyle',
        },
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
        keyboardBackgroundStyle: {
          buttonStyleType: 'geometry',
          normalColor: color[theme]['键盘背景颜色'],
        },
      },

      '横屏中文26键': {
        keyboardLayout: [
          {
            HStack: {
              style: 'rowofFunctionStyle',
              subviews: [
                {
                  VStack: {
                    style: 'columnStyle1',
                    subviews: [
                      {
                        HStack: {
                          subviews: [
                            { Cell: 'leftButton' },
                            { Cell: 'headButton' },
                            { Cell: 'selectButton' },
                            { Cell: 'cutButton' },
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
                            { Cell: 'copyButton' },
                            { Cell: 'pasteButton' },
                            { Cell: 'tailButton' },
                            { Cell: 'rightButton' },
                          ],
                        },
                      },
                    ],
                  },
                },
              ],
            },
          },
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
        rowofFunctionStyle: {
          size: {
            height: { percentage: 0.17 },
          },
          backgroundStyle: 'keyboardBackgroundStyle',
        },
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
        keyboardBackgroundStyle: {
          buttonStyleType: 'geometry',
          normalColor: color[theme]['键盘背景颜色'],
        },
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
              style: 'rowofFunctionStyle',
              subviews: [
                { Cell: 'leftButton' },
                { Cell: 'headButton' },
                { Cell: 'selectButton' },
                { Cell: 'cutButton' },
                { Cell: 'copyButton' },
                { Cell: 'pasteButton' },
                { Cell: 'tailButton' },
                { Cell: 'rightButton' },
              ],
            },
          },
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
        rowofFunctionStyle: {
          size: {
            height: { percentage: 0.17 },
          },
          backgroundStyle: 'keyboardBackgroundStyle',
        },
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
        keyboardBackgroundStyle: {
          buttonStyleType: 'geometry',
          normalColor: color[theme]['键盘背景颜色'],
        },
      },
      'ipad英文26键': {
        keyboardLayout: [
          {
            HStack: {
              style: 'rowofFunctionStyle',
              subviews: [
                { Cell: 'leftButton' },
                { Cell: 'headButton' },
                { Cell: 'selectButton' },
                { Cell: 'cutButton' },
                { Cell: 'copyButton' },
                { Cell: 'pasteButton' },
                { Cell: 'tailButton' },
                { Cell: 'rightButton' },
              ],
            },
          },
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
        rowofFunctionStyle: {
          size: {
            height: { percentage: 0.17 },
          },
          backgroundStyle: 'keyboardBackgroundStyle',
        },
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
        keyboardBackgroundStyle: {
          buttonStyleType: 'geometry',
          normalColor: color[theme]['键盘背景颜色'],
        },
      },

      '横屏英文26键': {
        keyboardLayout: [
          {
            HStack: {
              style: 'rowofFunctionStyle',
              subviews: [
                {
                  VStack: {
                    style: 'columnStyle1',
                    subviews: [
                      {
                        HStack: {
                          subviews: [
                            { Cell: 'leftButton' },
                            { Cell: 'headButton' },
                            { Cell: 'selectButton' },
                            { Cell: 'cutButton' },
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
                            { Cell: 'copyButton' },
                            { Cell: 'pasteButton' },
                            { Cell: 'tailButton' },
                            { Cell: 'rightButton' },
                          ],
                        },
                      },
                    ],
                  },
                },
              ],
            },
          },
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
        rowofFunctionStyle: {
          size: {
            height: { percentage: 0.17 },
          },
          backgroundStyle: 'keyboardBackgroundStyle',
        },
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
        keyboardBackgroundStyle: {
          buttonStyleType: 'geometry',
          normalColor: color[theme]['键盘背景颜色'],
        },
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
        // 14-Key Portrait Sizes
        '14键Row1Size': { width: { percentage: 0.2 } },
        '14键Row2Size': { width: { percentage: 0.2 } },
        '14键Row3Size': { width: { percentage: 0.175 } },
        '14键As键size和bounds': {
            size: { width: { percentage: 0.2 } },
        },
        '14键L键size和bounds': {
            size: { width: { percentage: 0.2 } },
        },
        // 18-Key Portrait Sizes
        '18键Row1Size': { width: { percentage: 1/7 } }, 
        '18键Row2Size': { width: { percentage: 1/7 } },
        '18键A键size和bounds': {
            size: { width: { percentage: 3/14 } },
            bounds: { width: '2/3', alignment: 'right' },
        },
        '18键L键size和bounds': {
            size: { width: { percentage: 3/14 } },
            bounds: { width: '2/3', alignment: 'left' },
        },
        '18键Row3Size': { width: { percentage: 1/7 } },
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
        // 14-Key Landscape Sizes
        '14键横屏Row1Size': { width: { percentage: 0.33 } },
        '14键横屏As键size和bounds': {
            size: { width: { percentage: 0.33 } },
        },
        '14键横屏L键size和bounds': {
            size: { width: { percentage: 0.33 } },
        },
        '14键横屏shift键size': { width: { percentage: 0.33 } },
        '14键横屏backspace键size': { width: { percentage: 0.33 } },
        // 18-Key Landscape Sizes
        '18键横屏Row1LeftSize': { width: { percentage: 1/4 } },
        '18键横屏Row1RightSize': { width: { percentage: 1/4 } },
        '18键横屏Row2Size': { width: { percentage: 1/4 } },
        '18键横屏A键size和bounds': {
            size: { width: { percentage: 2/4 } },
            bounds: { width: '1/2', alignment: 'right' },
        },
        '18键横屏L键size和bounds': {
             size: { width: { percentage: 2/4 } },
             bounds: { width: '1/2', alignment: 'left' },
        },
      },
    },
}
