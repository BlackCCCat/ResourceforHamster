# 万象键盘 Android 原生图标版

基于同目录下的 `WanxiangSkin`，独立维护安卓兼容配置。原 iOS 皮肤源码保持不变。本版用元书官方支持的 `systemImageName: material:图标名` 显示安卓原生图标，移除旧版自定义图标字体、`fontFace` 声明及私用区字符，避免部分手机显示空白或其他文字。

官方说明：https://ihsiao.com/apps/hamster/v3/docs/guides/skins/styles/#systemimage

## 保留的功能

- 默认中文 26 键，可配置 9/14/17/18/26/27 键；支持横竖屏、深浅色。
- Z 下滑进入万象 `V` 计算模式并切到数字键盘，显示安卓计算器图标；英文键盘及 14/18 键的计算入口同步处理。
- 固定与滑动剪贴板入口均先读取当前系统剪贴板，再打开元书剪贴板面板。
- 日期快捷键使用 `orq`；动作使用 `shortcut`；默认不显示 iOS App Store 搜索入口。
- 复制使用 `content_copy`，粘贴使用 `content_paste`，删除使用 `backspace`，数字入口直接显示普通文字 `123`。

图标由元书 Android 应用绘制，形状与 iOS 不完全相同。皮肤不打包苹果图标、图标字体或字体导出工具。用户在元书中自行选择的普通文字字体继续由应用管理。

核心配置在 `jsonnet/Custom.libsonnet`。计算器、日期、金额转换等功能依赖已部署的万象方案及对应 Lua 模块。

工具栏第二个指令入口使用 `terminal`，第三个使用 `auto_awesome` 星光标识，表情左侧的符号键盘入口使用 `emoji_symbols`。本次图标调整保留各入口原动作；第三个仍调用 `#toggleSymbolBar`。Google、Bing、百度搜索分别使用 `search`、`travel_explore`、`manage_search` 区分。

## 测试

本版经本地配置检查和用户手机试用确认。不同设备及元书版本仍需实际验证；导入后可检查工具栏、功能行、Shift/大写、删除、123、Z 下滑、长按菜单和深浅色切换。

本地测试命令：

```sh
python -m pip install jsonnet pyyaml
python Python_Tools/WanxiangAndroid/verify_actions.py
```

检查覆盖六种布局，77 份输出、38 组深浅色配对；校验原生图标名称、无字体私用区字符、无自定义字体依赖，以及计算器/剪贴板动作。另见 `Python_Tools/WanxiangAndroid/README.md`。

剪贴板持久历史由元书应用管理，本皮肤不能恢复未记录的内容。系统主题切换后底部出现空白时，可检查元书「键盘底部安全区域」设置。
