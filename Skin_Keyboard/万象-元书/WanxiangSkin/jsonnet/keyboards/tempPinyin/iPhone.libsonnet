// 暴露临时拼音 26 键入口，供非 26 键英文键盘上划切回拼音 26 键。
local pinyin26 = import '../pinyin26/iPhone.libsonnet';
local styleFactories = import '../../shared/styles/styleFactories.libsonnet';
local color = import '../../shared/styles/color.libsonnet';
local fontSize = import '../../shared/styles/fontSize.libsonnet';
local center = import '../../shared/styles/center.libsonnet';

local build(theme, orientation) =
  local base = pinyin26.new(theme, orientation);
  base + {
    cn2enButton: base.cn2enButton {
      action: { keyboardType: 'alphabetic' },
      notification:: null,
    },
    // 临时拼音键盘中的中英切换键改为返回英文键盘。
    cn2enButtonForegroundStyle: styleFactories.makeSystemImageStyle(
      'return.left',
      fontSize['按键前景文字大小'] - 3,
      color[theme]['按键前景颜色'],
      color[theme]['按键前景颜色'],
      center['功能键前景文字偏移'] { y: 0.5 }
    ),
    // temp_pinyin 的空格键固定显示 RIME，不受 show_wanxiang 控制。
    spaceButton: base.spaceButton {
      foregroundStyle: ['spaceButtonForegroundStyle', 'spaceButtonForegroundStyle1'],
      swipeUpAction: { sendKeys: 'Shift+space' },
    },
    spaceButtonPreeditNotification: base.spaceButtonPreeditNotification {
      foregroundStyle: ['spaceButtonForegroundStyle', 'spaceButtonForegroundStyle1'],
      swipeUpAction: { sendKeys: 'Shift+space' },
    },
    spaceButtonForegroundStyle1: styleFactories.makeTextStyle(
      'RIME',
      fontSize['按键前景文字大小'] - 10,
      color[theme]['划动字符颜色'],
      color[theme]['划动字符颜色'],
      { x: 0.9, y: 0.8 }
    ),
    spaceFirstButton: base.spaceFirstButton {
      swipeUpAction: { sendKeys: 'Shift+space' },
    },
    spaceFirstButtonPreeditNotification: base.spaceFirstButtonPreeditNotification {
      swipeUpAction: { sendKeys: 'Shift+space' },
    },
    spaceSecondButton: base.spaceSecondButton {
      foregroundStyle: ['spaceSecondButtonForegroundStyle', 'spaceSecondButtonForegroundStyle1'],
      swipeUpAction: { sendKeys: 'Shift+space' },
    },
    spaceSecondButtonPreeditNotification: base.spaceSecondButtonPreeditNotification {
      foregroundStyle: ['spaceSecondButtonForegroundStyle', 'spaceSecondButtonForegroundStyle1'],
      swipeUpAction: { sendKeys: 'Shift+space' },
    },
    spaceSecondButtonForegroundStyle1: styleFactories.makeTextStyle(
      'RIME',
      fontSize['按键前景文字大小'] - 10,
      color[theme]['划动字符颜色'],
      color[theme]['划动字符颜色'],
      { x: 0.85, y: 0.8 }
    ),
  };

{
  new(theme, orientation): build(theme, orientation),
}
