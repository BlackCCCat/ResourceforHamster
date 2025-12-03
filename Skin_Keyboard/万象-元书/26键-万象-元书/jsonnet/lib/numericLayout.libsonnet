{
    LayoutWithFunc: [
      {
        HStack: {
          style: 'rowofFunctionStyle',
          subviews: [
            { Cell: 'leftButton' },
            { Cell: 'headButton' },
            { Cell: 'selectButton' },
            { Cell: 'cutButton' },
            { Cell: 'copyButton' },
            { Cell: 'pasteButton' },
            { Cell: 'tailButton' },
            { Cell: 'rightButton' },
          ],
        },
      },
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
