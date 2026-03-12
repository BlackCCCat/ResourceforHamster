{
  // 当前中文键盘布局（实际生效配置）
  // 26: 全键（pinyin_26）
  // 18: 18键（pinyin_18）
  // 14: 14键（pinyin_14）
  // 9: 九键（pinyin_9）
  // 其他值会回退到 26
  keyboard_layout: 26,

  // 9键按键长按符号是否直接上屏
  wanxiang_9_hintSymbol: true,

  // 是否使用万象18键转写规则（大写转写）
  is_wanxiang_18: true,

  // 是否使用万象14键转写规则（大写转写）
  is_wanxiang_14: true,

  // 功能按键配置
  function_button_config: {
    // 是否启用功能行（按设备区分）
    with_functions_row: {
      iPhone: true,
      iPad: false,
    },

    // 是否启用功能按键通知功能
    enable_notification: true,

    // 功能行按钮顺序
    // 可用值:
    // left: 左移
    // head: 行首
    // select: 选择
    // cut: 剪切
    // copy: 复制
    // paste: 粘贴
    // tail: 行尾
    // right: 右移
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

  // 26字母按键是否显示大写
  is_letter_capital: false,

  // 是否修复部分 sf_symbol 不显示问题
  fix_sf_symbol: false,

  // 是否显示上下划前景
  show_swipe: true,

  // tips 上屏动作
  // 万象默认可改为 { character: ',' }
  tips_button_action: { sendKeys: 'Break' },

  // 空格按键是否显示“万象”标识
  show_wanxiang: true,

  // 是否启用 iOS26 风格（统一按键颜色，Light模式下调整高亮）
  ios26_style: true,

  // 字号配置
  font_size_config: {
    // 仅控制26字母键(q~m)前景文字大小
    pinyin_26_letter_font_size: 20,

    // 仅控制14/18键字母前景文字大小
    pinyin_14_18_letter_font_size: 20,

    // 仅控制9键字母前景文字大小
    pinyin_9_letter_font_size: 20,

    // 仅控制数字键盘数字前景文字大小
    numeric_digit_font_size: 20,
  },

  // 按键间距
  button_insets: {
    // 若需要间隔稍大，可使用:
    // { top: 5, left: 3, bottom: 5, right: 3 }
    portrait: { top: 3.8, left: 2.5, right: 2.5, bottom: 3.8 },

    // 若需要间隔稍大，可按需调整:
    // { top: 3, left: 2, bottom: 3, right: 2 }
    landscape: { top: 2.2, left: 1.8, bottom: 2.2, right: 1.8 },
  },

  // 按键圆角，建议 7 / 8 / 8.5
  cornerRadius: 8,

  // shift 特殊动作配置（仅用于26键）
  shift_config: {
    // 是否启用 shift 的预编辑特殊动作
    enable_preedit: true,

    // shift 在预编辑状态的动作
    preedit_action: { character: '/' },

    // shift 在预编辑状态显示的 sf symbol
    // 为空时使用默认符号
    preedit_sf_symbol: '',

    // 26键shift按键预编辑状态上划操作
    // 可选：分词、辅助筛选，分词为'，辅助筛选为`
    preedit_swipeup_action: '辅助筛选',
  },

  // 是否开启候选栏展开按钮
  showExpandButton: false,

  // 工具栏布局配置
  toolbar_config: {
    // 是否启用键盘菜单页面
    // false: 使用皮肤内置的悬浮键盘
    // true: 使用 app 的 keyboardMenu
    toolbar_menu: false,

    // segmented:
    // 固定按钮 + 左侧横向滑动 + 固定中间按钮 + 右侧横向滑动 + 固定收起按钮
    //
    // carousel:
    // 固定首按钮 + 中间整体横向滑动 + 固定尾按钮
    mode: 'segmented',

    // 可用按钮 ID:
    // script: 脚本
    // note: 常用语
    // clipboard: 剪切板
    // hide: 收起键盘
    // menu_or_panel: 键盘菜单或浮动键盘
    // google: Google 搜索
    // baidu: 百度搜索
    // bing: Bing 搜索
    // safari: 浏览器打开剪切板内容
    // apple: App Store 搜索
    // keyboard_settings: 键盘设置
    // keyboard_skins: 皮肤管理
    // skin_adjust: 皮肤调整
    // keyboard_performance: 内存占用
    // rime_switcher: 方案切换
    // embedding_toggle: 内嵌开关
    // symbol: 符号键盘
    // emoji: 表情键盘
    // left_hand: 左手键盘
    // right_hand: 右手键盘
    // switch_keyboard: 切换手机键盘

    segmented: {
      // 第一种布局
      left_fixed: 'script',
      left_slide: [
        'google',
        'safari',
        'apple',
        'bing',
        // 如有需要添加的按钮直接在后面添加即可
      ],
      center_fixed: 'menu_or_panel',
      right_slide: [
        'note',
        'clipboard',
        'symbol',
        'emoji',
        // 如有需要添加的按钮直接在后面添加即可
      ],
      right_fixed: 'hide',
    },

    carousel: {
      // 第二种布局
      // 中间区域当前显示 5 个按钮，只有按钮数量超过 5 个时才会产生横向滑动
      left_fixed: 'menu_or_panel',
      center_slide: [
        'script',
        'google',
        'note',
        'clipboard',
        'emoji',
        'symbol',
        'skin_adjust',
        'keyboard_settings',
        'keyboard_skins',
        'baidu',
        'bing',
        // 如有需要添加的按钮直接在后面添加即可
      ],
      right_fixed: 'hide',
    },

    // iPad 工具栏
    // 首按钮固定为 menu_or_panel
    // 末按钮固定为 hide
    // 中间为显示 11 个按钮的横向滑动区域
    ipad: {
      // 是否启用键盘菜单页面
      // false: 使用皮肤内置的悬浮键盘
      // true: 使用 app 的 keyboardMenu
      toolbar_menu: false,

      // 可用按钮 ID:
      // keyboard_settings: 键盘设置
      // keyboard_skins: 皮肤管理
      // skin_adjust: 皮肤调整
      // keyboard_performance: 内存占用
      // embedding_toggle: 内嵌开关
      // rime_switcher: 方案切换
      // google: Google 搜索
      // baidu: 百度搜索
      // bing: Bing 搜索
      // safari: 浏览器打开剪切板内容
      // apple: App Store 搜索
      // script: 脚本
      // note: 常用语
      // clipboard: 剪切板
      // symbol: 符号键盘
      // emoji: 表情键盘
      // 中间区域当前显示 11 个按钮，只有按钮数量超过 11 个时才会产生横向滑动
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
  },
}
