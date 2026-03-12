// 生成功能按键专用前景样式，避免 functionButtons 相关逻辑散落在 utils 目录中。
local Settings = import '../../Custom.libsonnet';
local styleShared = import '../utils/shared.libsonnet';
local styleSpecs = import 'styleSpecs.libsonnet';

{
  genFuncKeyStyles(fontSize, color, theme, center)::
    local funcKeyMap = styleSpecs.funcKeyMap;
    local funcKeySystemImageNameMap = styleSpecs.funcKeySystemImageNameMap(Settings);
    local funcKeyPreeditSystemImageNameMap = styleSpecs.funcKeyPreeditSystemImageNameMap(Settings);
    styleShared.genSystemImageStates(
      funcKeyMap,
      funcKeySystemImageNameMap,
      'ButtonForegroundStyle',
      fontSize['功能按键sf符号大小'],
      color[theme]['按键前景颜色'],
      color[theme]['按键前景颜色'],
      center['功能键前景文字偏移']
    ) + styleShared.genSystemImageStates(
      funcKeyMap,
      funcKeyPreeditSystemImageNameMap,
      'ButtonPreeditForegroundStyle',
      fontSize['功能按键sf符号大小'],
      color[theme]['按键前景颜色'],
      color[theme]['按键前景颜色'],
      center['功能键前景文字偏移']
    ) + styleShared.genSystemImageStates(
      funcKeyMap,
      funcKeySystemImageNameMap,
      'ButtonUppercasedStateForegroundStyle',
      fontSize['功能按键sf符号大小'],
      color[theme]['按键前景颜色'],
      color[theme]['按键前景颜色'],
      center['功能键前景文字偏移']
    ),
}
