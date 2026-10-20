// 在拼音主键盘产物上仅修改“中→英”按键目标，避免改写共享系统键或 iPad 入口。
// 英文使用按来源布局区分的 alphabetic9/14/17/18/26/27 槽位，能原路返回。
local module9 = import '../pinyin9/keyboard.libsonnet';
local module14 = import '../pinyinGrouped/pinyin14/keyboard.libsonnet';
local module17 = import '../pinyinGrouped/pinyin17/keyboard.libsonnet';
local module18 = import '../pinyinGrouped/pinyin18/keyboard.libsonnet';
local module26 = import '../keyboard26/pinyin/keyboard.libsonnet';
local moduleFor(layout) =
  if layout == 9 then module9
  else if layout == 14 then module14
  else if layout == 17 then module17
  else if layout == 18 then module18
  else module26;
{
  new(theme, orientation, layout):
    assert std.member([9, 14, 17, 18, 26, 27], layout) : '不支持的拼音布局';
    local keyboard = moduleFor(layout).new(theme, orientation, layout);
    local english = 'alphabetic' + std.toString(layout);
    keyboard {
      cn2enButton: keyboard.cn2enButton {
        action: { keyboardType: english },
      },
    },
}
