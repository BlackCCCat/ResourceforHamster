{
  // 键盘布局配置: 26 (全键), 18 (18键), 14 (14键)
  layout_config:: {
    layout: self.keyboard_layout,
  },
  with_functions_row: {
    iPhone: true,
    iPad: false,
  },
  keyboard_layout: 26, // 26 = Full, 18 = 18-key, 14 = 14-key键
  enable_functions_notification: true,  // 功能按键是否启用通知功能，true为启用
  is_letter_capital: false,  // 26个字母按键大小写显示，false为显示小写
  fix_sf_symbol: false,  // 是否修复部分sf_symbol不显示的情况，false为不修复
  show_swipe: true,  // 是否显示上下划前景
  tips_button_action: { sendKeys: 'Break' },  // 根据自己方案中tips上屏的按键进行调整，万象方案默认为 { character: ',' }
  show_wanxiang: true,  // 空格按键上是否显示“万象”标识
  ios26_style: true,  // 是否启用iOS26风格（统一按键颜色，Light模式下调整高亮）
  button_insets: {
    portrait: { top: 3.8, left: 2.5, right: 2.5, bottom: 3.8 },  // 若需要间隔大稍大，可使用：{ top: 5, left: 3, bottom: 5, right: 3 }
    landscape: { top: 2.2, left: 1.8, bottom: 2.2, right: 1.8 },  // 若需要间隔大稍大，可按需调整:{top: 3, left: 2, bottom: 3, right: 2}
  },
  cornerRadius: 8,  // 圆角大小，建议7或者8或者8.5即可
  shift_config: {
    enable_preedit: true,  // 是否启用shift键的预编辑特殊动作，默认为启用合并辅助码的功能
    preedit_action: { character: '/' },  // shift按键预编辑状态的动作，默认为pro版的辅助码合并键
    preedit_sf_symbol: '',  // shift键预编辑状态显示的sf symbol，为空时显示已有的符号
  },

}
