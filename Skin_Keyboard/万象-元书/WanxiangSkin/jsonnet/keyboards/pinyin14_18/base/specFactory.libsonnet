// 定义 14 键与 18 键共用的规格辅助逻辑。
{
  makeLabel(id, isCapital):: (
    local letters = std.stringChars(id);
    local rendered = [
      if isCapital then std.asciiUpper(letter) else letter
      for letter in letters
    ];
    std.join(' ', rendered)
  ),

  resolveTemplate(keyboardLayout, orientation, template):: (
    local isPortrait = orientation == 'portrait';
    local portrait = keyboardLayout['竖屏按键尺寸'];
    local landscape = keyboardLayout['横屏按键尺寸'];
    if template == '14r1' then {
      width: if isPortrait then portrait['14键Row1Size'].width.percentage else landscape['14键横屏Row1Size'].width.percentage,
    } else if template == '14as' then (
      local source = if isPortrait then portrait['14键As键size和bounds'] else landscape['14键横屏As键size和bounds'];
      {
        width: source.size.width.percentage,
        [if std.objectHas(source, 'bounds') then 'bounds']: source.bounds,
      }
    ) else if template == '14r2' then {
      width: if isPortrait then portrait['14键Row2Size'].width.percentage else landscape['14键横屏Row1Size'].width.percentage,
    } else if template == '14l' then (
      local source = if isPortrait then portrait['14键L键size和bounds'] else landscape['14键横屏L键size和bounds'];
      {
        width: source.size.width.percentage,
        [if std.objectHas(source, 'bounds') then 'bounds']: source.bounds,
      }
    ) else if template == '14r3' then {
      width: if isPortrait then portrait['14键Row3Size'].width.percentage else landscape['14键横屏Row1Size'].width.percentage,
    } else if template == '18r1l' then {
      width: if isPortrait then portrait['18键Row1Size'].width.percentage else landscape['18键横屏Row1LeftSize'].width.percentage,
    } else if template == '18r1r' then {
      width: if isPortrait then portrait['18键Row1Size'].width.percentage else landscape['18键横屏Row1RightSize'].width.percentage,
    } else if template == '18a' then (
      local source = if isPortrait then portrait['18键A键size和bounds'] else landscape['18键横屏A键size和bounds'];
      {
        width: source.size.width.percentage,
        [if std.objectHas(source, 'bounds') then 'bounds']: source.bounds,
      }
    ) else if template == '18r2' then {
      width: if isPortrait then portrait['18键Row2Size'].width.percentage else landscape['18键横屏Row2Size'].width.percentage,
    } else if template == '18l' then (
      local source = if isPortrait then portrait['18键L键size和bounds'] else landscape['18键横屏L键size和bounds'];
      {
        width: source.size.width.percentage,
        [if std.objectHas(source, 'bounds') then 'bounds']: source.bounds,
      }
    ) else if template == '18r3l' then {
      width: if isPortrait then portrait['18键Row3Size'].width.percentage else landscape['18键横屏Row1LeftSize'].width.percentage,
    } else if template == '18r3r' then {
      width: if isPortrait then portrait['18键Row3Size'].width.percentage else landscape['18键横屏Row1RightSize'].width.percentage,
    } else
      error 'Unknown compact template: ' + template
  ),

  buildKeys(entries, context, keyboardLayout):: [
    local template = self.resolveTemplate(keyboardLayout, context.orientation, entry[2]);
    local bounds = if std.objectHas(template, 'bounds') then template.bounds else null;
    {
      id: entry[0],
      action: entry[1],
      label: $.makeLabel(entry[0], context.Settings.is_letter_capital),
      width: template.width,
      [if bounds != null then 'bounds']: bounds,
    }
    for entry in entries
  ],
}
