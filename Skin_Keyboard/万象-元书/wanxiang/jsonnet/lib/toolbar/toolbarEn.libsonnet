// 英文工具栏入口：在共用 toolbar 基础上只覆盖中英切换按钮的动作和图标。
// local center = import '../shared/center.libsonnet';
local toolbar = import 'index.libsonnet';

local custom(theme) = {  // 中英键盘有不同，在这里加上，会覆盖掉toolbar.libsonnet中对应的按键设置以供英文键盘使用。
  toolbarButtonswitchKeyboardStyle: toolbar.getToolBar(theme).toolbarButtonswitchKeyboardStyle
                                    { action: {
    keyboardType: 'pinyin',
  } },
  toolbarButtonswitchKeyboardForegroundStyle: toolbar.getToolBar(theme).toolbarButtonswitchKeyboardForegroundStyle
                                              { assetImageName: 'englishState' },
};

// 下面不要动
{
  getToolBar(theme): toolbar.getToolBar(theme) + custom(theme),
}
