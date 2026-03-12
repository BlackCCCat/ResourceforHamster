// Resolve the active keyboard layout provider so callers do not duplicate with-functions-row branching.
local keyboardLayouts = import '../layout/keyboardLayouts.libsonnet';

{
  getKeyboardLayout(context)::
    keyboardLayouts.getKeyboardLayout(context.theme, context.withFunctionsRow),
}
