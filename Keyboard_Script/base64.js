// 该脚本来自互联网，仅根据个人使用习惯进行一些修改

function base64Encode(str) {
  // 将字符串转换为 UTF-8 编码
  const utf8Bytes = unescape(encodeURIComponent(str));
  let output = '';
  let buffer = 0;
  let bitsCollected = 0;

  for (let byte of utf8Bytes) {
    buffer = (buffer << 8) | byte.charCodeAt(0);
    bitsCollected += 8;

    while (bitsCollected >= 6) {
      bitsCollected -= 6;
      output += 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/='[(buffer >> bitsCollected) & 0x3F];
    }
  }


  if (bitsCollected > 0) {
    buffer <<= (6 - bitsCollected);
    output += 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/='[(buffer & 0x3F)];
    output += '='; // 添加填充
  }

  return output;
}

function base64Decode(str) {
  const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=';
  let output = '';
  let buffer = 0;
  let bitsCollected = 0;

  for (let char of str) {
    if (char === '=') break;
    const charIndex = chars.indexOf(char);
    if (charIndex === -1) continue; // 忽略非法字符

    buffer = (buffer << 6) | charIndex;
    bitsCollected += 6;

    while (bitsCollected >= 8) {
      bitsCollected -= 8;
      output += String.fromCharCode((buffer >> bitsCollected) & 0xFF);
    }
  }

  // 将解码后的字节转换回 UTF-8
  return decodeURIComponent(escape(output));
}

async function output() {
  const text = $searchText || $pasteboardContent
  if (!text) {
    return "请输入内容!";
  }
  if (text[0].toUpperCase() === "E") {
    return base64Encode(text.slice(1));;
  } else if (text[0].toUpperCase() === "D") {
    return base64Decode(text.slice(1));
  } else {
    return "请输入正确的指令：E/e/D/d";
  }
}