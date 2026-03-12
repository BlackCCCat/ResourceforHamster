// Add the function-row-specific layout overrides on top of the shared base keyboard layouts.
local Settings = import '../../Custom.libsonnet';
local functionButtonSpecs = import '../functionButtons/specs.libsonnet';

{
  functionRowOrderedKeys:: functionButtonSpecs.resolveOrderedKeys(Settings),

  cell(name):: { Cell: name + 'Button' },

  rowofFunctionStyle:: {
    size: {
      height: { percentage: 0.17 },
    },
    backgroundStyle: 'keyboardBackgroundStyle',
  },

  standardFunctionRow(orderedKeys):: {
    HStack: {
      style: 'rowofFunctionStyle',
      subviews: [$.cell(key) for key in orderedKeys],
    },
  },

  splitFunctionRow(orderedKeys):: (
    local leftKeys = std.slice(orderedKeys, 0, 4, 1);
    local rightKeys = std.slice(orderedKeys, 4, std.length(orderedKeys), 1);
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
                    subviews: [$.cell(key) for key in leftKeys],
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
                    subviews: [$.cell(key) for key in rightKeys],
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
        [$.cell('qButton'), $.cell('weButton'), $.cell('rtButton'), $.cell('yButton')],
        [$.cell('aButton'), $.cell('sdButton'), $.cell('fgButton')],
        [$.cell('shiftButton'), $.cell('zButton'), $.cell('xcButton'), $.cell('vButton')],
        [$.cell('123Button'), $.cell('spaceLeftButton'), $.cell('spaceFirstButton')],
      ],
      [
        [$.cell('yButton'), $.cell('uButton'), $.cell('ioButton'), $.cell('pButton')],
        [$.cell('hButton'), $.cell('jkButton'), $.cell('lButton')],
        [$.cell('vButton'), $.cell('bnButton'), $.cell('mButton'), $.cell('backspaceButton')],
        [$.cell('spaceSecondButton'), $.cell('cn2enButton'), $.cell('enterButton')],
      ]
    ),
    '横屏中文14键': $.compactLandscapeLayoutPatch(
      baseLayout['横屏中文14键'],
      [
        [$.cell('qwButton'), $.cell('erButton'), $.cell('tyButton')],
        [$.cell('asButton'), $.cell('dfButton'), $.cell('ghButton')],
        [$.cell('shiftButton'), $.cell('zxButton'), $.cell('cvButton')],
        [$.cell('123Button'), $.cell('spaceLeftButton'), $.cell('spaceFirstButton')],
      ],
      [
        [$.cell('tyButton'), $.cell('uiButton'), $.cell('opButton')],
        [$.cell('ghButton'), $.cell('jkButton'), $.cell('lButton')],
        [$.cell('bnButton'), $.cell('mButton'), $.cell('backspaceButton')],
        [$.cell('spaceSecondButton'), $.cell('cn2enButton'), $.cell('enterButton')],
      ]
    ),
  },
}
