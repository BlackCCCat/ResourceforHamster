{
  with_functions_row: { iPhone: true, iPad: false },  // true为有功能按键，false为无功能按键, iPad键盘默认不带功能按键
  is_letter_capital: false,  // 26个字母按键大小写显示，false为显示小写
  fix_sf_symbol: false,  // 是否修复部分sf_symbol不显示的情况，false为不修复
  show_swipe: true,  // 是否显示上下划前景
  tips_button_action: { sendKeys: 'Break' },  // 根据自己方案中tips上屏的按键进行调整，万象方案默认为 { character: ',' }
  show_wanxiang: true,  // 空格按键上是否显示“万象”标识
  ios26_style: true,  // 是否启用iOS26风格（统一按键颜色，Light模式下调整高亮）
  button_insets: { 
    portrait: {top: 3.8, left: 2, right: 2, bottom: 3.8}, // 若需要间隔大稍大，可使用：{ top: 5, left: 3, bottom: 5, right: 3 }
    landscape: {top: 2.2, left: 1.8, bottom: 2.2, right: 1.8}, // 若需要间隔大稍大，可按需调整:{top: 3, left: 2, bottom: 3, right: 2}
  },
  schema_type: 'pro', // 万象方案的类型，pro or base，如果使用base，则shift按键不会有合并辅助码的功能
}
