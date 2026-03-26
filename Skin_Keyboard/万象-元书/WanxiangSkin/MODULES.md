# 模块清单文档

这份文档只描述 `WanxiangSkin` 当前实际结构，以及常见修改应该优先去哪里。

## 1. 总入口

### `jsonnet/Custom.libsonnet`
职责：
- 所有可配置项入口。
- 包括布局、字号、toolbar、功能行、按钮交互开关。

### `jsonnet/main.jsonnet`
职责：
- 统一导出 yaml。
- 维护输出文件名和入口文件的映射关系。

## 2. 入口层

### `jsonnet/entries/`
职责：
- 每个文件代表一个对外键盘入口。
- 这里只做装配和转发。
- `panel.jsonnet` 只负责暴露浮动面板入口，完整实现位于 `jsonnet/keyboards/float/panel.libsonnet`。

常见场景：
- 新增一个完整输出入口。
- 调整某个入口绑定到哪个键盘实现。

## 3. 键盘实现层

### `jsonnet/keyboards/pinyin26/`
职责：
- 中文 26 键入口与装配。

主要文件：
- `iPhone.libsonnet`
- `iPad.libsonnet`
- `builder.libsonnet`

改这里的情况：
- 改中文 26 键入口装配。
- 接线 26 键共用布局、字母规格和系统键模块。

### `jsonnet/keyboards/tempPinyin/`
职责：
- 临时拼音 26 键入口。
- 复用中文 26 键主体，并只覆写返回英文键盘所需的 `cn2enButton`。

主要文件：
- `iPhone.libsonnet`

改这里的情况：
- 调整非 26 键英文键盘上划切回拼音 26 键后的返回路径。
- 改 `temp_pinyin` 中 `cn2enButton` 的动作、通知与前景图标。
- 改 `temp_pinyin` 中空格键的固定 `RIME` 标识与 `Shift+space` 上划动作。

### `jsonnet/keyboards/alphabetic26/`
职责：
- 英文 26 键实现。

主要文件：
- `iPhone.libsonnet`
- `iPad.libsonnet`
- `builder.libsonnet`
- `systemKeys.libsonnet`
- `letters.libsonnet`

改这里的情况：
- 改英文 26 键系统键。
- 改英文 26 键 `123Button` 行为。
- 改 9/14/18 英文键盘的 `en2cnButton` 上划切到 `temp_pinyin`。
- 改 9/14/18 英文键盘空格键上划发送 `Shift+space`。

### `jsonnet/keyboards/pinyin18/`
职责：
- 18 键入口与规格。

主要文件：
- `iPhone.libsonnet`
- `layout.libsonnet`
- `specs.libsonnet`

改这里的情况：
- 改 18 键布局树。
- 改 18 键横屏主键区左右列内容。
- 改 18 键键位规格。
- 改 18 键使用哪套万象规则。

### `jsonnet/keyboards/pinyin14/`
职责：
- 14 键入口与规格。

主要文件：
- `iPhone.libsonnet`
- `layout.libsonnet`
- `specs.libsonnet`

改这里的情况：
- 改 14 键布局树。
- 改 14 键横屏主键区左右列内容。
- 改 14 键键位规格。
- 改 14 键使用哪套万象规则。

### `jsonnet/keyboards/common/keyboard26/`
职责：
- 中文 26 键、英文 26 键与 iPad 26 键共用的构建能力。

主要文件：
- `buttonFactory.libsonnet`
- `layout.libsonnet`
- `letters.libsonnet`
- `iPadBuilder.libsonnet`

改这里的情况：
- 同时影响中英文 26 键的按钮工厂。
- 同时影响中英文 26 键共用布局。
- 同时影响中英文 26 键字母规格。
- 同时影响 iPad 26 键的共用覆盖构建流程。
- iPad 26 键的独立四行结构、双 Shift、双 123、Tab 与收起键盘按钮也在这里收口。

### `jsonnet/keyboards/common/systemKeys26/`
职责：
- 26 键体系共用的系统键模块与装配。

主要文件：
- `systemKeys.libsonnet`
- `systemKeysSpec.libsonnet`
- `systemKeysSwitcher.libsonnet`
- `systemKeysShift.libsonnet`
- `systemKeysBackspace.libsonnet`
- `systemKeysCn2en.libsonnet`
- `systemKeysSpace.libsonnet`
- `systemKeysEnter.libsonnet`

改这里的情况：
- 同时影响中文 26 键和复用这批系统键产物的键盘。
- 改 `123Button`、`shift`、`backspace`、`空格`、`回车`、`中英切换` 系统键模块。
- 改 26 键系统键组装逻辑。

### `jsonnet/keyboards/common/pinyin14_18/`
职责：
- 14 键 / 18 键共用的拼音键盘实现。

主要文件：
- `iPhone.libsonnet`
- `buttons.libsonnet`
- `compactSpecFactory.libsonnet`

改这里的情况：
- 同时影响 14 键和 18 键的共享构建逻辑。

### `jsonnet/keyboards/pinyin9/`
职责：
- 9 键实现。

主要文件：
- `iPhone.libsonnet`
- `layout.libsonnet`
- `builder.libsonnet`
- `panels.libsonnet`
- `t9.libsonnet`

改这里的情况：
- 改 9 键布局树。
- 改 9 键按钮本体。
- 改 `collection`、`verticalCandidates` 等面板组件。
- 改 `symbolButton` 组件。
- 改 9 键长按、滑动、符号按钮交互。
- 9 键与数字键盘共用的符号按钮交互辅助逻辑位于 `jsonnet/shared/buttonHelpers/buttonInteraction.libsonnet`。

### `jsonnet/keyboards/numeric9/`
职责：
- 数字键盘实现。

主要文件：
- `iPhone.libsonnet`
- `iPad.libsonnet`
- `builder.libsonnet`
- `layout.libsonnet`
- `panels.libsonnet`

改这里的情况：
- 改数字键盘按钮本体。
- 改数字键盘横屏布局。
- 改 `collection`、`landscapeNumericSymbols` 等面板组件。
- 改返回按钮切换逻辑。
- 9 键与数字键盘共用的符号按钮交互辅助逻辑位于 `jsonnet/shared/buttonHelpers/buttonInteraction.libsonnet`。

### `jsonnet/keyboards/float/`
职责：
- 浮动面板键盘的完整实现。

主要文件：
- `panel.libsonnet`

改这里的情况：
- 改浮动面板的完整按钮配置、布局和样式。

## 4. 共享布局装配

### `jsonnet/keyboards/common/layoutAssembly/`
职责：
- 管理共享布局运行时上下文与最终布局装配。

主要文件：
- `keyboardLayoutAssembly.libsonnet`
  - 共享布局装配入口。
  - 负责汇合共享布局数据、26 键布局、14 键布局、18 键布局，并在需要时叠加功能行 patch。

相关依赖：
- `jsonnet/shared/data/layoutData.libsonnet`
  - 共享基础布局数据。
  - 当前主要承载 26 键与 iPad 共享尺寸、通用基础布局数据。
- `jsonnet/shared/functionButtons/functionRowPatch.libsonnet`
  - 功能行布局 patch。
  - 根据 `with_functions_row` 将功能行插入共享布局树。

改这里的情况：
- 改共享布局装配入口。
- 改功能行开关如何影响布局。
- 改共享尺寸、通用布局基底和 function-row 相关逻辑。

## 5. Toolbar

### `jsonnet/shared/toolbar/`
职责：
- 共享 toolbar 配置、registry 和 renderer。

主要文件：
- `iPhone.libsonnet`
  - iPhone toolbar 入口。
- `iPad.libsonnet`
  - iPad toolbar 入口。
- `registry.libsonnet`
  - toolbar 按钮注册表。
- `config.libsonnet`
  - toolbar 配置读取与公共 helper。
- `iPhoneRenderer.libsonnet`
  - iPhone toolbar 渲染。
  - 读取 `toolbar_config.content_right_to_left`。
- `iPadRenderer.libsonnet`
  - iPad toolbar 渲染。
  - 读取 `toolbar_config.ipad.content_right_to_left`。

改这里的情况：
- 新增 toolbar 按钮。
- `registry.libsonnet` 中的 `simplified_traditional` 可作为工具栏配置按钮，样式定义位于 `iPhone.libsonnet`。
- `registry.libsonnet` 中的 `undo` / `redo` 可作为工具栏配置按钮，样式定义位于 `iPhone.libsonnet`。
- 调整 iPhone / iPad toolbar 布局。
- 调整 `toolbar_config.toolbar_height` 与 `toolbar_config.ipad.toolbar_height`。
- 调整 segmented / carousel 行为。

## 6. 功能行按钮

### `jsonnet/shared/functionButtons/`
职责：
- 功能行按钮 specs、iPhone 构建入口和样式。

主要文件：
- `iPhone.libsonnet`
- `specs.libsonnet`
- `styles.libsonnet`

改这里的情况：
- 新增功能行按钮。
- 调整功能行按钮顺序、动作、通知行为。

## 7. 共享辅助逻辑

### `jsonnet/shared/buttonHelpers/`
职责：
- 收口跨键盘复用的按钮交互、回车键、按键包装辅助逻辑。

主要文件：
- `buttonInteraction.libsonnet`
- `returnKey.libsonnet`
- `key.libsonnet`

改这里的情况：
- 同时影响 26 键与 iPad 的 `123Button` 交互配置解析。
- 同时影响 9 键与数字键盘的 `symbolButton` 交互配置解析。
- 改回车键前景与 `returnKeyType` 通知辅助逻辑。
- 改字母键提示样式和重复按键包装辅助逻辑。

## 8. 样式

### `jsonnet/shared/styles/`
职责：
- 颜色、字号、基础样式工厂、hintSymbols 样式、滑动按钮前景样式。

改这里的情况：
- 调颜色。
- 调字号。
- 调通用样式生成逻辑。

## 8. 数据

### `jsonnet/shared/data/`
职责：
- 纯数据层。
- 数字键盘的 collection / landscape symbol 列表已内聚到 `jsonnet/keyboards/numeric9/panels.libsonnet`。

主要文件：
- `swipeData.libsonnet`
- `swipeDataEn.libsonnet`
- `hintSymbolsData.libsonnet`

改这里的情况：
- 调整全局 swipe 数据。
- 调整 hint symbols 数据。

## 9. 其他共享模块

### `jsonnet/shared/buttonHelpers/key.libsonnet`
职责：
- 跨多个键盘复用的按键辅助逻辑。

### `jsonnet/shared/buttonHelpers/buttonInteraction.libsonnet`
职责：
- 统一承载 `button123` 与 `symbolButton` 的交互辅助逻辑。
- `button123` 负责中文 26 键、英文 26 键和 iPad 26 键的 `123Button` 配置读取、长按菜单和上下滑目标归一化。
- `symbolButton` 负责 9 键与数字键盘符号按钮的配置读取、长按菜单和上划目标归一化。

### `jsonnet/shared/buttonHelpers/returnKey.libsonnet`
职责：
- 中文 26 键、英文 26 键和数字键盘共用的回车键前景与 `returnKeyType` 通知辅助逻辑。

### `jsonnet/shared/styles/swipeKeyStyles.libsonnet`
职责：
- swipe 相关按键前景和提示气泡样式 helper。

## 10. 常见修改落点

### 改 `123Button`
- 中文 26 键：
  - `jsonnet/keyboards/common/systemKeys26/systemKeysSwitcher.libsonnet`
- 英文 26 键：
  - `jsonnet/keyboards/alphabetic26/systemKeys.libsonnet`
- iPad：
  - `jsonnet/keyboards/common/keyboard26/iPadBuilder.libsonnet`
- 共享 helper：
  - `jsonnet/shared/buttonHelpers/buttonInteraction.libsonnet`
- 配置：
  - `jsonnet/Custom.libsonnet` 中的 `button_123_config`
  - `button_123_config.show_swipe_indicators` 只控制 `123Button` 上下划角标显示，不影响 swipe 动作

### 改 9 键符号按钮
- `jsonnet/keyboards/pinyin9/builder.libsonnet`
- `jsonnet/Custom.libsonnet` 中的 `button_symbol_config`

### 改数字键盘符号按钮
- `jsonnet/keyboards/numeric9/builder.libsonnet`
- `jsonnet/Custom.libsonnet` 中的 `button_symbol_config`

### 改 9 键和数字键盘按钮交换位置
- 9 键：
  - `jsonnet/Custom.libsonnet` 中的 `swap_9_123_symbol`
  - `jsonnet/keyboards/pinyin9/layout.libsonnet`
- 数字键盘：
  - `jsonnet/Custom.libsonnet` 中的 `swap_numeric_return_symbol`
  - `jsonnet/keyboards/numeric9/layout.libsonnet`

### 改横屏 9 键
- 布局：
  - `jsonnet/keyboards/pinyin9/layout.libsonnet`
- 组件：
  - `jsonnet/keyboards/pinyin9/builder.libsonnet`

### 改横屏数字键盘
- iPhone 布局：
  - `jsonnet/keyboards/numeric9/layout.libsonnet`
- 组件：
  - `jsonnet/keyboards/numeric9/builder.libsonnet`
- iPad 数字键盘横屏：
  - 当前回退到竖屏布局，入口在 `jsonnet/keyboards/numeric9/iPad.libsonnet`


- `jsonnet/shared/toolbar/iPhone.libsonnet`
  - 读取 `horizon_candidate_button`，决定横向候选栏右侧显示展开按钮、收起键盘按钮或留空。

- `jsonnet/keyboards/common/keyboard26/layout.libsonnet`
  - iPad 26 键当前采用独立四行布局：首行删除、次行更宽回车、第三行双 Shift + Tab、底行双 123 + 逗号 + 中英切换 + 收起键盘。
- `jsonnet/keyboards/common/keyboard26/iPadBuilder.libsonnet`
  - 负责 iPad 专用按钮定义与尺寸覆写，包括 `tabButton`、`rightShiftButton`、`ipad123ButtonRight`、`dismissButton`。
  - 负责给底行逗号键补充上划句号动作，并保留逗号/句号双前景显示。
  - 负责让右侧 Shift 与左侧 Shift 使用一致的通知逻辑，并调整第二行 `a` 键留白、字母可视宽度、回车键宽度以及第三行左右边缘键宽度平衡。
- `jsonnet/keyboards/alphabetic26/iPad.libsonnet`
  - 负责英文 iPad 26 键入口覆写，包括与中文 iPad 26 键对齐的字母字号。
