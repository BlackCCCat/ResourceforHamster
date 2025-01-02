async function replaceText() {
  // 读取剪贴板内容或搜索框内容
  const content = $searchText || $pasteboardContent;

  // 如果文本为空，返回提示信息
  if (!content) {
    return "[文本替换结果] -> 未提供任何文本，无法替换。";
  }

  // 定义需要替换的内容和对应的目标内容
  const replacements = {
    ":": "%3A",
    "/": "%2F",
  };

  // 使用循环遍历替换
  let replacedContent = content;
  for (const [target, replacement] of Object.entries(replacements)) {
    replacedContent = replacedContent.replace(new RegExp(target, "g"), replacement);
  }

  // 返回处理后的文本
  return `${replacedContent}`;
}

async function output() {
  const result = await replaceText();
  return result;
}
