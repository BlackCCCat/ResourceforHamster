// local center = import 'center.libsonnet';
local toolbar = import 'toolbar.libsonnet';

local custom(theme) = {  // 中英键盘有不同，在这里加上，会覆盖掉toolbar.libsonnet中对应的按键设置以供英文键盘使用。
  toolbarButtonEmojiStyle: toolbar.getToolBar(theme).toolbarButtonEmojiStyle
                           {
    action: 'returnPrimaryKeyboard',
  },
  toolbarButtonswitchKeyboardStyle: toolbar.getToolBar(theme).toolbarButtonswitchKeyboardStyle
                                    {
    action: 'returnPrimaryKeyboard',
  },
  toolbarButtonswitchKeyboardForegroundStyle: toolbar.getToolBar(theme).toolbarButtonswitchKeyboardForegroundStyle {
    buttonStyleType: 'systemImage',
    systemImageName: 'numbers.rectangle.fill',
  },
};

// 下面不要动
{
  getToolBar(theme): toolbar.getToolBar(theme) + custom(theme),
}
