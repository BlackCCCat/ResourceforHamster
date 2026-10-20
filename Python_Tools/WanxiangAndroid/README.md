# 万象 Android 兼容测试工具

`verify_actions.py` 核对六种布局、深浅色和横竖屏中的计算器、剪贴板动作、日期触发词和字体范围；`verify_theme_geometry.py` 检查深浅色配置只存在颜色差异。

```sh
python -m pip install jsonnet fonttools pyyaml
python Python_Tools/WanxiangAndroid/verify_actions.py
```

`export_symbols.swift` 和 `build_font.py` 记录本次测试资源的生成方式。图标来源和使用范围见皮肤 `fonts/NOTICE.md`，图标字体不属于仓库 MIT 许可。记录生成方式不授予 Android 分发权。

```sh
python -m pip install fonttools pillow vtracer
swift Python_Tools/WanxiangAndroid/export_symbols.swift Python_Tools/WanxiangAndroid/symbols.json /tmp/wanxiang-symbols
python Python_Tools/WanxiangAndroid/build_font.py /tmp/wanxiang-symbols Skin_Keyboard/万象-元书/WanxiangSkin-Android
```

字体只占 U+E000—U+E0A5，普通汉字、字母、数字和标点不使用该字体。字重已经保存在字形中。代码绘制的计算器不依赖系统图标导出。
