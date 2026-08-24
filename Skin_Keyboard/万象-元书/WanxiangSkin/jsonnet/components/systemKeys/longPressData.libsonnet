// 保存中英切换键共用的动态 Rime 选项长按数据。
{
  cn2en: {
    selectedIndex: 1,
    size: { width: 65, height: 53 },
    list: [
      { action: { sendKeys: 'Control+Shift+4' }, label: { text: 'rimeOptionLabel$s2s' } },
      { action: { sendKeys: 'Control+Shift+4' }, label: { text: 'rimeOptionLabel$s2t' } },
      { action: { sendKeys: 'Control+Shift+4' }, label: { text: 'rimeOptionLabel$s2hk' } },
      { action: { sendKeys: 'Control+Shift+4' }, label: { text: 'rimeOptionLabel$s2tw' } },
      { action: { sendKeys: 'Control+e' }, label: { text: 'rimeOptionLabel$chinese_english' } },
      { action: { sendKeys: 'Control+e' }, label: { text: 'rimeOptionLabel$chinese_english' } },
      { action: { sendKeys: 'Control+t' }, label: { text: 'rimeOptionLabel$super_tips' } },
      { action: { sendKeys: 'Control+t' }, label: { text: 'rimeOptionLabel$super_tips' } },
      { action: { sendKeys: 'Control+q' }, label: { text: 'rimeOptionLabel$abbrev' } },
      { action: { sendKeys: 'Control+q' }, label: { text: 'rimeOptionLabel$abbrev' } },
      { action: { sendKeys: 'Control+c' }, label: { text: 'rimeOptionLabel$chaifen_switch' } },
      { action: { sendKeys: 'Control+c' }, label: { text: 'rimeOptionLabel$chaifen_switch' } },
    ],
  },
  spaceLeft: {
    selectedIndex: 1,
    list: [
      { action: { symbol: ',' }, label: { text: ',' } },
      { action: { symbol: '.' }, label: { text: '.' } },
    ],
  },
  enter: {
    size: { width: 50, height: 53 },
    selectedIndex: 0,
    list: [
      { action: { shortcut: '#换行' }, label: { text: '换行' }, fontSize: 16 },
    ],
  },
}
