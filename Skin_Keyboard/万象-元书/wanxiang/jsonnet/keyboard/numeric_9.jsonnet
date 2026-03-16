// Expose the numeric 9-key keyboard through a thin entry module backed by shared context and builder logic.
local Settings = import '../Custom.libsonnet';
local keyboardRuntime = import '../lib/core/keyboardRuntime.libsonnet';
local numeric9Builder = import '../lib/builders/numeric9Builder.libsonnet';
local numeric9Layout = import '../lib/layout/numeric9Layout.libsonnet';

local chooseLayout(selector) =
  if selector then numeric9Layout.LayoutWithFunc else numeric9Layout.LayoutWithoutFunc;

local chooseLandscapeLayout() =
  numeric9Layout.LandscapeLayout;

local moduleForDevice(deviceType) = {
  keyboard(theme, orientation):
    local context = keyboardRuntime.new(Settings, theme, orientation, deviceType);
    numeric9Builder.build(
      context,
      if orientation == 'portrait' then
        chooseLayout(Settings.function_button_config.with_functions_row[deviceType])
      else
        chooseLandscapeLayout()
    ),
  new(theme, orientation):
    self.keyboard(theme, orientation),
};

moduleForDevice('iPhone') + {
  layout(deviceType): moduleForDevice(deviceType),
}
