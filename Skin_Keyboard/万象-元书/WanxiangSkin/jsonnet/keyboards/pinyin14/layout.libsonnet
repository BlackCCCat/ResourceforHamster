// 定义 14 键拼音的专属基础布局。
local color = import '../../shared/styles/color.libsonnet';
local styleFactories = import '../../shared/styles/styleFactories.libsonnet';

{
  getLandscapePatchRows(): {
    left: [
      ['qwButton', 'erButton', 'tyButton'],
      ['asButton', 'dfButton', 'ghButton'],
      ['shiftButton', 'zxButton', 'cvButton'],
      ['123Button', 'spaceLeftButton', 'spaceFirstButton'],
    ],
    right: [
      ['tyButton', 'uiButton', 'opButton'],
      ['ghButton', 'jkButton', 'lButton'],
      ['bnButton', 'mButton', 'backspaceButton'],
      ['spaceSecondButton', 'cn2enButton', 'enterButton'],
    ],
  },

  getKeyboardLayout(theme)::
    local makeKeyboardBackgroundStyle() =
      // 生成键盘区域背景。
      styleFactories.makeGeometryStyle(color[theme]['键盘背景颜色']);
    {
      '竖屏按键尺寸'+: {
        '14键Row1Size': { width: { percentage: 0.2 } },
        '14键Row2Size': { width: { percentage: 0.2 } },
        '14键Row3Size': { width: { percentage: 0.175 } },
        '14键As键size和bounds': {
          size: { width: { percentage: 0.2 } },
        },
        '14键L键size和bounds': {
          size: { width: { percentage: 0.2 } },
        },
      },
      '横屏按键尺寸'+: {
        '14键横屏Row1Size': { width: { percentage: 0.33 } },
        '14键横屏As键size和bounds': {
          size: { width: { percentage: 0.33 } },
        },
        '14键横屏L键size和bounds': {
          size: { width: { percentage: 0.33 } },
        },
        '14键横屏shift键size': { width: { percentage: 0.33 } },
        '14键横屏backspace键size': { width: { percentage: 0.33 } },
      },
      '竖屏中文14键': {
        keyboardLayout: [
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
      '横屏中文14键': {
        keyboardLayout: [
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
                      { HStack: { subviews: [{ Cell: '123Button' }, { Cell: 'spaceLeftButton' }, { Cell: 'spaceButtonLeft' }] } },
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
