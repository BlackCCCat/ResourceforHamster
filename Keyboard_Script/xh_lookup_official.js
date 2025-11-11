
/**
 * 校验输入参数，确保只支持单个汉字
 * @param {string} text - 查询输入的文本
 * @returns {string|boolean} 如果验证失败则返回错误提示，否则返回 true
 */
function validateWord(text) {
  if (!text || typeof text !== "string" || text.trim().length === 0) {
    return "输入不能为空";
  }
  if (text.length > 1) {
    return "请输入单个汉字进行查询";
  }
  if (!/^[\u4e00-\u9fa5]$/.test(text)) {
    return "不支持非汉字的查询";
  }
  return true;
}

/**
 * 发起 GET 请求获取词典数据
 * @returns 返回JSON
 */
async function getJSON() {
  const url = `https://flypy.cc/ix/data.json`;
  try {
    const response = await $http({ url });
    if (response && response.data) {
      return response.data;
    } else {
      throw new Error("获取JSON数据失败：返回数据为空");
    }
  } catch (error) {
    console.error("获取 JSON 数据出错:", error);
    throw new Error(`获取 JSON 数据出错：${error.message}`);
  }
}


/**
 * 主函数，处理输入并返回结果
 * @returns {Promise<string>} 输出查询结果或相关提示
 */
async function output() {
  // 要查询的字，只能查询单个汉字
  const word = $searchText || $pasteboardContent;
  // 校验输入
  const validationResult = validateWord(word);
  if (validationResult !== true) {
    return validationResult; // 输出校验提示
  }

  try {
    // 获取 JSON 字典数据
    const json_str = await getJSON();
    if (!json_str) {
      return "无法获取 JSON 词库数据";
    }

    // 获取查询结果
	const json_res = JSON.parse(json_str)
    const result = json_res[word];

    // 提取相关信息并组装输出
    const lineOne = `汉字： ${word}`;
    const lineTwo = `● 编码：${result["1"]}`;
    const lineThree = `● 鹤形：${result["2"]}`;
    const lineFour = `● 拆分：${result["3"]}`;
    const lineFive = `● 拼音：${result["4"]}`;
      
    return [lineOne, lineTwo, lineThree, lineFour, lineFive].join("\n");
  } catch (error) {
    // 捕获和返回错误信息
    return `出错了：${error.message || error}`;
  }
}