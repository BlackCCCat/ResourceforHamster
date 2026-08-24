---
name: wanxiang-skin-maintainer
description: Use when modifying the WanxiangSkin Hamster3 keyboard under ResourceforHamster, including Custom.libsonnet options, keyboard layouts, button actions, swipe/long-press data, system keys, function rows, toolbars, candidates, iPad behavior, or synchronized README/MODULES updates.
---

# WanxiangSkin Maintainer

一次任务只处理一个 `<keyboard-root>`，通常为 `Skin_Keyboard/万象-元书/WanxiangSkin`。除非用户明确要求跨目录操作，源码、验证和文档修改都限制在该皮肤及其对应维护 skill。

## 必须保持的边界

- `main.jsonnet` 只引用 `build`，键盘入口通过 `build/context.libsonnet` 解析设备与布局上下文。
- `components` 不引用具体键盘族。
- `design` 不引用 `components` 或具体键盘族。
- 键盘专属长按和滑动数据位于对应键盘族的 `data.libsonnet`。
- `tempPinyin` 可以复用拼音 26 键，因为它是明确的薄覆写入口。
- `Custom.libsonnet` 是公开配置唯一入口。
- 不重新创建 `entries/`、`shared/` 或 `keyboards/common/`。

## 工作流程

1. 读取 `<keyboard-root>/MODULES.md` 和 `references/file-map.md`。
2. 用 `rg` 定位配置、按钮名、动作和样式的全部读者。
3. 修改最窄责任层，先数据/规格，再 builder，最后布局。
4. 每批修改后运行 `jsonnet jsonnet/main.jsonnet -o /tmp/WanxiangSkin.json`。
5. 公共层修改同时验证浅色/深色、横屏/竖屏、iPhone/iPad。
6. 布局选择或滑动辅助修改验证 9/14/18/26/27 与 `none/up/down/all`。
7. 公开配置或目录职责变化同步更新 `README.md`、`MODULES.md` 和本 skill。

## 修改优先级

- 配置：`jsonnet/Custom.libsonnet`
- 构建映射：`jsonnet/build/`
- 颜色/字号/偏移/高度：`jsonnet/design/appearance.libsonnet`
- 样式函数：`jsonnet/design/styleFactories.libsonnet`
- 通用按键交互：`jsonnet/components/key/`
- 拼音系统键：`jsonnet/components/systemKeys/`
- 功能行：`jsonnet/components/functionRow/`
- 工具栏：`jsonnet/components/toolbar/`
- 候选栏：`jsonnet/components/candidates.libsonnet`
- 键盘专属行为：对应 `jsonnet/keyboards/<family>/`

## 不可回退的数据

- `jsonnet/components/systemKeys/longPressData.libsonnet` 中 `cn2en.list` 使用 `rimeOptionLabel$<option>` 动态标签。
- 中文 26 键 KP 标签以 `jsonnet/keyboards/keyboard26/pinyin/data.libsonnet` 当前文本为准。
- iPad 已调尺寸位于 `jsonnet/keyboards/keyboard26/base/iPadLayout.libsonnet`，除非需求明确涉及布局尺寸，不做顺带调整。

## 功能要点

- `keyboard_layout = 27`：中文 26 键第二行追加 `;`。
- `swipe_assist_mode`：仅中文 26 键；`none` 使用原通知，其他模式使用 `preeditChanged` 辅助通知并重排长按菜单。
- `button_123_config.show_swipe_indicators`：只控制 123Button 角标，不控制动作。
- `button_symbol_config`：九键/数字键盘符号按钮交互，不改变位置交换配置。
- `horizon_candidate_button`：横向候选栏尾部按钮。
- `temp_pinyin`：返回英文键盘、固定 RIME 空格、上划 `Shift+space`。
- 工具栏可选 `simplified_traditional`、`undo`、`redo`、`cut`、`copy`、`paste`。

## 验证

```bash
cd <keyboard-root>
jsonnet jsonnet/main.jsonnet -o /tmp/WanxiangSkin.json
```

针对单个键盘可直接导入其 `keyboard.libsonnet` 调用 `new(theme, orientation)`。完整路径和操作清单见 `references/file-map.md` 与 `references/playbooks.md`。
