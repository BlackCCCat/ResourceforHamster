// 定义「乱序 17 键」拼音的专属基础布局。
local appearance = import '../../../design/appearance.libsonnet';
local color = appearance.color;
local styleFactories = import '../../../design/styleFactories.libsonnet';

{
  getLandscapePatchRows(): {
    left: [
      ['hpButton', 'sButton', 'zButton'],
      ['lButton', 'dButton', 'yButton'],
      ['cButton', 'qButton', 'gButton'],
      ['123Button', 'spaceLeftButton', 'spaceFirstButton'],
    ],
    right: [
      ['bButton', 'xButton', 'msButton'],
      ['wzButton', 'jkButton', 'nrButton'],
      ['fcButton', 'tButton', 'backspaceButton'],
      ['spaceSecondButton', 'cn2enButton', 'enterButton'],
    ],
  },

  getKeyboardLayout(theme)::
    local makeKeyboardBackgroundStyle() =
      // 生成键盘区域背景。
      styleFactories.makeGeometryStyle(color[theme]['键盘背景颜色']);
    {
      '竖屏按键尺寸'+: {
        '17键Row1Size': { width: { percentage: 1/6 } },
        '17键Row2Size': { width: { percentage: 1/6 } },
        '17键Row3Size': { width: { percentage: 1/6 } },
        '17键L键size和bounds': {
          size: { width: { percentage: 1/6 } },
        },
        '17键Nr键size和bounds': {
          size: { width: { percentage: 1/6 } },
        },
      },
      '横屏按键尺寸'+: {
        '17键横屏Row1Size': { width: { percentage: 1/3 } },
        '17键横屏shift键size': { width: { percentage: 1/3 } },
        '17键横屏backspace键size': { width: { percentage: 1/3 } },
      },
      '竖屏中文17键': {
        keyboardLayout: [
          {
            HStack: {
              style: 'keyboardStyle',
              subviews: [
                {
                  HStack: {
                    subviews: [
                      { Cell: 'hpButton' },
                      { Cell: 'sButton' },
                      { Cell: 'zButton' },
                      { Cell: 'bButton' },
                      { Cell: 'xButton' },
                      { Cell: 'msButton' },
                    ],
                  },
                },
                {
                  HStack: {
                    subviews: [
                      { Cell: 'lButton' },
                      { Cell: 'dButton' },
                      { Cell: 'yButton' },
                      { Cell: 'wzButton' },
                      { Cell: 'jkButton' },
                      { Cell: 'nrButton' },
                    ],
                  },
                },
                {
                  HStack: {
                    subviews: [
                      { Cell: 'cButton' },
                      { Cell: 'qButton' },
                      { Cell: 'gButton' },
                      { Cell: 'fcButton' },
                      { Cell: 'tButton' },
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
      '横屏中文17键': {
        keyboardLayout: [
          {
            HStack: {
              style: 'keyboardStyle',
              subviews: [
                {
                  VStack: {
                    style: 'columnStyle1',
                    subviews: [
                      { HStack: { subviews: [{ Cell: 'hpButton' }, { Cell: 'sButton' }, { Cell: 'zButton' }] } },
                      { HStack: { subviews: [{ Cell: 'lButton' }, { Cell: 'dButton' }, { Cell: 'yButton' }] } },
                      { HStack: { subviews: [{ Cell: 'cButton' }, { Cell: 'qButton' }, { Cell: 'gButton' }] } },
                      { HStack: { subviews: [{ Cell: '123Button' }, { Cell: 'spaceLeftButton' }, { Cell: 'spaceButtonLeft' }] } },
                    ],
                  },
                },
                { VStack: { style: 'columnStyle2' } },
                {
                  VStack: {
                    style: 'columnStyle3',
                    subviews: [
                      { HStack: { subviews: [{ Cell: 'bButton' }, { Cell: 'xButton' }, { Cell: 'msButton' }] } },
                      { HStack: { subviews: [{ Cell: 'wzButton' }, { Cell: 'jkButton' }, { Cell: 'nrButton' }] } },
                      { HStack: { subviews: [{ Cell: 'fcButton' }, { Cell: 'tButton' }, { Cell: 'backspaceButton' }] } },
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
