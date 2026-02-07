// Size/bounds helpers for 26-key letter layouts.
local letters = [
  'q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p',
  'a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l',
  'z', 'x', 'c', 'v', 'b', 'n', 'm',
];

{
  letters: letters,

  get26KeySpecs(orientation, keyboardLayout):: 
    local isPortrait = orientation == 'portrait';
    local sizeBlock = keyboardLayout[if isPortrait then '竖屏按键尺寸' else '横屏按键尺寸'];
    local normalSize = sizeBlock['普通键size'];

    local aSpec = sizeBlock['a键size和bounds'];
    local lSpec = sizeBlock['l键size和bounds'];
    local tBounds = if isPortrait then {} else sizeBlock['t键size和bounds'].bounds;
    local ySpec = if isPortrait then { size: normalSize, bounds: {} } else sizeBlock['y键size和bounds'];

    local specForKey(key) =
      if key == 'a' then { size: aSpec.size, bounds: aSpec.bounds }
      else if key == 'l' then { size: lSpec.size, bounds: lSpec.bounds }
      else if key == 't' then { size: normalSize, bounds: tBounds }
      else if key == 'y' then { size: ySpec.size, bounds: ySpec.bounds }
      else { size: normalSize, bounds: {} };

    [
      { key: key } + specForKey(key)
      for key in letters
    ],
}
