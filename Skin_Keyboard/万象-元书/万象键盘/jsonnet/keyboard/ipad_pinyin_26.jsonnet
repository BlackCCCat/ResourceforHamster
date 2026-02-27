local pinyin_base = import 'pinyin_26.jsonnet';
local toolbar_ipad = import '../lib/toolbar-ipad.libsonnet';
local ipad_common = import '../lib/ipad_common.libsonnet';
local utils = import '../lib/utils.libsonnet';
local color = import '../lib/color.libsonnet';
local center = import '../lib/center.libsonnet';
local fontSize = import '../lib/fontSize.libsonnet';
local others = import '../lib/others.libsonnet';
local hintSymbolsData = import '../lib/hintSymbolsData.libsonnet';
local hintSymbolsStyles = import '../lib/hintSymbolsStyles.libsonnet';
local swipeData = import '../lib/swipeData.libsonnet';
local swipeStyles = import '../lib/swipeStyle.libsonnet';

// iPad 使用的 deviceType 和相关的库
local deviceType = 'iPad';
local Settings = import '../Custom.libsonnet';
local keyboardLayout_ = if Settings.with_functions_row[deviceType] then import '../lib/keyboardLayout.libsonnet' else import '../lib/keyboardLayoutWithoutFuncRow.libsonnet';


local ipad_fontSize = fontSize + {
  '按键前景文字大小': 24,
  '26键字母前景文字大小': 24,
  '上划文字大小': 12,
  '下划文字大小': 12,
  'toolbar按键前景sf符号大小': 20,
};

local ipad_others = others + {
  '竖屏': others['竖屏'] + { 'preedit高度': 20, 'toolbar高度': 57, 'keyboard高度': 240 },
  '横屏': others['横屏'] + { 'preedit高度': 20, 'toolbar高度': 57, 'keyboard高度': 350 },
};

// 上下和下划的数据
local swipe_up = if std.objectHas(swipeData.genSwipeData(deviceType), 'swipe_up') then swipeData.genSwipeData(deviceType).swipe_up else {};
local swipe_down = if std.objectHas(swipeData.genSwipeData(deviceType), 'swipe_down') then swipeData.genSwipeData(deviceType).swipe_down else {};


// 定义一个专门用于生成 iPad 键盘的函数
local ipad_keyboard(theme, orientation, keyboardLayout) =
  // 1. 首先，调用 pinyin_base 的 keyboard 函数，生成一个完整的 iPhone 键盘定义
  local base_def = pinyin_base.keyboard(theme, 'portrait', keyboardLayout); // 由于iPad横屏也使用和竖屏一样的键盘布局，因此这里限制为 portrait
  local hintStyles = hintSymbolsStyles.getStyle(theme, hintSymbolsData.pinyin);
  local toolbar_def = toolbar_ipad.getToolBar(theme);

  // 2. 然后，定义一个 "补丁"，包含所有 iPad 与 iPhone 的差异点
  local ipad_overrides =
    // 2.1. 使用 iPad 的专属布局
    keyboardLayout['ipad中文26键'] +
    toolbar_def +
    swipeStyles.getStyle('cn', theme, swipe_up, swipe_down, ipad_fontSize) +
    ipad_common.getOverrides(theme, keyboardLayout, pinyin_base.createButton, hintStyles) +
    utils.genPinyinStyles(ipad_fontSize, color, theme, center) +

    {
      preeditHeight: ipad_others[if orientation == 'portrait' then '竖屏' else '横屏']['preedit高度'],
      toolbarHeight: ipad_others[if orientation == 'portrait' then '竖屏' else '横屏']['toolbar高度'],
      keyboardHeight: ipad_others[if orientation == 'portrait' then '竖屏' else '横屏']['keyboard高度'],
    } +
    {
      [key]+: { fontSize: ipad_fontSize['toolbar按键前景sf符号大小'] }
      for key in std.objectFields(toolbar_def)
      if std.startsWith(key, 'toolbarButton')
    } +
    {
      spaceLeftButtonForegroundStyle+: {
        // 注意使用 +: 只有这样才能继承原有的 color 和 fontSize
        // 根据 iPad 的实际显示效果调整 x 和 y
        text: ',',
        center: { y: 0.5 }, 
      },
      spaceLeftButtonForegroundStyle2+: {
        text: '.',
        center: { y: 0.3 },
      },
    } +
    // 遍历 iPad 的下划数据，强制更新所有按键的 swipeDownAction
    {
      [key + 'Button']+: {
        swipeDownAction: swipe_down[key].action
      } for key in std.objectFields(swipe_down)
    } +
    // 同理上划 (如果 iPad 上划也有不同)
    {
      [key + 'Button']+: {
        swipeUpAction: swipe_up[key].action
      } for key in std.objectFields(swipe_up)
    };

  // 3. 最后，将 iPad 的 "补丁" 合并到 iPhone 的基础定义上，同名字段会被覆盖
  base_def + ipad_overrides;

// 导出与 pinyin_26.jsonnet 结构相同的对象
{
  new(theme, orientation)::
    ipad_keyboard(theme, orientation, keyboardLayout_.getKeyboardLayout(theme)),
}
