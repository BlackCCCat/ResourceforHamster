// 保存各拼音布局共用的系统键上下划动作，避免复用具体 26 键键盘。
{
  swipeUp: {
    spaceLeft: { action: { character: '.' } },
    spaceRight: { action: { symbol: '.' } },
    backspace: { action: { shortcut: '#deleteText' } },
    enter: { action: { shortcut: '#换行' } },
  },
  swipeDown: {
    backspace: { action: { shortcut: '#undo' } },
  },
}
