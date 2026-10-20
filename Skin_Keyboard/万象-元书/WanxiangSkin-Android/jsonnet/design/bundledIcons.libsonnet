// 内置同名图标，避免 Android 使用另一套图形替代原项目图标。
// 字体仅占私用区，不替换普通汉字、字母、数字和标点。
local glyphs = import './bundledIconGlyphs.libsonnet';
local fallback = import './platformIcons.libsonnet';
local symbolName(value) =
  if std.type(value) == 'object' && std.objectHas(value, 'ios') then value.ios else value;
local hasGlyph(name) = std.type(name) == 'string' && std.objectHas(glyphs, name);
local glyph(name, weight='regular') =
  glyphs[name][if weight == 'medium' then 'medium' else 'regular'];
local without(object, keys) = {
  [key]: object[key]
  for key in std.objectFields(object)
  if !std.member(keys, key)
};
{
  fontFace: {
    url: 'WanxiangIcons.ttf',
    ranges: [{ location: 57344, length: 2 * std.length(std.objectFields(glyphs)) }],
  },

  adapt(value)::
    if std.type(value) == 'array' then [$.adapt(item) for item in value]
    else if std.type(value) != 'object' then value
    else
      local hasSymbol = std.objectHas(value, 'systemImageName');
      local name = if hasSymbol then symbolName(value.systemImageName) else null;
      local isStyle = std.objectHas(value, 'buttonStyleType');
      local isSystemStyle = isStyle && value.buttonStyleType == 'systemImage';
      local weight = if std.objectHas(value, 'fontWeight') then value.fontWeight else 'regular';
      local hasDifferentHighlight = std.objectHas(value, 'highlightSystemImageName')
        && symbolName(value.highlightSystemImageName) != name;
      if hasGlyph(name) && (!isStyle || isSystemStyle) && !hasDifferentHighlight then
        without(value, ['systemImageName', 'highlightSystemImageName', 'fontWeight']) + {
          text: glyph(name, weight),
          [if isSystemStyle then 'buttonStyleType']: 'text',
        }
      else if hasSymbol then fallback.adapt(value)
      else {
        [key]: $.adapt(value[key])
        for key in std.objectFields(value)
      },
}
