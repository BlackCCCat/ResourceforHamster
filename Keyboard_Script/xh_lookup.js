// 要查询的字，只能查询单个汉字
var word = $searchText || $pasteboardContent;

let url = 'https://itho.cn/tool/api/encode/index.php?md5_encode=fjc_xhup' + word

// GET 请求
async function getMD5() {
    try {
      const value = await $http({
        url: url
      })
      if (value.data) {
        return value.data
      }
      return true
    } catch (error) {
      return error
    }
  }


// POST 请求
async function output() {
    if (word.length > 1) {
      return '请输入单个汉字进行查询'
    }
    if (/^[a-zA-Z0-9]/.test(word)) {
      return '不支持非汉字的查询'
    }
    const md5 = await getMD5();
    try {
      const value = await $http({
        url: "http://www.xhup.club/Xhup/Search/searchCode",
        method: "POST",
        header: {
          "Content-Type": "application/x-www-form-urlencoded",
          "Host": "www.xhup.club",
          "Origin": "http://react.xhup.club",
          "Referer": "http://react.xhup.club/search",
          "Accept": "application/json, text/plain, */*",
          "Accept-Charset": "zh-CN,zh;q=0.9,en;q=0.8",
          "User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.122 Safari/537.36"
        },
        body: {
          search_word: word,
          sign: md5
        }
      })
      if (value.data) {
        let json = JSON.parse(value.data)
				var res = json.list_dz.toString().split(',')
				var line_one = res[0]
				var line_two = '● 拆分：' + res[1]
				var line_three = '● 首末：' + res[2] + res[3]
				var line_four = '● 形码：' + res[4] + res[5]
				return line_one + '\n' + line_two + '\n' + line_three + '\n' + line_four
      }
      return true
    } catch (error) {
      return error
    }
  }