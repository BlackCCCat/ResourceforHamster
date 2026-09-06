# File Map

所有路径相对 `<keyboard-root>`。

## 入口与构建

- `jsonnet/Custom.libsonnet`：公开配置。
- `jsonnet/main.jsonnet`：最终渲染。
- `jsonnet/build/skinConfig.libsonnet`：config 映射。
- `jsonnet/build/keyboardRegistry.libsonnet`：输出键盘注册和拼音布局选择。
- `jsonnet/build/context.libsonnet`：设备上下文、基础尺寸、布局汇总和功能行插入。

## 视觉

- `jsonnet/design/appearance.libsonnet`：animation、center、color、fontSize、others。
- `jsonnet/design/styleFactories.libsonnet`：文本、图片、SF Symbol、geometry 工厂。
- `jsonnet/design/baseKeyStyles.libsonnet`：基础按键背景和长按背景引用。

## 按键组件

- `jsonnet/components/key/factory.libsonnet`：按键、状态前景、长按包装和回车通知工厂。
- `jsonnet/components/key/interaction.libsonnet`：123Button/symbolButton 配置解析。
- `jsonnet/components/key/longPress.libsonnet`：长按样式生成。
- `jsonnet/components/key/swipe.libsonnet`：上下划与滑动气泡样式。

## 拼音系统键

- `jsonnet/components/systemKeys/index.libsonnet`：公共装配入口。
- `jsonnet/components/systemKeys/editing.libsonnet`：退格、空格、回车。
- `jsonnet/components/systemKeys/inputMode.libsonnet`：Shift、中英切换。
- `jsonnet/components/systemKeys/keyboardSwitch.libsonnet`：123Button。
- `jsonnet/components/systemKeys/longPressData.libsonnet`：cn2en、spaceLeft、enter 长按数据。
- `jsonnet/components/systemKeys/swipeData.libsonnet`：公共系统键滑动动作。

## 功能行、工具栏与候选

- `jsonnet/components/functionRow/index.libsonnet`：按钮与布局补丁。
- `jsonnet/components/functionRow/specs.libsonnet`：动作、顺序、通知。
- `jsonnet/components/functionRow/styles.libsonnet`：前景。
- `jsonnet/components/toolbar/config.libsonnet`：配置解析。
- `jsonnet/components/toolbar/registry.libsonnet`：可选按钮注册。
- `jsonnet/components/toolbar/iPhone.libsonnet`、`iPad.libsonnet`：平台入口。
- `jsonnet/components/toolbar/iPhoneRenderer.libsonnet`、`iPadRenderer.libsonnet`：布局渲染。
- `jsonnet/components/candidates.libsonnet`：候选栏与候选词长按菜单。

## 26/27 键

- `jsonnet/keyboards/keyboard26/base/letters.libsonnet`：字母规格。
- `jsonnet/keyboards/keyboard26/base/iPhoneLayout.libsonnet`：手机布局。
- `jsonnet/keyboards/keyboard26/base/iPadLayout.libsonnet`：iPad 布局尺寸。
- `jsonnet/keyboards/keyboard26/base/iPadBuilder.libsonnet`：iPad 覆写。
- `jsonnet/keyboards/keyboard26/pinyin/keyboard.libsonnet`：中文入口。
- `jsonnet/keyboards/keyboard26/pinyin/builder.libsonnet`：中文装配。
- `jsonnet/keyboards/keyboard26/pinyin/data.libsonnet`：中文长按/滑动数据。
- `jsonnet/keyboards/keyboard26/pinyin/swipeAssist.libsonnet`：滑动辅助。
- `jsonnet/keyboards/keyboard26/pinyin/iPad.libsonnet`：中文 iPad。
- `jsonnet/keyboards/keyboard26/alphabetic/keyboard.libsonnet`、`iPad.libsonnet`：英文入口。
- `jsonnet/keyboards/keyboard26/alphabetic/builder.libsonnet`：英文装配。
- `jsonnet/keyboards/keyboard26/alphabetic/systemKeys.libsonnet`：英文系统键。
- `jsonnet/keyboards/keyboard26/alphabetic/data.libsonnet`：英文数据。
- `jsonnet/keyboards/keyboard26/tempPinyin/keyboard.libsonnet`：临时拼音薄覆写。

## 分组拼音（14/17/18 键）

- `jsonnet/keyboards/pinyinGrouped/base/builder.libsonnet`：共用装配。
- `jsonnet/keyboards/pinyinGrouped/base/buttons.libsonnet`：复合键与系统键尺寸。
- `jsonnet/keyboards/pinyinGrouped/base/specFactory.libsonnet`：规格模板。
- `jsonnet/keyboards/pinyinGrouped/pinyin14/{keyboard,layout,data}.libsonnet`
- `jsonnet/keyboards/pinyinGrouped/pinyin17/{keyboard,layout,data}.libsonnet`
- `jsonnet/keyboards/pinyinGrouped/pinyin18/{keyboard,layout,data}.libsonnet`

## 九键、数字与浮动面板

- `jsonnet/keyboards/pinyin9/{keyboard,layout,builder,panels,data}.libsonnet`
- `jsonnet/keyboards/numeric9/{keyboard,layout,builder,panels,data}.libsonnet`
- `jsonnet/keyboards/numeric9/iPad.libsonnet`
- `jsonnet/keyboards/floatPanel/keyboard.libsonnet`

## 文档

- `README.md`：公开结构和配置说明。
- `MODULES.md`：维护职责与落点。
