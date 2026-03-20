// 定义回车键前景与 returnKeyType 通知的共用辅助逻辑。
{
  makeForeground(styleFactories, theme, color, fontSize, center, text, extra={})::
    styleFactories.makeTextStyle(
      text,
      fontSize['按键前景文字大小'] - 3,
      if std.objectHas(extra, 'normalColor') then extra.normalColor else color[theme]['按键前景颜色'],
      if std.objectHas(extra, 'highlightColor') then extra.highlightColor else color[theme]['按键前景颜色'],
      if std.objectHas(extra, 'center') then extra.center else center['功能键前景文字偏移']
    ) +
    (if std.objectHas(extra, 'insets') then { insets: extra.insets } else {}),

  makeNotification(returnKeyType, backgroundStyle, foregroundStyle):: {
    notificationType: 'returnKeyType',
    returnKeyType: returnKeyType,
    backgroundStyle: backgroundStyle,
    foregroundStyle: foregroundStyle,
  },
}
