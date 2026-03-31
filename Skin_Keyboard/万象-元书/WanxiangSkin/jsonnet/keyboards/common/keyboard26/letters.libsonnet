// 暴露 26 键字母规格，并在文件内展开共享模板。
local entries = [
  ['q', 'normal'],
  ['w', 'normal'],
  ['e', 'normal'],
  ['r', 'normal'],
  ['t', 't'],
  ['y', 'y'],
  ['u', 'normal'],
  ['i', 'normal'],
  ['o', 'normal'],
  ['p', 'normal'],
  ['a', 'a'],
  ['s', 'normal'],
  ['d', 'normal'],
  ['f', 'normal'],
  ['g', 'normal'],
  ['h', 'normal'],
  ['j', 'normal'],
  ['k', 'normal'],
  ['l', 'l'],
  [';', 'normal'],
  ['z', 'normal'],
  ['x', 'normal'],
  ['c', 'normal'],
  ['v', 'normal'],
  ['b', 'normal'],
  ['n', 'normal'],
  ['m', 'normal'],
];

local letters = [entry[0] for entry in entries];
local letters26 = std.filter(function(key) key != ';', letters);

{
  letters: letters26,
  letters27: letters,
  getLetters(includeSemicolon=false): if includeSemicolon then letters else letters26,

  resolveTemplate(orientation, sizeBlock, template)::
    local isPortrait = orientation == 'portrait';
    local normalSize = sizeBlock['普通键size'];
    if template == 'normal' then { size: normalSize, bounds: {} }
    else if template == 'a' then {
      size: sizeBlock['a键size和bounds'].size,
      bounds: sizeBlock['a键size和bounds'].bounds,
    } else if template == 'l' then {
      size: sizeBlock['l键size和bounds'].size,
      bounds: sizeBlock['l键size和bounds'].bounds,
    } else if template == 't' then {
      size: normalSize,
      bounds: if isPortrait then {} else sizeBlock['t键size和bounds'].bounds,
    } else if template == 'y' then (
      if isPortrait then { size: normalSize, bounds: {} }
      else {
        size: sizeBlock['y键size和bounds'].size,
        bounds: sizeBlock['y键size和bounds'].bounds,
      }
    ) else error 'Unknown 26-key template: ' + template,

  get26KeySpecs(orientation, keyboardLayout, includeSemicolon=false)::
    local sizeBlock = keyboardLayout[if orientation == 'portrait' then '竖屏按键尺寸' else '横屏按键尺寸'];
    [
      {
        key: entry[0],
      } + self.resolveTemplate(
        orientation,
        sizeBlock,
        if includeSemicolon && std.member(['a', 'l'], entry[0]) then
          'normal'
        else if includeSemicolon && entry[0] == 'g' then
          't'
        else if includeSemicolon && entry[0] == 'h' then
          'y'
        else
          entry[1]
      )
      for entry in (if includeSemicolon then entries else std.filter(function(entry) entry[0] != ';', entries))
    ],
}
