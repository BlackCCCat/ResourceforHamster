// 汇总全皮肤共用的颜色、字号、偏移、动效和几何度量。
{
  // 按钮动效预设。
  animation: (
    {
      // 缩放动画
      '26键按键动画':
        {
          animationType: 'scale',
          isAutoReverse: true,
          scale: 0.87,
          pressDuration: 60,
          releaseDuration: 80,
        },
    }


    // {
    //   // 缩放动画
    //   '26键按键动画':
    //     {
    //       animationType: 'cartoon',
    //       fps: 30,  // 默认60
    //       targetScale: 0.2,
    //       zPosition: 'above',  // above or below
    //       center: {
    //         y: 0.5,
    //       },
    //       images: [
    //         std.format('ax_%02d.png', i)
    //         for i in std.range(1, 24)
    //       ],
    //     },
    // }
  ),

  // 前景元素偏移预设。
  center: (
    {
      // 26键
      '上划文字偏移': {
        x: 0.25,
        y: 0.28,
      },
      '下划文字偏移': {
        x: 0.75,
        y: 0.28,
      },
      '上划sf符号偏移': {
        x: 0.25,
        y: 0.68,
      },
      '下划sf符号偏移': {
        x: 0.75,
        y: 0.68,
      },

      // 气泡
      '长按气泡文字偏移': {
        x: 0.5,
        y: 0.8,
      },
      '长按气泡sf符号偏移': {
        x: 0.5,
        y: 0.5,
      },
      '划动气泡文字偏移': {
        x: 0.5,
        y: 0.6,
      },
      '划动气泡sf符号偏移': {
        x: 0.5,
        y: 0.5,
      },

      '26键中文前景偏移': {
        x: 0.5,
        y: 0.54,
      },
      '功能键前景文字偏移': {  // 中英文在偏移上有些许不同
        x: 0.5,
        y: 0.5,  // 0.47
      },
      '中文九键字符前景偏移': {
        x: 0.5,
        y: 0.5,
      },
      '中文九键下划字符前景偏移': {
        x: 0.5,
        y: 0.8,
      },
      '数字键盘数字前景偏移': {
        x: 0.5,
        y: 0.5,
      },

      '26键英文小写前景偏移': self['26键中文前景偏移'],  // 小写字母默认复用中文字母偏移。

      // 数字键盘
      '数字键盘上划文字偏移': {
        x: 0.18,
        y: 0.28,
      },
      '数字键盘下划文字偏移': {
        x: 0.82,
        y: 0.28,
      },
      '数字键盘上划sf符号偏移': {
        x: 0.18,
        y: 0.28,
      },
      '数字键盘下划sf符号偏移': {
        x: 0.82,
        y: 0.28,
      },

      // toolbar部分偏移
      'toolbar按键偏移': {
        x: 0.5,
        y: 0.55,
      },

      'toolbar按键文字偏移': {
        x: 0.5,
        // y: 0.8,
      },
      'toolbar按键sf符号偏移': {
        x: 0.5,
        y: 0.53,
      },
      // panel浮动键盘
      'panel键盘按键文字前景偏移': {
        y: 0.7,
      },
      'panel键盘按键sf符号前景偏移': {
        y: 0.4,
      },

      // 缩放
      '26键中文前景缩放': 0.95,  // 英文大写前景也用这个
      '26键英文小写前景缩放': 1,  // 同上面小写前景偏移
      'toolbar按键缩放': 0.52,
      '数字键盘前景缩放': 1,

    }
  ),

  // 浅色与深色主题颜色令牌。
  color: (
    local Settings = import '../Custom.libsonnet';

    local base_light = {
      '字母键背景颜色-普通': 'FFFFFFCC',
      '字母键背景颜色-高亮': 'ABB0BACC',

      '功能键背景颜色-普通': '979faf66',  // 5D5E664A
      '功能键背景颜色-高亮': 'FFFFFFCC',

      'enter键背景(蓝色)': '1162ff',

      '气泡背景颜色': 'FFFFFF',
      '气泡边缘颜色': '606060',
      '气泡高亮颜色': '0279FE',

      '底边缘颜色-普通': '88898D',
      '底边缘颜色-高亮': '89898B',

      '长按选中字体颜色': 'FFFFFF',
      '长按非选中字体颜色': '000000',
      '长按选中背景颜色': '007AFF',
      '长按背景阴影颜色': '797B7E',
      '长按背景颜色': 'FFFFFFCC',

      '候选字体选中字体颜色': '000000',
      '候选字体未选中字体颜色': '000000',
      '选中候选背景颜色': 'FFFFFF',

      'toolbar按键颜色': '000000',
      '划动字符颜色': '5E686F',
      '按下气泡文字颜色': '2E2E2E',

      // 数字键盘颜色
      'collection前景颜色': '000000',

      // 符号键盘颜色
      '列表选中字体颜色': '000000',
      '列表未选中字体颜色': '000000',
      '符号键盘左侧collection背景颜色': '979faf80',
      '符号键盘左侧collection背景下边缘颜色': '88898D',
      '符号键盘右侧collection背景颜色': 'ffffff',
      '符号键盘右侧collection背景下边缘颜色': '88898D40',
      '按键边缘颜色': 'C7C7CC',

      '按键前景颜色': '000000',


      // 全部键盘的背景色, 默认透明,自行设置
      '键盘背景颜色': 'D0D3DA03',  // 采用 99% 透明度，保留非零背景色
    };

    local base_dark = {
      '字母键背景颜色-普通': 'D1D1D199',
      '字母键背景颜色-高亮': 'D1D1D640',

      '功能键背景颜色-普通': 'D1D1D640',
      '功能键背景颜色-高亮': 'D1D1D673',

      'enter键背景(蓝色)': '1162ff',

      '气泡背景颜色': '6B6B6B',
      '气泡边缘颜色': '606060',
      '气泡高亮颜色': '0279FE',

      '底边缘颜色-普通': '1E1E1E',
      '底边缘颜色-高亮': '1D1D1D',

      '长按选中字体颜色': 'FFFFFF',
      '长按非选中字体颜色': 'FFFFFF',
      '长按选中背景颜色': '007AFF',
      '长按背景阴影颜色': '00000050',
      '长按背景颜色': '6B6B6B',

      '候选字体选中字体颜色': 'ffffff',
      '候选字体未选中字体颜色': 'ffffff',
      '选中候选背景颜色': 'D1D1D199',

      'toolbar按键颜色': 'E5E5E5',
      '划动字符颜色': 'b6b7b9',
      '按下气泡文字颜色': 'E6E6E6',

      // 数字键盘颜色
      'collection前景颜色': 'E4EAF0',

      // 符号键盘颜色
      '列表选中字体颜色': 'FFFFFF',
      '列表未选中字体颜色': 'FFFFFF',
      '符号键盘左侧collection背景颜色': 'D1D1D624',
      '符号键盘左侧collection背景下边缘颜色': '1E1E1E',
      '符号键盘右侧collection背景颜色': 'D1D1D165',
      '符号键盘右侧collection背景下边缘颜色': '343941',
      '按键边缘颜色': 'C7C7CC',

      '按键前景颜色': 'FFFFFF',

      // 全部键盘的背景色, 默认透明,自行设置
      '键盘背景颜色': '47474703',  // 采用 99% 透明度，保留非零背景色
    };

    // iOS26 风格覆盖：Light 模式统一为白色（字母键风格），Dark 模式统一为灰色（功能键风格）
    local ios26_light = base_light {
      '字母键背景颜色-普通': 'FFFFFF',
      '字母键背景颜色-高亮': 'ABB0BA99',
      '功能键背景颜色-普通': 'FFFFFF',
      '功能键背景颜色-高亮': 'ABB0BA99',
      '符号键盘左侧collection背景颜色': 'FFFFFF',
      '符号键盘左侧collection背景下边缘颜色': '00000000',
      '气泡背景颜色': base_light['气泡背景颜色'],
      '底边缘颜色-普通': '00000000',
      '底边缘颜色-高亮': '00000000',
      '键盘背景颜色': '00000000',
    };

    local ios26_dark = base_dark {
      '字母键背景颜色-普通': base_dark['功能键背景颜色-普通'],
      '字母键背景颜色-高亮': base_dark['功能键背景颜色-高亮'],
      '符号键盘左侧collection背景颜色': base_dark['功能键背景颜色-普通'],
      '符号键盘左侧collection背景下边缘颜色': base_dark['符号键盘左侧collection背景下边缘颜色'],
      '气泡背景颜色': base_dark['气泡背景颜色'],
    };

    {
      light: if Settings.ios26_style then ios26_light else base_light,
      dark: if Settings.ios26_style then ios26_dark else base_dark,
    }
  ),

  // 键盘元素字号令牌。
  fontSize: (
    local Settings = import '../Custom.libsonnet';
    local customFontSize = if std.objectHas(Settings, 'font_size_config') then Settings.font_size_config else {};

    {
      '未展开候选字体选中字体大小': 20,
      '未展开comment字体大小': 10,
      '展开候选字体选中字体大小': 20,
      '展开comment字体大小': 10,
      'preedit区字体大小': 13,

      '上划文字大小': 9,
      '下划文字大小': 9,
      '划动气泡前景文字大小': 28,
      '划动气泡前景sf符号大小': 28,

      '长按气泡文字大小': 20,
      '长按气泡sf符号大小': 12,

      '按键前景文字大小': 20,
      '26键字母前景文字大小': if std.objectHas(customFontSize, 'pinyin_26_letter_font_size') then customFontSize.pinyin_26_letter_font_size else 20,
      '14/18键字母前景文字大小': if std.objectHas(customFontSize, 'pinyin_14_18_letter_font_size') then customFontSize.pinyin_14_18_letter_font_size else 20,
      '按键前景sf符号大小': 15,
      '功能按键sf符号大小': 17,

      'toolbar按键前景sf符号大小': 18,
      'toolbar按键前景文字大小': 13,

      // 数字键盘
      'collection前景字体大小': 18,
      '数字键盘数字前景字体大小': if std.objectHas(customFontSize, 'numeric_digit_font_size') then customFontSize.numeric_digit_font_size else 20,

      // 中文九键
      '中文九键字符键前景文字大小': if std.objectHas(customFontSize, 'pinyin_9_letter_font_size') then customFontSize.pinyin_9_letter_font_size else 15,
      '中文九键字根前景文字大小': 10,
      '中文九键划动文字大小': 10,

      // 符号键盘
      '符号键盘左侧collection前景字体大小': 13,
      '符号键盘右侧collection前景字体大小': 16,

      // panel键盘
      'panel按键前景文字大小': 12,
      'panel按键前景sf符号大小': 20,
    }
  ),

  // 键盘高度与共享几何常量。
  others: (
    local Settings = import '../Custom.libsonnet';

    local fromVh(s) =
      local num = std.substr(s, 0, std.length(s) - 2);
      std.parseJson(num);

    local sumVh(arr) = (
      local sum = std.foldl(
        function(acc, v) acc + fromVh(v),
        arr,
        0
      );
      std.toString(sum) + 'vh'
    );

    local sumHeights(arr) = (
      if std.length(arr) == 0 then
        null  // 空数组返回 null（或自定义默认值）
      else if std.type(arr[0]) == 'string' && std.endsWith(arr[0], 'vh') then
        sumVh(arr)
      else
        std.sum(arr)
    );
    // 兼容数值高度与 vh 字符串的键盘高度求和函数。

    {
      // 杂项设置
      // 键盘高度统一使用数值单位
      '竖屏': {
        'preedit高度': 15,
        'toolbar高度': Settings.toolbar_config.toolbar_height,
        'keyboard高度': 240,
        '键盘总高度': sumHeights([
          self['preedit高度'],
          self['toolbar高度'],
          self['keyboard高度'],
        ]),
      },
      '横屏': {
        'preedit高度': 15,
        'toolbar高度': Settings.toolbar_config.toolbar_height,
        'keyboard高度': 205,
        '键盘总高度': sumHeights([
          self['preedit高度'],
          self['toolbar高度'],
          self['keyboard高度'],
        ]),
      },

    }
  ),

}
