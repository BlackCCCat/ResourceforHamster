// 将同一英文 26 键按中文来源布局绑定：英文返回键和工具栏“切换键盘”均返回原中文槽位。
// 仅 iPhone 使用；iPad 继续沿用原 alphabetic 键盘。
local base = import './keyboard.libsonnet';
local slots = [9, 14, 17, 18, 26, 27];
local rewriteItems(items, slot) = [
  if std.objectHas(item, 'action') && item.action == { keyboardType: 'pinyin' } then
    item { action: { keyboardType: slot } }
  else item
  for item in items
];
{
  new(theme, orientation, layout):
    assert std.member(slots, layout) : '不支持的来源布局';
    local target = 'pinyin' + std.toString(layout);
    local keyboard = base.new(theme, orientation);
    keyboard {
      en2cnButton: keyboard.en2cnButton {
        action: { keyboardType: target },
      },
      toolbarButtonswitchKeyboardStyle: keyboard.toolbarButtonswitchKeyboardStyle {
        action: { keyboardType: target },
      },
      horizontalSymbolsDataSourceLeft: rewriteItems(keyboard.horizontalSymbolsDataSourceLeft, target),
      horizontalSymbolsDataSourceRight: rewriteItems(keyboard.horizontalSymbolsDataSourceRight, target),
      horizontalSymbolsDataSourceCenter: rewriteItems(keyboard.horizontalSymbolsDataSourceCenter, target),
    },
}
