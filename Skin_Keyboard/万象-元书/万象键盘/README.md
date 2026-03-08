# 使用说明

详细使用说明请查看：

`https://github.com/BlackCCCat/ResourceforHamster/tree/main/Skin_Keyboard/万象-元书/README.md`

## 使用方式

- 建议配合自定义配置仓一起使用，尤其是自定义按键部分：
  `https://github.com/BlackCCCat/ResourceforHamster/tree/main/Input_Method/万象拼音/Rime4Hamster`
- 打开元书输入法键盘皮肤中的“启动皮肤开发者模式”。
- 导入后点击皮肤，或在导入后长按手动运行 `main.jsonnet`，即可生成皮肤配置文件。
- 当前自定义配置文件路径为 `jsonnet/Custom.libsonnet`。

## 基础配置

- `with_functions_row`
  - 控制是否启用功能行。
  - 按设备区分：`iPhone` 和 `iPad`。
  - 默认 iPad 不启用功能行。

- `keyboard_layout`
  - 当前中文键盘布局。
  - 可选值：`26`、`18`、`14`、`9`。
  - 其他值会回退到 `26`。

- `wanxiang_9_hintSymbol`
  - 控制 9 键长按符号是否直接上屏。

- `is_wanxiang_18`
  - 控制 18 键是否使用万象转写规则。

- `is_wanxiang_14`
  - 控制 14 键是否使用万象转写规则。

- `enable_functions_notification`
  - 控制功能按键通知功能是否启用。

- `is_letter_capital`
  - 控制 26 字母按键是否显示大写。

- `fix_sf_symbol`
  - 修复部分 SF Symbol 显示空白的问题。

- `show_swipe`
  - 控制是否显示上下划前景。

- `tips_button_action`
  - 控制 tips 上屏按键动作。
  - 万象默认方式可改为 `{ character: ',' }`。

- `show_wanxiang`
  - 控制空格键是否显示“万象”标识。

- `ios26_style`
  - 控制是否启用 iOS26 风格。
  - 开启后字母按键和系统按键颜色统一。

- `showExpandButton`
  - 控制候选栏是否显示展开按钮。

## 字体与样式

- `font_size_config`
  - 字号独立配置。
  - `pinyin_26_letter_font_size`：26 键字母按键字号。
  - `pinyin_14_18_letter_font_size`：14 键 / 18 键字母按键字号。
  - `pinyin_9_letter_font_size`：9 键字母按键字号。
  - `numeric_digit_font_size`：数字键盘数字字号。

- `button_insets`
  - 按键间距配置。
  - 分为 `portrait` 和 `landscape`。

- `cornerRadius`
  - 按键圆角。
  - 建议值：`7`、`8`、`8.5`。

## Shift 配置

- `shift_config.enable_preedit`
  - 控制 26 键 `shift` 是否启用预编辑通知动作。

- `shift_config.preedit_action`
  - 控制 `shift` 在预编辑状态下的动作。

- `shift_config.preedit_sf_symbol`
  - 控制 `shift` 在预编辑状态下显示的 SF Symbol。
  - 留空时使用默认图标。

- `shift_config.preedit_swipeup_action`
  - 控制 26 键 `shift` 在预编辑状态下的上划动作。
  - 可选值：`辅助筛选`、`分词`。

## 工具栏配置

### iPhone 工具栏

- 配置入口：`toolbar_config`

- `toolbar_config.toolbar_menu`
  - 控制 `menu_or_panel` 按钮是打开键盘菜单还是打开皮肤内置浮动键盘。
  - `false`：使用皮肤内置浮动键盘。
  - `true`：使用 app 的 `keyboardMenu`。

- `toolbar_config.mode`
  - iPhone 工具栏布局模式。
  - 可选值：`segmented`、`carousel`。

- `segmented`
  - 布局结构：
    固定按钮 + 左侧横向滑动 + 固定中间按钮 + 右侧横向滑动 + 固定收起按钮。
  - 对应配置：
    `segmented.left_fixed`
    `segmented.left_slide`
    `segmented.center_fixed`
    `segmented.right_slide`
    `segmented.right_fixed`

- `carousel`
  - 布局结构：
    固定首按钮 + 中间整体横向滑动 + 固定尾按钮。
  - 对应配置：
    `carousel.left_fixed`
    `carousel.center_slide`
    `carousel.right_fixed`

- iPhone 可用按钮 ID
  - `script`：脚本
  - `note`：常用语
  - `clipboard`：剪切板
  - `hide`：收起键盘
  - `menu_or_panel`：键盘菜单或浮动键盘
  - `google`：Google 搜索
  - `baidu`：百度搜索
  - `bing`：Bing 搜索
  - `safari`：浏览器打开剪切板内容
  - `apple`：App Store 搜索
  - `keyboard_settings`：键盘设置
  - `keyboard_skins`：皮肤管理
  - `keyboard_performance`：内存占用
  - `rime_switcher`：方案切换
  - `embedding_toggle`：内嵌开关
  - `symbol`：符号键盘
  - `emoji`：表情键盘
  - `left_hand`：左手键盘
  - `right_hand`：右手键盘
  - `switch_keyboard`：切换手机键盘

### iPad 工具栏

- 配置入口：`toolbar_config.ipad`

- iPad 工具栏布局固定为：
  首个按钮固定 + 中间横向滑动 + 最后一个收起按钮固定。

- `toolbar_config.ipad.toolbar_menu`
  - 控制首个固定按钮使用键盘菜单还是浮动键盘。
  - 若未填写，则回退到 `toolbar_config.toolbar_menu`。

- `toolbar_config.ipad.center_slide`
  - 控制中间横向滑动区域的按钮列表。
  - 当前显示 11 个按钮。

- iPad 可用按钮 ID
  - `keyboard_settings`：键盘设置
  - `keyboard_skins`：皮肤管理
  - `keyboard_performance`：内存占用
  - `embedding_toggle`：内嵌开关
  - `rime_switcher`：方案切换
  - `google`：Google 搜索
  - `baidu`：百度搜索
  - `bing`：Bing 搜索
  - `safari`：浏览器打开剪切板内容
  - `apple`：App Store 搜索
  - `script`：脚本
  - `note`：常用语
  - `clipboard`：剪切板
  - `symbol`：符号键盘
  - `emoji`：表情键盘

## 获取更新

请到 ResourceforHamster 获取可能的更新：

`https://github.com/BlackCCCat/ResourceforHamster`

也可以通过快捷指令自动下载最新版本并导入到元书输入法中：

`https://www.icloud.com/shortcuts/c541ddb2a1614732b2c9fde38bb89be6`
