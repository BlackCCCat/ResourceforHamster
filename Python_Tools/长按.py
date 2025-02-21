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
        {"action": { "character": "q" }, "label": { "text": "q" }},
        {"action": { "character": "Q" }, "label": { "text": "Q" }},
        {"action": { "symbol": "➊" }, "label": { "text": "➊" }}
    ],
    "w": [
        {"action": { "character": "w" }, "label": { "text": "w" }},
        {"action": { "character": "W" }, "label": { "text": "W" }},
        {"action": { "symbol": "➋" }, "label": { "text": "➋" }}
    ],
    "e": [
        {"action": { "character": "e" }, "label": { "text": "e" }},
        {"action": { "character": "E" }, "label": { "text": "E" }},
        {"action": { "symbol": "➌" }, "label": { "text": "➌" }}
    ],
    "r": [
        {"action": { "character": "r" }, "label": { "text": "r" }},
        {"action": { "character": "R" }, "label": { "text": "R" }},
        {"action": { "symbol": "➍" }, "label": { "text": "➍" }}
    ],
    "t": [
        {"action": { "character": "t" }, "label": { "text": "t" }},
        {"action": { "character": "T" }, "label": { "text": "T" }},
        {"action": { "symbol": "➎" }, "label": { "text": "➎" }}
    ],
    "y": [
        {"action": { "character": "y" }, "label": { "text": "y" }},
        {"action": { "character": "Y" }, "label": { "text": "Y" }},
        {"action": { "symbol": "➏" }, "label": { "text": "➏" }}
    ],
    "u": [
        {"action": { "character": "u" }, "label": { "text": "u" }},
        {"action": { "character": "U" }, "label": { "text": "U" }},
        {"action": { "symbol": "➐" }, "label": { "text": "➐" }}
    ],
    "i": [
        {"action": { "character": "i" }, "label": { "text": "i" }},
        {"action": { "character": "I" }, "label": { "text": "I" }},
        {"action": { "symbol": "➑" }, "label": { "text": "➑" }}
    ],
    "o": [
        {"action": { "character": "o" }, "label": { "text": "o" }},
        {"action": { "character": "O" }, "label": { "text": "O" }},
        {"action": { "symbol": "➒" }, "label": { "text": "➒" }}
    ],
    "p": [
        {"action": { "character": "p" }, "label": { "text": "p" }},
        {"action": { "character": "P" }, "label": { "text": "P" }},
        {"action": { "symbol": "🄌" }, "label": { "text": "🄌" }}
    ],
    "a": [
        {"action": { "character": "a" }, "label": { "text": "a" }},
        {"action": { "character": "A" }, "label": { "text": "A" }}
    ],
    "s": [
        {"action": { "character": "s" }, "label": { "text": "s" }},
        {"action": { "character": "S" }, "label": { "text": "S" }}
    ],
    "d": [
        {"action": { "character": "d" }, "label": { "text": "d" }},
        {"action": { "character": "D" }, "label": { "text": "D" }}
    ],
    "f": [
        {"action": { "character": "f" }, "label": { "text": "f" }},
        {"action": { "character": "F" }, "label": { "text": "F" }}
    ],
    "g": [
        {"action": { "character": "g" }, "label": { "text": "g" }},
        {"action": { "character": "G" }, "label": { "text": "G" }}
    ],
    "h": [
        {"action": { "character": "h" }, "label": { "text": "h" }},
        {"action": { "character": "H" }, "label": { "text": "H" }}
    ],
    "j": [
        {"action": { "character": "j" }, "label": { "text": "j" }},
        {"action": { "character": "J" }, "label": { "text": "J" }}
    ],
    "k": [
        {"action": { "character": "k" }, "label": { "text": "k" }},
        {"action": { "character": "K" }, "label": { "text": "K" }}
    ],
    "l": [
        {"action": { "character": "l" }, "label": { "text": "l" }},
        {"action": { "character": "L" }, "label": { "text": "L" }}
    ],
    "z": [
        {"action": { "character": "z" }, "label": { "text": "z" }},
        {"action": { "character": "Z" }, "label": { "text": "Z" }}
    ],
    "x": [
        {"action": { "character": "x" }, "label": { "text": "x" }},
        {"action": { "character": "X" }, "label": { "text": "X" }}
    ],
    "c": [
        {"action": { "character": "c" }, "label": { "text": "c" }},
        {"action": { "character": "C" }, "label": { "text": "C" }}
    ],
    "v": [
        {"action": { "character": "v" }, "label": { "text": "v" }},
        {"action": { "character": "V" }, "label": { "text": "V" }}
    ],
    "b": [
        {"action": { "character": "b" }, "label": { "text": "b" }},
        {"action": { "character": "B" }, "label": { "text": "B" }}
    ],
    "n": [
        {"action": { "character": "n" }, "label": { "text": "n" }},
        {"action": { "character": "N" }, "label": { "text": "N" }}
    ],
    "m": [
        {"action": { "character": "m" }, "label": { "text": "m" }},
        {"action": { "character": "M" }, "label": { "text": "M" }}
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

    # 准备foregroundStyle
    foregroundStyles = []
    for i in hold_symbol_list:
        style = CommentedMap()
        style['text'] = i['label']['text']
        # style['font'] = 14
        style.add_yaml_merge([(1, data["alphabeticHoldSymbolStyle"])])
        foregroundStyles.append(style)
    
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
    process_files = ["pinyin_26_portrait.yaml","pinyin_26_landscape.yaml"]

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
        comments.CommentedBase.yaml_set_anchor = yaml_set_anchor # 保留锚点
        dir_list = ["26_Black&White","26_Gradient","26_NewRainbow","26_PartColor","26_Rainbow","26_White&Black","26_Normal"]
        # dir_list = ["26_Normal"]
        for son_dir in dir_list:
            source_dir = f"多色合集/{son_dir}"
            main(source_dir)

