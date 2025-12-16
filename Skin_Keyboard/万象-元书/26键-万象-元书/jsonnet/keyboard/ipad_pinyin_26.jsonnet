local pinyin_base = import 'pinyin_26.jsonnet';

// iPad 使用的 deviceType 和相关的库
local deviceType = 'iPad';
local Settings = import '../custom/Custom.libsonnet';
local keyboardLayout_ = if Settings.with_functions_row[deviceType] then import '../lib/keyboardLayout.libsonnet' else import '../lib/keyboardLayoutWithoutFuncRow.libsonnet';
local center = import '../lib/center.libsonnet';
local color = import '../lib/color.libsonnet';
local fontSize = import '../lib/fontSize.libsonnet';

// 定义一个专门用于生成 iPad 键盘的函数
local ipad_keyboard(theme, orientation, keyboardLayout) =
  // 1. 首先，调用 pinyin_base 的 keyboard 函数，生成一个完整的 iPhone 键盘定义
  local base_def = pinyin_base.keyboard(theme, orientation, keyboardLayout);

  // 2. 然后，定义一个 "补丁"，包含所有 iPad 与 iPhone 的差异点
  local ipad_overrides =
    // 2.1. 使用 iPad 的专属布局
    keyboardLayout['ipad中文26键'] +
    {
      // 2.2. 通过 ::: 将 iPhone 的 123Button 设置为 null，从最终结果中移除它
      '123Button':: null,

      // 2.3. 添加 iPad 专属的 nextButton (地球键)，这里复用了 pinyin_base 里的 createButton 函数
      nextButton: pinyin_base.createButton(
        'next',
        keyboardLayout['竖屏按键尺寸']['next键size'], // iPad 横竖屏尺寸一致
        {},
        $,
        false
      ) + {
        backgroundStyle: 'systemButtonBackgroundStyle',
        foregroundStyle: 'nextButtonForegroundStyle',
        action: 'nextKeyboard',
      },
      nextButtonForegroundStyle: {
        buttonStyleType: 'systemImage',
        systemImageName: 'globe',
        normalColor: color[theme]['按键前景颜色'],
        highlightColor: color[theme]['按键前景颜色'],
        fontSize: fontSize['按键前景文字大小'] - 3,
        center: center['功能键前景文字偏移'] { y: 0.5 },
      },

      // 2.4. 添加 iPad 专属的 ipad123Button，同样复用 createButton
      ipad123Button: pinyin_base.createButton(
        'ipad123',
        keyboardLayout['竖屏按键尺寸']['ipad123键size'], // iPad 横竖屏尺寸一致
        {},
        $,
        false
      ) + {
        type: 'horizontalSymbols',
        maxColumns: 1,
        insets: { left: 3, right: 3 },
        contentRightToLeft: false,
        backgroundStyle: 'systemButtonBackgroundStyle',
        dataSource: 'ipad123ButtonSymbolsDataSource',
      },
      ipad123ButtonSymbolsDataSource: [
        { label: '1', action: { keyboardType: 'numeric' }, styleName: 'numericStyle' },
        { label: '2', action: { keyboardType: 'symbolic' }, styleName: 'symbolicStyle' },
        { label: '4', action: { keyboardType: 'emojis' }, styleName: 'emojisStyle' },  // 内置键盘
      ],
    };

  // 3. 最后，将 iPad 的 "补丁" 合并到 iPhone 的基础定义上，同名字段会被覆盖
  base_def + ipad_overrides;

// 导出与 pinyin_26.jsonnet 结构相同的对象
{
  new(theme, orientation)::
    ipad_keyboard(theme, orientation, keyboardLayout_.getKeyboardLayout(theme)),
}
