# 万象键盘·元书皮肤

`WanxiangSkin` 是一套面向 [元书输入法（Hamster3）](https://apps.apple.com/us/app/%E5%85%83%E4%B9%A6%E8%BE%93%E5%85%A5%E6%B3%95/id6744464701) 的万象键盘皮肤。皮肤以 Jsonnet 维护，支持 iPhone、iPad、浅色/深色模式以及多种中文键盘布局，公开配置集中在 [`WanxiangSkin/jsonnet/Custom.libsonnet`](WanxiangSkin/jsonnet/Custom.libsonnet)。

> 皮肤中的功能行、预编辑动作、中英切换长按菜单和部分快捷指令依赖万象方案配置。建议与仓库中的 [Rime4Hamster 自定义配置](../../Input_Method/%E4%B8%87%E8%B1%A1%E6%8B%BC%E9%9F%B3/Rime4Hamster/) 配套使用。

![万象键盘外观](assets/keyboard.JPEG)

## 主要特性

- 中文键盘可选 `9`、`14`、`17`、`18`、`26` 和 `27` 键，英文键盘统一使用 26 键。
- 全部中文布局同时打包进皮肤，工具栏的 `keyboard_swotcher` 打开布局切换浮动面板，运行时在 9/14/17/18/26/27 键之间直接跳转，无需重新生成皮肤。
- 支持 iPhone 横竖屏、iPad 独立四行布局与 iPad 浮动键盘。
- 支持浅色/深色配色、iOS 26 风格、按键间距、圆角和分类字号调整。
- 支持功能行、预编辑通知动作、上下划、长按菜单、候选词操作和纵向候选。
- 提供两种 iPhone 工具栏布局，并可自由排列搜索、剪切板、常用语、脚本、命令面板、简繁切换等按钮。
- 123 键和九键/数字键盘的符号键可选水平滑动、长按菜单或上下划交互。
- 中文 26 键可开启上划、下划或双向大写字母辅助。
- 候选词长按菜单支持左移、右移、重置、置顶和移除。

## 安装与使用

### 方式一：安装已打包皮肤

1. 在仓库 [Releases](https://github.com/BlackCCCat/ResourceforHamster/releases) 中下载最新的 `WanxiangSkin.cskin`。
2. 将文件传到 iPhone 或 iPad，选择使用元书输入法打开并导入。
3. 在元书输入法的皮肤页面选择“万象键盘”。
4. 部署配套的 Rime 配置后重新部署输入方案。

也可使用[自动下载并导入的快捷指令](https://www.icloud.com/shortcuts/2aff51bac0bf41c6b9285a423d05176f)。

### 方式二：导入源码并自定义

1. 在元书输入法中开启“皮肤开发者模式”。
2. 导入 [`WanxiangSkin`](WanxiangSkin/) 目录。
3. 编辑 [`WanxiangSkin/jsonnet/Custom.libsonnet`](WanxiangSkin/jsonnet/Custom.libsonnet)。
4. 点击皮肤触发生成，或长按皮肤后手动运行 `main.jsonnet`。
5. 每次修改 `Custom.libsonnet` 后都需重新运行 `main.jsonnet`，否则已生成的 YAML 不会自动更新。

## 键盘布局

| `keyboard_layout` | 布局 | 说明 |
| --- | --- | --- |
| `26` | 中文 26 键 | 默认布局，支持 `swipe_assist_mode` |
| `27` | 搜狗双拼 27 键 | 在 26 键第二行增加 `;` 键，用于输入 `ing` |
| `18` | 分组拼音 18 键 | 可由 `is_wanxiang_18` 控制万象转写动作 |
| `17` | 乱序分组拼音 17 键 | 支持复合字母标签、长按与上下划 |
| `14` | 分组拼音 14 键 | 可由 `is_wanxiang_14` 控制万象转写动作 |
| `9` | 中文九键 | 支持 T9 字母分组、长按字符和上下划符号 |

传入其他数值时会回退到 26 键。英文键盘不随该选项改变键数，始终使用 26 键。

`keyboard_layout` 现在只决定**默认布局**（即 `config.yaml` 里 `pinyin` 主槽指向哪一套，以及英文键盘、数字键盘等共享键盘的行为）；构建时六套布局会全部产出到 `light/`、`dark/`，并分别注册为 `pinyin9`、`pinyin14`、`pinyin17`、`pinyin18`、`pinyin26`、`pinyin27` 槽位，运行时通过工具栏按钮打开的布局切换面板互相跳转。

> 只有 9 键需要绑定输入方案：面板上的 9 键按钮用 `combine` 同时执行 `keyboardType: pinyin9` 与 `switchRimeSchema: wanxiang_t9i`；其余布局只切键盘、不改方案。若要在切到 9 键后能正常组词，需要先把 `wanxiang_t9i` 加进 Rime 的 `schema_list`。注意从 9 键切回其它布局时不会自动切回方案，需要自行用方案菜单切回 `wanxiang`。

## 按键与预编辑功能

### 功能行

默认顺序为：左移、行首、全选、剪切、复制、粘贴、行尾、右移。常态动作如下：

| ID | 常态点击 | 是否支持持续触发 |
| --- | --- | --- |
| `left` | 光标左移 | 是 |
| `head` | 移到行首 | 否 |
| `select` | 全选 | 否 |
| `cut` | 剪切 | 否 |
| `copy` | 复制 | 否 |
| `paste` | 粘贴 | 否 |
| `tail` | 移到行尾 | 否 |
| `right` | 光标右移 | 是 |

开启功能行通知后，拼音键盘在预编辑状态会切换为候选翻页、声调/编码辅助和脱字符操作：

| ID | 预编辑点击 | 上划 | 下划 |
| --- | --- | --- | --- |
| `left` | `Up` | `[` | `Left` |
| `head` | 候选下翻页 | 候选上翻页 | 候选下翻页 |
| `select` | `7` | `Control+1` | `Control+1` |
| `cut` | `8` | `Control+2` | `Control+2` |
| `copy` | `9` | `Control+3` | `Control+3` |
| `paste` | `0` | `Control+4` | `Control+4` |
| `tail` | `backslash` | `\` | `\` |
| `right` | `Down` | `]` | `Right` |

九键、英文键盘和数字键盘不会为 `select`、`cut`、`copy`、`paste`、`tail` 开启上述预编辑通知，这些按钮保持常态编辑功能。

![非预编辑模式](assets/非预编辑模式.png)

![预编辑模式](assets/预编辑模式.png)

### 常用系统键

- **退格键**：点击或持续按下删除；上划执行 `#deleteText`，下划执行 `#undo`。
- **空格键**：常态输入空格；预编辑状态上划次选上屏、下划三选上屏。
- **回车键**：根据系统的 `returnKeyType` 显示换行、完成、搜索、前往、发送等文案；上划可执行 `#换行`。
- **中英切换键**：点击切换英文键盘；长按菜单使用 `rimeOptionLabel$<option>` 动态显示简繁、中英、超级 Tips、简码和拆分开关状态。
- **Shift**：`shift_config` 只作用于中文 26/27 键和 iPad 26 键，不作用于 14/17/18 键。

### 候选词菜单

长按候选词可执行：

| 菜单项 | 动作 |
| --- | --- |
| 左移 | `Control+j` |
| 右移 | `Control+k` |
| 重置 | `Control+l` |
| 置顶 | `Control+p` |
| 移除 | `Control+Delete` |

## `Custom.libsonnet` 配置说明

### 基础布局与显示

| 参数 | 默认值 | 作用范围 | 说明 |
| --- | --- | --- | --- |
| `keyboard_layout` | `26` | iPhone 中文键盘 | 选择 `9/14/17/18/26/27` 键 |
| `wanxiang_9_hintSymbol` | `true` | 中文九键 | `true` 使长按字符直接上屏，`false` 作为 Rime 字符输入 |
| `swap_9_123_symbol` | `false` | 中文九键 | 交换左下角 123 键与符号键 |
| `swap_numeric_return_symbol` | `false` | 数字键盘 | 交换返回键与符号切换键 |
| `is_wanxiang_18` | `true` | 18 键 | 使用万象 18 键大写转写规则 |
| `is_wanxiang_14` | `true` | 14 键 | 使用万象 14 键大写转写规则 |
| `is_letter_capital` | `false` | 中文 9/14/17/18/26/27 键 | 只改变字母常态显示，不改变按键输入动作 |
| `fix_sf_symbol` | `false` | 全局兼容图标 | 用兼容性更好的 SF Symbol 替换部分新图标 |
| `show_swipe` | `true` | 具有上下划数据的键盘 | 只控制上下划前景是否显示，不关闭实际划动动作 |
| `show_wanxiang` | `true` | 普通拼音空格键 | 控制空格键上的“万象”标识；不影响临时拼音的 `RIME` |
| `tips_button_action` | `{ sendKeys: 'Break' }` | 预编辑提示按钮 | 自定义 Tips 上屏动作 |
| `ios26_style` | `true` | 浅色/深色键盘 | 启用 iOS 26 风格的按键颜色覆写 |
| `cornerRadius` | `8` | 通用按键和长按背景 | 调整按键圆角 |
| `horizon_candidate_button` | `2` | 横向候选栏 | `0` 不显示，`1` 显示展开候选键，`2` 显示收起键盘键 |

### 字号与按键间距

```jsonnet
font_size_config: {
  pinyin_26_letter_font_size: 20,
  pinyin_grouped_letter_font_size: 20,
  pinyin_9_letter_font_size: 20,
  numeric_digit_font_size: 20,
},

button_insets: {
  portrait: { top: 3.8, left: 2.5, right: 2.5, bottom: 3.8 },
  landscape: { top: 2.2, left: 1.8, right: 1.8, bottom: 2.2 },
},
```

| 字号参数 | 作用范围 |
| --- | --- |
| `pinyin_26_letter_font_size` | 中文/英文 26 键字母与 27 键扩展布局 |
| `pinyin_grouped_letter_font_size` | 14/17/18 键复合字母按键 |
| `pinyin_9_letter_font_size` | 中文九键字母分组 |
| `numeric_digit_font_size` | 数字键盘数字 |

分组拼音中包含多个字符的标签会根据基准字号自动缩小。`button_insets` 调整键帽内缩，不改变所在行的布局宽度。

### 中文 26 键划动辅助

`swipe_assist_mode` 默认为 `none`，只作用于 iPhone 中文 26 键：

| 值 | 行为 |
| --- | --- |
| `none` | 保留原始上下划动作和按键通知前景 |
| `up` | 预编辑状态上划输入对应大写字母，原上划内容移入长按菜单 |
| `down` | 预编辑状态下划输入对应大写字母，原下划内容移入长按菜单 |
| `all` | 预编辑状态上下划都输入大写字母，原上划和下划内容依次移入长按菜单 |

开启辅助后，对应方向的划动气泡会被关闭，长按项按键位置作左右对称排列，并将默认索引指向原辅助符号。

### 功能行配置

```jsonnet
function_button_config: {
  with_functions_row: {
    iPhone: true,
    iPad: false,
  },
  enable_notification: true,
  order: ['left', 'head', 'select', 'cut', 'copy', 'paste', 'tail', 'right'],
},
```

- `with_functions_row` 按设备控制功能行是否显示。
- `enable_notification` 控制允许启用通知的按钮是否随预编辑状态切换动作。
- `order` 同时决定按钮顺序和是否显示；删除数组中的 ID 即可隐藏对应按钮。
- 功能行宽度按当前有效按钮数量自动均分。

### 123 键交互

```jsonnet
button_123_config: {
  enable_slide: false,
  secondary_action_mode: 'swipe',
  swipe_up_keyboard: 'emojis',
  swipe_down_keyboard: 'symbolic',
  show_swipe_indicators: false,
},
```

| 配置 | 说明 |
| --- | --- |
| `enable_slide: true` | 使用 `horizontalSymbols` 在数字、符号和 emoji 键盘之间滑动选择 |
| `enable_slide: false` | 点击进入数字键盘，次级交互由 `secondary_action_mode` 决定 |
| `secondary_action_mode: 'hint_symbols'` | 长按显示符号键盘与 emoji 键盘菜单 |
| `secondary_action_mode: 'swipe'` | 使用上下划切换 `swipe_up_keyboard` 和 `swipe_down_keyboard` |
| `show_swipe_indicators` | 只控制手机 123 键上下划角标，不受 `show_swipe` 影响，也不改变划动动作 |

`swipe_up_keyboard` 和 `swipe_down_keyboard` 可填 `symbolic` 或 `emojis`。如果两个方向填了相同的值，下划目标会自动改为另一种键盘。123 键不显示点击气泡。

该交互用于中文 26/27 键、14/17/18 键、英文 26 键和 iPad 26 键。iPad 的双 123 键支持 slide、长按和上下划目标，但不叠加手机版的上下划角标。

### 九键/数字键盘符号键

```jsonnet
button_symbol_config: {
  enable_slide: false,
  secondary_action_mode: 'swipe',
  swipe_up_keyboard: 'emojis',
},
```

- `enable_slide: true`：在符号键和 emoji 键盘之间水平滑动选择。
- `enable_slide: false`：点击符号键进入 `symbolic`。
- `secondary_action_mode: 'hint_symbols'`：长按显示 emoji 选项。
- `secondary_action_mode: 'swipe'`：上划进入 `swipe_up_keyboard`，当前支持的有效次级目标为 `emojis`。
- 该配置不改变 `swap_9_123_symbol` 和 `swap_numeric_return_symbol` 的按键位置逻辑。

### Shift 预编辑配置

```jsonnet
shift_config: {
  enable_preedit: true,
  preedit_action: { character: '/' },
  preedit_sf_symbol: '',
  preedit_swipeup_action: '辅助筛选',
},
```

- `enable_preedit`：是否在预编辑状态启用 Shift 特殊动作。
- `preedit_action`：Shift 在预编辑状态的点击动作。
- `preedit_sf_symbol`：预编辑状态的 SF Symbol；空字符串使用皮肤默认图标。
- `preedit_swipeup_action`：可选“分词”或“辅助筛选”，仅当 `keyboard_layout == 26` 时使用辅助筛选的反引号动作。

整组配置用于中文 26/27 键和 iPad 26 键，不作用于 14/17/18 键。

## 工具栏配置

### iPhone 布局模式

`toolbar_config.mode` 支持：

- `segmented`：固定左键 + 左侧滑动区 + 固定中键 + 右侧滑动区 + 固定右键。
- `carousel`：固定左键 + 中间整体滑动区 + 固定右键。

```jsonnet
toolbar_config: {
  toolbar_menu: false,
  toolbar_height: 50,
  content_right_to_left: false,
  mode: 'segmented',

  segmented: {
    left_fixed: 'script',
    left_slide: ['google', 'safari', 'apple', 'bing'],
    center_fixed: 'menu_or_panel',
    right_slide: ['note', 'clipboard', 'keyboard_swotcher', 'symbol', 'emoji'],
    right_fixed: 'hide',
  },

  carousel: {
    left_fixed: 'menu_or_panel',
    center_slide: [
      'script',
      'google',
      'note',
      'clipboard',
      'keyboard_swotcher',
      'emoji',
      'symbol',
      'skin_adjust',
      'keyboard_settings',
      'keyboard_skins',
      'baidu',
      'bing',
    ],
    right_fixed: 'hide',
  },
},
```

- `toolbar_menu: false`：`menu_or_panel` 打开皮肤内置浮动键盘。
- `toolbar_menu: true`：`menu_or_panel` 调用元书的 `#keyboardMenu`。
- `content_right_to_left`：控制滑动区数据的显示方向。
- `toolbar_height`：调整 iPhone 工具栏高度，默认为 `50`。
- `segmented` 的左右滑动区各显示 2 个按钮；`carousel` 中间区显示 5 个按钮，超出后可滑动。

![工具栏及滑动区域](assets/工具栏及划动.png)

### iPad 工具栏

`toolbar_config.ipad` 独立控制 iPad：

```jsonnet
ipad: {
  toolbar_menu: false,
  content_right_to_left: false,
  toolbar_height: 57,
  center_slide: [
    'keyboard_settings',
    'keyboard_skins',
    'embedding_toggle',
    'rime_switcher',
    'google',
    'safari',
    'script',
    'note',
    'clipboard',
    'symbol',
    'emoji',
    'baidu',
    'bing',
    'apple',
    'skin_adjust',
    'keyboard_performance',
  ],
},
```

iPad 工具栏首键固定为 `menu_or_panel`，末键固定为 `hide`，中间区域同时显示 11 个按钮，超出后可滑动。

### 可用工具栏按钮

iPhone 与 iPad 共用同一组 ID：

| ID | 功能 |
| --- | --- |
| `script` | 打开/关闭键盘脚本页面 |
| `command` | 使用 `#toggleCommandView` 打开/关闭命令面板 |
| `symbols` | 使用 `#toggleSymbolBar` 打开/关闭符号栏 |
| `note` | 打开常用语 |
| `clipboard` | 打开剪切板 |
| `keyboard_swotcher` | 打开布局切换浮动面板，在 9/14/17/18/26/27 键之间跳转 |
| `hide` | 收起键盘 |
| `menu_or_panel` | 根据 `toolbar_menu` 打开键盘菜单或内置浮动键盘 |
| `google` | Google 搜索剪切板内容 |
| `baidu` | 百度搜索剪切板内容 |
| `bing` | Bing 搜索剪切板内容 |
| `safari` | 使用浏览器打开剪切板内容 |
| `apple` | 在 App Store 搜索剪切板内容 |
| `keyboard_settings` | 打开元书键盘设置 |
| `keyboard_skins` | 打开元书皮肤管理 |
| `skin_adjust` | 打开当前皮肤的 `Custom.libsonnet` |
| `keyboard_performance` | 显示键盘性能/内存信息 |
| `rime_switcher` | 打开 Rime 方案选单 |
| `embedding_toggle` | 切换内嵌输入模式 |
| `symbol` | 切换符号键盘 |
| `emoji` | 切换 emoji 键盘 |
| `left_hand` | 执行 `#左手模式` |
| `right_hand` | 执行 `#右手模式` |
| `switch_keyboard` | 切换中文/英文键盘 |
| `simplified_traditional` | 执行 `#简繁切换` |
| `undo` | 撤销 |
| `redo` | 重做 |
| `cut` | 剪切 |
| `copy` | 复制 |
| `paste` | 粘贴 |

## 候选栏与浮动键盘

- 横向候选栏右侧按钮由 `horizon_candidate_button` 控制。
- 纵向候选栏底部提供上翻页、下翻页、返回和删除键。
- 当 `toolbar_menu == false` 时，工具栏的 `menu_or_panel` 打开 `panel` 浮动键盘。
- iPad 的 `floating` 不使用 iPad 四行布局，而是分别复用 iPhone 竖屏的拼音 26 键、英文 26 键和数字九键。

## iPad 键盘

iPad 使用独立四行布局：

- 第一行右侧为退格键。
- 第二行右侧为回车键。
- 第三行左右两侧均有 Shift，右侧 Shift 左边是 Tab。
- 第四行包含 Globe、左右 123、逗号、空格、中英切换和收起键盘。
- 逗号键上划输入句号。

iPad 不跟随 `keyboard_layout` 切换到 9/14/17/18/27 键，拼音与英文保持 iPad 26 键。

## 非 26 键的英文返回路径

当 `keyboard_layout` 不是 `26` 时，英文键盘提供临时拼音路径：

1. 英文键盘的中英切换键上划进入 `temp_pinyin`。
2. `temp_pinyin` 复用中文 26 键布局。
3. 其空格键固定显示 `RIME`，不受 `show_wanxiang` 影响。
4. 空格键上划发送 `Shift+space`。
5. 中英切换键使用返回图标，点击返回英文键盘，不附加 Rime 通知。

## 目录与源码

```text
万象-元书/
├── README.md
├── README_old.md
├── assets/                  # 文档示意图
├── WanxiangSkin-modifier/  # 皮肤修改 Skill
└── WanxiangSkin/
    ├── config.yaml
    ├── demo.png
    ├── README.md
    ├── MODULES.md
    ├── light/                # 浅色资源
    ├── dark/                 # 深色资源
    └── jsonnet/
        ├── Custom.libsonnet # 公开配置
        ├── main.jsonnet      # 总构建入口
        ├── build/            # 键盘注册、设备上下文与输出配置
        ├── design/           # 颜色、字号、偏移、动画与样式工厂
        ├── components/       # 系统键、功能行、工具栏和候选栏
        └── keyboards/        # 各键盘族的布局与专属数据
```

更详细的模块职责和修改落点见 [`WanxiangSkin/MODULES.md`](WanxiangSkin/MODULES.md)。

## 开发、编译与打包

### 验证 Jsonnet

```bash
cd Skin_Keyboard/万象-元书/WanxiangSkin
jsonnet jsonnet/main.jsonnet -o /tmp/WanxiangSkin.json
```

`main.jsonnet` 返回“输出路径 → YAML 文本”的对象。如需在命令行将所有文件实体化到皮肤目录，可执行：

```bash
jsonnet -m . jsonnet/main.jsonnet
```

> 六套中文布局全部产出后共有 57 个输出文件，`main.jsonnet` 需要一次性把它们全部留在内存里。
> 在内存受限环境（例如 iSH）会报 `FATAL ERROR: a memory allocation error occurred`。
> 这种情况下用分进程构建，输出与 `main.jsonnet` 完全一致：
>
> ```bash
> python3 build_split.py
> ```

修改键盘布局或公共组件后，建议至少验证：

- `9/14/17/18/26/27` 六种中文键盘。
- 浅色/深色与横屏/竖屏。
- iPad 拼音、英文和数字键盘。
- `swipe_assist_mode` 的 `none/up/down/all` 四种状态。
- 功能行开关、123 键交互模式与工具栏两种布局。

### 自动发布

GitHub Actions 监听以 `wanxiangskin-` 开头的 Tag，当前约定使用以下日期版本格式：

```text
wanxiangskin-YYYY.MM.DD.N
```

例如：

```bash
git tag wanxiangskin-2026.09.09.1
git push origin wanxiangskin-2026.09.09.1
```

发布流程会将 Tag 写入 `version.txt`，生成 `WanxiangSkin.cskin`，并将 `WanxiangSkin-modifier` 作为 ZIP 一同上传到 Release。

## 皮肤修改 Skill

[`WanxiangSkin-modifier`](WanxiangSkin-modifier/) 用于让支持 Skill 的 AI 工具理解当前皮肤结构、不可回退的手动数据以及建议的验证范围。它适合处理：

- `Custom.libsonnet` 公开配置调整。
- 工具栏按钮、功能行和候选菜单修改。
- 各键盘布局、按键动作、长按和上下划数据修改。
- Jsonnet 抽象、路径调整与构建验证。

## 注意事项

- 皮肤中的 `#行首`、`#行尾`、`#简繁切换`、`#次选上屏`、`#三选上屏` 等指令需要元书或配套 Rime 配置提供对应能力。
- `rimeOptionLabel$<option>` 依赖元书的动态 Rime 选项标签功能；旧版元书可能显示异常。
- 生成的 YAML 是 Jsonnet 构建产物。需要长期保留的改动应写入 `jsonnet/` 源码，避免在下次构建时被覆盖。
- 修改公共组件时会同时影响多种键盘，应在修改后执行完整 `main.jsonnet` 编译。
