// Provide shared helpers for 26-key letter specs so normal and special key sizes come from concise templates.
{
  entries: [
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
    ['z', 'normal'],
    ['x', 'normal'],
    ['c', 'normal'],
    ['v', 'normal'],
    ['b', 'normal'],
    ['n', 'normal'],
    ['m', 'normal'],
  ],

  resolveTemplate(sizeBlock, orientation, template):: (
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
    ) else error 'Unknown 26-key template: ' + template
  ),

  buildSpecs(orientation, keyboardLayout):: (
    local sizeBlock = keyboardLayout[if orientation == 'portrait' then '竖屏按键尺寸' else '横屏按键尺寸'];
    [
      { key: entry[0] } + self.resolveTemplate(sizeBlock, orientation, entry[1])
      for entry in self.entries
    ]
  ),
}
