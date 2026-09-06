# Playbooks

所有命令默认在 `<keyboard-root>` 运行。

## 修改 Custom 配置

1. 编辑 `jsonnet/Custom.libsonnet`。
2. 用 `rg '<option>' jsonnet` 检查全部读者。
3. 在最窄责任层实现行为。
4. 编译 `jsonnet/main.jsonnet`。
5. 更新 `README.md`、`MODULES.md` 和维护 skill。

常见读者：

- `keyboard_layout`：`build/keyboardRegistry`、`keyboard26/base/iPhoneLayout`、`keyboard26/base/letters`、`keyboard26/pinyin/builder`。
- `swipe_assist_mode`：`keyboard26/pinyin/swipeAssist` 和 `builder`。
- `button_123_config`：`components/key/interaction`、`components/systemKeys/keyboardSwitch`、英文 `systemKeys`、iPadBuilder。
- `button_symbol_config`：`components/key/interaction`、九键 builder、数字 builder。
- 功能行：`components/functionRow`、九键/数字布局和 `build/context`。

## 修改 26/27 键布局

1. 字母规格改 `keyboards/keyboard26/base/letters.libsonnet`。
2. 手机行结构改 `base/iPhoneLayout.libsonnet`。
3. iPad 行结构与尺寸改 `base/iPadLayout.libsonnet`。
4. iPad 按钮行为改 `base/iPadBuilder.libsonnet`。
5. 验证中文、英文、iPad，以及 `keyboard_layout = 26/27`。

## 修改滑动辅助

1. 模式解析、长按排序、索引、通知改 `keyboard26/pinyin/swipeAssist.libsonnet`。
2. 原始滑动/长按数据改 `keyboard26/pinyin/data.libsonnet`。
3. 保持 KP 显示文本和左右对称顺序。
4. 验证 `none`、`up`、`down`、`all`。
5. 检查通知冲突、滑动气泡显隐和长按默认索引。

## 修改拼音系统键

- 退格/空格/回车：`components/systemKeys/editing.libsonnet`
- Shift/中英切换：`components/systemKeys/inputMode.libsonnet`
- 123Button：`components/systemKeys/keyboardSwitch.libsonnet`
- 公共装配：`components/systemKeys/index.libsonnet`
- cn2en 动态长按数据：`components/systemKeys/longPressData.libsonnet`

修改后验证 26、14、17、18、九键；这些布局直接复用公共系统键。

## 修改英文系统键或临时拼音

1. 英文系统键改 `keyboard26/alphabetic/systemKeys.libsonnet`。
2. 非 26 键英文的 en2cn 上划与空格上划也在该文件。
3. 临时拼音覆写改 `keyboard26/tempPinyin/keyboard.libsonnet`。
4. 保持 temp_pinyin 中英键无通知，空格固定 `RIME`，上划 `Shift+space`。

## 修改分组拼音（14/17/18 键）

1. 共用构建改 `pinyinGrouped/base/builder.libsonnet`。
2. 复合按钮和系统键尺寸改 `base/buttons.libsonnet`。
3. 单一布局的行结构改对应 `layout.libsonnet`。
4. 键位规格、长按和滑动数据改对应 `data.libsonnet`。
5. 分别验证 14、17 和 18，不通过拼音 26 键间接验证。

## 修改九键或数字键盘

1. 位置、横竖屏树和交换配置改 `layout.libsonnet`。
2. 按钮动作/通知改 `builder.libsonnet`。
3. collection、纵向候选或符号面板改 `panels.libsonnet`。
4. 长按/滑动数据改 `data.libsonnet`。
5. 检查 `swap_9_123_symbol` 或 `swap_numeric_return_symbol`。

## 修改功能行

1. 动作、顺序和通知规则改 `components/functionRow/specs.libsonnet`。
2. SF Symbol 改 `components/functionRow/styles.libsonnet`。
3. 按钮生成和布局插入改 `components/functionRow/index.libsonnet`。
4. 检查 iPhone/iPad 开关、横屏九键和横屏数字键盘。

## 修改工具栏或候选栏

1. 新按钮 ID、Cell 和动作改 `components/toolbar/registry.libsonnet`。
2. 配置解析改 `components/toolbar/config.libsonnet`。
3. 固定按钮样式和动作改 `components/toolbar/iPhone.libsonnet`。
4. 布局或滑动方向改对应 Renderer。
5. 候选栏、尾部按钮、翻页和候选长按菜单改 `components/candidates.libsonnet`。
6. 检查 segmented、carousel、iPad center_slide 和 `horizon_candidate_button`。

## 修改视觉

1. 颜色、字号、偏移、动画、高度改 `design/appearance.libsonnet`。
2. 可复用样式函数改 `design/styleFactories.libsonnet`。
3. 基础按键背景改 `design/baseKeyStyles.libsonnet`。
4. 验证 light/dark、portrait/landscape、iPhone/iPad。

## 新增完整键盘输出

1. 在 `keyboards/<family>/` 创建独立入口、布局和数据。
2. 在 `build/keyboardRegistry.libsonnet` 注册模块。
3. 在 `build/skinConfig.libsonnet` 增加 config 映射。
4. 在 `main.jsonnet` 增加 render。
5. 不创建一行式 `entries/`。

## 回归验证

```bash
jsonnet jsonnet/main.jsonnet -o /tmp/WanxiangSkin.json
```

结构重构使用 Git 中修改前版本建立临时副本，逐项比较完整输出。至少覆盖：

- `keyboard_layout`: 9、14、17、18、26、27
- `swipe_assist_mode`: none、up、down、all
- light/dark
- portrait/landscape
- iPhone/iPad

最终使用 `rg -n "import .*?(shared/|entries/|keyboards/common/)" jsonnet` 确认源码中没有旧结构导入。
