// 手机工具栏总入口：负责读取 Custom 配置、解析按钮布局，并定义固定按钮与样式对象。
local Settings = import '../../Custom.libsonnet';
local center = import '../shared/center.libsonnet';
local color = import '../shared/color.libsonnet';
local fontSize = import '../shared/fontSize.libsonnet';
local iPhoneRenderer = import 'iPhoneRenderer.libsonnet';
local toolbarRegistryLib = import 'registry.libsonnet';
local toolbarShared = import 'shared.libsonnet';

local toolbarConfig = toolbarShared.getToolbarConfig(Settings);
local toolbarMenu = toolbarShared.getToolbarMenu(toolbarConfig);
local toolbarMode =
  if std.objectHas(toolbarConfig, 'mode') && std.member(['segmented', 'carousel'], toolbarConfig.mode) then
    toolbarConfig.mode
  else
    'segmented';

local segmentedConfig =
  if std.objectHas(toolbarConfig, 'segmented') then toolbarConfig.segmented else {};
local carouselConfig =
  if std.objectHas(toolbarConfig, 'carousel') then toolbarConfig.carousel else {};

local toolbarButtonRegistry = toolbarRegistryLib.getPhoneRegistry(toolbarMenu);

// 这里把用户在 Custom 中配置的分段式布局解析为最终可用的按钮 ID。
local segmentedResolved = {
  left_fixed: toolbarShared.getToolbarId(
    toolbarButtonRegistry,
    if std.objectHas(segmentedConfig, 'left_fixed') then segmentedConfig.left_fixed else null,
    'script'
  ),
  left_slide: toolbarShared.getToolbarIds(
    toolbarButtonRegistry,
    if std.objectHas(segmentedConfig, 'left_slide') then segmentedConfig.left_slide else [],
    ['google', 'safari', 'apple']
  ),
  center_fixed: toolbarShared.getToolbarId(
    toolbarButtonRegistry,
    if std.objectHas(segmentedConfig, 'center_fixed') then segmentedConfig.center_fixed else null,
    'menu_or_panel'
  ),
  right_slide: toolbarShared.getToolbarIds(
    toolbarButtonRegistry,
    if std.objectHas(segmentedConfig, 'right_slide') then segmentedConfig.right_slide else [],
    ['note', 'clipboard']
  ),
  right_fixed: toolbarShared.getToolbarId(
    toolbarButtonRegistry,
    if std.objectHas(segmentedConfig, 'right_fixed') then segmentedConfig.right_fixed else null,
    'hide'
  ),
};

// 这里把用户在 Custom 中配置的整体滑动布局解析为最终可用的按钮 ID。
local carouselResolved = {
  left_fixed: toolbarShared.getToolbarId(
    toolbarButtonRegistry,
    if std.objectHas(carouselConfig, 'left_fixed') then carouselConfig.left_fixed else null,
    'menu_or_panel'
  ),
  center_slide: toolbarShared.getToolbarIds(
    toolbarButtonRegistry,
    if std.objectHas(carouselConfig, 'center_slide') then carouselConfig.center_slide else [],
    ['script', 'google', 'note', 'clipboard', 'keyboard_settings']
  ),
  right_fixed: toolbarShared.getToolbarId(
    toolbarButtonRegistry,
    if std.objectHas(carouselConfig, 'right_fixed') then carouselConfig.right_fixed else null,
    'hide'
  ),
};

local getToolBar(theme) =
  // 渲染器只负责生成布局和滑动数据源，这里继续补齐固定按钮样式与 action。
  local iPhoneRendererConfig = iPhoneRenderer.build(toolbarMode, segmentedResolved, carouselResolved, toolbarButtonRegistry);

  {
    preeditStyle: {
      insets: { left: 15, top: 2 },
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
    toolbarLayout: iPhoneRendererConfig.toolbarLayout,

    toolbarButtonKeyboardSelectionStyle: iPhoneRendererConfig.toolbarButtonKeyboardSelectionStyle,
    horizontalSymbolsDataSource3: iPhoneRendererConfig.horizontalSymbolsDataSource3,

    toolbarSlideButtonsLeft: iPhoneRendererConfig.toolbarSlideButtonsLeft,
    toolbarSlideButtonsRight: iPhoneRendererConfig.toolbarSlideButtonsRight,
    toolbarSlideButtonsCenter: iPhoneRendererConfig.toolbarSlideButtonsCenter,
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
      normalColor: color[theme]['按键前景颜色'],
    },
    horizontalSymbolsDataSourceLeft: iPhoneRendererConfig.horizontalSymbolsDataSourceLeft,
    horizontalSymbolsDataSourceRight: iPhoneRendererConfig.horizontalSymbolsDataSourceRight,
    horizontalSymbolsDataSourceCenter: iPhoneRendererConfig.horizontalSymbolsDataSourceCenter,


    // 横向候选文字栏调式
    horizontalCandidatesStyle: {
      insets: { left: 5, top: 3 },
      backgroundStyle: 'toolbarBackgroundStyle',
    },
    horizontalCandidatesLayout: [
      {
        HStack: {
          subviews: [
            { Cell: 'horizontalCandidates' },
            // { Cell: 'clearPreeditButton' },
            if Settings.showExpandButton then { Cell: 'expandButton' } else {},
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
        height: '1/6',
      },
    },
    verticalCandidates: {
      // 定义一个纵向候选文字显示区域
      type: 'verticalCandidates',
      insets: { top: 3, left: 3, right: 3, bottom: 3 },
      // （非必须，默认值为 4）显示区域内候选文字最大行数
      maxRows: 5,
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
      action: { shortcut: '#右手模式' },
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
      action: { shortcut: '#左手模式' },
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
    // 固定按钮走 Cell 渲染路径，因此 action 要定义在样式对象上。
    toolbarButtonOpenAppMenuStyle: {
      backgroundStyle: 'toolbarButtonBackgroundStyle',
      foregroundStyle: 'toolbarButtonOpenAppMenuForegroundStyle',
      action: {
        shortcut: '#keyboardMenu',
      },
    },

    toolbarButtonOpenAppMenuForegroundStyle: {
      buttonStyleType: 'systemImage',
      systemImageName: 'hexagon.righthalf.filled',
      normalColor: color[theme]['toolbar按键颜色'],
      highlightColor: color[theme]['toolbar按键颜色'],
      fontSize: fontSize['toolbar按键前景sf符号大小'],
      // center: center['toolbar按键文字偏移'],
      fontWeight: 'medium',
    },
    // menu_or_panel 在固定按钮场景下会直接引用这个样式对象。
    toolbarButtonPanelStyle: {
      backgroundStyle: 'toolbarButtonBackgroundStyle',
      foregroundStyle: 'toolbarButtonPanelForegroundStyle',
      action: {
        floatKeyboardType: 'panel',
      },
    },
    toolbarButtonPanelForegroundStyle: {
      buttonStyleType: 'systemImage',
      systemImageName: 'hexagon.righthalf.filled',
      normalColor: color[theme]['toolbar按键颜色'],
      highlightColor: color[theme]['toolbar按键颜色'],
      fontSize: fontSize['toolbar按键前景sf符号大小'],
      // center: center['toolbar按键文字偏移'],
      fontWeight: 'medium',
    },
    // iPad 首位固定按钮在 toolbar_menu=false 时使用这个样式，动作是直接打开 App。
    toolbarButtonOpenAppStyle: {
      backgroundStyle: 'toolbarButtonBackgroundStyle',
      foregroundStyle: 'toolbarButtonOpenAppForegroundStyle',
      action: {
        openURL: 'hamster3://',
      },
    },
    toolbarButtonOpenAppForegroundStyle: {
      buttonStyleType: 'systemImage',
      systemImageName: 'hexagon.righthalf.filled',
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
      systemImageName: 'bookmark.square.fill',
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
      systemImageName: if Settings.fix_sf_symbol then 's.circle.fill' else 'peruviansolessign.circle.fill',
      normalColor: color[theme]['toolbar按键颜色'],
      highlightColor: color[theme]['toolbar按键颜色'],
      fontSize: fontSize['toolbar按键前景sf符号大小'],
      // center: center['toolbar按键文字偏移'],
      fontWeight: 'medium',
    },
    toolbarButtonEmojiStyle: {
      backgroundStyle: 'toolbarButtonBackgroundStyle',
      foregroundStyle: 'toolbarButtonEmojiForegroundStyle',
      action: { keyboardType: 'emojis' },
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
      systemImageName: 'list.bullet.clipboard.fill',
      normalColor: color[theme]['toolbar按键颜色'],
      highlightColor: color[theme]['toolbar按键颜色'],
      fontSize: fontSize['toolbar按键前景sf符号大小'],
      // center: center['toolbar按键文字偏移'],
      fontWeight: 'medium',
    },

    toolbarButtonSafariStyle: {
      backgroundStyle: 'toolbarButtonBackgroundStyle',
      foregroundStyle: 'toolbarButton5ForegroundStyle',
      action: { openURL: '#pasteboardContent' },
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
      action: { openURL: 'itms-apps://search.itunes.apple.com/WebObjects/MZSearch.woa/wa/search?media=software&term=#pasteboardContent' },
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
      action: { openURL: 'https://www.google.com/search?q=#pasteboardContent' },
    },
    toolbarButtonBaiduStyle: {
      backgroundStyle: 'toolbarButtonBackgroundStyle',
      foregroundStyle: 'toolbarButtonBaiduForegroundStyle',
      action: { openURL: 'https://www.baidu.com/s?wd=#pasteboardContent' },
    },
    toolbarButtonBingStyle: {
      backgroundStyle: 'toolbarButtonBackgroundStyle',
      foregroundStyle: 'toolbarButtonBingForegroundStyle',
      action: { openURL: 'https://www.bing.com/search?q=#pasteboardContent' },
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
    toolbarButtonBaiduForegroundStyle: {
      buttonStyleType: 'systemImage',
      systemImageName: 'pawprint.fill',
      normalColor: color[theme]['toolbar按键颜色'],
      highlightColor: color[theme]['toolbar按键颜色'],
      fontSize: fontSize['toolbar按键前景sf符号大小'],
      fontWeight: 'medium',
    },
    toolbarButtonBingForegroundStyle: {
      buttonStyleType: 'systemImage',
      systemImageName: 'b.circle.fill',
      normalColor: color[theme]['toolbar按键颜色'],
      highlightColor: color[theme]['toolbar按键颜色'],
      fontSize: fontSize['toolbar按键前景sf符号大小'],
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
      action: { shortcut: '#RimeSwitcher' },
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
      action: { shortcut: '#toggleEmbeddedInputMode' },
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
      action: { openURL: 'hamster3://com.ihsiao.apps.hamster3/keyboardSettings' },
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
      action: { openURL: 'hamster3://com.ihsiao.apps.hamster3/keyboardSkins' },
    },
    toolbarButtonKeyboardSkinsForegroundStyle: {
      buttonStyleType: 'systemImage',
      systemImageName: 'tshirt.fill',
      normalColor: color[theme]['toolbar按键颜色'],
      highlightColor: color[theme]['toolbar按键颜色'],
      fontSize: fontSize['toolbar按键前景sf符号大小'],
      // center: center['toolbar按键文字偏移'],
      fontWeight: 'medium',
    },
    toolbarButtonSkinAdjustStyle: {
      backgroundStyle: 'toolbarButtonBackgroundStyle',
      foregroundStyle: 'toolbarButtonSkinAdjustForegroundStyle',
      action: { openURL: 'hamster3://com.ihsiao.apps.hamster3/finder?action=openSkinsFile&fileURL=jsonnet/Custom.libsonnet' },
    },
    toolbarButtonSkinAdjustForegroundStyle: {
      buttonStyleType: 'systemImage',
      systemImageName: 'paintpalette.fill',
      normalColor: color[theme]['toolbar按键颜色'],
      highlightColor: color[theme]['toolbar按键颜色'],
      fontSize: fontSize['toolbar按键前景sf符号大小'],
      // center: center['toolbar按键文字偏移'],
      fontWeight: 'medium',
    },
    toolbarButtonKeyboardPerformanceStyle: {
      backgroundStyle: 'toolbarButtonBackgroundStyle',
      foregroundStyle: 'toolbarButtonKeyboardPerformanceForegroundStyle',
      action: { shortcut: '#keyboardPerformance' },
    },
    toolbarButtonKeyboardPerformanceForegroundStyle: {
      buttonStyleType: 'systemImage',
      systemImageName: if Settings.fix_sf_symbol then 'gauge.medium' else 'gauge.with.dots.needle.bottom.50percent',
      normalColor: color[theme]['toolbar按键颜色'],
      highlightColor: color[theme]['toolbar按键颜色'],
      fontSize: fontSize['toolbar按键前景sf符号大小'],
      // center: center['toolbar按键文字偏移'],
      fontWeight: 'medium',
    },
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
