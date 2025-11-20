// desc: 生成不同规则的密码，分段方便复制

async function generatePassword(specialChars = false) {
    // 处理长度参数
    let length = parseInt($searchText);
    if (isNaN(length) || length <= 5 || length > 20 || !Number.isInteger(length)) {
        length = 12; // 无效时使用默认值
    }
    
    const uppercase = "ABCDEFGHJKLMNOPQRSTUVWXYZ";
    const lowercase = "abcdefghijkmnopqrstuvwxyz";
    const digits = "0123456789";
    const specials = "!@#$%^&*()_+[]{}|;:,.<>?";

    let charset = uppercase + lowercase + digits;
    let password = '';

    // 强制包含至少2个特殊字符
    if (specialChars) {
        charset += specials;
        for (let i = 0; i < 2; i++) {
            password += specials[Math.floor(Math.random() * specials.length)];
        }
    }

    // 补充剩余字符
    const remainingLength = length - password.length;
    for (let i = 0; i < remainingLength; i++) {
        password += charset[Math.floor(Math.random() * charset.length)];
    }

    // Fisher-Yates洗牌算法
    password = password.split('');
    for (let i = password.length - 1; i > 0; i--) {
        const j = Math.floor(Math.random() * (i + 1));
        [password[i], password[j]] = [password[j], password[i]];
    }
    
    return password.join('');
}

async function output() {
    try {
        const withSpecial = await generatePassword(true);
        const withoutSpecial = await generatePassword(false);
        return [
            `${withSpecial.length}位-含特殊符号`,
            withSpecial,
            `${withoutSpecial.length}位-无特殊符号`,
            withoutSpecial,
        ];
    } catch (error) {
        return ["密码生成失败"];
    }
}

// 执行输出
output().then(result => console.log(result.join('\n')));