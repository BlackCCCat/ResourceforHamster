from ruamel.yaml import YAML, CommentedMap, comments
import os
from pathlib import Path
import argparse
import sys
# 初始化 YAML 对象
yaml = YAML()
yaml.preserve_quotes = True
# # 上划按键行为和显示
pinyin26_up = {
    "q": {"action": { "character": "1" }, "label": {'text': "1"}},
    "w": {"action": { "character": "2" }, "label": {'text': "2"}},
    "e": {"action": { "character": "3" }, "label": {'text': "3"}},
    "r": {"action": { "character": "4" }, "label": {'text': "4"}},
    "t": {"action": { "character": "5" }, "label": {'text': "5"}},
    "y": {"action": { "character": "6" }, "label": {'text': "6"}},
    "u": {"action": { "character": "7" }, "label": {'text': "7"}},
    "i": {"action": { "character": "8" }, "label": {'text': "8"}},
    "o": {"action": { "character": "9" }, "label": {'text': "9"}},
    "p": {"action": { "character": "0" }, "label": {'text': "0"}},
    "a": {"action": { "character": "、" }, "label": {'text': "、"}},
    "s": {"action": { "character": "-" }, "label": {'text': "-"}},
    "d": {"action": { "symbol": "=" }, "label": {'text': "="}},
    "f": {"action": { "symbol": "【" }, "label": {'text': "["}},
    "g": {"action": { "symbol": "】" }, "label": {'text': "]"}},
    "h": {"action": { "symbol": "\\" }, "label": {'text': "\\"}},
    "j": {"action": { "character": "/" }, "label": {'text': "/"}},
    "k": {"action": { "character": ":" }, "label": {'text': ":"}},
    "l": {"action": { "character": '"' }, "label": {'text': '"'}},
    "z": {"action": 'tab', "label": {'text': "⇥"}},
    "x": {"action": { "character": "[" }, "label": {"text": "〔"}},
    "c": {"action": { "character": "]" }, "label": {"text": "〕"}},
    "v": {"action": { "character": "<" }, "label": {"text": "《"}},
    "b": {"action": { "character": ">" }, "label": {"text": "》"}},
    "n": {"action": { "character": "!" }, "label": {"text": "!"}},
    "m": {"action": { "character": "?" }, "label": {"text": "?"}}
}

pinyin26_down = {
    "q": {"action": { "character": "~" }, "label": {'text': "~"}},
    "w": {"action": { "character": "@" }, "label": {'text': "@"}},
    "e": {"action": { "character": "#" }, "label": {'text': "#"}},
    "r": {"action": { "character": "$" }, "label": {'text': "$"}},
    "t": {"action": { "character": "%" }, "label": {'text': "%"}},
    "y": {"action": { "character": "^" }, "label": {'text': "^"}},
    "u": {"action": { "character": "&" }, "label": {'text': "&"}},
    "i": {"action": { "character": "*" }, "label": {'text': "*"}},
    "o": {"action": { "character": "(" }, "label": {'text': "("}},
    "p": {"action": { "character": ")" }, "label": {'text': ")"}},
    "a": {"action": { "character": "`" }, "label": {'text': "`"}},
    "s": {"action": { "character": "_" }, "label": {'text': "_"}},
    "d": {"action": { "character": "+" }, "label": {'text': "+"}},
    "f": {"action": { "character": "{" }, "label": {'text': "{"}},
    "g": {"action": { "character": "}" }, "label": {'text': "}"}},
    "h": {"action": { "character": "|" }, "label": {'text': "|"}},
    "j": {"action": { "character": "." }, "label": {'text': "."}},
    "k": {"action": { "character": ";" }, "label": {'text': ";"}},
    "l": {"action": { "character": "'" }, "label": {"text": "'"}},
    "z": {"action": { "character": "=" }, "label": {'systemImageName': "av.remote.fill"}},
    "x": {"action": { "sendKeys": "Vhs" }, "label": {'systemImageName': "clock.arrow.circlepath"}},
    "c": {"action": { "sendKeys": "orq" }, "label": {'systemImageName': "calendar"}},
    "v": {"action": { "sendKeys": "datetime" }, "label": {'systemImageName': "calendar.badge.clock"}},
    "b": {"action": { "sendKeys": "R" }, "label": {'systemImageName': "chineseyuanrenminbisign.square.fill"}},
    "n": {"action": { "sendKeys": "N" }, "label": {'systemImageName': "calendar.badge.exclamationmark"}},
    "m": {"action": { "sendKeys": "uU" }, "label": {'systemImageName': "rectangle.3.group.fill"}}
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


def add_swipes(data: CommentedMap, button: str, direction: str, action, label: dict):
    button_key = f"{button}Button"
    up_style_key = f"{button}ButtonUpForegroundStyle"
    down_style_key = f"{button}ButtonDownForegroundStyle"
    swipe_style_key = up_style_key if direction == "up" else down_style_key

    # 定义上划和下划样式
    up_style = CommentedMap()
    up_style.update(label)
    if label.get("systemImageName"): # 如果划动配置的前景是systemImageName则使用sfsymbol样式
        up_style.add_yaml_merge([(1, data["sfsymbolSwipeUpBadgeStyle"])])
    else:
        up_style.add_yaml_merge([(1, data["alphabeticSwipeUpBadgeStyle"])])

    down_style = CommentedMap()
    down_style.update(label)
    if label.get("systemImageName"): 
        down_style.add_yaml_merge([(0, data["sfsymbolSwipeDownBadgeStyle"])])
    else:
        down_style.add_yaml_merge([(0, data["alphabeticSwipeDownBadgeStyle"])])
    swipe_style = up_style if direction == "up" else down_style

    section = data[button_key] # 26按键配置部分
    # 替换上下划动作
    swipeAction_key = "swipeUpAction" if direction == "up" else "swipeDownAction"
    section[swipeAction_key] = action

    # 替换上划和下划样式
    for style in ["foregroundStyle", "uppercasedStateForegroundStyle", "capsLockedStateForegroundStyle"]:
        if swipe_style_key not in section[style]:
            section[style].append(swipe_style_key)
    if swipe_style_key not in data:
        keys = list(data.keys())
        # 找到合适的位置插入新样式(有上下划就在上下划旁边插，没有就在Button配置旁边)
        if up_style_key in keys:
            index_style = up_style_key
        elif down_style_key in keys:
            index_style = down_style_key
        else:
            index_style = button_key
        insert_index = keys.index(index_style) + 1

         # 插入新项并保留注释和空行
        data.insert(insert_index, swipe_style_key, swipe_style)
    else:
        # 更新已存在的样式
        data[swipe_style_key] = swipe_style
        
    hint_button_key = f"{button}ButtonHintStyle"
    up_hint_style_key = f"{button}ButtonSwipeUpHintForegroundStyle"
    down_hint_style_key = f"{button}ButtonSwipeDownHintForegroundStyle"
    swipe_hint_style_key = up_hint_style_key if direction == "up" else down_hint_style_key
    
    hint_swipe_style = CommentedMap()
    hint_swipe_style.update(label)
    hint_swipe_style.add_yaml_merge([(0, data["sfsymbolHintStyle"])]) if label.get("systemImageName") else hint_swipe_style.add_yaml_merge([(0, data["alphabeticHintStyle"])])

    hint_section = data[hint_button_key] # 26按键划动气泡配置部分
    
    hint_section.update({"swipeUpForegroundStyle": up_hint_style_key, "swipeDownForegroundStyle": down_hint_style_key})


    # 上下划动气泡修改
    if swipe_hint_style_key not in data:
        hint_keys = list(data.keys())
        # 找到合适的位置插入上下划动气泡样式(有上下划就在上下划旁边插，没有就在Button配置旁边)
        if up_hint_style_key in hint_keys:
            index_hint_style = up_hint_style_key
        elif down_hint_style_key in hint_keys:
            index_hint_style = down_hint_style_key
        else:
            index_hint_style = button_key
        hint_insert_index = hint_keys.index(index_hint_style) + 1
        
        # 插入上下划动气泡新项并保留注释和空行
        data.insert(hint_insert_index, swipe_hint_style_key, hint_swipe_style)
    else:
        data[swipe_hint_style_key] = hint_swipe_style
    

    return data

def process_26(data):
    # 处理26按键配置
    # 上划处理
    for button, value in pinyin26_up.items():
        label = value["label"] if value.get("label") else {"text": ""}
        action = value["action"] if value.get("action") else {"symbol": ""}
        data = add_swipes(data, button, "up", action, label)
    # 下划处理
    for button, value in pinyin26_down.items():
        label = value["label"] if value.get("label") else {"text": ""}
        action = value["action"] if value.get("action") else {"symbol": ""}
        data = add_swipes(data, button, "down", action, label)
    return data

def main(file_path):
    # 定义需要处理的文件列表
    process_files = {
        "pinyin_26_portrait.yaml": process_26,
        "pinyin_26_landscape.yaml": process_26
    }

    # 递归遍历目录并处理文件
    for root, _, files in os.walk(file_path):
        for file in files:
            if file not in process_files:
                continue
            
            file_path = os.path.join(root, file)
            print(f"处理文件: {file_path}")
            data = load_file(file_path)
            # 根据文件名选择处理函数
            process_func = process_files[file]
            data = process_func(data)
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
        # dir_list = ["26_Black&White","26_Gradient","26_NewRainbow","26_PartColor","26_Rainbow","26_White&Black","26_Normal","26_Normal_原声"]
        dir_list = ["26_Normal_Default"]
        for son_dir in dir_list:
            source_dir = f"多色合集/{son_dir}"
            main(source_dir)
