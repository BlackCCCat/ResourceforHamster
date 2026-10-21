// 安卓独立皮肤：直接使用官方支持的 material: 图标名，不依赖字体私用区。
// 官方格式：https://ihsiao.com/apps/hamster/v3/docs/guides/skins/styles/#systemimage
local names = {
  "calculator": "calculate",
  "face.smiling": "sentiment_satisfied",
  "square.grid.3x2.fill": "view_module",
  "9.square.fill": "dialpad",
  "14.square.fill": "keyboard",
  "17.square.fill": "keyboard",
  "18.square.fill": "keyboard",
  "26.square.fill": "keyboard",
  "27.square.fill": "keyboard",
  "textformat.123": "dialpad",
  "s.circle.fill": "code",
  "gauge.medium": "speed",
  "arrow.up.arrow.down": "unfold_more",
  "ellipsis.curlybraces": "more_horiz",
  "dollarsign.square.fill": "currency_yuan",
  "1.circle": "looks_one",
  "2.circle": "looks_two",
  "3.circle": "looks_3",
  "4.circle": "looks_4",
  "apple.logo": "apps",
  "apple.terminal.fill": "terminal",
  "arrow.right.to.line.compact": "keyboard_tab",
  "arrow.up.doc.on.clipboard": "content_copy",
  "arrow.uturn.left.circle.fill": "undo",
  "arrow.uturn.right.circle.fill": "redo",
  "arrowshape.turn.up.left.fill": "arrow_back",
  "arrowshape.turn.up.right.fill": "arrow_forward",
  "av.remote.fill": "settings_remote",
  "b.circle.fill": "search",
  "bookmark.square.fill": "bookmark",
  "calendar": "calendar_today",
  "calendar.badge.exclamationmark": "event_note",
  "capslock.fill": "keyboard_capslock",
  "character.textbox.zh": "translate",
  "chevron.compact.up.chevron.compact.down": "unfold_more",
  "chevron.down": "expand_more",
  "chevron.up": "expand_less",
  "chineseyuanrenminbisign.square.fill": "currency_yuan",
  "clock.arrow.circlepath": "history",
  "clock.circle": "schedule",
  "command.circle.fill": "keyboard_command_key",
  "delete.left": "backspace",
  "doc.on.clipboard.fill": "content_paste",
  "dots.and.line.vertical.and.cursorarrow.rectangle": "format_list_bulleted",
  "ellipsis.viewfinder": "more_horiz",
  "face.dashed": "sentiment_satisfied",
  "face.dashed.fill": "sentiment_satisfied",
  "filemenu.and.selection": "select_all",
  "florinsign.circle.fill": "functions",
  "folder": "folder",
  "g.circle.fill": "search",
  "gauge.with.dots.needle.bottom.50percent": "speed",
  "gearshape.fill": "settings",
  "globe": "language",
  "hexagon.righthalf.filled": "apps",
  "inset.filled.lefthalf.arrow.left.rectangle": "vertical_align_top",
  "keyboard.chevron.compact.down": "keyboard_hide",
  "keyboard.chevron.compact.down.fill": "keyboard_hide",
  "keyboard.onehanded.left.fill": "keyboard_arrow_left",
  "keyboard.onehanded.right.fill": "keyboard_arrow_right",
  "lightbulb.max": "lightbulb",
  "lightbulb": "lightbulb",
  "list.bullet.clipboard.fill": "assignment",
  "numbers": "dialpad",
  "paintpalette.fill": "palette",
  "paragraphsign": "notes",
  "pawprint.fill": "pets",
  "peruviansolessign.circle.fill": "code",
  "rectangle.3.group.fill": "view_column",
  "return.left": "keyboard_return",
  "safari.fill": "public",
  "scissors": "content_cut",
  "selection.pin.in.out": "select_all",
  "shift": "arrow_upward",
  "shift.fill": "arrow_circle_up",
  "space": "space_bar",
  "square.and.line.vertical.and.square.filled": "flip_to_back",
  "square.and.pencil": "edit",
  "square.filled.and.line.vertical.and.square": "content_copy",
  "switch.2": "swap_horiz",
  "text.line.first.and.arrowtriangle.forward": "first_page",
  "text.line.last.and.arrowtriangle.forward": "last_page",
  "tshirt.fill": "checkroom"
};
local icon(name) =
  if std.type(name) == 'object' && std.objectHas(name, 'android') then
    if std.startsWith(name.android, 'material:') then name.android else 'material:' + name.android
  else if std.type(name) != 'string' then name
  else if std.objectHas(names, name) then 'material:' + names[name]
  else name;
local isNumbers(value) = std.objectHas(value, 'systemImageName')
  && std.member(['numbers', 'textformat.123'], value.systemImageName);
{
  // 递归覆盖普通/预编辑状态、工具栏、长按菜单及划动角标。
  adapt(value)::
    if std.type(value) == 'array' then [$.adapt(item) for item in value]
    else if std.type(value) != 'object' then value
    else if isNumbers(value) then {
      [key]: value[key]
      for key in std.objectFields(value)
      if key != 'systemImageName' && key != 'highlightSystemImageName' && key != 'buttonStyleType'
    } + {
      text: '123',
      [if std.objectHas(value, 'buttonStyleType') then 'buttonStyleType']: 'text',
    }
    else {
      [key]: if key == 'systemImageName' || key == 'highlightSystemImageName'
             then icon(value[key]) else $.adapt(value[key])
      for key in std.objectFields(value)
    },
}
