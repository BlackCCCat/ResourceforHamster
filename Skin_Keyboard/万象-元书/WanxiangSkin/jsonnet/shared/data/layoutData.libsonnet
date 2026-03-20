// 定义不含功能行时的共享基础布局数据。
local color = import '../styles/color.libsonnet';

{
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
}
