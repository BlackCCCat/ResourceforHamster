// 组装手机功能行按钮，并提供功能行插入各键盘布局所需的布局补丁。
local buttonBuilder = (
  local Settings = import '../../Custom.libsonnet';
  local specs = import './specs.libsonnet';

  // 功能行按钮没有独立上下划数据，保持空映射可避免依赖具体键盘族。
  local swipe_up = {};
  local swipe_down = {};
  local resolvedOrderedKeys = specs.resolveOrderedKeys(Settings);

  local createFunctionButton(key, bg, actionMap, swipeUpMap, swipeDownMap, repeatMap, swipeUp, swipeDown, size, isUpper=true, isNotification=true) = {
    size: size,
    backgroundStyle: bg,
    foregroundStyle: std.filter(
      function(x) x != null,
      [
        key + 'ButtonForegroundStyle',
        if std.objectHas(swipeUp, key) then key + 'ButtonUpForegroundStyle' else null,
        if std.objectHas(swipeDown, key) then key + 'ButtonDownForegroundStyle' else null,
      ]
    ),
    [if isUpper then 'uppercasedStateForegroundStyle']: std.filter(
      function(x) x != null,
      [
        key + 'ButtonUppercasedStateForegroundStyle',
        if std.objectHas(swipeUp, key) then key + 'ButtonUpForegroundStyle' else null,
        if std.objectHas(swipeDown, key) then key + 'ButtonDownForegroundStyle' else null,
      ]
    ),
    [if isUpper then 'capsLockedStateForegroundStyle']: self.uppercasedStateForegroundStyle,
    hintStyle: key + 'ButtonHintStyle',
    [if std.objectHas(actionMap, key) && actionMap[key] != {} then 'action']: actionMap[key].action,
    [if std.objectHas(swipeUpMap, key) && swipeUpMap[key] != {} then 'swipeUpAction']: swipeUpMap[key].action,
    [if std.objectHas(swipeDownMap, key) && swipeDownMap[key] != {} then 'swipeDownAction']: swipeDownMap[key].action,
    [if std.objectHas(repeatMap, key) && repeatMap[key] != {} then 'repeatAction']: repeatMap[key].action,
    [if std.length(key) == 1 then 'uppercasedStateAction']: {
      character: std.asciiUpper(key),
    },
    [if std.objectHas(swipeUp, key) then 'swipeUpAction']: swipeUp[key].action,
    [if std.objectHas(swipeDown, key) then 'swipeDownAction']: swipeDown[key].action,
    animation: ['ButtonScaleAnimation'],
    [if isNotification then 'notification']: [key + 'ButtonPreeditNotification'],
  };

  local createNotification(key, notificationType, bg, actionMap, swipeUpMap, swipeDownMap, repeatMap) = {
    notificationType: notificationType,
    backgroundStyle: bg,
    foregroundStyle: key + 'ButtonPreeditForegroundStyle',
    [if std.objectHas(actionMap, key) && actionMap[key] != {} then 'action']: actionMap[key].action,
    [if std.objectHas(swipeUpMap, key) && swipeUpMap[key] != {} then 'swipeUpAction']: swipeUpMap[key].action,
    [if std.objectHas(swipeDownMap, key) && swipeDownMap[key] != {} then 'swipeDownAction']: swipeDownMap[key].action,
    [if std.objectHas(repeatMap, key) && repeatMap[key] != {} then 'repeatAction']: repeatMap[key].action,
  };

  local buildFunctionButtons(Settings, keyboardType, bg, swipeUp, swipeDown, size, orderedKeys) =
    std.foldl(
      function(acc, key)
        acc {
          [key + 'Button']: createFunctionButton(
            key,
            bg,
            specs.actionMap,
            specs.swipeUpMap,
            specs.swipeDownMap,
            specs.repeatMap,
            swipeUp,
            swipeDown,
            size,
            true,
            specs.notificationEnabled(Settings, keyboardType, key)
          ),
          [key + 'ButtonPreeditNotification']: createNotification(
            key,
            'preeditChanged',
            bg,
            specs.resolveNotificationActionMap(keyboardType),
            specs.notificationSwipeUpMap,
            specs.notificationSwipeDownMap,
            specs.notificationRepeatMap
          ),
        },
      orderedKeys,
      {}
    );

  local makeFunctionButtons(orientation, keyboardLayout, keyboard_type) =
    local getSafeSize =
      if std.objectHas(keyboardLayout, '竖屏按键尺寸') &&
         std.objectHas(keyboardLayout['竖屏按键尺寸'], '自定义键size') &&
         std.objectHas(keyboardLayout, '横屏按键尺寸') &&
         std.objectHas(keyboardLayout['横屏按键尺寸'], '自定义键size') then
        if orientation == 'portrait' then
          keyboardLayout['竖屏按键尺寸']['自定义键size']
        else
          keyboardLayout['横屏按键尺寸']['自定义键size']
      else
        {}
    ;
    local normalizedSize =
      if std.objectHas(getSafeSize, 'height') then { height: getSafeSize.height } else {};
    local getbg =
      if keyboard_type == 'numeric' then 'functionBackgroundStyle' else 'alphabeticBackgroundStyle'
    ;
    // 功能行宽度由 layout 层按当前按钮数量动态分配，按钮对象不再写死 width。
    buildFunctionButtons(Settings, keyboard_type, getbg, swipe_up, swipe_down, normalizedSize, resolvedOrderedKeys);

  {
    makeFunctionButtons(orientation, keyboardLayout, keyboard_type): makeFunctionButtons(orientation, keyboardLayout, keyboard_type),
  }
);

local layoutPatch = (
  local Settings = import '../../Custom.libsonnet';
  local functionButtonSpecs = import './specs.libsonnet';

  {
    functionRowOrderedKeys:: functionButtonSpecs.resolveOrderedKeys(Settings),

    cell(name):: { Cell: name + 'Button' },
    rawCell(name):: { Cell: name },

    functionCellWidth(count):: {
      width: {
        percentage: 1 / count,
      },
    },

    functionCell(name, count):: {
      Cell: name + 'Button',
      size: $.functionCellWidth(count),
    },

    rowofFunctionStyle:: {
      size: {
        height: { percentage: 0.17 },
      },
      backgroundStyle: 'keyboardBackgroundStyle',
    },

    standardFunctionRow(orderedKeys):: {
      HStack: {
        style: 'rowofFunctionStyle',
        subviews: [$.functionCell(key, std.length(orderedKeys)) for key in orderedKeys],
      },
    },

    splitFunctionRow(orderedKeys):: (
      local splitIndex = std.ceil(std.length(orderedKeys) / 2);
      local leftKeys = std.slice(orderedKeys, 0, splitIndex, 1);
      local rightKeys = std.slice(orderedKeys, splitIndex, std.length(orderedKeys), 1);
      {
        HStack: {
          style: 'rowofFunctionStyle',
          subviews: [
            {
              VStack: {
                style: 'columnStyle1',
                subviews: [
                  {
                    HStack: {
                      subviews: [$.functionCell(key, std.length(leftKeys)) for key in leftKeys],
                    },
                  },
                ],
              },
            },
            {
              VStack: {
                style: 'columnStyle2',
              },
            },
            {
              VStack: {
                style: 'columnStyle3',
                subviews: [
                  {
                    HStack: {
                      subviews: [$.functionCell(key, std.length(rightKeys)) for key in rightKeys],
                    },
                  },
                ],
              },
            },
          ],
        },
      }
    ),

    standardLayoutPatch(layoutDef):: {
      [if std.objectHas(layoutDef, '竖屏按键尺寸') then '竖屏按键尺寸']: layoutDef['竖屏按键尺寸'],
      keyboardLayout: [$.standardFunctionRow($.functionRowOrderedKeys)] + layoutDef.keyboardLayout,
      rowofFunctionStyle: $.rowofFunctionStyle,
      keyboardStyle: layoutDef.keyboardStyle,
      keyboardBackgroundStyle: layoutDef.keyboardBackgroundStyle,
      [if std.objectHas(layoutDef, 'VStackStyle1') then 'VStackStyle1']: layoutDef.VStackStyle1,
      [if std.objectHas(layoutDef, 'CenterStackStyle') then 'CenterStackStyle']: layoutDef.CenterStackStyle,
      [if std.objectHas(layoutDef, 'HStackStyle1') then 'HStackStyle1']: layoutDef.HStackStyle1,
      [if std.objectHas(layoutDef, 'HStackStyle2') then 'HStackStyle2']: layoutDef.HStackStyle2,
    },

    splitLayoutPatch(layoutDef):: {
      keyboardLayout: [$.splitFunctionRow($.functionRowOrderedKeys)] + layoutDef.keyboardLayout,
      rowofFunctionStyle: $.rowofFunctionStyle,
      keyboardStyle: layoutDef.keyboardStyle,
      keyboardBackgroundStyle: layoutDef.keyboardBackgroundStyle,
      columnStyle1: layoutDef.columnStyle1,
      columnStyle2: layoutDef.columnStyle2,
      columnStyle3: layoutDef.columnStyle3,
    },

    compactLandscapeContent(column1Rows, column3Rows):: {
      HStack: {
        style: 'keyboardStyle',
        subviews: [
          {
            VStack: {
              style: 'columnStyle1',
              subviews: [
                { HStack: { subviews: column1Rows[0] } },
                { HStack: { subviews: column1Rows[1] } },
                { HStack: { subviews: column1Rows[2] } },
                { HStack: { subviews: column1Rows[3] } },
              ],
            },
          },
          { VStack: { style: 'columnStyle2' } },
          {
            VStack: {
              style: 'columnStyle3',
              subviews: [
                { HStack: { subviews: column3Rows[0] } },
                { HStack: { subviews: column3Rows[1] } },
                { HStack: { subviews: column3Rows[2] } },
                { HStack: { subviews: column3Rows[3] } },
              ],
            },
          },
        ],
      },
    },

    compactLandscapeLayoutPatch(layoutDef, column1Rows, column3Rows):: {
      keyboardLayout: [$.splitFunctionRow($.functionRowOrderedKeys), $.compactLandscapeContent(column1Rows, column3Rows)],
      rowofFunctionStyle: $.rowofFunctionStyle,
      keyboardStyle: layoutDef.keyboardStyle,
      keyboardBackgroundStyle: layoutDef.keyboardBackgroundStyle,
      columnStyle1: layoutDef.columnStyle1,
      columnStyle2: layoutDef.columnStyle2,
      columnStyle3: layoutDef.columnStyle3,
    },

    getPatch(baseLayout, pinyin18LandscapeRows, pinyin14LandscapeRows):: {
      '竖屏中文9键': $.standardLayoutPatch(baseLayout['竖屏中文9键']),
      '竖屏中文26键': $.standardLayoutPatch(baseLayout['竖屏中文26键']),
      '竖屏中文18键': $.standardLayoutPatch(baseLayout['竖屏中文18键']),
      '竖屏中文14键': $.standardLayoutPatch(baseLayout['竖屏中文14键']),
      'ipad中文26键': $.standardLayoutPatch(baseLayout['ipad中文26键']),
      '竖屏英文26键': $.standardLayoutPatch(baseLayout['竖屏英文26键']),
      'ipad英文26键': $.standardLayoutPatch(baseLayout['ipad英文26键']),
      '横屏中文26键': $.splitLayoutPatch(baseLayout['横屏中文26键']),
      '横屏英文26键': $.splitLayoutPatch(baseLayout['横屏英文26键']),
      '横屏中文18键': $.compactLandscapeLayoutPatch(
        baseLayout['横屏中文18键'],
        [
          [$.rawCell(name) for name in pinyin18LandscapeRows.left[0]],
          [$.rawCell(name) for name in pinyin18LandscapeRows.left[1]],
          [$.rawCell(name) for name in pinyin18LandscapeRows.left[2]],
          [$.rawCell(name) for name in pinyin18LandscapeRows.left[3]],
        ],
        [
          [$.rawCell(name) for name in pinyin18LandscapeRows.right[0]],
          [$.rawCell(name) for name in pinyin18LandscapeRows.right[1]],
          [$.rawCell(name) for name in pinyin18LandscapeRows.right[2]],
          [$.rawCell(name) for name in pinyin18LandscapeRows.right[3]],
        ]
      ),
      '横屏中文14键': $.compactLandscapeLayoutPatch(
        baseLayout['横屏中文14键'],
        [
          [$.rawCell(name) for name in pinyin14LandscapeRows.left[0]],
          [$.rawCell(name) for name in pinyin14LandscapeRows.left[1]],
          [$.rawCell(name) for name in pinyin14LandscapeRows.left[2]],
          [$.rawCell(name) for name in pinyin14LandscapeRows.left[3]],
        ],
        [
          [$.rawCell(name) for name in pinyin14LandscapeRows.right[0]],
          [$.rawCell(name) for name in pinyin14LandscapeRows.right[1]],
          [$.rawCell(name) for name in pinyin14LandscapeRows.right[2]],
          [$.rawCell(name) for name in pinyin14LandscapeRows.right[3]],
        ]
      ),
    },
  }
);

buttonBuilder + layoutPatch
