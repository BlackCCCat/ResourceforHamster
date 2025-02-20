from ruamel.yaml import YAML, CommentedMap, comments
import os
from pathlib import Path
import argparse
import sys
# 初始化 YAML 对象
yaml = YAML()
yaml.preserve_quotes = True

# # 上划按键行为和显示
hold_symbols = {
    "q": [
        {"action": { "symbol": "q" }, "label": { "text": "q" }},
        {"action": { "symbol": "Q" }, "label": { "text": "Q" }},
        {"action": { "symbol": "➀" }, "label": { "text": "➀" }}
    ],
    "w": [
        {"action": { "symbol": "w" }, "label": { "text": "w" }},
        {"action": { "symbol": "W" }, "label": { "text": "W" }},
        {"action": { "symbol": "➁" }, "label": { "text": "➁" }}
    ],
    "e": [
        {"action": { "symbol": "e" }, "label": { "text": "e" }},
        {"action": { "symbol": "E" }, "label": { "text": "E" }},
        {"action": { "symbol": "➂" }, "label": { "text": "➂" }}
    ],
    "r": [
        {"action": { "symbol": "r" }, "label": { "text": "r" }},
        {"action": { "symbol": "R" }, "label": { "text": "R" }},
        {"action": { "symbol": "➃" }, "label": { "text": "➃" }}
    ],
    "t": [
        {"action": { "symbol": "t" }, "label": { "text": "t" }},
        {"action": { "symbol": "T" }, "label": { "text": "T" }},
        {"action": { "symbol": "➄" }, "label": { "text": "➄" }}
    ],
    "y": [
        {"action": { "symbol": "y" }, "label": { "text": "y" }},
        {"action": { "symbol": "Y" }, "label": { "text": "Y" }},
        {"action": { "symbol": "➅" }, "label": { "text": "➅" }}
    ],
    "u": [
        {"action": { "symbol": "u" }, "label": { "text": "u" }},
        {"action": { "symbol": "U" }, "label": { "text": "U" }},
        {"action": { "symbol": "➆" }, "label": { "text": "➆" }}
    ],
    "i": [
        {"action": { "symbol": "i" }, "label": { "text": "i" }},
        {"action": { "symbol": "I" }, "label": { "text": "I" }},
        {"action": { "symbol": "➇" }, "label": { "text": "➇" }}
    ],
    "o": [
        {"action": { "symbol": "o" }, "label": { "text": "o" }},
        {"action": { "symbol": "O" }, "label": { "text": "O" }},
        {"action": { "symbol": "➈" }, "label": { "text": "➈" }}
    ],
    "p": [
        {"action": { "symbol": "p" }, "label": { "text": "p" }},
        {"action": { "symbol": "P" }, "label": { "text": "P" }},
        {"action": { "symbol": "🄋" }, "label": { "text": "🄋" }}
    ],
    "a": [
        {"action": { "symbol": "a" }, "label": { "text": "a" }},
        {"action": { "symbol": "A" }, "label": { "text": "A" }}
    ],
    "s": [
        {"action": { "symbol": "s" }, "label": { "text": "s" }},
        {"action": { "symbol": "S" }, "label": { "text": "S" }}
    ],
    "d": [
        {"action": { "symbol": "d" }, "label": { "text": "d" }},
        {"action": { "symbol": "D" }, "label": { "text": "D" }}
    ],
    "f": [
        {"action": { "symbol": "f" }, "label": { "text": "f" }},
        {"action": { "symbol": "F" }, "label": { "text": "F" }}
    ],
    "g": [
        {"action": { "symbol": "g" }, "label": { "text": "g" }},
        {"action": { "symbol": "G" }, "label": { "text": "G" }}
    ],
    "h": [
        {"action": { "symbol": "h" }, "label": { "text": "h" }},
        {"action": { "symbol": "H" }, "label": { "text": "H" }}
    ],
    "j": [
        {"action": { "symbol": "j" }, "label": { "text": "j" }},
        {"action": { "symbol": "J" }, "label": { "text": "J" }}
    ],
    "k": [
        {"action": { "symbol": "k" }, "label": { "text": "k" }},
        {"action": { "symbol": "K" }, "label": { "text": "K" }}
    ],
    "l": [
        {"action": { "symbol": "l" }, "label": { "text": "l" }},
        {"action": { "symbol": "L" }, "label": { "text": "L" }}
    ],
    "z": [
        {"action": { "symbol": "z" }, "label": { "text": "z" }},
        {"action": { "symbol": "Z" }, "label": { "text": "Z" }}
    ],
    "x": [
        {"action": { "symbol": "x" }, "label": { "text": "x" }},
        {"action": { "symbol": "X" }, "label": { "text": "X" }}
    ],
    "c": [
        {"action": { "symbol": "c" }, "label": { "text": "c" }},
        {"action": { "symbol": "C" }, "label": { "text": "C" }}
    ],
    "v": [
        {"action": { "symbol": "v" }, "label": { "text": "v" }},
        {"action": { "symbol": "V" }, "label": { "text": "V" }}
    ],
    "b": [
        {"action": { "symbol": "b" }, "label": { "text": "b" }},
        {"action": { "symbol": "B" }, "label": { "text": "B" }}
    ],
    "n": [
        {"action": { "symbol": "n" }, "label": { "text": "n" }},
        {"action": { "symbol": "N" }, "label": { "text": "N" }}
    ],
    "m": [
        {"action": { "symbol": "m" }, "label": { "text": "m" }},
        {"action": { "symbol": "M" }, "label": { "text": "M" }}
    ]
}


hold_symbols_template = {
    "insets": { "top": 3, "bottom": 3, "left": 8, "right": 8 },
    "backgroundStyle": "alphabeticHoldSymbolsBackgroundStyle",
    "foregroundStyle": [],
    "actions": [],
    "selectedStyle": "alphabeticHoldSymbolsSelectedStyle",
    "selectedIndex": 1
}

def yaml_set_anchor(self, value, always_dump=True):
    self.anchor.value = value
    self.anchor.always_dump = always_dump

def load_file(file_path):
    with open(file_path, 'r', encoding='utf-8-sig') as file:
        data = yaml.load(file)
    return data

def save_file(file_path, data):
    with open(file_path, 'w', encoding='utf-8') as file:
        yaml.dump(data, file)


def replace_hold_symbols(data, button_name, hold_symbol_list):

    # 去除原有按钮的长按样式
    # 找到原有按钮的长按前景样式
    if "holdSymbolsStyle" in data[f"{button_name}Button"]:
        old_hold_style = data[f"{button_name}Button"]["holdSymbolsStyle"]
        for style_key in data[old_hold_style]["foregroundStyle"]:
            data.pop(style_key)

    # 准备actions
    actions = []
    for i in hold_symbol_list:
        actions.append(i['action'])
    # 准备foregroundStyle键名列表
    foregroundStyle_keys = [
        f"{button_name}ButtonForegroundStyle{i}" for i in range(1, len(hold_symbol_list)+1)
    ]
    # print(actions)

    # 准备foregroundStyle
    foregroundStyles = []
    for i in hold_symbol_list:
        style = CommentedMap()
        style['text'] = i['label']['text']
        # style['font'] = 14
        style.add_yaml_merge([(1, data["alphabeticHoldSymbolStyle"])])
        foregroundStyles.append(style)
    # print(foregroundStyles)
    
    # 准备长按总样式
    hold_style = hold_symbols_template.copy()
    hold_style.update({"backgroundStyle":f"alphabet{button_name}HoldSymbolsBackgroundStyle"})
    hold_style['actions'] = actions
    hold_style['foregroundStyle'] = foregroundStyle_keys
    # 长按指向我们的总样式
    data[f"{button_name}Button"]["holdSymbolsStyle"] = f"{button_name}ButtonHoldSymbolsStyle"

    # 添加总样式到指定位置
    keys = list(data.keys())
    # 位置是最后一个以button_name开头的按钮的下一个位置
    index = keys.index(list(filter(lambda x: x.startswith(f"{button_name}Button"), keys))[-1])
    # 插入总样式到指定位置
    data.insert(index, f"{button_name}ButtonHoldSymbolsStyle", hold_style)
    # 插入总样式内的各个前景的定义
    for i in range(len(hold_symbol_list)):
        data.insert(index+1+i, foregroundStyle_keys[i], foregroundStyles[i])
    return data

def main(file_path):
    # 定义需要处理的文件列表
    process_files = ["en_26_portrait.yaml","en_26_landscape.yaml"]

    # 递归遍历目录并处理文件
    for root, _, files in os.walk(file_path):
        for file in files:
            if file not in process_files:
                continue
            
            file_path = os.path.join(root, file)
            print(f"处理文件: {file_path}")
            data = load_file(file_path)
            for button_name, hold_symbol_list in hold_symbols.items():
                data = replace_hold_symbols(data, button_name, hold_symbol_list)
            save_file(file_path, data)

if __name__ == '__main__':
    if len(sys.argv) > 1:
        comments.CommentedBase.yaml_set_anchor = yaml_set_anchor # 保留锚点
        parser = argparse.ArgumentParser(description="处理源目录文件")
        parser.add_argument("source", type=Path, help="源目录路径")
        args = parser.parse_args()
        main(args.source)
    else:
        source_dir = "修改为你的皮肤文件夹名"
        main(source_dir)


