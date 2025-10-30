local collectionData = import '../lib/collectionData.libsonnet';
// local toolbar = import '../lib/toolbar-emoji.libsonnet';
local symbolic = import './symbolic_portrait.jsonnet';

local keyboard(theme) =
  symbolic.getKeyboard(theme);


{
  new(theme):
    keyboard(theme) + collectionData.emojiDataSource,
}
