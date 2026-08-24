// 集中维护数字九键的长按菜单与空格上下划动作。
{
  number: {
    number1: {
      selectedIndex: 1,
      size: { width: 42, height: 53 },
      list: [
        { action: { symbol: '一' }, label: { text: '一' }, fontSize: 17 },
        { action: { symbol: '壹' }, label: { text: '壹' }, fontSize: 17 },
        { action: { symbol: '➀' }, label: { text: '➀' } },
      ],
    },
    number2: {
      selectedIndex: 1,
      size: { width: 42, height: 53 },
      list: [
        { action: { symbol: '二' }, label: { text: '二' }, fontSize: 17 },
        { action: { symbol: '贰' }, label: { text: '贰' }, fontSize: 17 },
        { action: { symbol: '➁' }, label: { text: '➁' } },
      ],
    },
    number3: {
      selectedIndex: 1,
      size: { width: 42, height: 53 },
      list: [
        { action: { symbol: '三' }, label: { text: '三' }, fontSize: 17 },
        { action: { symbol: '叁' }, label: { text: '叁' }, fontSize: 17 },
        { action: { symbol: '➂' }, label: { text: '➂' } },
      ],
    },
    number4: {
      selectedIndex: 1,
      size: { width: 42, height: 53 },
      list: [
        { action: { symbol: '四' }, label: { text: '四' }, fontSize: 17 },
        { action: { symbol: '肆' }, label: { text: '肆' }, fontSize: 17 },
        { action: { symbol: '➃' }, label: { text: '➃' } },
      ],
    },
    number5: {
      selectedIndex: 1,
      size: { width: 42, height: 53 },
      list: [
        { action: { symbol: '五' }, label: { text: '五' }, fontSize: 17 },
        { action: { symbol: '伍' }, label: { text: '伍' }, fontSize: 17 },
        { action: { symbol: '➄' }, label: { text: '➄' } },
      ],
    },
    number6: {
      selectedIndex: 1,
      size: { width: 42, height: 53 },
      list: [
        { action: { symbol: '六' }, label: { text: '六' }, fontSize: 17 },
        { action: { symbol: '陆' }, label: { text: '陆' }, fontSize: 17 },
        { action: { symbol: '➅' }, label: { text: '➅' } },
      ],
    },
    number7: {
      selectedIndex: 1,
      size: { width: 42, height: 53 },
      list: [
        { action: { symbol: '七' }, label: { text: '七' }, fontSize: 17 },
        { action: { symbol: '柒' }, label: { text: '柒' }, fontSize: 17 },
        { action: { symbol: '➆' }, label: { text: '➆' } },
      ],
    },
    number8: {
      selectedIndex: 1,
      size: { width: 42, height: 53 },
      list: [
        { action: { symbol: '八' }, label: { text: '八' }, fontSize: 17 },
        { action: { symbol: '捌' }, label: { text: '捌' }, fontSize: 17 },
        { action: { symbol: '➇' }, label: { text: '➇' } },
      ],
    },
    number9: {
      selectedIndex: 1,
      size: { width: 42, height: 53 },
      list: [
        { action: { symbol: '九' }, label: { text: '九' }, fontSize: 17 },
        { action: { symbol: '玖' }, label: { text: '玖' }, fontSize: 17 },
        { action: { symbol: '➈' }, label: { text: '➈' } },
      ],
    },
    number0: {
      selectedIndex: 1,
      size: { width: 42, height: 53 },
      list: [
        { action: { symbol: '零' }, label: { text: '零' }, fontSize: 17 },
        { action: { symbol: '〇' }, label: { text: '〇' }, fontSize: 17 },
        { action: { symbol: '➉' }, label: { text: '➉' } },
      ],
    },
    // 其他可用字段名:
    // 除上方已经出现的剩下数字0-9,
    // 其他按键同上
  },
  genSwipeData(deviceType): {
    number_swipe_up: {
      // '1': { action: { symbol: '1' }, label: { text: '1' } },
      // '2': { action: { symbol: '2' }, label: { text: '2' } },
      // '3': { action: { symbol: '3' }, label: { text: '3' } },
      // '4': { action: { symbol: '4' }, label: { text: '4' } },
      // '5': { action: { symbol: '5' }, label: { text: '5' } },
      // '6': { action: { symbol: '6' }, label: { text: '6' } },
      // '7': { action: { symbol: '7' }, label: { text: '7' } },
      // '8': { action: { symbol: '8' }, label: { text: '8' } },
      // '9': { action: { symbol: '9' }, label: { text: '9' } },
      space: { action: { shortcut: '#次选上屏' } },
    },
    number_swipe_down: {
      // '3': { action: { sendKeys: 'dt' }, label: { text: '时间' } },
      // '4': { action: { shortcut: '#行首' }, label: { text: '行首' } },
      // '5': { action: { shortcut: '#selectText' }, label: { text: '全选' } },
      // '6': { action: { shortcut: '#行尾' }, label: { text: '行尾' } },
      // '7': { action: { shortcut: '#cut' }, label: { text: '剪切' } },
      // '8': { action: { shortcut: '#copy' }, label: { text: '复制' } },
      // '9': { action: { shortcut: '#paste' }, label: { text: '粘贴' } },
      space: { action: { shortcut: '#三选上屏' } },

    },
  },
}
