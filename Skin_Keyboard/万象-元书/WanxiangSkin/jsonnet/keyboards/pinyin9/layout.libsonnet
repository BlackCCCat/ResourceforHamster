// 定义拼音 9 键的横竖屏专属布局。
local Settings = import '../../Custom.libsonnet';
local functionButtonSpecs = import '../../shared/functionButtons/specs.libsonnet';
local functionRowPatch = import '../../shared/functionButtons/functionRowPatch.libsonnet';
local color = import '../../shared/styles/color.libsonnet';
local styleFactories = import '../../shared/styles/styleFactories.libsonnet';

local pinyin9bottomRowSlots =
  if Settings.swap_9_123_symbol then {
    left: {
      cell: 'symbolButton',
      sizeKey: { width: { percentage: 1 / 4 } },
    },
    right: {
      cell: '123Button',
      sizeKey: { width: { percentage: 1.5 / 7 } },
    },
  } else {
    left: {
      cell: '123Button',
      sizeKey: { width: { percentage: 1 / 4 } },
    },
    right: {
      cell: 'symbolButton',
      sizeKey: { width: { percentage: 1.5 / 7 } },
    },
  };

local pinyin9FunctionOrderedKeys = functionButtonSpecs.resolveOrderedKeys(Settings);
local pinyin9FunctionSplitIndex = std.ceil(std.length(pinyin9FunctionOrderedKeys) / 2);
local pinyin9LeftFunctionKeys = std.slice(pinyin9FunctionOrderedKeys, 0, pinyin9FunctionSplitIndex, 1);
local pinyin9RightFunctionKeys = std.slice(
  pinyin9FunctionOrderedKeys,
  pinyin9FunctionSplitIndex,
  std.length(pinyin9FunctionOrderedKeys),
  1
);
local pinyin9FunctionCellWidth(keys) = 1 / std.length(keys);
local pinyin9PortraitShowFunctions = Settings.function_button_config.with_functions_row.iPhone;
local pinyin9LandscapeShowFunctions = Settings.function_button_config.with_functions_row.iPhone;
local pinyin9LandscapeTopHeight = if pinyin9LandscapeShowFunctions then 0.17 else 0;
local pinyin9LandscapeBottomHeight = if pinyin9LandscapeShowFunctions then 0.83 else 1;
local pinyin9FunctionCells(keys) = [
  {
    Cell: key + 'Button',
    size: {
      width: {
        percentage: pinyin9FunctionCellWidth(keys),
      },
    },
  }
  for key in keys
];

{
  getKeyboardLayout(theme)::
    local makeKeyboardBackgroundStyle() =
      // 生成键盘区域背景。
      styleFactories.makeGeometryStyle(color[theme]['键盘背景颜色']);
    {
      '竖屏中文9键': {
        '竖屏按键尺寸': {
          [pinyin9bottomRowSlots.left.cell]: pinyin9bottomRowSlots.left.sizeKey,
          [pinyin9bottomRowSlots.right.cell]: pinyin9bottomRowSlots.right.sizeKey,
          spaceButton: { width: { percentage: 4 / 7 } },
          cn2enButton: { width: { percentage: 1.5 / 7 } },
          emojiButton: { width: { percentage: 1 / 4 } },
          backspaceButton: { height: { percentage: 1 / 4 } },
          cleanButton: { height: { percentage: 1 / 4 } },
          enterButton: { height: { percentage: 1 / 4 } },
        },
        keyboardLayout:
          (if pinyin9PortraitShowFunctions then [
             functionRowPatch.standardFunctionRow(pinyin9FunctionOrderedKeys),
           ] else []) + [
            {
              HStack: {
                style: 'keyboardStyle',
                subviews: [
                  {
                    VStack: {
                      style: 'VStackStyle1',
                      subviews: [
                        { Cell: 'collection' },
                        { Cell: pinyin9bottomRowSlots.left.cell },
                      ],
                    },
                  },
                  {
                    VStack: {
                      style: 'CenterStackStyle',
                      subviews: [
                        {
                          HStack: {
                            subviews: [
                              { Cell: 'number1Button' },
                              { Cell: 'number2Button' },
                              { Cell: 'number3Button' },
                            ],
                          },
                        },
                        {
                          HStack: {
                            subviews: [
                              { Cell: 'number4Button' },
                              { Cell: 'number5Button' },
                              { Cell: 'number6Button' },
                            ],
                          },
                        },
                        {
                          HStack: {
                            subviews: [
                              { Cell: 'number7Button' },
                              { Cell: 'number8Button' },
                              { Cell: 'number9Button' },
                            ],
                          },
                        },
                        {
                          HStack: {
                            subviews: [
                              { Cell: pinyin9bottomRowSlots.right.cell },
                              { Cell: 'spaceButton' },
                              { Cell: 'cn2enButton' },
                            ],
                          },
                        },
                      ],
                    },
                  },
                  {
                    VStack: {
                      style: 'VStackStyle1',
                      subviews: [
                        { Cell: 'backspaceButton' },
                        { Cell: 'cleanButton' },
                        { Cell: 'enterButton' },
                      ],
                    },
                  },
                ],
              },
            },
          ],
        keyboardStyle: {
          size: {
            height: { percentage: 0.73 },
          },
          insets: {
            top: 3,
            bottom: 3,
            left: 4,
            right: 4,
          },
          backgroundStyle: 'keyboardBackgroundStyle',
        },
        keyboardBackgroundStyle: makeKeyboardBackgroundStyle(),
        [if pinyin9PortraitShowFunctions then 'rowofFunctionStyle']: functionRowPatch.rowofFunctionStyle,
        VStackStyle1: {
          size: {
            width: '29/183',
          },
        },
        CenterStackStyle: {
          size: {
            width: '375/549',
          },
        },
      },
      '横屏中文9键': {
        '横屏按键尺寸': {
          [pinyin9bottomRowSlots.left.cell]: pinyin9bottomRowSlots.left.sizeKey,
          [pinyin9bottomRowSlots.right.cell]: pinyin9bottomRowSlots.right.sizeKey,
          spaceButton: { width: { percentage: 4 / 7 } },
          cn2enButton: { width: { percentage: 1.5 / 7 } },
          emojiButton: { width: { percentage: 1 / 4 } },
          backspaceButton: { height: { percentage: 1 / 3 } },
          cleanButton: { height: { percentage: 1 / 3 } },
          enterButton: { height: { percentage: 1 / 3 } },
        },
        keyboardLayout: [
          {
            HStack: {
              style: 'keyboardStyle',
              subviews: [
                {
                  VStack: {
                    style: 'landscape9LeftColumnStyle',
                    subviews:
                      (if pinyin9LandscapeShowFunctions then [
                         {
                           HStack: {
                             style: 'landscape9TopRowStyle',
                             subviews: pinyin9FunctionCells(pinyin9LeftFunctionKeys),
                           },
                         },
                       ] else []) + [
                        {
                          HStack: {
                            style: 'landscape9BottomRowStyle',
                            subviews: [
                              {
                                VStack: {
                                  style: 'landscape9CollectionColumnStyle',
                                  subviews: [
                                    { Cell: 'collection' },
                                    { Cell: pinyin9bottomRowSlots.left.cell },
                                  ],
                                },
                              },
                              {
                                VStack: {
                                  style: 'landscape9VerticalCandidatesColumnStyle',
                                  subviews: [
                                    { Cell: 'verticalCandidates' },
                                  ],
                                },
                              },
                            ],
                          },
                        },
                      ],
                  },
                },
                {
                  VStack: {
                    style: 'landscape9SpacerColumnStyle',
                  },
                },
                {
                  VStack: {
                    style: 'landscape9RightColumnStyle',
                    subviews:
                      (if pinyin9LandscapeShowFunctions then [
                         {
                           HStack: {
                             style: 'landscape9TopRowStyle',
                             subviews: pinyin9FunctionCells(pinyin9RightFunctionKeys),
                           },
                         },
                       ] else []) + [
                        {
                          HStack: {
                            style: 'landscape9BottomRowStyle',
                            subviews: [
                              {
                                VStack: {
                                  style: 'landscape9InputAreaStyle',
                                  subviews: [
                                    {
                                      HStack: {
                                        style: 'landscape9InputMatrixStyle',
                                        subviews: [
                                          { VStack: { subviews: [{ Cell: 'number1Button' }, { Cell: 'number4Button' }, { Cell: 'number7Button' }] } },
                                          { VStack: { subviews: [{ Cell: 'number2Button' }, { Cell: 'number5Button' }, { Cell: 'number8Button' }] } },
                                          { VStack: { subviews: [{ Cell: 'number3Button' }, { Cell: 'number6Button' }, { Cell: 'number9Button' }] } },
                                        ],
                                      },
                                    },
                                    {
                                      HStack: {
                                        style: 'landscape9InputBottomRowStyle',
                                        subviews: [
                                          { Cell: pinyin9bottomRowSlots.right.cell },
                                          { Cell: 'spaceButton' },
                                          { Cell: 'cn2enButton' },
                                        ],
                                      },
                                    },
                                  ],
                                },
                              },
                              {
                                VStack: {
                                  style: 'landscape9RightActionColumnStyle',
                                  subviews: [
                                    { Cell: 'backspaceButton' },
                                    { Cell: 'cleanButton' },
                                    { Cell: 'enterButton' },
                                  ],
                                },
                              },
                            ],
                          },
                        },
                      ],
                  },
                },
              ],
            },
          },
        ],
        keyboardStyle: {
          size: {
            height: { percentage: 0.73 },
          },
          insets: {
            top: 3,
            bottom: 3,
            left: 4,
            right: 4,
          },
          backgroundStyle: 'keyboardBackgroundStyle',
        },
        keyboardBackgroundStyle: makeKeyboardBackgroundStyle(),
        landscape9LeftColumnStyle: {
          size: {
            width: '2/5',
          },
        },
        landscape9SpacerColumnStyle: {
          size: {
            width: '1/5',
          },
        },
        landscape9RightColumnStyle: {
          size: {
            width: '2/5',
          },
        },
        landscape9TopRowStyle: {
          size: {
            height: { percentage: pinyin9LandscapeTopHeight },
          },
        },
        landscape9BottomRowStyle: {
          size: {
            height: { percentage: pinyin9LandscapeBottomHeight },
          },
        },
        landscape9CollectionColumnStyle: {
          size: {
            width: '29/154',
            height: '1',
          },
        },
        landscape9VerticalCandidatesColumnStyle: {
          size: {
            width: '125/154',
            height: '1',
          },
          backgroundStyle: 'alphabeticBackgroundStyle',
        },
        landscape9InputAreaStyle: {
          size: {
            width: '125/154',
          },
        },
        landscape9RightActionColumnStyle: {
          size: {
            width: '29/154',
          },
        },
        landscape9InputMatrixStyle: {
          size: {
            height: '3/4',
          },
        },
        landscape9InputBottomRowStyle: {
          size: {
            height: '1/4',
          },
        },
      },
    },
}
