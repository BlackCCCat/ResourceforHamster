// 暴露数字 9 键入口，衔接共享上下文与构建逻辑。
local Settings = import '../../Custom.libsonnet';
local keyboardRuntime = import '../../keyboards/common/layoutAssembly/keyboardLayoutAssembly.libsonnet';
local numeric9Builder = import 'builder.libsonnet';
local numeric9Layout = import 'layout.libsonnet';

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
