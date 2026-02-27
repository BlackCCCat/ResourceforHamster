{
  // 是否启用功能行（按设备区分）
  with_functions_row: {
    iPhone: true,
    iPad: false,
  },

  // 当前中文键盘布局（实际生效配置）
  // 26: 全键（pinyin_26）
  // 18: 18键（pinyin_18）
  // 14: 14键（pinyin_14）
  // 9: 九键（pinyin_9）
  // 其他值会回退到 26
  keyboard_layout: 26,

  // 是否使用万象18键转写规则（大写转写）
  is_wanxiang_18: true,

  // 是否使用万象14键转写规则（大写转写）
  is_wanxiang_14: true,

  // 功能按键通知功能开关
  enable_functions_notification: true,

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

  // shift 特殊动作配置
  shift_config: {
    // 是否启用 shift 的预编辑特殊动作
    enable_preedit: true,

    // shift 在预编辑状态的动作
    preedit_action: { character: '/' },

    // shift 在预编辑状态显示的 sf symbol
    // 为空时使用默认符号
    preedit_sf_symbol: '',
  },

  // 是否开启候选栏展开按钮
  showExpandButton: false,

  // 工具栏搜索引擎
  // 可选值: 'google' 'baidu' 'bing'
  toolbar_search_engine: 'google',
}
