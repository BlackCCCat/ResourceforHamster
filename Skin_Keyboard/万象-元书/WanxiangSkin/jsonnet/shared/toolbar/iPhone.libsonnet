// 手机工具栏总入口，负责读取配置、解析按钮布局，并定义固定按钮与样式对象。
local Settings = import '../../Custom.libsonnet';
local center = import '../styles/center.libsonnet';
local color = import '../styles/color.libsonnet';
local fontSize = import '../styles/fontSize.libsonnet';
local styleFactories = import '../styles/styleFactories.libsonnet';
local toolbarShared = import 'config.libsonnet';
local iPhoneRenderer = import 'iPhoneRenderer.libsonnet';
local toolbarRegistryLib = import 'registry.libsonnet';

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

local getToolBar(theme, overrides={}) =
  local switchKeyboardType = toolbarShared.getSwitchKeyboardType(overrides);
  local switchKeyboardAsset = toolbarShared.getSwitchKeyboardAsset(overrides);
  local toolbarButtonRegistry = toolbarRegistryLib.getPhoneRegistry(toolbarMenu, switchKeyboardType);
  // 将 Custom 中的分段式布局解析为最终可用的按钮 ID。
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
  // 将 Custom 中的整体滑动布局解析为最终可用的按钮 ID。
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
  // 渲染器只生成布局和滑动数据源，固定按钮样式与 action 在此补齐。
  local iPhoneRendererConfig = iPhoneRenderer.build(toolbarMode, segmentedResolved, carouselResolved, toolbarButtonRegistry);
  local makeToolbarSystemImageForegroundStyle(systemImageName, extra={}) = {
    buttonStyleType: 'systemImage',
    systemImageName: systemImageName,
    normalColor: color[theme]['toolbar按键颜色'],
    highlightColor: color[theme]['toolbar按键颜色'],
    fontSize: fontSize['toolbar按键前景sf符号大小'],
    fontWeight: 'medium',
  } + extra;
  local makeToolbarAssetImageForegroundStyle(assetImageName, extra={}) = {
    buttonStyleType: 'assetImage',
    assetImageName: assetImageName,
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


    toolbarSlideButtonsLeft: iPhoneRendererConfig.toolbarSlideButtonsLeft,
    toolbarSlideButtonsRight: iPhoneRendererConfig.toolbarSlideButtonsRight,
    toolbarSlideButtonsCenter: iPhoneRendererConfig.toolbarSlideButtonsCenter,
    toolbarcollectionCellStyle: {
      backgroundStyle: 'toolbarcollectionCellBackgroundStyle',
      foregroundStyle: 'toolbarcollectionCellForegroundStyle',
    },
    toolbarcollectionCellBackgroundStyle: styleFactories.makeGeometryStyle(color[theme]['键盘背景颜色']),
    toolbarcollectionCellForegroundStyle: styleFactories.makeGeometryStyle(color[theme]['按键前景颜色']),
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
            if Settings.horizon_candidate_button == 1 then { Cell: 'expandButton' } else if Settings.horizon_candidate_button == 2 then { Cell: 'toolbarButtonHideStyle'} else {},
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
    expandButton: makeToolbarButtonStyle('expandButtonForegroundStyle', { shortcut: '#candidatesBarStateToggle' }),
    expandButtonForegroundStyle:
      // 生成横向候选展开按钮前景。
      makeToolbarSystemImageForegroundStyle('chevron.down', { normalColor: color[theme]['按键前景颜色'], highlightColor: color[theme]['按键前景颜色'] }),

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
    // 纵向候选控制按钮
    verticalCandidatePageUpButton: makeSystemButtonStyle('verticalCandidatePageUpButtonForegroundStyle', { shortcut: '#verticalCandidatesPageUp' }),
    verticalCandidatePageDownButton: makeSystemButtonStyle('verticalCandidatePageDownButtonForegroundStyle', { shortcut: '#verticalCandidatesPageDown' }),
    verticalCandidateReturnButton: makeSystemButtonStyle('verticalCandidateReturnButtonForegroundStyle', { shortcut: '#candidatesBarStateToggle' }),
    verticalCandidateBackspaceButton: makeSystemButtonStyle('backspaceButtonForegroundStyle', 'backspace'),

    toolbarBackgroundStyle: styleFactories.makeGeometryStyle(color[theme]['键盘背景颜色']),
    toolbarButtonBackgroundStyle: {
      // "type": "original",
      // "normalBorderColor": "000000",
      // "borderSize": 1,
      normalColor: 0,
      highlightColor: 0,
    },
    // 切换键盘
    toolbarButtonswitchKeyboardStyle: makeToolbarButtonStyle('toolbarButtonswitchKeyboardForegroundStyle', {
      keyboardType: switchKeyboardType,
    }),

    toolbarButtonswitchKeyboardForegroundStyle: makeToolbarAssetImageForegroundStyle(switchKeyboardAsset),
    // 简繁切换与收起键盘
    toolbarButtonchangeSimplifiedandTraditionalStyle: makeToolbarButtonStyle('toolbarButtonchangeSimplifiedandTraditionalForegroundStyle', { shortcut: '#简繁切换' }),
    toolbarButtonchangeSimplifiedandTraditionalForegroundStyle: makeToolbarSystemImageForegroundStyle('character.textbox.zh'),
    toolbarButtonHideStyle: makeToolbarButtonStyle('toolbarButton1ForegroundStyle', 'dismissKeyboard'),
    toolbarButton1ForegroundStyle: makeToolbarSystemImageForegroundStyle('keyboard.chevron.compact.down.fill'),
    // 单手模式
    toolbarButtonRighthandKeyboardStyle: makeToolbarButtonStyle('toolbarButtonRighthandForegroundStyle', { shortcut: '#右手模式' }),
    toolbarButtonRighthandForegroundStyle: makeToolbarSystemImageForegroundStyle('keyboard.onehanded.right.fill'),
    toolbarButtonLefthandKeyboardStyle: makeToolbarButtonStyle('toolbarButtonLefthandForegroundStyle', { shortcut: '#左手模式' }),
    toolbarButtonLefthandForegroundStyle: makeToolbarSystemImageForegroundStyle('keyboard.onehanded.left.fill'),
    // 菜单与面板
    // 固定按钮走 Cell 渲染路径，因此 action 要定义在样式对象上。
    toolbarButtonOpenAppMenuStyle: makeToolbarButtonStyle('toolbarButtonOpenAppMenuForegroundStyle', {
      shortcut: '#keyboardMenu',
    }),

    toolbarButtonOpenAppMenuForegroundStyle: makeToolbarSystemImageForegroundStyle('hexagon.righthalf.filled'),
    // menu_or_panel 在固定按钮场景下会直接引用这个样式对象。
    toolbarButtonPanelStyle: makeToolbarButtonStyle('toolbarButtonPanelForegroundStyle', {
      floatKeyboardType: 'panel',
    }),
    toolbarButtonPanelForegroundStyle: makeToolbarSystemImageForegroundStyle('hexagon.righthalf.filled'),
    // iPad 首位固定按钮在 toolbar_menu=false 时使用这个样式，动作是直接打开 App。
    toolbarButtonOpenAppStyle: makeToolbarButtonStyle('toolbarButtonOpenAppForegroundStyle', {
      openURL: 'hamster3://',
    }),
    toolbarButtonOpenAppForegroundStyle: makeToolbarSystemImageForegroundStyle('hexagon.righthalf.filled'),

    // 常用动作与键盘切换
    toolbarButtonNoteStyle: makeToolbarButtonStyle('toolbarButton3ForegroundStyle', {
      shortcutCommand: '#showPhraseView',
    }),
    toolbarButton3ForegroundStyle: makeToolbarSystemImageForegroundStyle('bookmark.square.fill'),
    toolbarButtonScriptStyle: makeToolbarButtonStyle('toolbarButtonScriptForegroundStyle', {
      shortcutCommand: '#toggleScriptView',
    }),
    toolbarButtonScriptForegroundStyle: makeToolbarSystemImageForegroundStyle(if Settings.fix_sf_symbol then 's.circle.fill' else 'peruviansolessign.circle.fill'),
    toolbarButtonEmojiStyle: makeToolbarButtonStyle('toolbarButtonEmojiForegroundStyle', { keyboardType: 'emojis' }),
    toolbarButtonEmojiForegroundStyle: makeToolbarSystemImageForegroundStyle('face.dashed.fill'),
    toolbarButtonSymbolStyle: makeToolbarButtonStyle('toolbarButtonSymbolForegroundStyle', { keyboardType: 'symbolic' }),
    toolbarButtonSymbolForegroundStyle: makeToolbarSystemImageForegroundStyle('command.circle.fill'),
    toolbarButtonClipboardStyle: makeToolbarButtonStyle('toolbarButton4ForegroundStyle', {
      shortcutCommand: '#showPasteboardView',
    }),
    toolbarButton4ForegroundStyle: makeToolbarSystemImageForegroundStyle('list.bullet.clipboard.fill'),

    // 搜索与外部打开
    toolbarButtonSafariStyle: makeToolbarButtonStyle('toolbarButton5ForegroundStyle', { openURL: '#pasteboardContent' }),
    toolbarButton5ForegroundStyle: makeToolbarSystemImageForegroundStyle('safari.fill'),

    toolbarButtonAppleStyle: makeToolbarButtonStyle('toolbarButton6ForegroundStyle', { openURL: 'itms-apps://search.itunes.apple.com/WebObjects/MZSearch.woa/wa/search?media=software&term=#pasteboardContent' }),
    toolbarButton6ForegroundStyle: makeToolbarSystemImageForegroundStyle('apple.logo'),
    toolbarButtonGoogleStyle: makeToolbarButtonStyle('toolbarButton7ForegroundStyle', { openURL: 'https://www.google.com/search?q=#pasteboardContent' }),
    toolbarButtonBaiduStyle: makeToolbarButtonStyle('toolbarButtonBaiduForegroundStyle', { openURL: 'https://www.baidu.com/s?wd=#pasteboardContent' }),
    toolbarButtonBingStyle: makeToolbarButtonStyle('toolbarButtonBingForegroundStyle', { openURL: 'https://www.bing.com/search?q=#pasteboardContent' }),
    toolbarButton7ForegroundStyle: makeToolbarSystemImageForegroundStyle('g.circle.fill'),
    toolbarButtonBaiduForegroundStyle: makeToolbarSystemImageForegroundStyle('pawprint.fill'),
    toolbarButtonBingForegroundStyle: makeToolbarSystemImageForegroundStyle('b.circle.fill'),
    // 编辑控制
    toolbarButtonUndoStyle: makeToolbarButtonStyle('toolbarButtonUndoForegroundStyle', { shortcut: '#undo' }),
    toolbarButtonUndoForegroundStyle: makeToolbarSystemImageForegroundStyle('arrow.uturn.left.circle.fill'),
    toolbarButtonRedoStyle: makeToolbarButtonStyle('toolbarButtonRedoForegroundStyle', { shortcut: '#redo' }),
    toolbarButtonRedoForegroundStyle: makeToolbarSystemImageForegroundStyle('arrow.uturn.right.circle.fill'),
    // 输入法与皮肤工具
    toolbarButtonRimeSwitcherStyle: makeToolbarButtonStyle('toolbarButtonRimeSwitcherForegroundStyle', { shortcut: '#RimeSwitcher' }),
    toolbarButtonRimeSwitcherForegroundStyle: makeToolbarSystemImageForegroundStyle('filemenu.and.selection'),
    toolbarButtonEmbeddingToggleStyle: makeToolbarButtonStyle('toolbarButtonEmbeddingToggleForegroundStyle', { shortcut: '#toggleEmbeddedInputMode' }),
    toolbarButtonEmbeddingToggleForegroundStyle: makeToolbarSystemImageForegroundStyle('dots.and.line.vertical.and.cursorarrow.rectangle'),
    toolbarButtonKeyboardSettingsStyle: makeToolbarButtonStyle('toolbarButtonKeyboardSettingsForegroundStyle', { openURL: 'hamster3://com.ihsiao.apps.hamster3/keyboardSettings' }),
    toolbarButtonKeyboardSettingsForegroundStyle: makeToolbarSystemImageForegroundStyle('gearshape.fill'),
    toolbarButtonKeyboardSkinsStyle: makeToolbarButtonStyle('toolbarButtonKeyboardSkinsForegroundStyle', { openURL: 'hamster3://com.ihsiao.apps.hamster3/keyboardSkins' }),
    toolbarButtonKeyboardSkinsForegroundStyle: makeToolbarSystemImageForegroundStyle('tshirt.fill'),
    toolbarButtonSkinAdjustStyle: makeToolbarButtonStyle('toolbarButtonSkinAdjustForegroundStyle', { openURL: 'hamster3://com.ihsiao.apps.hamster3/finder?action=openSkinsFile&fileURL=jsonnet/Custom.libsonnet' }),
    toolbarButtonSkinAdjustForegroundStyle: makeToolbarSystemImageForegroundStyle('paintpalette.fill'),
    toolbarButtonKeyboardPerformanceStyle: makeToolbarButtonStyle('toolbarButtonKeyboardPerformanceForegroundStyle', { shortcut: '#keyboardPerformance' }),
    toolbarButtonKeyboardPerformanceForegroundStyle: makeToolbarSystemImageForegroundStyle(if Settings.fix_sf_symbol then 'gauge.medium' else 'gauge.with.dots.needle.bottom.50percent'),
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
    candidateStateButtonStyle: { backgroundStyle: 'toolbarButtonBackgroundStyle', foregroundStyle: 'candidateStateButtonForegroundStyle' },
    candidateStateButtonForegroundStyle:
      // 生成横向候选状态按钮前景。
      makeToolbarSystemImageForegroundStyle('chevron.down'),

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

    verticalCandidatePageUpButtonForegroundStyle: makeVerticalCandidateSystemImageForegroundStyle('chevron.up'),
    verticalCandidatePageDownButtonForegroundStyle: makeVerticalCandidateSystemImageForegroundStyle('chevron.down'),
    verticalCandidateReturnButtonStyle: { backgroundStyle: 'systemButtonBackgroundStyle', foregroundStyle: 'verticalCandidateReturnButtonForegroundStyle' },
    verticalCandidateReturnButtonForegroundStyle:
      // 生成纵向候选返回按钮前景。
      makeToolbarTextForegroundStyle('返回', fontSize['按键前景文字大小'] - 3),
    verticalCandidateBackspaceButtonStyle: { backgroundStyle: 'systemButtonBackgroundStyle', foregroundStyle: 'verticalCandidateBackspaceButtonForegroundStyle' },

    verticalCandidateBackspaceButtonForegroundStyle: makeVerticalCandidateSystemImageForegroundStyle('delete.left'),
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
