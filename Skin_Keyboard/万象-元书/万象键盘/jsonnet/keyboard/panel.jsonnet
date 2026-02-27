local Settings = import '../Custom.libsonnet';
local center = import '../lib/center.libsonnet';
local color = import '../lib/color.libsonnet';
local fontSize = import '../lib/fontSize.libsonnet';
local theme = std.extVar('theme');

// key: 按键名称
local createButton(key, action, sf_symbol, text, theme) = {
  [key + 'Button']: {
    size: {
      height: '1/2',
    },
    backgroundStyle: 'ButtonBackgroundStyle',
    foregroundStyle: [
      key + 'ButtonForegroundStyle',
      key + 'ButtonForegroundStyle2',
    ],
    action: action,
  },
  [key + 'ButtonForegroundStyle']: {
    buttonStyleType: 'systemImage',
    systemImageName: sf_symbol,
    fontSize: fontSize['panel按键前景sf符号大小'],
    normalColor: color[theme]['按键前景颜色'],
    highlightColor: color[theme]['按键前景颜色'],
    center: center['panel键盘按键sf符号前景偏移'],
  },
  [key + 'ButtonForegroundStyle2']: {
    buttonStyleType: 'text',
    text: text,
    fontSize: fontSize['panel按键前景文字大小'],
    normalColor: color[theme]['按键前景颜色'],
    highlightColor: color[theme]['按键前景颜色'],
    center: center['panel键盘按键文字前景偏移'],
  },
};
local keyboard(theme, orientation) =
  createButton(
    'KeyboardSettings',
    { openURL: 'hamster3://com.ihsiao.apps.hamster3/keyboardSettings' },
    'gearshape.fill',
    '键盘设置',
    theme
  ) +

  createButton(
    'Switcher',
    { shortcutCommand: '#RimeSwitcher' },
    'filemenu.and.selection',
    '方案开关',
    theme
  ) +
  createButton(
    'Skin',
    { openURL: 'hamster3://com.ihsiao.apps.hamster3/finder?action=openAppFile&fileURL=Skins/万象键盘/jsonnet/Custom.libsonnet' },
    'paintpalette.fill',
    '皮肤调整',
    theme
  ) +
  createButton(
    'Finder',
    { openURL: 'hamster3://com.ihsiao.apps.hamster3/finder' },
    'folder',
    '文件管理',
    theme
  ) +
  createButton(
    'toogleEmbedded',
    { shortcut: '#toggleEmbeddedInputMode' },
    'square.and.pencil',
    '内嵌开关',
    theme
  ) +
  createButton(
    'Performance',
    { shortcut: '#keyboardPerformance' },
    'gauge.with.dots.needle.bottom.50percent',
    '内存占用',
    theme
  ) +
  createButton(
    'Script',
    { openURL: 'hamster3://com.ihsiao.apps.hamster3/script' },
    'apple.terminal.fill',
    '脚本管理',
    theme
  ) +
  createButton(
    'InputSchema',
    { openURL: 'hamster3://com.ihsiao.apps.hamster3/inputSchema' },
    'switch.2',
    '方案管理',
    theme
  ) +
  {
    keyboardLayout: [
      {
        HStack: {
          subviews: [
            { Cell: 'KeyboardSettingsButton' },
            { Cell: 'SwitcherButton' },
            { Cell: 'FinderButton' },
            { Cell: 'toogleEmbeddedButton' },
          ],
        },
      },
      {
        HStack: {
          subviews: [
            { Cell: 'SkinButton' },
            { Cell: 'ScriptButton' },
            { Cell: 'InputSchemaButton' },
            { Cell: 'PerformanceButton' },
          ],
        },
      },
    ],
    floatTargetScale:
      if orientation == 'portrait' then
        { x: 0.75, y: 0.8 }
      else
        { x: 0.45, y: 0.8 }
    ,
    // floatKeyboardAlpha: 0.7,
    keyboardStyle: {
      insets: if orientation == 'portrait' then { top: 50, left: 24, bottom: 50, right: 24 }
      else { top: 20, left: 24, bottom: 20, right: 24 },
      backgroundStyle: 'keyboardBackgroundStyle',
    },
    keyboardBackgroundStyle: {
      // buttonStyleType: 'fileImage',
      // normalImage: {
      //   file: 'float_back',
      //   image: 'IMG1',
      // },
      // highlightImage: {
      //   file: 'float_back',
      //   image: 'IMG1',
      // },
      type: 'original',
      normalColor: color[theme]['键盘背景颜色'],
      cornerRadius: Settings.cornerRadius,
      normalShadowColor: '00000000',
      shadowRadius: 7,
    },

    ButtonBackgroundStyle: {
      buttonStyleType: 'geometry',
      insets: { top: 15, left: 3, bottom: 10, right: 3 },
      normalColor: color[theme]['字母键背景颜色-普通'],
      highlightColor: color[theme]['字母键背景颜色-高亮'],
      cornerRadius: Settings.cornerRadius,
      normalLowerEdgeColor: color[theme]['底边缘颜色-普通'],
      highlightLowerEdgeColor: color[theme]['底边缘颜色-高亮'],
    },
    ButtonBackgroundAnimation: [
      {
        type: 'bounds',
        duration: 60,
        repeatCount: 1,
        fromScale: 1,
        toScale: 0.87,
      },
      {
        type: 'bounds',
        duration: 80,
        repeatCount: 1,
        fromScale: 0.87,
        toScale: 1,
      },
    ],
    ButtonForegroundAnimation: [
      {
        type: 'bounds',
        duration: 60,
        repeatCount: 1,
        fromScale: 1,
        toScale: 0.82,
      },
      {
        type: 'bounds',
        duration: 80,
        repeatCount: 1,
        fromScale: 0.82,
        toScale: 1,
      },
    ],
  };

{
  new(theme, orientation):
    keyboard(theme, orientation),
}
