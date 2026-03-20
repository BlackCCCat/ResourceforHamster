// 定义滑动切换按钮的共享前景样式。
local Settings = import '../../Custom.libsonnet';
local color = import 'color.libsonnet';
local fontSize = import 'fontSize.libsonnet';

local makeSlideSystemImageForegroundStyle(theme, systemImageName) = {
  buttonStyleType: 'systemImage',
  systemImageName: systemImageName,
  normalColor: color[theme]['按键前景颜色'],
  highlightColor: color[theme]['按键前景颜色'],
  fontSize: fontSize['按键前景sf符号大小'],
  fontWeight: 'medium',
};

local slideButtonStyles(theme) =
  {
    numericStyle: {
      // backgroundStyle: 'systemButtonBackgroundStyle',
      foregroundStyle: '123ButtonForegroundStyle',
    },
  } + {
    // 数字键盘入口
    '123ButtonForegroundStyle': makeSlideSystemImageForegroundStyle(theme, if Settings.fix_sf_symbol then 'textformat.123' else 'numbers'),
  } + {
    symbolicStyle: {
      // backgroundStyle: 'systemButtonBackgroundStyle',
      foregroundStyle: 'symbolicButtonForegroundStyle',
    },
  } + {
    // 符号键盘入口
    symbolicButtonForegroundStyle: makeSlideSystemImageForegroundStyle(theme, 'command.circle.fill'),
  } + {
    emojiStyle: {
      // backgroundStyle: 'systemButtonBackgroundStyle',
      foregroundStyle: 'emojiButtonForegroundStyle',
    },
  } + {
    // Emoji 键盘入口
    emojiButtonForegroundStyle: makeSlideSystemImageForegroundStyle(theme, 'face.dashed.fill'),
  } + {
    emojisStyle: {
      // backgroundStyle: 'systemButtonBackgroundStyle',
      foregroundStyle: 'emojisButtonForegroundStyle',
    },
  } + {
    // 次级 Emoji 入口
    emojisButtonForegroundStyle: makeSlideSystemImageForegroundStyle(theme, 'face.dashed'),
  }
;

{
  slideButtonStyles(theme): slideButtonStyles(theme),
}
