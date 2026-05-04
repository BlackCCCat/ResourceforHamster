// 定义滑动标签与提示气泡的共享样式。
local Settings = import '../../Custom.libsonnet';

local center = import '../styles/center.libsonnet';
local color = import '../styles/color.libsonnet';
local fontSize = import '../styles/fontSize.libsonnet';
local styleFactories = import 'styleFactories.libsonnet';

local swipeStyle(center, colorMap, fontSizeConfig, fs=null) = {
  local makeSwipeTextStyle(fontSizeValue) =
    // 生成滑动标签的文字前景，不覆盖外层传入的 text。
    {
      buttonStyleType: 'text',
      fontSize: fontSizeValue,
      normalColor: colorMap['划动字符颜色'],
      highlightColor: colorMap['划动字符颜色'],
      center: center,
    },
  local makeSwipeSystemImageStyle(fontSizeValue) =
    // 生成滑动标签的系统图标前景，不覆盖外层传入的 systemImageName。
    {
      buttonStyleType: 'systemImage',
      fontSize: fontSizeValue,
      normalColor: colorMap['划动字符颜色'],
      highlightColor: colorMap['划动字符颜色'],
      center: center,
    },
  local makeBubbleTextStyle(fontSizeValue) =
    // 生成滑动气泡的文字前景，不覆盖外层传入的 text。
    {
      buttonStyleType: 'text',
      fontSize: fontSizeValue,
      normalColor: colorMap['按下气泡文字颜色'],
      highlightColor: colorMap['按下气泡文字颜色'],
      center: {},
    },
  local makeBubbleSystemImageStyle(fontSizeValue) =
    // 生成滑动气泡的系统图标前景，不覆盖外层传入的 systemImageName。
    {
      buttonStyleType: 'systemImage',
      fontSize: fontSizeValue,
      normalColor: colorMap['按下气泡文字颜色'],
      highlightColor: colorMap['按下气泡文字颜色'],
      center: {},
    },
  '上划样式': {
    '文字样式': makeSwipeTextStyle(if fs == null then fontSizeConfig['上划文字大小'] else fs),
    'sf符号样式': makeSwipeSystemImageStyle(if fs == null then fontSizeConfig['上划文字大小'] else fs),
  },
  '下划样式': {
    '文字样式': makeSwipeTextStyle(if fs == null then fontSizeConfig['下划文字大小'] else fs),
    'sf符号样式': makeSwipeSystemImageStyle(if fs == null then fontSizeConfig['下划文字大小'] else fs),
  },
  '上划气泡前景样式': makeBubbleTextStyle(fontSizeConfig['划动气泡前景文字大小']),
  '上划气泡sf符号前景样式': makeBubbleSystemImageStyle(fontSizeConfig['划动气泡前景sf符号大小']),
  '下划气泡前景样式': makeBubbleTextStyle(fontSizeConfig['划动气泡前景文字大小']),
  '下划气泡sf符号前景样式': makeBubbleSystemImageStyle(fontSizeConfig['划动气泡前景sf符号大小']),
  '按下气泡样式': makeBubbleTextStyle(fontSizeConfig['划动气泡前景文字大小']),
};

local swipeDisplay(o) = {
  [if std.objectHas(o.label, 'text') then 'text']: o.label.text,
  [if std.objectHas(o.label, 'systemImageName') then 'systemImageName']: o.label.systemImageName,
};

local swipeStyleName(type, key, suffix) =
  if type == 'number' then 'number' + key + suffix else key + suffix;

local directionalForeground(key, o, type, suffix, styleGroupName, textStyleName, imageStyleName, textCenter, imageCenter, colorMap, fontSizeConfig) =
  if !std.objectHas(o, 'label') then {}
  else {
    [swipeStyleName(type, key, suffix)]:
      swipeDisplay(o) +
      if std.objectHas(o.label, 'text') then
        swipeStyle(
          if std.objectHas(o, 'center') then o.center else textCenter,
          colorMap,
          fontSizeConfig,
          if std.objectHas(o, 'fontSize') then o.fontSize else null
        )[styleGroupName][textStyleName]
      else
        swipeStyle(
          if std.objectHas(o, 'center') then o.center else imageCenter,
          colorMap,
          fontSizeConfig,
          if std.objectHas(o, 'fontSize') then o.fontSize else null
        )[styleGroupName][imageStyleName],
  };

local hintBubbleForeground(key, o, type, suffix, textStyleName, imageStyleName, hintTextCenter, hintImageCenter, colorMap, fontSizeConfig) =
  if !std.objectHas(o, 'label') then {}
  else {
    [swipeStyleName(type, key, suffix)]:
      swipeDisplay(o) +
      if std.objectHas(o.label, 'text') then
        swipeStyle(hintTextCenter, colorMap, fontSizeConfig)[textStyleName]
      else
        swipeStyle(hintImageCenter, colorMap, fontSizeConfig)[imageStyleName],
  };

local hintForeground(key, Settings, colorMap, fontSizeConfig, hintTextCenter) = {
  [key + 'ButtonHintForegroundStyle']:
    { text: if Settings.is_letter_capital then std.asciiUpper(key) else key } +
    swipeStyle(hintTextCenter, colorMap, fontSizeConfig)['按下气泡样式'],
};

local finalStyles(type, theme, swipe_up, swipe_down, fontSizeConfig, swipe_up_foreground, swipe_down_foreground, swipe_up_hint, swipe_down_hint) =
  local colorMap = color[theme];
  local centerUpText = if type == 'number' then center['数字键盘上划文字偏移'] else center['上划文字偏移'];
  local centerUpImage = if type == 'number' then center['数字键盘上划sf符号偏移'] else center['上划文字偏移'];
  local centerDownText = if type == 'number' then center['数字键盘下划文字偏移'] else center['下划文字偏移'];
  local centerDownImage = if type == 'number' then center['数字键盘下划sf符号偏移'] else center['下划文字偏移'];
  local hintTextCenter = center['划动气泡文字偏移'];
  local hintImageCenter = center['划动气泡sf符号偏移'];
  {
    style: std.foldl(
             function(acc, key)
               acc + directionalForeground(
                 key,
                 swipe_up_foreground[key],
                 type,
                 'ButtonUpForegroundStyle',
                 '上划样式',
                 '文字样式',
                 'sf符号样式',
                 centerUpText,
                 centerUpImage,
                 colorMap,
                 fontSizeConfig
               ),
             std.objectFields(swipe_up_foreground),
             {}
           ) +
           std.foldl(
             function(acc, key)
               acc + directionalForeground(
                 key,
                 swipe_down_foreground[key],
                 type,
                 'ButtonDownForegroundStyle',
                 '下划样式',
                 '文字样式',
                 'sf符号样式',
                 centerDownText,
                 centerDownImage,
                 colorMap,
                 fontSizeConfig
               ),
             std.objectFields(swipe_down_foreground),
             {}
           ) +
           std.foldl(
             function(acc, key)
               acc + hintBubbleForeground(
                 key,
                 swipe_up_hint[key],
                 type,
                 'ButtonSwipeUpHintForegroundStyle',
                 '上划气泡前景样式',
                 '上划气泡sf符号前景样式',
                 hintTextCenter,
                 hintImageCenter,
                 colorMap,
                 fontSizeConfig
               ),
             std.objectFields(swipe_up_hint),
             {}
           ) +
           std.foldl(
             function(acc, key)
               acc + hintBubbleForeground(
                 key,
                 swipe_down_hint[key],
                 type,
                 'ButtonSwipeDownHintForegroundStyle',
                 '下划气泡前景样式',
                 '下划气泡sf符号前景样式',
                 hintTextCenter,
                 hintImageCenter,
                 colorMap,
                 fontSizeConfig
               ),
             std.objectFields(swipe_down_hint),
             {}
           ) +
           if type != 'number' then
             std.foldl(
               function(acc, key)
                 acc + hintForeground(
                   key,
                   Settings,
                   colorMap,
                   fontSizeConfig,
                   hintTextCenter
                 ),
               std.objectFields(swipe_up_foreground),
               {}
             )
           else
             {},
  };

{
  getStyle(
    type,
    theme,
    swipe_up,
    swipe_down,
    fontSizeConfig=fontSize,
    swipe_up_foreground=swipe_up,
    swipe_down_foreground=swipe_down,
    swipe_up_hint=swipe_up,
    swipe_down_hint=swipe_down
  ): finalStyles(
       type,
       theme,
       swipe_up,
       swipe_down,
       fontSizeConfig,
       swipe_up_foreground,
       swipe_down_foreground,
       swipe_up_hint,
       swipe_down_hint
     ).style,
}
