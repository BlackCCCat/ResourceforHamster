# 目录

## 当前结构

```text
WanxiangSkin/
├── README.md
├── MODULES.md
└── jsonnet/
    ├── Custom.libsonnet
    ├── main.jsonnet
    ├── entries/
    ├── keyboards/
    └── shared/
```

### `jsonnet/entries/`
- 对外入口层。
- 每个文件只负责把请求转发到对应键盘实现。

主要文件：
- `jsonnet/entries/pinyin_26.jsonnet`
- `jsonnet/entries/alphabetic_26.jsonnet`
- `jsonnet/entries/pinyin_18.jsonnet`
- `jsonnet/entries/pinyin_14.jsonnet`
- `jsonnet/entries/pinyin_9.jsonnet`
- `jsonnet/entries/numeric_9.jsonnet`
- `jsonnet/entries/ipad_pinyin_26.jsonnet`
- `jsonnet/entries/ipad_alphabetic_26.jsonnet`
- `jsonnet/entries/ipad_numeric_9.jsonnet`
- `jsonnet/entries/panel.jsonnet`
  - 仅暴露浮动面板入口，完整实现位于 `jsonnet/keyboards/float/panel.libsonnet`。

### `jsonnet/keyboards/`
- 按键盘类型组织实现。

当前目录：
- `jsonnet/keyboards/pinyin26/`
- `jsonnet/keyboards/tempPinyin/`
- `jsonnet/keyboards/alphabetic26/`
- `jsonnet/keyboards/pinyin18/`
- `jsonnet/keyboards/pinyin14/`
- `jsonnet/keyboards/pinyin9/`
- `jsonnet/keyboards/numeric9/`
- `jsonnet/keyboards/common/keyboard26/`
- `jsonnet/keyboards/common/systemKeys26/`
- `jsonnet/keyboards/common/pinyin14_18/`
- `jsonnet/keyboards/common/layoutAssembly/`
- `jsonnet/keyboards/float/`

### `jsonnet/shared/`
- 放多个键盘共用的能力。

当前目录：
- `jsonnet/shared/toolbar/`
- `jsonnet/shared/functionButtons/`
- `jsonnet/shared/styles/`
- `jsonnet/shared/data/`
- `jsonnet/shared/buttonHelpers/`

## 自定义配置

### 基础配置
- `keyboard_layout`
  - 中文键盘布局。
  - 可选值：`26`、`18`、`14`、`9`。
- `wanxiang_9_hintSymbol`
  - 9 键长按符号是否直接上屏。
- `swap_9_123_symbol`
  - 9 键底行左下角 `123` 与符号按钮是否交换位置。
  - 同时影响竖屏与横屏。
- `swap_numeric_return_symbol`
  - 数字键盘返回按钮与切换键盘按钮是否交换位置。
  - 同时影响竖屏与横屏。
- `is_wanxiang_18`
  - 18 键是否使用万象转写规则。
- `is_wanxiang_14`
  - 14 键是否使用万象转写规则。
- `is_letter_capital`
  - 26 键字母是否显示大写。
- `fix_sf_symbol`
  - 是否修复部分 SF Symbol 显示问题。
- `show_swipe`
  - 是否显示上下划前景。
- `show_wanxiang`
  - 空格键是否显示“万象”。
- `ios26_style`
  - 是否启用 iOS26 风格。
- `horizon_candidate_button`
  - 控制横向候选栏右侧按钮。
  - `0`：不显示。
  - `1`：显示候选栏展开按钮。
  - `2`：显示收起键盘按钮。

### 功能行配置
- `function_button_config.with_functions_row`
  - 按设备控制是否启用功能行。
  - `iPhone` 和 `iPad` 分开配置。
- `function_button_config.enable_notification`
  - 是否启用功能按键通知。
- `function_button_config.order`
  - 功能行顺序。
  - 可用值：`left`、`head`、`select`、`cut`、`copy`、`paste`、`tail`、`right`。

### `123Button` 配置
- `button_123_config.enable_slide`
  - `true`：保持 `horizontalSymbols` 滑动切换。
  - `false`：改用二级交互配置。
- `button_123_config.secondary_action_mode`
  - `hint_symbols`：点击切数字键盘，长按菜单显示符号键盘和 emoji 键盘。
  - `swipe`：点击切数字键盘，上下滑切换符号键盘和 emoji 键盘。
- `button_123_config.swipe_up_keyboard`
- `button_123_config.swipe_down_keyboard`
  - 当 `secondary_action_mode = 'swipe'` 时生效。
  - 可选值：`symbolic`、`emojis`。
- `button_123_config.show_swipe_indicators`
  - 是否显示 `123Button` 的上下划角标。
  - 默认 `false`。
  - 只控制角标显示，不影响 swipe 动作本身。
- 作用范围：
  - 中文 26 键
  - 英文 26 键
  - 14 键
  - 18 键
  - iPad 26 键

### 九键 / 数字键盘符号按钮配置
- `button_symbol_config.enable_slide`
  - `true`：保持 `horizontalSymbols` 滑动切换。
  - `false`：改用二级交互配置。
- `button_symbol_config.secondary_action_mode`
  - `hint_symbols`：点击切符号键盘，长按菜单只显示 emoji 键盘。
  - `swipe`：点击切符号键盘，只保留上滑动作。
- `button_symbol_config.swipe_up_keyboard`
  - 当 `secondary_action_mode = 'swipe'` 时生效。
  - 当前推荐保持为 `emojis`。
- 不影响：
  - `swap_9_123_symbol`
  - `swap_numeric_return_symbol`

### 字体和外观
- `font_size_config`
  - `pinyin_26_letter_font_size`
  - `pinyin_14_18_letter_font_size`
  - `pinyin_9_letter_font_size`
  - `numeric_digit_font_size`
- `button_insets`
  - `portrait`
  - `landscape`
- `cornerRadius`
  - 按键圆角。

### Shift 配置
- `shift_config.enable_preedit`
- `shift_config.preedit_action`
- `shift_config.preedit_sf_symbol`
- `shift_config.preedit_swipeup_action`

### Toolbar 配置
- `toolbar_config.toolbar_height`
  - iPhone 工具栏高度。

### 非 26 键英文键盘切回拼音 26 键
- 9 键、14 键、18 键使用英文键盘时：
  - `en2cnButton` 上划切到 `temp_pinyin`
  - `spaceButton`、`spaceFirstButton`、`spaceSecondButton` 上划发送 `Shift+space`
- `temp_pinyin` 是一个临时拼音 26 键入口：
  - 复用拼音 26 键主体
  - `cn2enButton` 点击返回英文键盘
  - `cn2enButton` 不挂通知
  - `cn2enButton` 前景改为返回语义的 SF Symbol
  - `spaceButton` / `spaceSecondButton` 固定显示 `RIME`
  - `spaceButton` / `spaceFirstButton` / `spaceSecondButton` 上划发送 `Shift+space`
- `toolbar_config.toolbar_menu`
  - 是否启用键盘菜单页面。
- `toolbar_config.content_right_to_left`
  - iPhone toolbar 滑动区域方向。
- `toolbar_config.mode`
  - `segmented` 或 `carousel`。
- `toolbar_config.segmented`
- `toolbar_config.carousel`
  - iPhone toolbar 两种模式的按钮配置。
- `toolbar_config.ipad.toolbar_height`
  - iPad 工具栏高度。
- `toolbar_config.ipad.toolbar_menu`
- `toolbar_config.ipad.content_right_to_left`
- `toolbar_config.ipad.center_slide`
  - iPad toolbar 配置。

### iPad 26 键布局
- 当前 iPad 26 键使用独立的四行布局。
- 第一行右侧为删除键。
- 第二行字母可视宽度与其他字母保持一致，仅在 `a` 键左侧保留留白，右侧为稍窄的回车键。
- 第三行左 Shift 宽度与右侧 `Tab + Shift` 总宽度对齐，右 Shift 左侧追加 Tab。
- 第四行从左到右为 Globe、123、逗号、空格、中英切换、123、收起键盘。
- 空格左侧逗号键保留上划句号。
- 右侧 Shift 与左侧 Shift 保持相同的通知能力。
- 中英文 iPad 26 键统一使用相同的 26 键字母字号覆写。
- 工具栏可选按钮新增 `simplified_traditional`，用于触发 `#简繁切换`。
- 工具栏可选按钮新增 `undo` / `redo`，分别触发 `#undo` 与 `#redo`。

## 横屏布局说明

### 横屏 9 键
- 使用独立横屏布局。
- 布局树定义在：
  - `jsonnet/keyboards/pinyin9/layout.libsonnet`
- 顶部功能行是否显示受 `function_button_config.with_functions_row.iPhone` 控制。
- 左下角和右下角按钮顺序受 `swap_9_123_symbol` 控制。
- `collection`、`verticalCandidates`、符号按钮等组件定义在：
  - `jsonnet/keyboards/pinyin9/panels.libsonnet`

### 横屏数字键盘
- iPhone 使用独立横屏布局。
- iPad 横屏数字键盘回退到竖屏布局。
- iPhone 横屏布局由 `jsonnet/keyboards/numeric9/layout.libsonnet` 管理。
- 顶部功能行是否显示受 `function_button_config.with_functions_row.iPhone` 控制。
- 返回按钮与切换键盘按钮顺序受 `swap_numeric_return_symbol` 控制。
- `collection`、`landscapeNumericSymbols` 等组件定义在：
  - `jsonnet/keyboards/numeric9/panels.libsonnet`
