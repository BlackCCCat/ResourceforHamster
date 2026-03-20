// 用数据描述 14 键拼音布局规格，供入口选择与构建。
local compactShared = import '../common/pinyin14_18/compactSpecFactory.libsonnet';

{
  getSpec(context, keyboardLayout)::
    local isPortrait = context.isPortrait;
    {
      layoutName: if isPortrait then '竖屏中文14键' else '横屏中文14键',
      hintData: 'pinyin_14',
      swipeUpName: 'swipe_up_14',
      swipeDownName: 'swipe_down_14',
      wanxiangSetting: 'is_wanxiang_14',
      sizes: {
        shift: if isPortrait then keyboardLayout['竖屏按键尺寸']['shift键size'].width else keyboardLayout['横屏按键尺寸']['14键横屏shift键size'].width,
        backspace: if isPortrait then keyboardLayout['竖屏按键尺寸']['backspace键size'].width else keyboardLayout['横屏按键尺寸']['14键横屏backspace键size'].width,
        oneTwoThree: if isPortrait then keyboardLayout['竖屏按键尺寸']['123键size'].width else keyboardLayout['横屏按键尺寸']['123键size'].width,
        space: if isPortrait then keyboardLayout['竖屏按键尺寸']['space键size'].width else keyboardLayout['横屏按键尺寸']['space键size'].width,
        spaceLeft: if isPortrait then keyboardLayout['竖屏按键尺寸']['spaceLeft键size'].width else keyboardLayout['横屏按键尺寸']['spaceLeft键size'].width,
        enter: if isPortrait then keyboardLayout['竖屏按键尺寸']['enter键size'].width else keyboardLayout['横屏按键尺寸']['enter键size'].width,
      },
      keys: compactShared.buildKeys(
        [
          ['qw', 'q', '14r1'],
          ['er', 'e', '14r1'],
          ['ty', 't', '14r1'],
          ['ui', 'u', '14r1'],
          ['op', 'o', '14r1'],
          ['as', 'a', '14as'],
          ['df', 'd', '14r2'],
          ['gh', 'g', '14r2'],
          ['jk', 'j', '14r2'],
          ['l', 'l', '14l'],
          ['zx', 'z', '14r3'],
          ['cv', 'c', '14r3'],
          ['bn', 'b', '14r3'],
          ['m', 'm', '14r3'],
        ],
        context,
        keyboardLayout
      ),
    },
}
