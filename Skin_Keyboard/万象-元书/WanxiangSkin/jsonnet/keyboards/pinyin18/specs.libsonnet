// 用数据描述 18 键拼音布局规格，供入口选择与构建。
local compactShared = import '../common/pinyin14_18/compactSpecFactory.libsonnet';

{
  getSpec(context, keyboardLayout)::
    local isPortrait = context.isPortrait;
    {
      layoutName: if isPortrait then '竖屏中文18键' else '横屏中文18键',
      hintData: 'pinyin_18',
      swipeUpName: 'swipe_up_18',
      swipeDownName: 'swipe_down_18',
      wanxiangSetting: 'is_wanxiang_18',
      sizes: {
        shift: if isPortrait then keyboardLayout['竖屏按键尺寸']['shift键size'].width else keyboardLayout['横屏按键尺寸']['shift键size'].width,
        backspace: if isPortrait then keyboardLayout['竖屏按键尺寸']['backspace键size'].width else keyboardLayout['横屏按键尺寸']['backspace键size'].width,
        oneTwoThree: if isPortrait then keyboardLayout['竖屏按键尺寸']['123键size'].width else keyboardLayout['横屏按键尺寸']['123键size'].width,
        space: if isPortrait then keyboardLayout['竖屏按键尺寸']['space键size'].width else keyboardLayout['横屏按键尺寸']['space键size'].width,
        spaceLeft: if isPortrait then keyboardLayout['竖屏按键尺寸']['spaceLeft键size'].width else keyboardLayout['横屏按键尺寸']['spaceLeft键size'].width,
        enter: if isPortrait then keyboardLayout['竖屏按键尺寸']['enter键size'].width else keyboardLayout['横屏按键尺寸']['enter键size'].width,
      },
      keys: compactShared.buildKeys(
        [
          ['q', 'q', '18r1l'],
          ['we', 'w', '18r1l'],
          ['rt', 'r', '18r1l'],
          ['y', 'y', '18r1r'],
          ['u', 'u', '18r1r'],
          ['io', 'i', '18r1r'],
          ['p', 'p', '18r1r'],
          ['a', 'a', '18a'],
          ['sd', 's', '18r2'],
          ['fg', 'f', '18r2'],
          ['h', 'h', '18r2'],
          ['jk', 'j', '18r2'],
          ['l', 'l', '18l'],
          ['z', 'z', '18r3r'],
          ['xc', 'x', '18r3r'],
          ['v', 'v', '18r3r'],
          ['bn', 'b', '18r3l'],
          ['m', 'm', '18r3l'],
        ],
        context,
        keyboardLayout
      ),
    },
}
