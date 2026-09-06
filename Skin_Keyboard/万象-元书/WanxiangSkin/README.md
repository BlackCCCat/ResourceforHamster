# WanxiangSkin

`WanxiangSkin` 是面向元书输入法（Hamster3）的万象键盘皮肤。Jsonnet 源码按构建、视觉、组件和键盘族四层组织；公开配置集中在 `jsonnet/Custom.libsonnet`。

## 目录结构

```text
jsonnet/
├── Custom.libsonnet
├── main.jsonnet
├── build/                  # 输出配置、键盘注册与构建上下文
├── design/                 # 颜色、字号、偏移和样式工厂
├── components/             # 按键、系统键、功能行、工具栏与候选栏
└── keyboards/              # 各键盘族的独立实现与专属数据
```

`main.jsonnet` 通过 `build/keyboardRegistry.libsonnet` 调用各键盘入口，键盘入口从 `build/context.libsonnet` 取得已解析的设备与布局上下文。键盘族可以复用 `components` 和 `design`，公共组件不引用具体键盘族。`tempPinyin` 是有意保留的例外，它在拼音 26 键结果上做少量覆写。

## 主要模块

- `jsonnet/build/skinConfig.libsonnet`：生成 `config.yaml` 使用的皮肤和键盘映射。
- `jsonnet/build/keyboardRegistry.libsonnet`：按 `keyboard_layout` 选择手机端拼音键盘，并注册其余输出键盘。
- `jsonnet/build/context.libsonnet`：创建设备上下文、汇总布局并按配置插入功能行。
- `jsonnet/design/appearance.libsonnet`：颜色、字号、偏移、动画和键盘高度。
- `jsonnet/design/styleFactories.libsonnet`：文本、SF Symbol、图片和 geometry 样式工厂。
- `jsonnet/components/systemKeys/`：拼音布局共用的 Shift、中英切换、123、退格、空格和回车键。
- `jsonnet/components/toolbar/`：iPhone/iPad 工具栏注册、配置和渲染。
- `jsonnet/components/candidates.libsonnet`：横向候选、纵向候选和候选词长按菜单。
- `jsonnet/keyboards/keyboard26/`：中文 26/27 键、英文 26 键、iPad 26 键和临时拼音键盘。
- `jsonnet/keyboards/pinyinGrouped/`：分组拼音键盘族，包含 14/17/18 键共用构建层及三个独立布局。
- `jsonnet/keyboards/pinyin9/`、`jsonnet/keyboards/numeric9/`：九键和数字九键独立实现。
- `jsonnet/keyboards/floatPanel/`：浮动面板键盘完整实现。

详细职责和修改落点见 `MODULES.md`。

## 自定义配置

### 布局与基础行为

- `keyboard_layout`：`9`、`14`、`17`、`18`、`26` 或 `27`。
- `27`：在中文 26 键第二行增加 `;`，用于搜狗双拼 `ing`。
- `wanxiang_9_hintSymbol`：控制九键长按字符使用 `symbol` 还是 `character`。
- `swap_9_123_symbol`：交换九键底行的 123 与符号按钮。
- `swap_numeric_return_symbol`：交换数字键盘底行的返回与切换按钮。
- `is_wanxiang_14`、`is_wanxiang_18`：控制 14/18 键字符动作。
- `is_letter_capital`：控制中文 9/14/17/18/26/27 键的字母常态大小写显示。
- `show_swipe`：控制普通按键上下划前景显示。
- `show_wanxiang`：控制普通拼音空格上的“万象”。
- `tips_button_action`：设定九键提示按钮的上屏动作。
- `fix_sf_symbol`：使用兼容性更好的 SF Symbol。
- `ios26_style`：启用 iOS 26 风格颜色覆盖。

### 中文 26 键滑动辅助

`swipe_assist_mode` 只作用于中文 26 键：

- `none`：保留原始上下划动作和 `keyboardAction` 前景通知。
- `up`：通知状态下，上划输入对应大写字母；原上划内容进入长按菜单。
- `down`：通知状态下，下划输入对应大写字母；原下划内容进入长按菜单。
- `all`：通知状态下，上下划均输入对应大写字母；原上划、下划内容依次进入长按菜单。

辅助方向的滑动气泡会被关闭；长按菜单按左右对称规则排列，并把默认索引切到原辅助符号。实现位于 `jsonnet/keyboards/keyboard26/pinyin/swipeAssist.libsonnet`。

### 功能行

- `function_button_config.with_functions_row.iPhone`
- `function_button_config.with_functions_row.iPad`
- `function_button_config.enable_notification`
- `function_button_config.order`

顺序可使用 `left`、`head`、`select`、`cut`、`copy`、`paste`、`tail`、`right`。功能行布局会按有效按钮数量自动分配宽度。

### 123Button

- `button_123_config.enable_slide`：启用 `horizontalSymbols` 滑动选择。
- `button_123_config.secondary_action_mode`：关闭 slide 后使用 `hint_symbols` 或 `swipe`。
- `button_123_config.swipe_up_keyboard`
- `button_123_config.swipe_down_keyboard`
- `button_123_config.show_swipe_indicators`：只控制 123Button 上下划角标，默认不显示，不受 `show_swipe` 影响，也不改变动作。

该配置覆盖中文 26/27 键、14 键、17 键、18 键、英文 26 键和 iPad 26 键；123Button 不显示点击气泡。

### 九键与数字键盘符号按钮

- `button_symbol_config.enable_slide`
- `button_symbol_config.secondary_action_mode`
- `button_symbol_config.swipe_up_keyboard`

符号按钮配置不改变 `swap_9_123_symbol` 和 `swap_numeric_return_symbol` 的位置逻辑。

### 候选栏与工具栏

- `horizon_candidate_button`：`0` 不显示、`1` 展开候选、`2` 收起键盘。
- `toolbar_config.toolbar_height`：iPhone 工具栏高度。
- `toolbar_config.ipad.toolbar_height`：iPad 工具栏高度。
- `toolbar_config.mode`：`segmented` 或 `carousel`。
- `toolbar_config.segmented`、`toolbar_config.carousel`：iPhone 工具栏按钮布局。
- `toolbar_config.ipad.center_slide`：iPad 中间滑动按钮。
- `toolbar_config.content_right_to_left`、`toolbar_config.ipad.content_right_to_left`：滑动内容方向。
- `toolbar_config.toolbar_menu`、`toolbar_config.ipad.toolbar_menu`：菜单或浮动面板入口。

可选按钮包括 `command`、`simplified_traditional`、`undo`、`redo`、`cut`、`copy`、`paste` 等；`command` 使用 `#toggleCommandView` 打开或关闭命令面板。完整注册表位于 `jsonnet/components/toolbar/registry.libsonnet`。

### 字号、边距与 Shift

- `font_size_config.pinyin_grouped_letter_font_size`：分组拼音（14/17/18 键）的字母前景字号。
- `button_insets.portrait`、`button_insets.landscape`：按键背景边距。
- `cornerRadius`：按键圆角。
- `shift_config`：Shift 预编辑动作与图标用于中文 26/27 键和 iPad 26 键，不作用于 14/17/18 键；`preedit_swipeup_action` 仅在中文 26 键生效。

## 特殊键盘

### iPad 26 键

iPad 使用独立四行布局：第一行右侧删除，第二行右侧回车，第三行双 Shift 且右侧 Shift 前有 Tab，第四行包含 Globe、双 123、逗号、空格、中英切换与收起键盘。逗号键上划句号。布局尺寸位于 `jsonnet/keyboards/keyboard26/base/iPadLayout.libsonnet`，按钮覆写位于 `jsonnet/keyboards/keyboard26/base/iPadBuilder.libsonnet`。

### 临时拼音

非 26 键布局的英文键盘可通过中英键上划进入 `temp_pinyin`。临时拼音复用中文 26 键主体，中英键返回英文键盘并移除通知；空格固定显示 `RIME`，上划发送 `Shift+space`。

### 浮动键盘

`config.yaml` 中 iPad `floating` 使用 iPhone 竖屏键盘。浮动面板键盘实现位于 `jsonnet/keyboards/floatPanel/keyboard.libsonnet`。

## 编译

```bash
cd Skin_Keyboard/万象-元书/WanxiangSkin
jsonnet jsonnet/main.jsonnet -o /tmp/WanxiangSkin.json
```

`main.jsonnet` 返回“输出路径 → YAML 文本”的对象。结构调整必须同时验证 9/14/17/18/26/27 键和 `swipe_assist_mode` 的各模式；修改公共样式或工具栏时还要覆盖浅色、深色、横屏、竖屏和 iPad 输出。
