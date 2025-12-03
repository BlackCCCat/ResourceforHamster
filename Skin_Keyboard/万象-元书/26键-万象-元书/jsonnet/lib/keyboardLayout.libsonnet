local color = import 'color.libsonnet';

{
  getKeyboardLayout(theme)::
    {
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
            height: {percentage: 0.17},
          },
          backgroundStyle: 'keyboardBackgroundStyle',
        },
        keyboardStyle: {
          size: {
            height: {percentage: 0.73},
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
            height: {percentage: 0.17},
          },
          backgroundStyle: 'keyboardBackgroundStyle',
        },
        keyboardStyle: {
          size: {
            height: {percentage: 0.73},
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
            height: {percentage: 0.17},
          },
          backgroundStyle: 'keyboardBackgroundStyle',
        },
        keyboardStyle: {
          size: {
            height: {percentage: 0.73},
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
            height: {percentage: 0.17},
          },
          backgroundStyle: 'keyboardBackgroundStyle',
        },
        keyboardStyle: {
          size: {
            height: {percentage: 0.73},
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
}
