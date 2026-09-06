# WanxiangSkin 模块说明

本文描述当前源码结构、依赖边界和常见修改的优先落点。

## 1. 构建入口

### `jsonnet/main.jsonnet`

- 只负责按浅色/深色、横屏/竖屏渲染已注册键盘。
- 不放键盘选择、布局或按钮实现。

### `jsonnet/Custom.libsonnet`

- 所有公开配置的唯一入口。
- 新增配置时同步更新 `README.md`、本文件和维护 skill。

### `jsonnet/build/`

- `skinConfig.libsonnet`：皮肤元信息和 `config.yaml` 键盘映射。
- `keyboardRegistry.libsonnet`：按 `keyboard_layout` 选择拼音键盘并注册所有输出模块。
- `context.libsonnet`：设备上下文、基础尺寸、键盘布局汇总和功能行插入。

旧的一行式 `entries/` 已取消。新增完整输出键盘时直接更新 `keyboardRegistry.libsonnet`、`skinConfig.libsonnet` 和 `main.jsonnet`。

## 2. 视觉层

### `jsonnet/design/appearance.libsonnet`

- `animation`：按键动画。
- `center`：前景与提示偏移。
- `color`：浅色、深色及 iOS 26 覆写颜色。
- `fontSize`：各键盘和组件字号。
- `others`：预编辑、工具栏和键盘高度。

### `jsonnet/design/styleFactories.libsonnet`

- 生成文本、SF Symbol、资源图片和 geometry 样式。
- 新的重复样式优先扩展此文件，不在键盘 builder 中复制对象。

### `jsonnet/design/baseKeyStyles.libsonnet`

- 生成字母键背景、系统键背景、蓝色回车背景、按键动画和长按背景引用。

## 3. 公共组件

### `jsonnet/components/key/`

- `factory.libsonnet`：文字状态、数字状态、普通按钮、长按包装和回车通知工厂。
- `interaction.libsonnet`：123Button 与 symbolButton 配置解析、长按数据和滑动目标。
- `longPress.libsonnet`：长按菜单背景、选中样式和各项前景。
- `swipe.libsonnet`：上下划前景、滑动气泡和滑动键盘切换样式。

### `jsonnet/components/systemKeys/`

- `index.libsonnet`：可供 26、14、17、18、九键复用的拼音系统键装配。
- `editing.libsonnet`：退格、空格和回车。
- `inputMode.libsonnet`：Shift 与中英切换。
- `keyboardSwitch.libsonnet`：123Button。
- `longPressData.libsonnet`：中英切换、空格左键和回车的共用长按数据；`cn2en` 使用 `rimeOptionLabel$<option>` 动态标签。
- `swipeData.libsonnet`：系统键共用上下划动作。

### `jsonnet/components/functionRow/`

- `index.libsonnet`：功能按钮生成和功能行布局补丁。
- `specs.libsonnet`：顺序、动作、通知动作和通知启用规则。
- `styles.libsonnet`：功能按钮 SF Symbol 前景。

### `jsonnet/components/toolbar/`

- `config.libsonnet`：配置读取、ID 校验和数据源项生成。
- `registry.libsonnet`：可配置按钮 ID、Cell、样式名和动作。
- `iPhone.libsonnet`、`iPad.libsonnet`：平台工具栏入口。
- `iPhoneRenderer.libsonnet`、`iPadRenderer.libsonnet`：布局与滑动数据源渲染。

### `jsonnet/components/candidates.libsonnet`

- 横向候选、纵向候选、展开/翻页/返回/删除按钮。
- `candidateContextMenu` 的“左移、右移、重置、置顶、移除”。

## 4. 键盘族

### `jsonnet/keyboards/keyboard26/base/`

- `letters.libsonnet`：26/27 键字母规格。
- `iPhoneLayout.libsonnet`：手机中文/英文 26/27 键横竖屏布局。
- `iPadLayout.libsonnet`：iPad 中文/英文独立四行布局和尺寸。
- `iPadBuilder.libsonnet`：iPad 按钮、字号、工具栏和系统键覆写。

### `jsonnet/keyboards/keyboard26/pinyin/`

- `keyboard.libsonnet`：中文 26/27 键入口。
- `builder.libsonnet`：字母键、样式、工具栏和公共系统键装配。
- `data.libsonnet`：拼音长按与上下划数据；KP 标签以该文件当前内容为准。
- `swipeAssist.libsonnet`：`swipe_assist_mode` 的长按重排、默认索引和通知动作。
- `iPad.libsonnet`：中文 iPad 入口。

### `jsonnet/keyboards/keyboard26/alphabetic/`

- `keyboard.libsonnet`、`iPad.libsonnet`：英文入口。
- `builder.libsonnet`：英文 26 键装配。
- `systemKeys.libsonnet`：英文系统键、非 26 键英文返回路径和临时拼音动作。
- `data.libsonnet`：英文长按与上下划数据。

### `jsonnet/keyboards/keyboard26/tempPinyin/`

- `keyboard.libsonnet`：有意复用拼音 26 键，只覆写返回英文键盘和 RIME 空格行为。

### `jsonnet/keyboards/pinyinGrouped/`

- `base/builder.libsonnet`：分组拼音 14/17/18 键共用装配。
- `base/buttons.libsonnet`：复合字母键和公共系统键尺寸覆写。
- `base/specFactory.libsonnet`：按方向解析键位模板。
- `pinyin14/`、`pinyin17/`、`pinyin18/`：各自的 `keyboard`、`layout` 和 `data`。
- 三个布局直接复用 `components/systemKeys`，不构建完整拼音 26 键。

### `jsonnet/keyboards/pinyin9/`

- `keyboard.libsonnet`：入口。
- `layout.libsonnet`：横竖屏布局、功能行和底行位置交换。
- `builder.libsonnet`：九键按钮、通知、公共系统键和样式装配。
- `panels.libsonnet`：collection 与纵向候选组件。
- `data.libsonnet`：T9 字母分组、长按和上下划数据。

### `jsonnet/keyboards/numeric9/`

- `keyboard.libsonnet`、`iPad.libsonnet`：手机和平板入口。
- `layout.libsonnet`：横竖屏布局和底行位置交换。
- `builder.libsonnet`：数字键、返回键、符号键和样式装配。
- `panels.libsonnet`：数字符号面板。
- `data.libsonnet`：数字长按和空格上下划数据。

### `jsonnet/keyboards/floatPanel/keyboard.libsonnet`

- 浮动面板键盘的按钮、布局、样式和动作完整实现。

## 5. 常见修改落点

| 需求 | 优先文件 |
| --- | --- |
| 新增公开配置 | `jsonnet/Custom.libsonnet` |
| 改 26/27 键行结构 | `keyboards/keyboard26/base/iPhoneLayout.libsonnet` |
| 改 iPad 四行布局尺寸 | `keyboards/keyboard26/base/iPadLayout.libsonnet` |
| 改 iPad 按钮行为 | `keyboards/keyboard26/base/iPadBuilder.libsonnet` |
| 改拼音滑动辅助 | `keyboards/keyboard26/pinyin/swipeAssist.libsonnet` |
| 改拼音/英文长按或滑动数据 | 对应键盘族的 `data.libsonnet` |
| 改拼音系统键 | `components/systemKeys/` |
| 改英文系统键 | `keyboards/keyboard26/alphabetic/systemKeys.libsonnet` |
| 改分组拼音共同行为 | `keyboards/pinyinGrouped/base/` |
| 改九键或数字布局 | 对应目录的 `layout.libsonnet` |
| 改 123/symbol 配置解析 | `components/key/interaction.libsonnet` |
| 改功能行 | `components/functionRow/` |
| 改工具栏按钮 | `components/toolbar/registry.libsonnet` 和 `iPhone.libsonnet` |
| 改候选栏或候选长按菜单 | `components/candidates.libsonnet` |
| 改颜色/字号/偏移/高度 | `design/appearance.libsonnet` |
| 改通用样式生成 | `design/styleFactories.libsonnet` |

## 6. 维护规则

- 功能或样式修改放在最窄的责任层；多个键盘使用的能力才进入 `components` 或 `design`。
- 键盘专属数据保留在对应键盘族，不重新建立全局 `shared/data`。
- `components` 不引用具体键盘族；`tempPinyin → pinyin` 是明确的薄覆写例外。
- 注释描述模块职责、参数含义或生成结果，不使用提醒式措辞。
- 保留 `cn2en` 的动态 Rime 标签和当前 KP 显示文本。
- 结构调整必须对比重构前后的完整 `main.jsonnet` 输出。
