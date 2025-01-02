async function removeSpaces() {
  // 读取剪贴板内容或搜索框内容
  const content = $searchText || $pasteboardContent;

  // 去除文本中的所有空格（包括中间的空格）
  const cleanedContent = content.replace(/\s+/g, '');

  // 如果文本为空，返回提示信息
  if (!cleanedContent) {
    return null;
  }

  // 返回处理后的文本
  return `${cleanedContent}`;
}

async function output() {
  const result = await removeSpaces();
  return result;
}
