// 生成功能按键专用前景样式，并内聚功能按键自己的系统图标映射。
local Settings = import '../../Custom.libsonnet';
local styleFactories = import '../styles/styleFactories.libsonnet';

{
  funcKeyMap: {
    left: 'left',
    head: 'head',
    select: 'select',
    cut: 'cut',
    copy: 'copy',
    paste: 'paste',
    tail: 'tail',
    right: 'right',
  },

  funcKeySystemImageNameMap(Settings): {
    left: 'arrowshape.turn.up.left.fill',
    head: 'text.line.first.and.arrowtriangle.forward',
    select: 'selection.pin.in.out',
    cut: 'scissors',
    copy: 'arrow.up.doc.on.clipboard',
    paste: 'doc.on.clipboard.fill',
    tail: 'text.line.last.and.arrowtriangle.forward',
    right: 'arrowshape.turn.up.right.fill',
  },

  funcKeyPreeditSystemImageNameMap(Settings): {
    left: 'square.filled.and.line.vertical.and.square',
    head: if Settings.fix_sf_symbol then 'arrow.up.arrow.down' else 'chevron.compact.up.chevron.compact.down',
    select: '1.circle',
    cut: '2.circle',
    copy: '3.circle',
    paste: '4.circle',
    tail: if Settings.fix_sf_symbol then 'ellipsis.curlybraces' else 'ellipsis.viewfinder',
    right: 'square.and.line.vertical.and.square.filled',
  },

  genFuncKeyStyles(fontSize, color, theme, center)::
    local funcKeyMap = self.funcKeyMap;
    local funcKeySystemImageNameMap = self.funcKeySystemImageNameMap(Settings);
    local funcKeyPreeditSystemImageNameMap = self.funcKeyPreeditSystemImageNameMap(Settings);
    styleFactories.genSystemImageStates(
      funcKeyMap,
      funcKeySystemImageNameMap,
      'ButtonForegroundStyle',
      fontSize['功能按键sf符号大小'],
      color[theme]['按键前景颜色'],
      color[theme]['按键前景颜色'],
      center['功能键前景文字偏移']
    ) + styleFactories.genSystemImageStates(
      funcKeyMap,
      funcKeyPreeditSystemImageNameMap,
      'ButtonPreeditForegroundStyle',
      fontSize['功能按键sf符号大小'],
      color[theme]['按键前景颜色'],
      color[theme]['按键前景颜色'],
      center['功能键前景文字偏移']
    ) + styleFactories.genSystemImageStates(
      funcKeyMap,
      funcKeySystemImageNameMap,
      'ButtonUppercasedStateForegroundStyle',
      fontSize['功能按键sf符号大小'],
      color[theme]['按键前景颜色'],
      color[theme]['按键前景颜色'],
      center['功能键前景文字偏移']
    ),
}
