# 使用说明

**详细使用说明请查看:**

`https://github.com/BlackCCCat/ResourceforHamster/tree/main/Skin_Keyboard/万象-元书/README.md`

**注意事项**
1. 建议和自定义配置(`https://github.com/BlackCCCat/ResourceforHamster/tree/main/Input_Method/万象拼音/Rime4Hamster`)一起使用，尤其是自定义按键部分

2. 打开元书输入法键盘皮肤中的“启动皮肤开发者模式”，导入后点击皮肤，或者在导入皮肤后长按手动运行`main.jsonnet`，两种方式来生成皮肤配置文件

3. 关于功能按键：如果不需要，可在`custom/Custom.libsonnet`中将`with_functions_row`值改为`false`,iPad布局默认不开启功能按键；如果不需要通知功能，可在`custom/Custom.libsonnet`中将`enable_functions_notification`值改为`false`

4. 关于某些按钮显示空白：可以在`custom/Custom.libsonnet`中将`fix_sf_symbol`值改为`true`

5. 26个按键显示为大写：可以在`custom/Custom.libsonnet`中将`is_letter_capital`值改为`true`

6. tips上屏按键：可以在`custom/Custom.libsonnet`中将`tips_button_action`值改为`{ character: ','}`，即为万象默认的tips上屏方式

7. 空格取消显示“万象”标识：可以在`custom/Custom.libsonnet`中将`show_wanxiang`值改为`false`

8. 字母按键和系统按键颜色统一（iOS26风格）默认开启，可以在`custom/Custom.libsonnet`中将`ios26_style`值改为`false`

9. 按键间距，可在`custom/Custom.libsonnet`中修改`button_insets`

10. 按键圆角，可在`custom/Custom.libsonnet`中修改`cornerRadius`的值，建议`7`、`8`、`8.5`

11. `shift`按键是否开启通知动作，默认为开启且为pro版的辅助码合并，请在`custom/Custom.libsonnet`中修改`enable_preedit`为`false`

12. `shift`按键通知动作自定义，默认为`/`，请在`custom/Custom.libsonnet`中修改`preedit_action`

13. `shift`按键通知动作前景样式，默认为`/`对应的sf symbol，请在`custom/Custom.libsonnet`中修改`preedit_sf_symbol`

14. 关于键盘布局，iOS支持多种布局：9键、14键、18键、26键，可在`custom/Custom.libsonnet`中修改`keyboard_layout`的值

15. 候选栏开启展开按钮：可在`custom/Custom.libsonnet`将`showExpandButton`的值改为`true`

# 获取更新
请到ResourceforHamster(`https://github.com/BlackCCCat/ResourceforHamster`)获取可能的更新，或者通过快捷指令(https://www.icloud.com/shortcuts/c541ddb2a1614732b2c9fde38bb89be6)自动下载最新版本并导入到元书输入法中

- `万象-元书.cskin`（对应release中`wanxiang.cskin`）
