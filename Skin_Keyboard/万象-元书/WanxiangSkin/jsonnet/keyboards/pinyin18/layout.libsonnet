// 定义 18 键拼音的专属基础布局。
local color = import '../../shared/styles/color.libsonnet';
local styleFactories = import '../../shared/styles/styleFactories.libsonnet';

{
  getLandscapePatchRows(): {
    left: [
      ['qButton', 'weButton', 'rtButton', 'yButton'],
      ['aButton', 'sdButton', 'fgButton'],
      ['shiftButton', 'zButton', 'xcButton', 'vButton'],
      ['123Button', 'spaceLeftButton', 'spaceFirstButton'],
    ],
    right: [
      ['yButton', 'uButton', 'ioButton', 'pButton'],
      ['hButton', 'jkButton', 'lButton'],
      ['vButton', 'bnButton', 'mButton', 'backspaceButton'],
      ['spaceSecondButton', 'cn2enButton', 'enterButton'],
    ],
  },

  getKeyboardLayout(theme)::
    local makeKeyboardBackgroundStyle() =
      // 生成键盘区域背景。
      styleFactories.makeGeometryStyle(color[theme]['键盘背景颜色']);
    {
      '竖屏按键尺寸'+: {
        '18键Row1Size': { width: { percentage: 1 / 7 } },
        '18键Row2Size': { width: { percentage: 1 / 7 } },
        '18键A键size和bounds': {
          size: { width: { percentage: 3 / 14 } },
          bounds: { width: '2/3', alignment: 'right' },
        },
        '18键L键size和bounds': {
          size: { width: { percentage: 3 / 14 } },
          bounds: { width: '2/3', alignment: 'left' },
        },
        '18键Row3Size': { width: { percentage: 1 / 7 } },
      },
      '横屏按键尺寸'+: {
        '18键横屏Row1LeftSize': { width: { percentage: 1 / 4 } },
        '18键横屏Row1RightSize': { width: { percentage: 1 / 4 } },
        '18键横屏Row2Size': { width: { percentage: 1 / 4 } },
        '18键横屏A键size和bounds': {
          size: { width: { percentage: 2 / 4 } },
          bounds: { width: '1/2', alignment: 'right' },
        },
        '18键横屏L键size和bounds': {
          size: { width: { percentage: 2 / 4 } },
          bounds: { width: '1/2', alignment: 'left' },
        },
      },
      '竖屏中文18键': {
        keyboardLayout: [
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
      '横屏中文18键': {
        keyboardLayout: [
          {
            HStack: {
              style: 'keyboardStyle',
              subviews: [
                {
                  VStack: {
                    style: 'columnStyle1',
                    subviews: [
                      { HStack: { subviews: [{ Cell: 'qButton' }, { Cell: 'weButton' }, { Cell: 'rtButton' }] } },
                      { HStack: { subviews: [{ Cell: 'aButton' }, { Cell: 'sdButton' }, { Cell: 'fgButton' }] } },
                      { HStack: { subviews: [{ Cell: 'shiftButton' }, { Cell: 'zButton' }, { Cell: 'xcButton' }, { Cell: 'vButton' }] } },
                      { HStack: { subviews: [{ Cell: '123Button' }, { Cell: 'spaceLeftButton' }] } },
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
                      { HStack: { subviews: [{ Cell: 'bnButton' }, { Cell: 'mButton' }, { Cell: 'backspaceButton' }] } },
                      { HStack: { subviews: [{ Cell: 'spaceButton' }, { Cell: 'enterButton' }] } },
                    ],
                  },
                },
              ],
            },
          },
        ],
        keyboardStyle: { size: { height: { percentage: 0.73 } }, insets: { top: 3, bottom: 3, left: 4, right: 4 }, backgroundStyle: 'keyboardBackgroundStyle' },
        keyboardBackgroundStyle: makeKeyboardBackgroundStyle(),
        columnStyle1: { size: { width: '2/5' } },
        columnStyle2: { size: { width: '1/5' } },
        columnStyle3: { size: { width: '2/5' } },
      },
    },
}
