local fixSymbol = import '../custom/Custom.libsonnet';
local color = import '../lib/color.libsonnet';
local fontSize = import '../lib/fontSize.libsonnet';

local slideForeground(theme) =
  {
    numericStyle: {
      // backgroundStyle: 'systemButtonBackgroundStyle',
      foregroundStyle: '123ButtonForegroundStyle',
    },
  } + {
    '123ButtonForegroundStyle': {
      buttonStyleType: 'systemImage',
      systemImageName: if fixSymbol.fix_sf_symbol then 'textformat.123' else 'numbers',
      normalColor: color[theme]['按键前景颜色'],
      highlightColor: color[theme]['按键前景颜色'],
      fontSize: fontSize['按键前景sf符号大小'],
      // center: center['功能键前景文字偏移'] { y: 0.5 },
      fontWeight: 'medium',
    },
  } + {
    symbolicStyle: {
      // backgroundStyle: 'systemButtonBackgroundStyle',
      foregroundStyle: 'symbolicButtonForegroundStyle',
    },
  } + {
    symbolicButtonForegroundStyle: {
      buttonStyleType: 'systemImage',
      systemImageName: 'command.circle.fill',
      normalColor: color[theme]['按键前景颜色'],
      highlightColor: color[theme]['按键前景颜色'],
      fontSize: fontSize['按键前景sf符号大小'],
      // center: center['toolbar按键文字偏移'],
      fontWeight: 'medium',
    },
  } + {
    emojiStyle: {
      // backgroundStyle: 'systemButtonBackgroundStyle',
      foregroundStyle: 'emojiButtonForegroundStyle',
    },
  } + {
    emojiButtonForegroundStyle: {
      buttonStyleType: 'systemImage',
      systemImageName: 'face.dashed.fill',
      normalColor: color[theme]['按键前景颜色'],
      highlightColor: color[theme]['按键前景颜色'],
      fontSize: fontSize['按键前景sf符号大小'],
      // center: center['toolbar按键文字偏移'],
      fontWeight: 'medium',
    },
  } + {
    emojisStyle: {
      // backgroundStyle: 'systemButtonBackgroundStyle',
      foregroundStyle: 'emojisButtonForegroundStyle',
    },
  } + {
    emojisButtonForegroundStyle: {
      buttonStyleType: 'systemImage',
      systemImageName: 'face.dashed',
      normalColor: color[theme]['按键前景颜色'],
      highlightColor: color[theme]['按键前景颜色'],
      fontSize: fontSize['按键前景sf符号大小'],
      // center: center['toolbar按键文字偏移'],
      fontWeight: 'medium',
    },
  }
;

{
  slideForeground(theme): slideForeground(theme),
}
