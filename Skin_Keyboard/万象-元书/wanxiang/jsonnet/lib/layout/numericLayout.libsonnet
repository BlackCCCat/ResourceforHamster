// Define the shared numeric keyboard layout structures.
local Settings = import '../../Custom.libsonnet';
local functionButtonSpecs = import '../functionButtons/specs.libsonnet';

{
    functionRowOrderedKeys:: functionButtonSpecs.resolveOrderedKeys(Settings),
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
    LayoutWithFunc: [
      $.functionRow($.functionRowOrderedKeys),
      {
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
                  { Cell: 'returnButton' },
                ],
              },
            },
            {
              VStack: {
                style: 'VStackStyle2',
                subviews: [
                  { Cell: 'number1Button' },
                  { Cell: 'number4Button' },
                  { Cell: 'number7Button' },
                  { Cell: 'symbolButton' },
                ],
              },
            },
            {
              VStack: {
                style: 'VStackStyle2',
                subviews: [
                  { Cell: 'number2Button' },
                  { Cell: 'number5Button' },
                  { Cell: 'number8Button' },
                  { Cell: 'number0Button' },
                ],
              },
            },
            {
              VStack: {
                style: 'VStackStyle2',
                subviews: [
                  { Cell: 'number3Button' },
                  { Cell: 'number6Button' },
                  { Cell: 'number9Button' },
                  { Cell: 'spaceButton' },
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
    ],
    LayoutWithoutFunc: [
      {
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
                  { Cell: 'returnButton' },
                ],
              },
            },
            {
              VStack: {
                style: 'VStackStyle2',
                subviews: [
                  { Cell: 'number1Button' },
                  { Cell: 'number4Button' },
                  { Cell: 'number7Button' },
                  { Cell: 'symbolButton' },
                ],
              },
            },
            {
              VStack: {
                style: 'VStackStyle2',
                subviews: [
                  { Cell: 'number2Button' },
                  { Cell: 'number5Button' },
                  { Cell: 'number8Button' },
                  { Cell: 'number0Button' },
                ],
              },
            },
            {
              VStack: {
                style: 'VStackStyle2',
                subviews: [
                  { Cell: 'number3Button' },
                  { Cell: 'number6Button' },
                  { Cell: 'number9Button' },
                  { Cell: 'spaceButton' },
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
    ],
}
