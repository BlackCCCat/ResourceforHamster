# 万象 Android 配置验证

本轮使用元书官方支持的 `material:` 图标名称，已移除内置图标字体及字体导出流程。

```sh
python -m pip install jsonnet pyyaml
python Python_Tools/WanxiangAndroid/verify_actions.py
```

`verify_actions.py` 生成六种布局的横竖屏、深浅色配置，检查：

- 所有图标都直接使用安卓 `material:` 名称。
- 输出不含字体私用区字符，`config.yaml` 没有 `fontFace`，皮肤不包含 `fonts` 目录。
- 中英文 Z 下滑调用计算器并显示计算器图标。
- 固定与滑动剪贴板入口动作一致，日期触发词正确。
- `verify_theme_geometry.py` 确认深浅色只存在配色差异。

可使用 `--dump /tmp/wanxiang-render.json` 保存生成结果。这些检查不模拟 Android 手机实际渲染、系统剪贴板或宿主应用。
