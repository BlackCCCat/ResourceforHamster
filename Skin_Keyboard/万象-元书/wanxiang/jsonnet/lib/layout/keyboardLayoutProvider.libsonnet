// Provide the effective keyboard layout set by combining the shared base layouts with optional function-row patches.
local keyboardLayoutBaseData = import 'keyboardLayoutBaseData.libsonnet';
local keyboardLayoutFuncRowPatch = import 'keyboardLayoutFuncRowPatch.libsonnet';

{
  getKeyboardLayout(theme, withFunctionsRow=false)::
    local baseLayout = keyboardLayoutBaseData.getKeyboardLayout(theme);
    if withFunctionsRow then
      baseLayout + keyboardLayoutFuncRowPatch.getPatch(theme, baseLayout)
    else
      baseLayout,
}
