// Define 9-key T9 letter groups and symbol data so the pinyin 9-key builder reads compact input data instead of inline maps.
{
  lettersUpper: {
    '2': 'ABC',
    '3': 'DEF',
    '4': 'GHI',
    '5': 'JKL',
    '6': 'MNO',
    '7': 'PQRS',
    '8': 'TUV',
    '9': 'WXYZ',
  },

  lettersLower: {
    '2': 'abc',
    '3': 'def',
    '4': 'ghi',
    '5': 'jkl',
    '6': 'mno',
    '7': 'pqrs',
    '8': 'tuv',
    '9': 'wxyz',
  },

  getLetters(isCapital)::
    if isCapital then self.lettersUpper else self.lettersLower,

  digitKeys: [std.toString(num) for num in std.range(2, 9)],

  symbols: [
    { label: ',', action: { character: ',' } },
    { label: '.', action: { character: '.' } },
    { label: '?', action: { character: '?' } },
    { label: '!', action: { character: '!' } },
    { label: '@', action: { character: '@' } },
  ],
}
