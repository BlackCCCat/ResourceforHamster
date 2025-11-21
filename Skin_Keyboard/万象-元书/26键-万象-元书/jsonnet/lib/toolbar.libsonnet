local center = import 'center.libsonnet';
local color = import 'color.libsonnet';
local fontSize = import 'fontSize.libsonnet';


local getToolBar(theme) =

  {
    preeditStyle: {
      insets: { left: 8 ,top: 2},
      // backgroundStyle: 'toolbarBackgroundStyle',
      foregroundStyle: 'preeditForegroundStyle',
    },
    preeditForegroundStyle: {
      insets: { left: 30 },
    },
    // 工具栏样式
    toolbarStyle: {
      insets: { left: 10, right: 10 },
      // backgroundStyle: 'toolbarBackgroundStyle',
    },
    toolbarLayout: [
      {
        HStack: {
          subviews: [
            // { Cell: 'toolbarButtonOpenAppStyle' },
            { Cell: 'toolbarSlideButtons2' },  // 滑动工具栏 包含 app相关内容
            { Cell: 'toolbarSlideButtons' },  // 滑动工具栏 包含 谷歌搜索、浏览器打开、App Store搜索
            // { Cell: 'toolbarButtonKeyboardSettingsStyle' },  //键盘设置
            // { Cell: 'toolbarButtonRimeSwitcherStyle' },  // 方案
            // { Cell: 'toolbarButtonEmbeddingToggleStyle' },  //内嵌开关
            // { Cell: 'toolbarButtonPanelStyle'},  // 面板
            // { Cell: 'toolbarButtonswitchKeyboardStyle'},  // 切换中英键盘
            // { Cell: 'toolbarButtonUndoStyle' },  // 撤销
            // { Cell: 'toolbarButtonRedoStyle' },  //重做
            // { Cell: 'toolbarButtonAppleStyle' },  // App Store搜索
            // { Cell: 'toolbarButtonGoogleStyle' },  // 谷歌搜索
            // { Cell: 'toolbarButtonSafariStyle' },  // 浏览器打开
            // { Cell: 'toolbarButtonSymbolStyle' },  // 符号
            // { Cell: 'toolbarButtonEmojiStyle' },  // 表情
            { Cell: 'toolbarButtonScriptStyle' },  // 脚本
            { Cell: 'toolbarButtonNoteStyle' },  // 常用语
            { Cell: 'toolbarButtonClipboardStyle' },  // 剪切板
            { Cell: 'toolbarButtonKeyboardSelectionStyle' },  // 键盘相关功能，包括收起键盘，切换单手键盘
            { Cell: 'toolbarButtonHideStyle' },  // 收起键盘
          ],
        },
      },
    ],
    toolbarSlideButtons2: {
      type: 'horizontalSymbols',
      size: { width: '2/9' },
      maxColumns: 2,
      contentRightToLeft: false,
      insets: { left: 3, right: 3 },
      backgroundStyle: 'toolbarcollectionCellBackgroundStyle',
      dataSource: 'horizontalSymbolsDataSource2',
      // 用于定义符号列表中每个符号的样式(仅支持文本)
      cellStyle: 'toolbarcollectionCellStyle',
    },
    horizontalSymbolsDataSource2: [
      { label: '0', action: { openURL: 'hamster3://' }, styleName: 'toolbarButtonOpenAppStyle' },
      { label: '1', action: { openURL: 'hamster3://com.ihsiao.apps.hamster3/keyboardSettings' }, styleName: 'toolbarButtonKeyboardSettingsStyle' },
      { label: '2', action: { openURL: 'hamster3://com.ihsiao.apps.hamster3/keyboardSkins' }, styleName: 'toolbarButtonKeyboardSkinsStyle' },
      { label: '5', action: { shortcut: '#keyboardPerformance' }, styleName: 'toolbarButtonKeyboardPerfomanceStyle' },
      { label: '3', action: { shortcut: '#toggleEmbeddedInputMode' }, styleName: 'toolbarButtonEmbeddingToggleStyle' },
      { label: '4', action: { shortcut: '#RimeSwitcher' }, styleName: 'toolbarButtonRimeSwitcherStyle' },
    ],

    toolbarButtonKeyboardSelectionStyle: {
      type: 'horizontalSymbols',
      size: { width: '1/9' },
      maxColumns: 1,
      contentRightToLeft: false,
      insets: { left: 3, right: 3 },
      backgroundStyle: 'toolbarcollectionCellBackgroundStyle',
      dataSource: 'horizontalSymbolsDataSource3',
      // 用于定义符号列表中每个符号的样式(仅支持文本)
      cellStyle: 'toolbarcollectionCellStyle',
    },
    horizontalSymbolsDataSource3: [
      { label: '1', action: { shortcut: '#右手模式' }, styleName: 'toolbarButtonRighthandKeyboardStyle' },
      { label: '0', action: { shortcut: '#左手模式' }, styleName: 'toolbarButtonLefthandKeyboardStyle' },
    ],

    toolbarSlideButtons: {
      type: 'horizontalSymbols',
      size: { width: '2/9' },
      maxColumns: 2,
      contentRightToLeft: false,
      insets: { left: 3, right: 3 },
      backgroundStyle: 'toolbarcollectionCellBackgroundStyle',
      dataSource: 'horizontalSymbolsDataSource',
      // 用于定义符号列表中每个符号的样式(仅支持文本)
      cellStyle: 'toolbarcollectionCellStyle',
    },
    toolbarcollectionCellStyle: {
      backgroundStyle: 'toolbarcollectionCellBackgroundStyle',
      foregroundStyle: 'toolbarcollectionCellForegroundStyle',
    },
    toolbarcollectionCellBackgroundStyle: {
      buttonStyleType: 'geometry',
      normalColor: color[theme]['键盘背景颜色'],
    },
    toolbarcollectionCellForegroundStyle: {
      buttonStyleType: 'geometry',
      normalColor: color[theme]['键盘背景颜色'],
    },
    horizontalSymbolsDataSource: [
      { label: '6', action: { openURL: 'https://www.google.com/search?q=#pasteboardContent' }, styleName: 'toolbarButtonGoogleStyle' },
      { label: '7', action: { openURL: '#pasteboardContent' }, styleName: 'toolbarButtonSafariStyle' },
      { label: '5', action: { openURL: 'itms-apps://search.itunes.apple.com/WebObjects/MZSearch.woa/wa/search?media=software&term=#pasteboardContent' }, styleName: 'toolbarButtonAppleStyle' },
    ],


    // 横向候选文字栏调式
    horizontalCandidatesStyle: {
      insets: { left: 5 , top: 3},
      backgroundStyle: 'toolbarBackgroundStyle',
    },
    horizontalCandidatesLayout: [
      {
        HStack: {
          subviews: [
            { Cell: 'horizontalCandidates' },
            // { Cell: 'clearPreeditButton' },
            // { Cell: 'expandButton' },
          ],
        },
      },
    ],
    horizontalCandidates: {
      // 定义一个横向候选文字展示区域
      type: 'horizontalCandidates',
      size: { width: '6/7' },
      // （非必须，默认值为 7）用于定义显示区域内最大候选文字数量
      maxColumns: 6,
      insets: { left: 3, right: 3 },
      backgroundStyle: 'toolbarBackgroundStyle',
      // 用于定义候选文字显示样式
      candidateStyle: 'horizontalCandidateStyle',
    },
    // 横向候选展开按键定义
    expandButton: {
      backgroundStyle: 'toolbarButtonBackgroundStyle',
      foregroundStyle: 'expandButtonForegroundStyle',
      action: { shortcut: '#candidatesBarStateToggle' },
    },
    expandButtonForegroundStyle: {
      buttonStyleType: 'systemImage',
      // insets: { left: -5, right: -5, top: -5, bottom: -5 },
      systemImageName: 'chevron.down',
      normalColor: color[theme]['按键前景颜色'],
      fontSize: fontSize['toolbar按键前景sf符号大小'],
      // center: center['toolbar按键偏移'],
    },

    // 纵向候选文字栏调式
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
        height: '1/5',
      },
    },
    verticalCandidates: {
      // 定义一个纵向候选文字显示区域
      type: 'verticalCandidates',
      insets: { top: 3, left: 3, right: 3, bottom: 3 },
      // （非必须，默认值为 4）显示区域内候选文字最大行数
      maxRows: 4,
      // （非必须，默认值为 5）显示区域内候选文字最大列数
      maxColumns: 5,
      // （非必须）显示区域内分割线颜色
      // separatorColor: '#33338888',
      backgroundStyle: 'toolbarBackgroundStyle',
      // 候选文字样式
      candidateStyle: 'verticalCandidateStyle',
    },
    verticalCandidatePageUpButton: {
      backgroundStyle: 'systemButtonBackgroundStyle',
      foregroundStyle: 'verticalCandidatePageUpButtonForegroundStyle',
      action: { shortcut: '#verticalCandidatesPageUp' },
    },
    verticalCandidatePageDownButton: {
      backgroundStyle: 'systemButtonBackgroundStyle',
      foregroundStyle: 'verticalCandidatePageDownButtonForegroundStyle',
      action: { shortcut: '#verticalCandidatesPageDown' },
    },
    verticalCandidateReturnButton: {
      backgroundStyle: 'systemButtonBackgroundStyle',
      foregroundStyle: 'verticalCandidateReturnButtonForegroundStyle',
      action: { shortcut: '#candidatesBarStateToggle' },
    },
    verticalCandidateBackspaceButton: {
      backgroundStyle: 'systemButtonBackgroundStyle',
      foregroundStyle: 'backspaceButtonForegroundStyle',
      action: 'backspace',
    },

    toolbarBackgroundStyle: {
      buttonStyleType: 'geometry',
      normalColor: color[theme]['键盘背景颜色'],
    },
    toolbarButtonBackgroundStyle: {
      // "type": "original",
      // "normalBorderColor": "000000",
      // "borderSize": 1,
      normalColor: 0,
      highlightColor: 0,
    },
    toolbarButtonswitchKeyboardStyle: {
      backgroundStyle: 'toolbarButtonBackgroundStyle',
      foregroundStyle: 'toolbarButtonswitchKeyboardForegroundStyle',
      action: {
        keyboardType: 'alphabetic',
      },
    },

    toolbarButtonswitchKeyboardForegroundStyle: {
      buttonStyleType: 'assetImage',
      assetImageName: 'chineseState',
      normalColor: color[theme]['toolbar按键颜色'],
      highlightColor: color[theme]['toolbar按键颜色'],
      fontSize: fontSize['toolbar按键前景sf符号大小'],
      // center: center['toolbar按键文字偏移'],
      fontWeight: 'medium',
    },
    toolbarButtonHideStyle: {
      backgroundStyle: 'toolbarButtonBackgroundStyle',
      foregroundStyle: 'toolbarButton1ForegroundStyle',
      action: 'dismissKeyboard',
    },
    toolbarButton1ForegroundStyle: {
      buttonStyleType: 'systemImage',
      systemImageName: 'keyboard.chevron.compact.down.fill',
      normalColor: color[theme]['toolbar按键颜色'],
      highlightColor: color[theme]['toolbar按键颜色'],
      fontSize: fontSize['toolbar按键前景sf符号大小'],
      // center: center['toolbar按键文字偏移'],
      fontWeight: 'medium',
    },
    toolbarButtonRighthandKeyboardStyle: {
      backgroundStyle: 'toolbarButtonBackgroundStyle',
      foregroundStyle: 'toolbarButtonRighthandForegroundStyle',
    },
    toolbarButtonRighthandForegroundStyle: {
      buttonStyleType: 'systemImage',
      systemImageName: 'keyboard.onehanded.right.fill',
      normalColor: color[theme]['toolbar按键颜色'],
      highlightColor: color[theme]['toolbar按键颜色'],
      fontSize: fontSize['toolbar按键前景sf符号大小'],
      // center: center['toolbar按键文字偏移'],
      fontWeight: 'medium',
    },
    toolbarButtonLefthandKeyboardStyle: {
      backgroundStyle: 'toolbarButtonBackgroundStyle',
      foregroundStyle: 'toolbarButtonLefthandForegroundStyle',
    },
    toolbarButtonLefthandForegroundStyle: {
      buttonStyleType: 'systemImage',
      systemImageName: 'keyboard.onehanded.left.fill',
      normalColor: color[theme]['toolbar按键颜色'],
      highlightColor: color[theme]['toolbar按键颜色'],
      fontSize: fontSize['toolbar按键前景sf符号大小'],
      // center: center['toolbar按键文字偏移'],
      fontWeight: 'medium',
    },
    toolbarButtonOpenAppStyle: {
      backgroundStyle: 'toolbarButtonBackgroundStyle',
      foregroundStyle: 'toolbarButtonOpenAppForegroundStyle',
      // action: {
      //   // floatKeyboardType: 'panel',
      //   openURL: 'hamster3://',
      // },
    },

    toolbarButtonOpenAppForegroundStyle: {
      buttonStyleType: 'systemImage',
      systemImageName: 'swirl.circle.righthalf.filled',
      normalColor: color[theme]['toolbar按键颜色'],
      highlightColor: color[theme]['toolbar按键颜色'],
      fontSize: fontSize['toolbar按键前景sf符号大小'],
      // center: center['toolbar按键文字偏移'],
      fontWeight: 'medium',
    },
    toolbarButtonPanelStyle: {
      backgroundStyle: 'toolbarButtonBackgroundStyle',
      foregroundStyle: 'toolbarButtonPanelForegroundStyle',
      action: {
        floatKeyboardType: 'panel',
      },
    },
    toolbarButtonPanelForegroundStyle: {
      buttonStyleType: 'systemImage',
      systemImageName: 'gearshape.fill',
      normalColor: color[theme]['toolbar按键颜色'],
      highlightColor: color[theme]['toolbar按键颜色'],
      fontSize: fontSize['toolbar按键前景sf符号大小'],
      // center: center['toolbar按键文字偏移'],
      fontWeight: 'medium',
    },

    toolbarButtonNoteStyle: {
      backgroundStyle: 'toolbarButtonBackgroundStyle',
      foregroundStyle: 'toolbarButton3ForegroundStyle',
      action: {
        shortcutCommand: '#showPhraseView',
      },
    },
    toolbarButton3ForegroundStyle: {
      buttonStyleType: 'systemImage',
      systemImageName: 'note.text',
      normalColor: color[theme]['toolbar按键颜色'],
      highlightColor: color[theme]['toolbar按键颜色'],
      fontSize: fontSize['toolbar按键前景sf符号大小'],
      // center: center['toolbar按键文字偏移'],
      fontWeight: 'medium',
    },
    toolbarButtonScriptStyle: {
      backgroundStyle: 'toolbarButtonBackgroundStyle',
      foregroundStyle: 'toolbarButtonScriptForegroundStyle',
      action: {
        shortcutCommand: '#toggleScriptView',
      },
    },
    toolbarButtonScriptForegroundStyle: {
      buttonStyleType: 'systemImage',
      systemImageName: 'apple.terminal.fill',
      normalColor: color[theme]['toolbar按键颜色'],
      highlightColor: color[theme]['toolbar按键颜色'],
      fontSize: fontSize['toolbar按键前景sf符号大小'],
      // center: center['toolbar按键文字偏移'],
      fontWeight: 'medium',
    },
    toolbarButtonEmojiStyle: {
      backgroundStyle: 'toolbarButtonBackgroundStyle',
      foregroundStyle: 'toolbarButtonEmojiForegroundStyle',
      action: { keyboardType: 'emoji' },
    },
    toolbarButtonEmojiForegroundStyle: {
      buttonStyleType: 'systemImage',
      systemImageName: 'face.dashed.fill',
      normalColor: color[theme]['toolbar按键颜色'],
      highlightColor: color[theme]['toolbar按键颜色'],
      fontSize: fontSize['toolbar按键前景sf符号大小'],
      // center: center['toolbar按键文字偏移'],
      fontWeight: 'medium',
    },
    toolbarButtonSymbolStyle: {
      backgroundStyle: 'toolbarButtonBackgroundStyle',
      foregroundStyle: 'toolbarButtonSymbolForegroundStyle',
      action: { keyboardType: 'symbolic' },
    },
    toolbarButtonSymbolForegroundStyle: {
      buttonStyleType: 'systemImage',
      systemImageName: 'command.circle.fill',
      normalColor: color[theme]['toolbar按键颜色'],
      highlightColor: color[theme]['toolbar按键颜色'],
      fontSize: fontSize['toolbar按键前景sf符号大小'],
      // center: center['toolbar按键文字偏移'],
      fontWeight: 'medium',
    },
    toolbarButtonClipboardStyle: {
      backgroundStyle: 'toolbarButtonBackgroundStyle',
      foregroundStyle: 'toolbarButton4ForegroundStyle',
      action: {
        shortcutCommand: '#showPasteboardView',
      },
    },
    toolbarButton4ForegroundStyle: {
      buttonStyleType: 'systemImage',
      systemImageName: 'list.bullet.clipboard',
      normalColor: color[theme]['toolbar按键颜色'],
      highlightColor: color[theme]['toolbar按键颜色'],
      fontSize: fontSize['toolbar按键前景sf符号大小'],
      // center: center['toolbar按键文字偏移'],
      fontWeight: 'medium',
    },

    toolbarButtonSafariStyle: {
      backgroundStyle: 'toolbarButtonBackgroundStyle',
      foregroundStyle: 'toolbarButton5ForegroundStyle',
      action: {
        openURL: '#pasteboardContent',
      },
    },
    toolbarButton5ForegroundStyle: {
      buttonStyleType: 'systemImage',
      systemImageName: 'safari.fill',
      normalColor: color[theme]['toolbar按键颜色'],
      highlightColor: color[theme]['toolbar按键颜色'],
      fontSize: fontSize['toolbar按键前景sf符号大小'],
      // center: center['toolbar按键文字偏移'],
      fontWeight: 'medium',
    },

    toolbarButtonAppleStyle: {
      backgroundStyle: 'toolbarButtonBackgroundStyle',
      foregroundStyle: 'toolbarButton6ForegroundStyle',
      // action: {
      //   openURL: 'itms-apps://search.itunes.apple.com/WebObjects/MZSearch.woa/wa/search?media=software&term=#pasteboardContent',
      // },
    },
    toolbarButton6ForegroundStyle: {
      buttonStyleType: 'systemImage',
      systemImageName: 'apple.logo',
      normalColor: color[theme]['toolbar按键颜色'],
      highlightColor: color[theme]['toolbar按键颜色'],
      fontSize: fontSize['toolbar按键前景sf符号大小'],
      // center: center['toolbar按键文字偏移'],
      fontWeight: 'medium',
    },
    toolbarButtonGoogleStyle: {
      backgroundStyle: 'toolbarButtonBackgroundStyle',
      foregroundStyle: 'toolbarButton7ForegroundStyle',
      // action: {
      //   openURL: 'https://www.google.com/search?q=#pasteboardContent',
      // },
    },
    toolbarButton7ForegroundStyle: {
      buttonStyleType: 'systemImage',
      systemImageName: 'g.circle.fill',
      normalColor: color[theme]['toolbar按键颜色'],
      highlightColor: color[theme]['toolbar按键颜色'],
      fontSize: fontSize['toolbar按键前景sf符号大小'],
      // center: center['toolbar按键文字偏移'],
      fontWeight: 'medium',
    },
    toolbarButtonUndoStyle: {
      backgroundStyle: 'toolbarButtonBackgroundStyle',
      foregroundStyle: 'toolbarButtonUndoForegroundStyle',
      // action: {
      //   shortcut: '#undo',
      // },
    },
    toolbarButtonUndoForegroundStyle: {
      buttonStyleType: 'systemImage',
      systemImageName: 'arrow.uturn.left.circle.fill',
      normalColor: color[theme]['toolbar按键颜色'],
      highlightColor: color[theme]['toolbar按键颜色'],
      fontSize: fontSize['toolbar按键前景sf符号大小'],
      // center: center['toolbar按键文字偏移'],
      fontWeight: 'medium',
    },
    toolbarButtonRedoStyle: {
      backgroundStyle: 'toolbarButtonBackgroundStyle',
      foregroundStyle: 'toolbarButtonRedoForegroundStyle',
      // action: {
      //   shortcut: '#redo',
      // },
    },
    toolbarButtonRedoForegroundStyle: {
      buttonStyleType: 'systemImage',
      systemImageName: 'arrow.uturn.right.circle.fill',
      normalColor: color[theme]['toolbar按键颜色'],
      highlightColor: color[theme]['toolbar按键颜色'],
      fontSize: fontSize['toolbar按键前景sf符号大小'],
      // center: center['toolbar按键文字偏移'],
      fontWeight: 'medium',
    },
    toolbarButtonRimeSwitcherStyle: {
      backgroundStyle: 'toolbarButtonBackgroundStyle',
      foregroundStyle: 'toolbarButtonRimeSwitcherForegroundStyle',
      // action: {
      //   shortcut: '#RimeSwitcher',
      // },
    },
    toolbarButtonRimeSwitcherForegroundStyle: {
      buttonStyleType: 'systemImage',
      systemImageName: 'filemenu.and.selection',
      normalColor: color[theme]['toolbar按键颜色'],
      highlightColor: color[theme]['toolbar按键颜色'],
      fontSize: fontSize['toolbar按键前景sf符号大小'],
      // center: center['toolbar按键文字偏移'],
      fontWeight: 'medium',
    },
    toolbarButtonEmbeddingToggleStyle: {
      backgroundStyle: 'toolbarButtonBackgroundStyle',
      foregroundStyle: 'toolbarButtonEmbeddingToggleForegroundStyle',
      // action: {
      //   shortcut: '#toggleEmbeddedInputMode',
      // },
    },
    toolbarButtonEmbeddingToggleForegroundStyle: {
      buttonStyleType: 'systemImage',
      systemImageName: 'dots.and.line.vertical.and.cursorarrow.rectangle',
      normalColor: color[theme]['toolbar按键颜色'],
      highlightColor: color[theme]['toolbar按键颜色'],
      fontSize: fontSize['toolbar按键前景sf符号大小'],
      // center: center['toolbar按键文字偏移'],
      fontWeight: 'medium',
    },
    toolbarButtonKeyboardSettingsStyle: {
      backgroundStyle: 'toolbarButtonBackgroundStyle',
      foregroundStyle: 'toolbarButtonKeyboardSettingsForegroundStyle',
      // action: {
      //   openURL: 'hamster3://com.ihsiao.apps.hamster3/keyboardSettings',
      // },
    },
    toolbarButtonKeyboardSettingsForegroundStyle: {
      buttonStyleType: 'systemImage',
      systemImageName: 'gearshape.fill',
      normalColor: color[theme]['toolbar按键颜色'],
      highlightColor: color[theme]['toolbar按键颜色'],
      fontSize: fontSize['toolbar按键前景sf符号大小'],
      // center: center['toolbar按键文字偏移'],
      fontWeight: 'medium',
    },
    toolbarButtonKeyboardSkinsStyle: {
      backgroundStyle: 'toolbarButtonBackgroundStyle',
      foregroundStyle: 'toolbarButtonKeyboardSkinsForegroundStyle',
    },
    toolbarButtonKeyboardSkinsForegroundStyle: {
      buttonStyleType: 'systemImage',
      systemImageName: 'paintpalette.fill',
      normalColor: color[theme]['toolbar按键颜色'],
      highlightColor: color[theme]['toolbar按键颜色'],
      fontSize: fontSize['toolbar按键前景sf符号大小'],
      // center: center['toolbar按键文字偏移'],
      fontWeight: 'medium',
    },
    toolbarButtonKeyboardPerfomanceStyle: {
      backgroundStyle: 'toolbarButtonBackgroundStyle',
      foregroundStyle: 'toolbarButtonKeyboardPerformanceForegroundStyle',
    },
    toolbarButtonKeyboardPerformanceForegroundStyle: {
      buttonStyleType: 'systemImage',
      systemImageName: 'gauge.with.dots.needle.bottom.50percent',
      normalColor: color[theme]['toolbar按键颜色'],
      highlightColor: color[theme]['toolbar按键颜色'],
      fontSize: fontSize['toolbar按键前景sf符号大小'],
      // center: center['toolbar按键文字偏移'],
      fontWeight: 'medium',
    },
    horizontalCandidateStyle: {
      insets: {
        top: 8,
        bottom: 3,
        left: 5,
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
    candidateStateButtonForegroundStyle: {
      buttonStyleType: 'systemImage',
      systemImageName: 'chevron.down',
      normalColor: color[theme]['toolbar按键颜色'],
      highlightColor: color[theme]['toolbar按键颜色'],
      fontSize: fontSize['toolbar按键前景sf符号大小'],
      // center: center['toolbar按键sf符号偏移'],
    },

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

    verticalCandidatePageUpButtonForegroundStyle: {
      buttonStyleType: 'systemImage',
      systemImageName: 'chevron.up',
      normalColor: color[theme]['按键前景颜色'],
      highlightColor: color[theme]['按键前景颜色'],
      fontSize: fontSize['数字键盘数字前景字体大小'] - 3,
      center: { y: 0.53 },
    },
    verticalCandidatePageDownButtonForegroundStyle: {
      buttonStyleType: 'systemImage',
      systemImageName: 'chevron.down',
      normalColor: color[theme]['按键前景颜色'],
      highlightColor: color[theme]['按键前景颜色'],
      fontSize: fontSize['数字键盘数字前景字体大小'] - 3,
      center: { y: 0.53 },
    },
    verticalCandidateReturnButtonStyle: {
      backgroundStyle: 'systemButtonBackgroundStyle',
      foregroundStyle: 'verticalCandidateReturnButtonForegroundStyle',
    },
    verticalCandidateReturnButtonForegroundStyle: {
      buttonStyleType: 'text',
      text: '返回',
      normalColor: color[theme]['按键前景颜色'],
      highlightColor: color[theme]['按键前景颜色'],
      fontSize: fontSize['按键前景文字大小'] - 3,
      // center: center['26键中文前景偏移'],
    },
    verticalCandidateBackspaceButtonStyle: {
      backgroundStyle: 'systemButtonBackgroundStyle',
      foregroundStyle: 'verticalCandidateBackspaceButtonForegroundStyle',
    },

    verticalCandidateBackspaceButtonForegroundStyle: {
      buttonStyleType: 'systemImage',
      systemImageName: 'delete.left',
      normalColor: color[theme]['按键前景颜色'],
      highlightColor: color[theme]['按键前景颜色'],
      fontSize: fontSize['数字键盘数字前景字体大小'] - 3,
      center: { y: 0.53 },
    },
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
    ],
  };

{
  getToolBar: getToolBar,
}
