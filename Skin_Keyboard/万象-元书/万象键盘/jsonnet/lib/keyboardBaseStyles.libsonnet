// Shared base styles for alphabetic/system keys.
{
  baseStyles(theme, orientation, Settings, color, animation, hintSymbolsStyles):: {
    alphabeticBackgroundStyle: {
      buttonStyleType: 'geometry',
      insets: if orientation == 'portrait' then Settings.button_insets.portrait else Settings.button_insets.landscape,
      normalColor: color[theme]['字母键背景颜色-普通'],
      highlightColor: color[theme]['字母键背景颜色-高亮'],
      cornerRadius: Settings.cornerRadius,
      normalLowerEdgeColor: color[theme]['底边缘颜色-普通'],
      highlightLowerEdgeColor: color[theme]['底边缘颜色-高亮'],
    },
    systemButtonBackgroundStyle: {
      buttonStyleType: 'geometry',
      insets: if orientation == 'portrait' then Settings.button_insets.portrait else Settings.button_insets.landscape,
      normalColor: color[theme]['功能键背景颜色-普通'],
      highlightColor: color[theme]['功能键背景颜色-高亮'],
      cornerRadius: Settings.cornerRadius,
      normalLowerEdgeColor: color[theme]['底边缘颜色-普通'],
      highlightLowerEdgeColor: color[theme]['底边缘颜色-高亮'],
    },
    enterButtonBlueBackgroundStyle: {
      buttonStyleType: 'geometry',
      normalColor: color[theme]['enter键背景(蓝色)'],
      highlightColor: color[theme]['功能键背景颜色-高亮'],
      cornerRadius: Settings.cornerRadius,
      normalLowerEdgeColor: color[theme]['底边缘颜色-普通'],
      highlightLowerEdgeColor: color[theme]['底边缘颜色-高亮'],
      insets: if orientation == 'portrait' then Settings.button_insets.portrait else Settings.button_insets.landscape,
    },
    ButtonScaleAnimation: animation['26键按键动画'],
    alphabeticHintBackgroundStyle: {
      buttonStyleType: 'geometry',
      normalColor: color[theme]['气泡背景颜色'],
      highlightColor: color[theme]['气泡高亮颜色'],
      cornerRadius: Settings.cornerRadius,
      shadowColor: color[theme]['长按背景阴影颜色'],
      shadowOffset: { x: 0, y: 5 },
    },
    alphabeticHintSymbolsBackgroundStyle: hintSymbolsStyles['长按背景样式'],
    alphabeticHintSymbolsSelectedStyle: hintSymbolsStyles['长按选中背景样式'],
  },
}
