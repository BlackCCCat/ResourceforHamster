// Resolve the effective keyboard layout set by combining the shared base layouts with optional function-row patches.
local keyboardLayoutBase = import 'keyboardLayoutBase.libsonnet';
local keyboardLayoutFuncRowPatch = import 'keyboardLayoutFuncRowPatch.libsonnet';

{
  getKeyboardLayout(theme, withFunctionsRow=false)::
    local baseLayout = keyboardLayoutBase.getKeyboardLayout(theme);
    if withFunctionsRow then
      baseLayout + keyboardLayoutFuncRowPatch.getPatch(theme, baseLayout)
    else
      baseLayout,
}
