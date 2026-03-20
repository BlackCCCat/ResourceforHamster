// Define the shared numeric keyboard layout structures.
local Settings = import '../../Custom.libsonnet';
local functionButtonSpecs = import '../functionButtons/specs.libsonnet';
local numericBottomSlots =
  if Settings.swap_numeric_return_symbol then {
    left: 'symbolButton',
    right: 'returnButton',
  } else {
    left: 'returnButton',
    right: 'symbolButton',
  };

{
  functionRowOrderedKeys:: functionButtonSpecs.resolveOrderedKeys(Settings),
  landscapeShowFunctions:: Settings.function_button_config.with_functions_row.iPhone,
  landscapeFunctionSplitIndex:: std.ceil(std.length($.functionRowOrderedKeys) / 2),
  landscapeLeftFunctionKeys:: std.slice($.functionRowOrderedKeys, 0, $.landscapeFunctionSplitIndex, 1),
  landscapeRightFunctionKeys:: std.slice($.functionRowOrderedKeys, $.landscapeFunctionSplitIndex, std.length($.functionRowOrderedKeys), 1),
  landscapeTopHeight:: if $.landscapeShowFunctions then 0.17 else 0,
  landscapeBottomHeight:: if $.landscapeShowFunctions then 0.83 else 1,
  functionCellWidth(count):: {
    width: {
      percentage: 1 / count,
    },
  },
  functionCell(name, count):: {
    Cell: name + 'Button',
    size: $.functionCellWidth(count),
  },
  functionRow(orderedKeys):: {
    HStack: {
      style: 'rowofFunctionStyle',
      subviews: [$.functionCell(key, std.length(orderedKeys)) for key in orderedKeys],
    },
  },
  landscapeFunctionRow(orderedKeys):: {
    HStack: {
      style: 'landscapeNumericTopRowStyle',
      subviews: [$.functionCell(key, std.length(orderedKeys)) for key in orderedKeys],
    },
  },
  portraitContent:: {
    HStack: {
      style: 'keyboardStyle',
      subviews: [
        {
          VStack: {
            style: 'VStackStyle1',
            subviews: [
              {
                Cell: 'collection',
              },
              { Cell: numericBottomSlots.left },
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
                    { Cell: numericBottomSlots.right },
                    { Cell: 'number0Button' },
                    { Cell: 'spaceButton' },
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
              { Cell: 'spaceRightButton' },
              { Cell: 'atButton' },
              { Cell: 'enterButton' },
            ],
          },
        },
      ],
    },
  },
  LayoutWithFunc: [
    $.functionRow($.functionRowOrderedKeys),
    $.portraitContent,
  ],
  LayoutWithoutFunc: [
    $.portraitContent,
  ],
  LandscapeLayout: [
    {
      HStack: {
        style: 'keyboardStyle',
        subviews: [
          {
            VStack: {
              style: 'landscapeNumericLeftColumnStyle',
              subviews:
                (if $.landscapeShowFunctions then [$.landscapeFunctionRow($.landscapeLeftFunctionKeys)] else []) + [
                  {
                    HStack: {
                      style: 'landscapeNumericBottomRowStyle',
                      subviews: [
                        {
                          VStack: {
                            style: 'landscapeNumericCollectionColumnStyle',
                            subviews: [
                              { Cell: 'collection' },
                              { Cell: numericBottomSlots.left },
                            ],
                          },
                        },
                        {
                          VStack: {
                            style: 'landscapeNumericSymbolsColumnStyle',
                            subviews: [
                              { Cell: 'landscapeNumericSymbols' },
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
              style: 'landscapeNumericSpacerColumnStyle',
            },
          },
          {
            VStack: {
              style: 'landscapeNumericRightColumnStyle',
              subviews:
                (if $.landscapeShowFunctions then [$.landscapeFunctionRow($.landscapeRightFunctionKeys)] else []) + [
                  {
                    HStack: {
                      style: 'landscapeNumericBottomRowStyle',
                      subviews: [
                        {
                          VStack: {
                            style: 'landscapeNumericInputAreaStyle',
                            subviews: [
                              {
                                HStack: {
                                  style: 'landscapeNumericInputMatrixStyle',
                                  subviews: [
                                    { VStack: { subviews: [{ Cell: 'number1Button' }, { Cell: 'number4Button' }, { Cell: 'number7Button' }] } },
                                    { VStack: { subviews: [{ Cell: 'number2Button' }, { Cell: 'number5Button' }, { Cell: 'number8Button' }] } },
                                    { VStack: { subviews: [{ Cell: 'number3Button' }, { Cell: 'number6Button' }, { Cell: 'number9Button' }] } },
                                  ],
                                },
                              },
                              {
                                HStack: {
                                  style: 'landscapeNumericInputBottomRowStyle',
                                  subviews: [
                                    {
                                      Cell: numericBottomSlots.right,
                                      size: {
                                        width: {
                                          percentage: 1 / 3,
                                        },
                                      },
                                    },
                                    {
                                      Cell: 'number0Button',
                                      size: {
                                        width: {
                                          percentage: 1 / 3,
                                        },
                                      },
                                    },
                                    {
                                      Cell: 'spaceButton',
                                      size: {
                                        width: {
                                          percentage: 1 / 3,
                                        },
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
                            style: 'landscapeNumericRightActionColumnStyle',
                            subviews: [
                              { Cell: 'backspaceButton' },
                              { Cell: 'spaceRightButton' },
                              { Cell: 'atButton' },
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
  landscapeNumericLeftColumnStyle: {
    size: {
      width: '2/5',
    },
  },
  landscapeNumericSpacerColumnStyle: {
    size: {
      width: '1/5',
    },
  },
  landscapeNumericRightColumnStyle: {
    size: {
      width: '2/5',
    },
  },
  landscapeNumericTopRowStyle: {
    size: {
      height: { percentage: $.landscapeTopHeight },
    },
  },
  landscapeNumericBottomRowStyle: {
    size: {
      height: { percentage: $.landscapeBottomHeight },
    },
  },
  landscapeNumericCollectionColumnStyle: {
    size: {
      width: '29/154',
      height: '1',
    },
  },
  landscapeNumericSymbolsColumnStyle: {
    size: {
      width: '125/154',
      height: '1',
    },
  },
  landscapeNumericInputAreaStyle: {
    size: {
      width: '125/154',
    },
  },
  landscapeNumericRightActionColumnStyle: {
    size: {
      width: '29/154',
    },
  },
  landscapeNumericInputMatrixStyle: {
    size: {
      height: '3/4',
    },
  },
  landscapeNumericInputBottomRowStyle: {
    size: {
      height: '1/4',
    },
  },
}
