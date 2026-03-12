// Provide the shared no-function-row keyboard layout definitions as the base for later layout patches.
local keyboardLayoutBaseData = import 'keyboardLayoutBaseData.libsonnet';

{
  getKeyboardLayout(theme):: keyboardLayoutBaseData.getKeyboardLayout(theme),
}
