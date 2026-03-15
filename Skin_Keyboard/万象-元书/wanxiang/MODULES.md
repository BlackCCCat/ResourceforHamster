# 模块清单文档

这份文档说明当前重构目录中各模块的职责，以及新增布局、按钮时应该改哪些文件。

## 一、总入口

### `jsonnet/Custom.libsonnet`

职责：

- 所有可调参数入口
- 控制布局、字号、toolbar、功能行、行为开关

什么时候改：

- 只是想开放配置，不改底层逻辑
- 想新增一个可选项让用户切换
- 想调整功能行按钮顺序

### `jsonnet/main.jsonnet`

职责：

- 统一导出 yaml
- 维护不同键盘类型和输出文件名之间的映射

什么时候改：

- 新增一种键盘输出
- 修改输出文件命名规则

## 二、keyboard 入口层

### `jsonnet/keyboard/`

职责：

- 每个文件代表一种键盘入口
- 现在多数文件只负责选 builder、选 spec、传配置

主要文件：

- `pinyin_26.jsonnet`
- `alphabetic_26.jsonnet`
- `pinyin_18.jsonnet`
- `pinyin_14.jsonnet`
- `pinyin_9.jsonnet`
- `numeric_9.jsonnet`
- `ipad_pinyin_26.jsonnet`
- `ipad_alphabetic_26.jsonnet`
- `ipad_numeric_9.jsonnet`
- `panel.jsonnet`

什么时候改：

- 新增一种完整键盘类型
- 调整某个键盘入口选择的 builder 或 spec

## 三、builder 层

### `jsonnet/lib/builders/`

职责：

- 负责把 layout、spec、样式、toolbar、系统键拼成最终键盘对象

主要文件：

- `keyboard26Builder.libsonnet`
  - 中文 26 键 builder
- `keyboard26AlphabeticBuilder.libsonnet`
  - 英文 26 键 builder
- `keyboard26ButtonFactory.libsonnet`
  - 26 键中英文共享按钮工厂
- `compactKeyboardBuilder.libsonnet`
  - 14 键 / 18 键共享 builder
- `pinyin9Builder.libsonnet`
  - 中文 9 键 builder
- `pinyin9ButtonFactory.libsonnet`
  - 中文 9 键按钮工厂
- `numeric9Builder.libsonnet`
  - 数字键盘 builder
- `ipad26Builder.libsonnet`
  - iPad 26 键中英文共享 overlay builder

什么时候改：

- 某类键盘的生成逻辑要变
- 想把重复逻辑继续抽成共享工厂

## 四、spec 层

### `jsonnet/lib/specs/`

职责：

- 只放声明式规格数据，尽量不直接拼大对象

主要文件：

- `compact14.libsonnet`
  - 14 键规格
- `compact18.libsonnet`
  - 18 键规格
- `compactShared.libsonnet`
  - 14/18 键共享模板解析
- `letter26Shared.libsonnet`
  - 26 键字母模板
- `systemKeysPinyin26.libsonnet`
  - 中文 26 键系统键总装
- `systemKeysAlphabetic26.libsonnet`
  - 英文 26 键系统键
- `pinyinSystemKeysShift.libsonnet`
- `pinyinSystemKeysBackspace.libsonnet`
- `pinyinSystemKeysCn2en.libsonnet`
- `pinyinSystemKeysSwitcher.libsonnet`
- `pinyinSystemKeysSpace.libsonnet`
- `pinyinSystemKeysEnter.libsonnet`
  - 中文 26 键系统键拆分模块
- `pinyin9T9.libsonnet`
  - 中文 9 键 T9 映射

什么时候改：

- 新增一个紧凑键布局
- 修改某类系统键的规格
- 调整 26 键字母模板尺寸规则

## 五、layout 层

### `jsonnet/lib/layout/`

职责：

- 统一管理布局基底与 function-row patch

主要文件：

- `keyboardLayoutBaseData.libsonnet`
  - 无 function-row 的基础布局数据
  - 同时负责 9 键底行基础槽位定义，例如 `wanxiang_9_swap_123_and_symbol` 对 `123` 与符号按钮位置/尺寸的交换
- `keyboardLayoutBase.libsonnet`
  - base 数据入口
- `keyboardLayoutFuncRowPatch.libsonnet`
  - function-row patch
- `keyboardLayouts.libsonnet`
  - 对外统一布局解析入口

什么时候改：

- 新增一种布局结构
- 调整按键排列
- 调整带功能行/不带功能行的布局差异

## 六、toolbar 层

### `jsonnet/lib/toolbar/`

职责：

- toolbar 按钮注册、配置解析、布局渲染

主要文件：

- `shared.libsonnet`
  - toolbar 配置读取与通用 helper
- `registry.libsonnet`
  - 按钮注册表，包含 iPhone / iPad 共用的皮肤管理与皮肤调整按钮映射
- `iPhoneRenderer.libsonnet`
  - iPhone toolbar 渲染
- `ipadRenderer.libsonnet`
  - iPad toolbar 渲染

入口文件：

- `jsonnet/lib/toolbar/index.libsonnet`
- `jsonnet/lib/toolbar/ipad.libsonnet`
- `jsonnet/lib/toolbar/en.libsonnet`

什么时候改：

- 新增 toolbar 按钮
- 调整 toolbar 布局模式
- 调整 iPhone/iPad toolbar 配置行为

## 七、functionButton 层

### `jsonnet/lib/functionButtons/`

职责：

- 管理功能行按钮的规格和构建
- 管理功能行按钮专用前景样式

主要文件：

- `specs.libsonnet`
- `builder.libsonnet`
- `styles.libsonnet`
- `styleSpecs.libsonnet`

入口文件：

- `jsonnet/lib/functionButtons/index.libsonnet`

什么时候改：

- 修改功能行按钮顺序
- 修改功能行按钮动作
- 新增功能行按钮
- 调整功能行按钮数量变化时的宽度分配

配置来源：

- `jsonnet/Custom.libsonnet` 中的 `function_button_config.with_functions_row`
- `jsonnet/Custom.libsonnet` 中的 `function_button_config.order`
- `jsonnet/Custom.libsonnet` 中的 `function_button_config.enable_notification`
- `jsonnet/lib/functionButtons/specs.libsonnet` 中的 `defaultOrderedKeys`

## 八、utils / swipe / 样式层

### `jsonnet/lib/utils/`

职责：

- 通用样式生成 helper
- 字母键与数字键的批量样式生成
- 不再承载功能按键专用样式

主要文件：

- `jsonnet/lib/utils/index.libsonnet`
- `jsonnet/lib/utils/shared.libsonnet`
- `jsonnet/lib/utils/specs.libsonnet`

### `jsonnet/lib/swipe/`

职责：

- swipe 样式共享 helper

主要文件：

- `jsonnet/lib/swipe/index.libsonnet`
- `jsonnet/lib/swipe/shared.libsonnet`

### 其他共享数据/样式

- `jsonnet/lib/shared/color.libsonnet`
- `jsonnet/lib/shared/fontSize.libsonnet`
- `jsonnet/lib/shared/center.libsonnet`
- `jsonnet/lib/shared/animation.libsonnet`
- `jsonnet/lib/data/hintSymbolsData.libsonnet`
- `jsonnet/lib/shared/hintSymbolsStyles.libsonnet`
- `jsonnet/lib/data/swipeData.libsonnet`
- `jsonnet/lib/data/swipeData-en.libsonnet`
- `jsonnet/lib/shared/others.libsonnet`

什么时候改：

- 调整颜色、字号、偏移、上划/下划显示
- 调整长按候选或符号数据

## 九、新增一个布局时改哪些文件

按布局类型分情况。

### 1. 新增一个 14/18 这种紧凑布局

通常需要改：

- `jsonnet/lib/specs/`
  - 新增一个规格文件，例如 `compact17.libsonnet`
- `jsonnet/keyboard/`
  - 新增入口文件，例如 `pinyin_17.jsonnet`
- `jsonnet/main.jsonnet`
  - 如果需要作为新的导出目标，就要补映射
- `jsonnet/lib/layout/`
  - 如果布局结构和现有 14/18 不同，需要补布局尺寸/排列
- `jsonnet/Custom.libsonnet`
  - 如果要让用户可切换到这个布局，需要新增配置值

### 2. 新增一个 26 键变体

通常需要改：

- `jsonnet/lib/builders/keyboard26Builder.libsonnet`
  - 如果只是小差异，可能不用改 builder
- `jsonnet/lib/specs/letter26Shared.libsonnet`
  - 如果字母模板有变化
- `jsonnet/lib/specs/systemKeysPinyin26.libsonnet`
  - 如果系统键组合变了
- `jsonnet/keyboard/`
  - 新增对应入口

### 3. 新增一个 iPad 26 键变体

通常需要改：

- `jsonnet/lib/builders/ipad26Builder.libsonnet`
  - 若共享逻辑足够，通常不用改
- `jsonnet/keyboard/ipad_*.jsonnet`
  - 新增一个 config 入口
- `jsonnet/lib/ipad/common.libsonnet`
  - 若 iPad 专属按钮或 patch 有变化

## 十、新增一个按钮时改哪些文件

按按钮类型分情况。

### 1. 新增普通字母键

通常需要改：

- `jsonnet/lib/specs/letter26Shared.libsonnet`
  - 26 键模板
或
- `jsonnet/lib/specs/compact*.libsonnet`
  - 紧凑布局规格
或
- `jsonnet/lib/specs/pinyin9T9.libsonnet`
  - 9 键映射

- `jsonnet/lib/layout/`
  - 如果位置变化，需要补布局排列

### 2. 新增系统键

通常需要改：

- 中文 26 键：
  - `jsonnet/lib/specs/systemKeysPinyin26.libsonnet`
  - 或具体子模块，例如 `pinyinSystemKeysSpace.libsonnet`
- 英文 26 键：
  - `jsonnet/lib/specs/systemKeysAlphabetic26.libsonnet`
- 如涉及共用按钮生成：
  - `jsonnet/lib/builders/keyboard26ButtonFactory.libsonnet`

### 3. 新增 toolbar 按钮

通常需要改：

- `jsonnet/lib/toolbar/registry.libsonnet`
  - 注册按钮 ID、样式和动作
- `jsonnet/Custom.libsonnet`
  - 如果要让用户在配置里使用这个按钮 ID
- 如布局规则需要变化：
  - `jsonnet/lib/toolbar/iPhoneRenderer.libsonnet`
  - `jsonnet/lib/toolbar/ipadRenderer.libsonnet`

### 4. 新增功能行按钮

通常需要改：

- `jsonnet/lib/functionButtons/specs.libsonnet`
- 必要时：
  - `jsonnet/lib/functionButtons/builder.libsonnet`
