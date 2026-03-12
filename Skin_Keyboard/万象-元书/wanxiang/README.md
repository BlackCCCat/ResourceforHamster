# 目录

## 目录结构说明

```text
万象键盘/
├── README.md
├── MODULES.md
└── jsonnet/
    ├── Custom.libsonnet
    ├── main.jsonnet
    ├── keyboard/
    │   ├── pinyin_26.jsonnet
    │   ├── alphabetic_26.jsonnet
    │   ├── pinyin_18.jsonnet
    │   ├── pinyin_14.jsonnet
    │   ├── pinyin_9.jsonnet
    │   ├── numeric_9.jsonnet
    │   ├── ipad_pinyin_26.jsonnet
    │   ├── ipad_alphabetic_26.jsonnet
    │   ├── ipad_numeric_9.jsonnet
    │   └── panel.jsonnet
    └── lib/
        ├── builders/
        ├── core/
        ├── data/
        ├── functionButtons/
        ├── ipad/
        ├── keys/
        ├── layout/
        ├── shared/
        ├── specs/
        ├── swipe/
        ├── toolbar/
        └── utils/
```

### 目录职责

- `jsonnet/Custom.libsonnet`
  - 所有可配置项入口
  - 包括键盘布局、字号、toolbar、自定义行为等

- `jsonnet/main.jsonnet`
  - 统一导出所有 yaml
  - 负责把不同键盘类型映射到最终输出文件名

- `jsonnet/keyboard/`
  - 各类键盘的入口文件
  - 现在多数文件已经是“薄入口”，主要负责选择 builder 和传入配置

- `jsonnet/lib/builders/`
  - 真正负责组装键盘对象
  - 例如 26 键、9 键、数字键盘、iPad 26 键等

- `jsonnet/lib/core/`
  - 共享上下文和布局解析
  - 例如 `theme`、`orientation`、`deviceType`、`function_button_config.with_functions_row`

- `jsonnet/lib/layout/`
  - 统一的布局定义和 function-row patch
  - 当前 layout 主线已经从 legacy 文件迁入这里

- `jsonnet/lib/specs/`
  - 声明式规格数据
  - 包括紧凑键、26 键字母模板、系统键拆分模块等

- `jsonnet/lib/toolbar/`
  - toolbar 共享逻辑
  - 已拆成 shared、registry、renderer

- `jsonnet/lib/functionButtons/`
  - 功能行按钮的 specs、builder 与专用前景样式

- `jsonnet/lib/data/`
  - 纯数据文件
  - 包括长按提示数据、swipe 数据、collection 数据

- `jsonnet/lib/shared/`
  - 共享样式和主题基础能力
  - 包括颜色、字号、偏移、动画、基础样式

- `jsonnet/lib/keys/`
  - 各类按键相关的共享入口
  - 包括 key builder、字母 spec 入口、拼音紧凑键和系统键入口

- `jsonnet/lib/ipad/`
  - iPad 共享覆盖逻辑

- `jsonnet/lib/swipe/`
  - swipe 样式生成的共享 helper

- `jsonnet/lib/utils/`
  - 共用样式生成 helper，与字母/数字键样式 specs

# 自定义配置
## 基础配置

- `function_button_config.with_functions_row`
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

- `function_button_config`
  - 功能按键自定义配置。
  - 包含：
    - `with_functions_row`：按设备控制是否启用功能行。
    - `enable_notification`：控制功能按键通知功能是否启用。
    - `order`：控制功能行按钮顺序。
  - `order` 可用值：
    - `left`
    - `head`
    - `select`
    - `cut`
    - `copy`
    - `paste`
    - `tail`
    - `right`
  - 如果 `order` 为空或没有有效项，会回退到默认顺序。

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

## 功能按键配置

- 配置入口：`function_button_config`

- `function_button_config.with_functions_row`
  - 控制是否启用功能行。
  - 按设备区分：`iPhone` 和 `iPad`。

- `function_button_config.enable_notification`
  - 控制功能按键通知功能是否启用。

- `function_button_config.order`
  - 控制功能行按钮顺序。
  - 如果删除部分按钮，剩余按钮会自动平分功能行宽度。
  - 默认顺序：

```jsonnet
function_button_config: {
  with_functions_row: {
    iPhone: true,
    iPad: false,
  },
  enable_notification: true,
  order: [
    'left',
    'head',
    'select',
    'cut',
    'copy',
    'paste',
    'tail',
    'right',
  ],
},
```

- 可用值：
  - `left`
  - `head`
  - `select`
  - `cut`
  - `copy`
  - `paste`
  - `tail`
  - `right`

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
    - `segmented.left_fixed`
    - `segmented.left_slide`
    - `segmented.center_fixed`
    - `segmented.right_slide`
    - `segmented.right_fixed`

- `carousel`
  - 布局结构：
    固定首按钮 + 中间整体横向滑动 + 固定尾按钮。
  - 中间区域当前显示 5 个按钮，只有 `carousel.center_slide` 超过 5 个按钮时才会产生滑动。
  - 对应配置：
    - `carousel.left_fixed`
    - `carousel.center_slide`
    - `carousel.right_fixed`

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
  - `skin_adjust`：皮肤调整
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
  - 当前显示 11 个按钮，只有按钮数量超过 11 个时才会产生滑动。

- iPad 可用按钮 ID
  - `keyboard_settings`：键盘设置
  - `keyboard_skins`：皮肤管理
  - `skin_adjust`：皮肤调整
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

`https://www.icloud.com/shortcuts/a1cec82c7b91493e9c0bf9f46da3e469`

## 后续自定义建议

- 优先改 `Custom.libsonnet` 做配置调整
- 改布局时优先看 `jsonnet/keyboard/` 和 `jsonnet/lib/layout/`
- 改按钮生成逻辑时优先看 `jsonnet/lib/builders/`
- 改系统键时优先看 `jsonnet/lib/specs/` 和 `jsonnet/lib/keys/pinyinSystemKeys.libsonnet`
- 新增布局或按钮前，先看 `MODULES.md`
