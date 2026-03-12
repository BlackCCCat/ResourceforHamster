// 定义功能按键专用的前景样式映射，供 functionButtons 样式生成模块复用。
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
}
