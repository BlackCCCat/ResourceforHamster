async function extractLinks() {
  // 读取剪贴板内容或搜索框内容
  const content = $searchText || $pasteboardContent;

  // 使用正则表达式匹配所有 URL 链接
  const urlPattern = /https?:\/\/[^\s]+/g;

  // 提取链接
  const links = content.match(urlPattern);

  // 如果没有找到任何链接
  if (!links || links.length === 0) {
    return "[链接提取结果] -> 未找到任何链接。";
  }

  // 基于 accumulator.push(line) 格式化每一个链接
  const info = links.reduce((accumulator, link, index) => {
    let line = `${link}`;  // 为每个链接添加前缀
    accumulator.push(line);                      // 将每个链接逐行添加到 accumulator
    return accumulator;
  }, []);

  // 返回最终格式化后的结果，遵循汇率脚本格式
  return [`[链接提取结果] -> 共找到 ${links.length} 个链接：`].concat(info);
}

async function output() {
  const result = await extractLinks();
  return result;
}
