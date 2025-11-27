local is_cap = import '../custom/Custom.libsonnet';

local center = import 'center.libsonnet';
local color = import 'color.libsonnet';
local fontSize = import 'fontSize.libsonnet';

// fs: 在swipeData中定义的字体大小，用于特殊情况，会覆盖fontSize中的设置
local swipe_style(center, theme, fs=null) = {
  '上划样式': {
    '文字样式': {
      buttonStyleType: 'text',
      normalColor: color[theme]['划动字符颜色'],
      highlightColor: color[theme]['划动字符颜色'],
      center: center,
      fontSize: if fs == null then fontSize['上划文字大小'] else fs,
    },
    'sf符号样式': {
      buttonStyleType: 'systemImage',
      normalColor: color[theme]['划动字符颜色'],
      highlightColor: color[theme]['划动字符颜色'],
      center: center,
      fontSize: if fs == null then fontSize['上划文字大小'] else fs,
    },
  },
  '下划样式': {
    '文字样式': {
      buttonStyleType: 'text',
      normalColor: color[theme]['划动字符颜色'],
      highlightColor: color[theme]['划动字符颜色'],
      center: center,
      fontSize: if fs == null then fontSize['下划文字大小'] else fs,
    },
    'sf符号样式': {
      buttonStyleType: 'systemImage',
      normalColor: color[theme]['划动字符颜色'],
      highlightColor: color[theme]['划动字符颜色'],
      center: center,
      fontSize: if fs == null then fontSize['下划文字大小'] else fs,
    },
  },
  '上划气泡前景样式': {
    buttonStyleType: 'text',
    fontSize: fontSize['划动气泡前景文字大小'],
    // center: center,
    normalColor: color[theme]['按下气泡文字颜色'],
  },
  '上划气泡sf符号前景样式': {
    buttonStyleType: 'systemImage',
    fontSize: fontSize['划动气泡前景sf符号大小'],
    // center: center,
    normalColor: color[theme]['按下气泡文字颜色'],
  },
  '下划气泡前景样式': {
    buttonStyleType: 'text',
    fontSize: fontSize['划动气泡前景文字大小'],
    // center: center,
    normalColor: color[theme]['按下气泡文字颜色'],
  },
  '下划气泡sf符号前景样式': {
    buttonStyleType: 'systemImage',
    fontSize: fontSize['划动气泡前景sf符号大小'],
    // center: center,
    normalColor: color[theme]['按下气泡文字颜色'],
  },
  '按下气泡样式': {
    buttonStyleType: 'text',
    fontSize: fontSize['划动气泡前景文字大小'],
    // center: center,
    normalColor: color[theme]['按下气泡文字颜色'],
  },
};


local display(o) = {
  [if std.objectHas(o.label, 'text') then 'text']: o.label.text,
  [if std.objectHas(o.label, 'systemImageName') then 'systemImageName']: o.label.systemImageName,
};

// 上划前景
// key: 按键名称，o: 按键数据(action label以及偏移，字体大小等)，theme: dark/light
local ButtonUpForegroundStyles(key, o, theme, center, type) =
  if !std.objectHas(o, 'label') then {} else {  // 当没有
    [if type == 'number' then 'number' + key + 'ButtonUpForegroundStyle' else
      key + 'ButtonUpForegroundStyle']:
      display(o) +  // text: "xxx" or systemImageName: "xxx"
      if std.objectHas(o.label, 'text') then
        swipe_style(
          if std.objectHas(o, 'center') then o.center else center['上划文字偏移'],
          theme,
          if std.objectHas(o, 'fontSize') then o.fontSize else null
        )['上划样式']['文字样式']
      else
        swipe_style(
          if std.objectHas(o, 'center') then o.center else center['上划sf符号偏移'],
          theme,
          if std.objectHas(o, 'fontSize') then o.fontSize else null
        )['上划样式']['sf符号样式'],
  };

// 下划前景
local ButtonDownForegroundStyles(key, o, theme, center, type) =
  if !std.objectHas(o, 'label') then {} else {
    [if type == 'number' then 'number' + key + 'ButtonDownForegroundStyle' else
      key + 'ButtonDownForegroundStyle']:
      display(o) +
      if std.objectHas(o.label, 'text') then
        swipe_style(
          if std.objectHas(o, 'center') then o.center else center['下划文字偏移'],
          theme,
          if std.objectHas(o, 'fontSize') then o.fontSize else null,
        )['下划样式']['文字样式']
      else
        swipe_style(
          if std.objectHas(o, 'center') then o.center else center['下划sf符号偏移'],
          theme,
          if std.objectHas(o, 'fontSize') then o.fontSize else null,
        )['下划样式']['sf符号样式'],
  };

// 上划提示气泡
local ButtonSwipeUpHintForegroundStyle(key, o, theme, type) =
  if !std.objectHas(o, 'label') then {} else {
    [if type == 'number' then 'number' + key + 'ButtonSwipeUpHintForegroundStyle' else
      key + 'ButtonSwipeUpHintForegroundStyle']:
      display(o) +
      if std.objectHas(o.label, 'text') then
        swipe_style(center['划动气泡文字偏移'], theme)['上划气泡前景样式']
      else
        swipe_style(center['划动气泡sf符号偏移'], theme)['上划气泡sf符号前景样式'],
  };
// 下划提示气泡
local ButtonSwipeDownHintForegroundStyle(key, o, theme, type) =
  if !std.objectHas(o, 'label') then {} else {
    [if type == 'number' then 'number' + key + 'ButtonSwipeDownHintForegroundStyle' else
      key + 'ButtonSwipeDownHintForegroundStyle']:
      display(o) +
      if std.objectHas(o.label, 'text') then
        swipe_style(center['划动气泡文字偏移'], theme)['下划气泡前景样式']
      else
        swipe_style(center['划动气泡sf符号偏移'], theme)['下划气泡sf符号前景样式'],
  };

// 按下气泡
local ButtonHintForegroundStyle(key, o, theme, type) = {
  [key + 'ButtonHintForegroundStyle']:
    // { text: if type == 'cn' then std.asciiUpper(key) else key } +  // 英文使用小写字母
    { text: if is_cap.is_letter_capital then std.asciiUpper(key) else key} + // 根据选择的大小写显示气泡的大小写
    swipe_style(center['划动气泡文字偏移'], theme)['按下气泡样式'],
};

local finalStyles(type, theme, swipe_up, swipe_down) = {
  local centerUp = {
    '上划文字偏移': if type == 'number' then center['数字键盘上划文字偏移'] else center['上划文字偏移'],
    '上划sf符号偏移': if type == 'number' then center['数字键盘上划sf符号偏移'] else center['上划文字偏移'],
  },
  local centerDown = {
    '下划文字偏移': if type == 'number' then center['数字键盘下划文字偏移'] else center['下划文字偏移'],
    '下划sf符号偏移': if type == 'number' then center['数字键盘下划sf符号偏移'] else center['下划文字偏移'],
  },

  style: std.foldl(  //上划样式
           function(acc, key) acc + ButtonUpForegroundStyles(key, swipe_up[key], theme, centerUp, type),
           std.objectFields(swipe_up),
           {}
         ) +
         std.foldl(  //下划样式
           function(acc, key) acc + ButtonDownForegroundStyles(key, swipe_down[key], theme, centerDown, type),
           std.objectFields(swipe_down),
           {}
         ) +
         std.foldl(  // 上划提示气泡样式
           function(acc, key) acc + ButtonSwipeUpHintForegroundStyle(key, swipe_up[key], theme, type),
           std.objectFields(swipe_up),
           {}
         ) +
         std.foldl(  // 下划提示气泡样式
           function(acc, key) acc + ButtonSwipeDownHintForegroundStyle(key, swipe_down[key], theme, type),
           std.objectFields(swipe_down),
           {}
         ) +
         if type != 'number' then
           std.foldl(  // 按下气泡样式，有潜在问题，暂时放着
             function(acc, key)
               if std.length(key) == 1 then
                 acc + ButtonHintForegroundStyle(key, swipe_up[key], theme, type)
               else acc,
             std.stringChars('qwertyuiopasdfghjklzxcvbnm'),
             {}
           )
         else
           {},
};


{
  getStyle(type, theme, swipe_up, swipe_down): finalStyles(type, theme, swipe_up, swipe_down).style,
}
