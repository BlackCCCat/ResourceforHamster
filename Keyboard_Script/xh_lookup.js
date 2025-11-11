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
 * 发起 GET 请求获取 MD5 签名
 * @returns {Promise<string>} 返回 MD5 哈希值
 */
async function getMD5(word) {
  const url = `https://itho.cn/tool/api/encode/index.php?md5_encode=fjc_xhup${word}`;
  try {
    const response = await $http({ url });
    if (response && response.data) {
      return response.data;
    } else {
      throw new Error("获取 MD5 签名失败：返回数据为空");
    }
  } catch (error) {
    console.error("获取 MD5 出错:", error);
    throw new Error(`获取 MD5 出错：${error.message}`);
  }
}

/**
 * 发起 POST 请求获取查询结果
 * @param {string} md5 - MD5 签名
 * @returns {Promise<string>} 解析后的结果
 */
async function queryResult(md5, word) {
  const url = "http://www.xhup.club/Xhup/Search/searchCode";
  const headers = {
    "Content-Type": "application/x-www-form-urlencoded",
    "Host": "www.xhup.club",
    "Origin": "http://react.xhup.club",
    "Referer": "http://react.xhup.club/search",
    "Accept": "application/json, text/plain, */*",
    "Accept-Charset": "zh-CN,zh;q=0.9,en;q=0.8",
    "User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.122 Safari/537.36"
  };
  const body = {
    search_word: word,
    sign: md5
  };

  try {
    const response = await $http({
      url,
      method: "POST",
      header: headers,
      body
    });

    if (response && response.data) {
      // 解析返回数据
      const json = JSON.parse(response.data);
      
      // 检查接口是否返回 `list_dz` 字段
      if (!json.list_dz) {
        throw new Error("接口返回中缺少 list_dz 数据");
      }

      const resultArray = json.list_dz.toString().split(",");

      // 提取相关信息并组装输出
      const lineOne = resultArray[0];
      const lineTwo = `● 拆分：${resultArray[1]}`;
      const lineThree = `● 首末：${resultArray[2]}${resultArray[3]}`;
      const lineFour = `● 形码：${resultArray[4]}${resultArray[5]}`;
      
      return [lineOne, lineTwo, lineThree, lineFour].join("\n");
    } else {
      throw new Error("查询结果返回为空");
    }
  } catch (error) {
    console.error("获取查询结果出错:", error);
    throw new Error(`获取查询结果出错：${error.message}`);
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
    // 获取 MD5 签名
    const md5 = await getMD5(word);
    if (!md5) {
      return "无法生成 MD5 签名";
    }

    // 获取查询结果
    const result = await queryResult(md5, word);
    return result;
  } catch (error) {
    // 捕获和返回错误信息
    return `出错了：${error.message || error}`;
  }
}