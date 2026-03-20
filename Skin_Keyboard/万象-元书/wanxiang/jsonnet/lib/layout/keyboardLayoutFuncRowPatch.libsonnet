// Add the function-row-specific layout overrides on top of the shared base keyboard layouts.
local Settings = import '../../Custom.libsonnet';
local functionButtonSpecs = import '../functionButtons/specs.libsonnet';

{
  functionRowOrderedKeys:: functionButtonSpecs.resolveOrderedKeys(Settings),

  cell(name):: { Cell: name + 'Button' },
  rawCell(name):: { Cell: name },

  functionCellWidth(count):: {
    width: {
      percentage: 1 / count,
    },
  },

  functionCell(name, count):: {
    Cell: name + 'Button',
    size: $.functionCellWidth(count),
  },

  rowofFunctionStyle:: {
    size: {
      height: { percentage: 0.17 },
    },
    backgroundStyle: 'keyboardBackgroundStyle',
  },

  standardFunctionRow(orderedKeys):: {
    HStack: {
      style: 'rowofFunctionStyle',
      subviews: [$.functionCell(key, std.length(orderedKeys)) for key in orderedKeys],
    },
  },

  splitFunctionRow(orderedKeys):: (
    local splitIndex = std.ceil(std.length(orderedKeys) / 2);
    local leftKeys = std.slice(orderedKeys, 0, splitIndex, 1);
    local rightKeys = std.slice(orderedKeys, splitIndex, std.length(orderedKeys), 1);
    {
      HStack: {
        style: 'rowofFunctionStyle',
        subviews: [
          {
            VStack: {
              style: 'columnStyle1',
              subviews: [
                {
                  HStack: {
                    subviews: [$.functionCell(key, std.length(leftKeys)) for key in leftKeys],
                  },
                },
              ],
            },
          },
          {
            VStack: {
              style: 'columnStyle2',
            },
          },
          {
            VStack: {
              style: 'columnStyle3',
              subviews: [
                {
                  HStack: {
                    subviews: [$.functionCell(key, std.length(rightKeys)) for key in rightKeys],
                  },
                },
              ],
            },
          },
        ],
      },
    }
  ),

  standardLayoutPatch(layoutDef):: {
    [if std.objectHas(layoutDef, '竖屏按键尺寸') then '竖屏按键尺寸']: layoutDef['竖屏按键尺寸'],
    keyboardLayout: [$.standardFunctionRow($.functionRowOrderedKeys)] + layoutDef.keyboardLayout,
    rowofFunctionStyle: $.rowofFunctionStyle,
    keyboardStyle: layoutDef.keyboardStyle,
    keyboardBackgroundStyle: layoutDef.keyboardBackgroundStyle,
    [if std.objectHas(layoutDef, 'VStackStyle1') then 'VStackStyle1']: layoutDef.VStackStyle1,
    [if std.objectHas(layoutDef, 'CenterStackStyle') then 'CenterStackStyle']: layoutDef.CenterStackStyle,
    [if std.objectHas(layoutDef, 'HStackStyle1') then 'HStackStyle1']: layoutDef.HStackStyle1,
    [if std.objectHas(layoutDef, 'HStackStyle2') then 'HStackStyle2']: layoutDef.HStackStyle2,
  },

  splitLayoutPatch(layoutDef):: {
    keyboardLayout: [$.splitFunctionRow($.functionRowOrderedKeys)] + layoutDef.keyboardLayout,
    rowofFunctionStyle: $.rowofFunctionStyle,
    keyboardStyle: layoutDef.keyboardStyle,
    keyboardBackgroundStyle: layoutDef.keyboardBackgroundStyle,
    columnStyle1: layoutDef.columnStyle1,
    columnStyle2: layoutDef.columnStyle2,
    columnStyle3: layoutDef.columnStyle3,
  },

  compactLandscapeContent(column1Rows, column3Rows):: {
    HStack: {
      style: 'keyboardStyle',
      subviews: [
        {
          VStack: {
            style: 'columnStyle1',
            subviews: [
              { HStack: { subviews: column1Rows[0] } },
              { HStack: { subviews: column1Rows[1] } },
              { HStack: { subviews: column1Rows[2] } },
              { HStack: { subviews: column1Rows[3] } },
            ],
          },
        },
        { VStack: { style: 'columnStyle2' } },
        {
          VStack: {
            style: 'columnStyle3',
            subviews: [
              { HStack: { subviews: column3Rows[0] } },
              { HStack: { subviews: column3Rows[1] } },
              { HStack: { subviews: column3Rows[2] } },
              { HStack: { subviews: column3Rows[3] } },
            ],
          },
        },
      ],
    },
  },

  compactLandscapeLayoutPatch(layoutDef, column1Rows, column3Rows):: {
    keyboardLayout: [$.splitFunctionRow($.functionRowOrderedKeys), $.compactLandscapeContent(column1Rows, column3Rows)],
    rowofFunctionStyle: $.rowofFunctionStyle,
    keyboardStyle: layoutDef.keyboardStyle,
    keyboardBackgroundStyle: layoutDef.keyboardBackgroundStyle,
    columnStyle1: layoutDef.columnStyle1,
    columnStyle2: layoutDef.columnStyle2,
    columnStyle3: layoutDef.columnStyle3,
  },

  getPatch(theme, baseLayout):: {
    '竖屏中文9键': $.standardLayoutPatch(baseLayout['竖屏中文9键']),
    '竖屏中文26键': $.standardLayoutPatch(baseLayout['竖屏中文26键']),
    '竖屏中文18键': $.standardLayoutPatch(baseLayout['竖屏中文18键']),
    '竖屏中文14键': $.standardLayoutPatch(baseLayout['竖屏中文14键']),
    'ipad中文26键': $.standardLayoutPatch(baseLayout['ipad中文26键']),
    '竖屏英文26键': $.standardLayoutPatch(baseLayout['竖屏英文26键']),
    'ipad英文26键': $.standardLayoutPatch(baseLayout['ipad英文26键']),
    '横屏中文26键': $.splitLayoutPatch(baseLayout['横屏中文26键']),
    '横屏英文26键': $.splitLayoutPatch(baseLayout['横屏英文26键']),
    '横屏中文18键': $.compactLandscapeLayoutPatch(
      baseLayout['横屏中文18键'],
      [
        [$.rawCell('qButton'), $.rawCell('weButton'), $.rawCell('rtButton'), $.rawCell('yButton')],
        [$.rawCell('aButton'), $.rawCell('sdButton'), $.rawCell('fgButton')],
        [$.rawCell('shiftButton'), $.rawCell('zButton'), $.rawCell('xcButton'), $.rawCell('vButton')],
        [$.rawCell('123Button'), $.rawCell('spaceLeftButton'), $.rawCell('spaceFirstButton')],
      ],
      [
        [$.rawCell('yButton'), $.rawCell('uButton'), $.rawCell('ioButton'), $.rawCell('pButton')],
        [$.rawCell('hButton'), $.rawCell('jkButton'), $.rawCell('lButton')],
        [$.rawCell('vButton'), $.rawCell('bnButton'), $.rawCell('mButton'), $.rawCell('backspaceButton')],
        [$.rawCell('spaceSecondButton'), $.rawCell('cn2enButton'), $.rawCell('enterButton')],
      ]
    ),
    '横屏中文14键': $.compactLandscapeLayoutPatch(
      baseLayout['横屏中文14键'],
      [
        [$.rawCell('qwButton'), $.rawCell('erButton'), $.rawCell('tyButton')],
        [$.rawCell('asButton'), $.rawCell('dfButton'), $.rawCell('ghButton')],
        [$.rawCell('shiftButton'), $.rawCell('zxButton'), $.rawCell('cvButton')],
        [$.rawCell('123Button'), $.rawCell('spaceLeftButton'), $.rawCell('spaceFirstButton')],
      ],
      [
        [$.rawCell('tyButton'), $.rawCell('uiButton'), $.rawCell('opButton')],
        [$.rawCell('ghButton'), $.rawCell('jkButton'), $.rawCell('lButton')],
        [$.rawCell('bnButton'), $.rawCell('mButton'), $.rawCell('backspaceButton')],
        [$.rawCell('spaceSecondButton'), $.rawCell('cn2enButton'), $.rawCell('enterButton')],
      ]
    ),
  },
}
