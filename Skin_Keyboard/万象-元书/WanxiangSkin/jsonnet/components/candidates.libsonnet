// 统一生成横向候选栏、纵向候选栏、候选控制按钮与候选词长按菜单。
local Settings = import '../Custom.libsonnet';
local appearance = import '../design/appearance.libsonnet';
local color = appearance.color;
local fontSize = appearance.fontSize;

{
  // 按主题生成完整候选栏配置，字段名与 Cell 引用保持统一。
  getCandidates(theme)::
    local makeToolbarSystemImageForegroundStyle(systemImageName, extra={}) = {
      buttonStyleType: 'systemImage',
      systemImageName: systemImageName,
      normalColor: color[theme]['toolbar按键颜色'],
      highlightColor: color[theme]['toolbar按键颜色'],
      fontSize: fontSize['toolbar按键前景sf符号大小'],
      fontWeight: 'medium',
    } + extra;
    local makeToolbarTextForegroundStyle(textValue, fontSizeValue, extra={}) = {
      buttonStyleType: 'text',
      text: textValue,
      normalColor: color[theme]['按键前景颜色'],
      highlightColor: color[theme]['按键前景颜色'],
      fontSize: fontSizeValue,
    } + extra;
    local makeToolbarButtonStyle(foregroundStyle, action, extra={}) = {
      backgroundStyle: 'toolbarButtonBackgroundStyle',
      foregroundStyle: foregroundStyle,
      action: action,
    } + extra;
    local makeSystemButtonStyle(foregroundStyle, action, extra={}) = {
      backgroundStyle: 'systemButtonBackgroundStyle',
      foregroundStyle: foregroundStyle,
      action: action,
    } + extra;
    local makeVerticalCandidateSystemImageForegroundStyle(systemImageName, extra={}) = {
      buttonStyleType: 'systemImage',
      systemImageName: systemImageName,
      normalColor: color[theme]['按键前景颜色'],
      highlightColor: color[theme]['按键前景颜色'],
      fontSize: fontSize['数字键盘数字前景字体大小'] - 3,
      center: { y: 0.53 },
    } + extra;

    {
      // 横向候选栏由候选区域与可配置的右侧控制按钮组成。
      horizontalCandidatesStyle: {
        insets: { left: 5, right: 10 },
        backgroundStyle: 'toolbarBackgroundStyle',
      },
      horizontalCandidatesLayout: [
        {
          HStack: {
            subviews: [
              { Cell: 'horizontalCandidates' },
              if Settings.horizon_candidate_button == 1 then
                { Cell: 'expandButton' }
              else if Settings.horizon_candidate_button == 2 then
                { Cell: 'toolbarButtonHideStyle' }
              else
                {},
            ],
          },
        },
      ],
      horizontalCandidates: {
        type: 'horizontalCandidates',
        size: { width: '6/7' },
        maxColumns: 6,
        insets: { left: 3, right: 3 },
        backgroundStyle: 'toolbarBackgroundStyle',
        candidateStyle: 'horizontalCandidateStyle',
      },
      expandButton: makeToolbarButtonStyle(
        'expandButtonForegroundStyle',
        { shortcut: '#candidatesBarStateToggle' }
      ),
      expandButtonForegroundStyle: makeToolbarSystemImageForegroundStyle('chevron.down', {
        normalColor: color[theme]['按键前景颜色'],
        highlightColor: color[theme]['按键前景颜色'],
      }),

      // 纵向候选栏下方依次提供翻页、返回和删除控制按钮。
      verticalCandidatesStyle: {
        insets: { left: 3, bottom: 1, top: 3 },
        backgroundStyle: 'toolbarBackgroundStyle',
      },
      verticalCandidatesLayout: [
        {
          HStack: {
            subviews: [
              { Cell: 'verticalCandidates' },
            ],
          },
        },
        {
          HStack: {
            style: 'HStackStyle',
            subviews: [
              { Cell: 'verticalCandidatePageUpButton' },
              { Cell: 'verticalCandidatePageDownButton' },
              { Cell: 'verticalCandidateReturnButton' },
              { Cell: 'verticalCandidateBackspaceButton' },
            ],
          },
        },
      ],
      HStackStyle: {
        size: {
          height: '1/6',
        },
      },
      verticalCandidates: {
        type: 'verticalCandidates',
        insets: { top: 3, left: 3, right: 3, bottom: 3 },
        maxRows: 5,
        maxColumns: 5,
        backgroundStyle: 'toolbarBackgroundStyle',
        candidateStyle: 'verticalCandidateStyle',
      },
      verticalCandidatePageUpButton: makeSystemButtonStyle(
        'verticalCandidatePageUpButtonForegroundStyle',
        { shortcut: '#verticalCandidatesPageUp' }
      ),
      verticalCandidatePageDownButton: makeSystemButtonStyle(
        'verticalCandidatePageDownButtonForegroundStyle',
        { shortcut: '#verticalCandidatesPageDown' }
      ),
      verticalCandidateReturnButton: makeSystemButtonStyle(
        'verticalCandidateReturnButtonForegroundStyle',
        { shortcut: '#candidatesBarStateToggle' }
      ),
      verticalCandidateBackspaceButton: makeSystemButtonStyle('backspaceButtonForegroundStyle', 'backspace'),

      // 候选文字样式同时覆盖选中、未选中与注释文字状态。
      horizontalCandidateStyle: {
        insets: {
          top: 3,
          bottom: 3,
          left: 5,
          right: 5,
        },
        candidateStateButtonStyle: 'candidateStateButtonStyle',
        highlightBackgroundColor: 0,
        preferredBackgroundColor: color[theme]['选中候选背景颜色'],
        preferredIndexColor: color[theme]['候选字体选中字体颜色'],
        preferredTextColor: color[theme]['候选字体选中字体颜色'],
        preferredCommentColor: color[theme]['候选字体选中字体颜色'],
        indexColor: color[theme]['候选字体未选中字体颜色'],
        textColor: color[theme]['候选字体未选中字体颜色'],
        commentColor: color[theme]['候选字体未选中字体颜色'],
        indexFontSize: fontSize['未展开comment字体大小'],
        textFontSize: fontSize['未展开候选字体选中字体大小'],
        commentFontSize: fontSize['未展开comment字体大小'],
      },
      candidateStateButtonStyle: {
        backgroundStyle: 'toolbarButtonBackgroundStyle',
        foregroundStyle: 'candidateStateButtonForegroundStyle',
      },
      candidateStateButtonForegroundStyle: makeToolbarSystemImageForegroundStyle('chevron.down'),
      verticalCandidateStyle: {
        insets: {
          top: 8,
          bottom: 8,
          left: 8,
          right: 8,
        },
        backgroundInsets: {
          top: 8,
          bottom: 8,
          left: 8,
          right: 8,
        },
        cornerRadius: 7,
        backgroundColor: 0,
        separatorColor: 0,
        highlightBackgroundColor: 0,
        preferredBackgroundColor: color[theme]['选中候选背景颜色'],
        preferredIndexColor: color[theme]['候选字体选中字体颜色'],
        preferredTextColor: color[theme]['候选字体选中字体颜色'],
        preferredCommentColor: color[theme]['候选字体选中字体颜色'],
        indexColor: color[theme]['长按非选中字体颜色'],
        textColor: color[theme]['长按非选中字体颜色'],
        commentColor: color[theme]['长按非选中字体颜色'],
        indexFontSize: fontSize['未展开comment字体大小'],
        textFontSize: fontSize['展开候选字体选中字体大小'],
        commentFontSize: fontSize['未展开comment字体大小'],
      },
      verticalCandidatePageUpButtonForegroundStyle:
        makeVerticalCandidateSystemImageForegroundStyle('chevron.up'),
      verticalCandidatePageDownButtonForegroundStyle:
        makeVerticalCandidateSystemImageForegroundStyle('chevron.down'),
      verticalCandidateReturnButtonStyle: {
        backgroundStyle: 'systemButtonBackgroundStyle',
        foregroundStyle: 'verticalCandidateReturnButtonForegroundStyle',
      },
      verticalCandidateReturnButtonForegroundStyle:
        makeToolbarTextForegroundStyle('返回', fontSize['按键前景文字大小'] - 3),
      verticalCandidateBackspaceButtonStyle: {
        backgroundStyle: 'systemButtonBackgroundStyle',
        foregroundStyle: 'verticalCandidateBackspaceButtonForegroundStyle',
      },
      verticalCandidateBackspaceButtonForegroundStyle:
        makeVerticalCandidateSystemImageForegroundStyle('delete.left'),

      // 候选词长按菜单保持移动、重置、置顶与移除的既有顺序。
      candidateContextMenu: [
        {
          name: '左移',
          action: { sendKeys: 'Control+j' },
        },
        {
          name: '右移',
          action: { sendKeys: 'Control+k' },
        },
        {
          name: '重置',
          action: { sendKeys: 'Control+l' },
        },
        {
          name: '置顶',
          action: { sendKeys: 'Control+p' },
        },
        {
          name: '移除',
          action: { sendKeys: 'Control+Delete' },
        },
      ],
    },
}
