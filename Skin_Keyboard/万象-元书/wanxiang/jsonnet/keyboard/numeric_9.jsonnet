// Expose the numeric 9-key keyboard through a thin entry module backed by shared context and builder logic.
local Settings = import '../Custom.libsonnet';
local contextLib = import '../lib/core/context.libsonnet';
local numeric9Builder = import '../lib/builders/numeric9Builder.libsonnet';
local numericLayout = import '../lib/layout/numericLayout.libsonnet';

local chooseLayout(selector) =
  if selector then numericLayout.LayoutWithFunc else numericLayout.LayoutWithoutFunc;

local moduleForDevice(deviceType) = {
  keyboard(theme, orientation):
    local context = contextLib.new(Settings, theme, orientation, deviceType);
    numeric9Builder.build(context, chooseLayout(Settings.function_button_config.with_functions_row[deviceType])),
  new(theme, orientation):
    self.keyboard(theme, orientation),
};

moduleForDevice('iPhone') + {
  layout(deviceType): moduleForDevice(deviceType),
}
