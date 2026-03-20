// Build keyboard runtime context and resolve the effective layout set from one entry point.
local keyboardLayoutProvider = import '../layout/keyboardLayoutProvider.libsonnet';

{
  new(Settings, theme, orientation, deviceType='iPhone'):: {
    Settings: Settings,
    theme: theme,
    orientation: orientation,
    deviceType: deviceType,
    isPortrait: orientation == 'portrait',
    withFunctionsRow: Settings.function_button_config.with_functions_row[deviceType],
  },

  getKeyboardLayout(context)::
    keyboardLayoutProvider.getKeyboardLayout(context.theme, context.withFunctionsRow),
}
