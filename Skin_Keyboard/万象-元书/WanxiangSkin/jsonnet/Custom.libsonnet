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
  // 9键键盘是否交换左下角数字键盘和符号键盘按钮位置
  swap_9_123_symbol: false,
  // 数字键盘是否交换左侧返回按钮和右侧切换键盘按钮位置
  swap_numeric_return_symbol: false,

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

    // 功能行按钮顺序，也可以注释掉不需要的按钮，但不建议这么做
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

  // 26键 / 14键 / 18键 的 123 按键交互配置
  button_123_config: {
    // true: 保持当前 horizontalSymbols 滑动切换
    // false: 改用下方配置的长按菜单或上下滑动
    enable_slide: false,

    // 当 enable_slide 为 false 时生效
    // hint_symbols: 使用长按菜单显示「符号键盘 / emoji键盘」
    // swipe: 使用上下滑动切换「符号键盘 / emoji键盘」
    secondary_action_mode: 'swipe',

    // 当 secondary_action_mode 为 swipe 时生效
    // 可选值: symbolic / emojis
    swipe_up_keyboard: 'emojis',
    swipe_down_keyboard: 'symbolic',

    // 是否显示 123Button 的上下划角标
    // 只影响角标显示，不影响 swipe 动作本身
    show_swipe_indicators: false,
  },

  // 九键 / 数字键盘的符号按钮交互配置
  button_symbol_config: {
    // true: 保持当前 horizontalSymbols 滑动切换
    // false: 改用下方配置的长按菜单或上下滑动
    enable_slide: false,

    // 当 enable_slide 为 false 时生效
    // hint_symbols: 使用长按菜单显示「emoji键盘」
    // swipe: 仅使用上滑切换到次级键盘
    secondary_action_mode: 'swipe',

    // 当 secondary_action_mode 为 swipe 时生效
    // symbolButton 点击动作本身进入 symbolic，次级目标保留 emoji 键盘。
    swipe_up_keyboard: 'emojis',
  },

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

  // 横向候选栏最右侧按钮：
  // 0: 无
  // 1: 展开候选按钮
  // 2: 收起键盘按钮（开启预测时建议使用，方便收起键盘）
  horizon_candidate_button: 2,

  // 工具栏布局配置
  toolbar_config: {
    // 是否启用键盘菜单页面
    // false: 使用皮肤内置的悬浮键盘
    // true: 使用 app 的 keyboardMenu
    toolbar_menu: false,

    // 工具栏高度（在开启comment的情况下，该高度比较合适，如果不开启，使用30或者40都可以）
    toolbar_height: 50,

    // 工具栏滑动区域按钮显示方向
    content_right_to_left: false,

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
    // simplified_traditional: 简繁切换
    // undo: 撤销
    // redo: 重做

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

      // 工具栏滑动区域按钮显示方向
      content_right_to_left: false,

      // 工具栏高度（在开启comment的情况下，iPad上该高度比较合适）
      toolbar_height: 57,

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
