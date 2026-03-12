// Expose the swipe-style entry module on top of the shared swipe helpers.
local Settings = import '../../Custom.libsonnet';

local center = import '../shared/center.libsonnet';
local color = import '../shared/color.libsonnet';
local fontSize = import '../shared/fontSize.libsonnet';
local swipeShared = import 'shared.libsonnet';

local finalStyles(type, theme, swipe_up, swipe_down, fontSizeConfig) =
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
               acc + swipeShared.directionalForeground(
                 key,
                 swipe_up[key],
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
             std.objectFields(swipe_up),
             {}
           ) +
           std.foldl(
             function(acc, key)
               acc + swipeShared.directionalForeground(
                 key,
                 swipe_down[key],
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
             std.objectFields(swipe_down),
             {}
           ) +
           std.foldl(
             function(acc, key)
               acc + swipeShared.hintBubbleForeground(
                 key,
                 swipe_up[key],
                 type,
                 'ButtonSwipeUpHintForegroundStyle',
                 '上划气泡前景样式',
                 '上划气泡sf符号前景样式',
                 hintTextCenter,
                 hintImageCenter,
                 colorMap,
                 fontSizeConfig
               ),
             std.objectFields(swipe_up),
             {}
           ) +
           std.foldl(
             function(acc, key)
               acc + swipeShared.hintBubbleForeground(
                 key,
                 swipe_down[key],
                 type,
                 'ButtonSwipeDownHintForegroundStyle',
                 '下划气泡前景样式',
                 '下划气泡sf符号前景样式',
                 hintTextCenter,
                 hintImageCenter,
                 colorMap,
                 fontSizeConfig
               ),
             std.objectFields(swipe_down),
             {}
           ) +
           if type != 'number' then
             std.foldl(
               function(acc, key)
                 acc + swipeShared.hintForeground(
                   key,
                   Settings,
                   colorMap,
                   fontSizeConfig,
                   hintTextCenter
                 ),
               std.objectFields(swipe_up),
               {}
             )
           else
             {},
  };

{
  getStyle(type, theme, swipe_up, swipe_down, fontSizeConfig=fontSize): finalStyles(type, theme, swipe_up, swipe_down, fontSizeConfig).style,
}
