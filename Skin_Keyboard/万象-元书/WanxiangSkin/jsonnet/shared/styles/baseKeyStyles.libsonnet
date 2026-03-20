// 定义 26 键与 14/18 键共用的基础按键样式。
local styleFactories = import 'styleFactories.libsonnet';

{
  baseStyles(theme, orientation, Settings, color, animation, hintSymbolsStyles)::
    local makeButtonBackground(normalKey, highlightKey) =
      // 生成功能键、字母键等共用按键背景。
      styleFactories.makeGeometryStyle(color[theme][normalKey], {
        insets: if orientation == 'portrait' then Settings.button_insets.portrait else Settings.button_insets.landscape,
        highlightColor: color[theme][highlightKey],
        cornerRadius: Settings.cornerRadius,
        normalLowerEdgeColor: color[theme]['底边缘颜色-普通'],
        highlightLowerEdgeColor: color[theme]['底边缘颜色-高亮'],
      });
    local makeHintBackground() =
      // 生成长按气泡背景。
      styleFactories.makeGeometryStyle(color[theme]['气泡背景颜色'], {
        highlightColor: color[theme]['气泡高亮颜色'],
        cornerRadius: Settings.cornerRadius,
        shadowColor: color[theme]['长按背景阴影颜色'],
        shadowOffset: { x: 0, y: 5 },
      });
    {
    alphabeticBackgroundStyle: makeButtonBackground('字母键背景颜色-普通', '字母键背景颜色-高亮'),
    systemButtonBackgroundStyle: makeButtonBackground('功能键背景颜色-普通', '功能键背景颜色-高亮'),
    enterButtonBlueBackgroundStyle: makeButtonBackground('enter键背景(蓝色)', '功能键背景颜色-高亮'),
    ButtonScaleAnimation: animation['26键按键动画'],
    alphabeticHintBackgroundStyle: makeHintBackground(),
    alphabeticHintSymbolsBackgroundStyle: hintSymbolsStyles['长按背景样式'],
    alphabeticHintSymbolsSelectedStyle: hintSymbolsStyles['长按选中背景样式'],
  },
}
