// Build a shared render context so keyboard modules read theme, orientation, and settings consistently.
{
  new(Settings, theme, orientation, deviceType='iPhone'):: {
    Settings: Settings,
    theme: theme,
    orientation: orientation,
    deviceType: deviceType,
    isPortrait: orientation == 'portrait',
    withFunctionsRow: Settings.with_functions_row[deviceType],
  },
}
