// 定义「布局切换」浮动面板：按键盘键数直接跳转到对应拼音布局。
// 结构与 floatPanel 保持一致（符号前景 + 文字前景 + geometry 背景），只替换按键与动作。
local Settings = import '../../Custom.libsonnet';
local appearance = import '../../design/appearance.libsonnet';
local center = appearance.center;
local color = appearance.color;
local fontSize = appearance.fontSize;
local styleFactories = import '../../design/styleFactories.libsonnet';

// 六种布局的方案名统一从 Custom.keyboard_layout_schemas 读取。
local layouts = [
  { key: 'Switch9', slot: 'pinyin9', icon: '9.square.fill', label: '9键', number: '9' },
  { key: 'Switch14', slot: 'pinyin14', icon: '14.square.fill', label: '14键', number: '14' },
  { key: 'Switch17', slot: 'pinyin17', icon: '17.square.fill', label: '17键', number: '17' },
  { key: 'Switch18', slot: 'pinyin18', icon: '18.square.fill', label: '18键', number: '18' },
  { key: 'Switch26', slot: 'pinyin26', icon: '26.square.fill', label: '26键', number: '26' },
  { key: 'Switch27', slot: 'pinyin27', icon: '27.square.fill', label: '27键', number: '27' },
];

local switchAction(layout) =
  local schemas = Settings.keyboard_layout_schemas;
  if std.objectHas(schemas, layout.number) && std.type(schemas[layout.number]) == 'string' && schemas[layout.number] != '' then
    { combine: [{ keyboardType: layout.slot }, { switchRimeSchema: schemas[layout.number] }] }
  else
    { keyboardType: layout.slot };

// key: 按键名称，结构与 floatPanel 的 createButton 完全一致。
local createButton(key, action, sf_symbol, text, theme, size={ height: '1/2' }) = {
  [key + 'Button']: {
    size: size,
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
  local makePanelButtonBackgroundStyle() =
    // 生成面板按键的通用 geometry 背景。
    styleFactories.makeGeometryStyle(color[theme]['字母键背景颜色-普通'], {
      insets: { top: 5, left: 3, bottom: 5, right: 3 },
      highlightColor: color[theme]['字母键背景颜色-高亮'],
      cornerRadius: Settings.cornerRadius,
      normalLowerEdgeColor: color[theme]['底边缘颜色-普通'],
      highlightLowerEdgeColor: color[theme]['底边缘颜色-高亮'],
    });
  std.foldl(
    function(acc, layout)
      acc + createButton(layout.key, switchAction(layout), layout.icon, layout.label, theme),
    layouts,
    {}
  ) + {
    keyboardLayout: [
      {
        HStack: {
          subviews: [
            { Cell: layouts[0].key + 'Button' },
            { Cell: layouts[1].key + 'Button' },
            { Cell: layouts[2].key + 'Button' },
          ],
        },
      },
      {
        HStack: {
          subviews: [
            { Cell: layouts[3].key + 'Button' },
            { Cell: layouts[4].key + 'Button' },
            { Cell: layouts[5].key + 'Button' },
          ],
        },
      },
    ],
    floatTargetScale:
      if orientation == 'portrait' then
        { x: 0.8, y: 0.55 }
      else
        { x: 0.45, y: 0.65 },
    keyboardStyle: {
      insets: { top: 1, left: 1, bottom: 1, right: 1 },
      backgroundStyle: 'keyboardBackgroundStyle',
    },
    keyboardBackgroundStyle: {
      type: 'original',
      normalColor: color[theme]['键盘背景颜色'],
      cornerRadius: Settings.cornerRadius,
      normalShadowColor: '00000000',
      shadowRadius: 7,
    },
    ButtonBackgroundStyle: makePanelButtonBackgroundStyle(),
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
