#!/usr/bin/env python3
"""WanxiangSkin 分进程构建脚本。

`jsonnet jsonnet/main.jsonnet` 需要一次性把全部输出留在内存里；六套中文布局全部产出后
（57 个文件）在内存受限环境会触发 "a memory allocation error occurred"。
本脚本把输出按键盘族分组，每组单独跑一个 jsonnet 进程，逐组落盘，内存占用与单键盘相当。

用法：
    python3 build_split.py            # 生成 light/ dark/ 与 config.yaml
    python3 build_split.py --check    # 只跑 config，快速验证语法

与 main.jsonnet 的输出完全一致（同样的表达式，只是分进程求值）。
"""
import json
import os
import shutil
import subprocess
import sys
import tempfile
import time

SKIN = os.path.dirname(os.path.abspath(__file__))

# (组名, 模块路径, 输出前缀, layoutOverride)
GROUPS = [
    ("layoutSwitch", "jsonnet/keyboards/layoutSwitch/keyboard.libsonnet", "keyboard_switcher", None),
    ("pinyin9", "jsonnet/keyboards/pinyin9/keyboard.libsonnet", "pinyin_9", 9),
    ("pinyin14", "jsonnet/keyboards/pinyinGrouped/pinyin14/keyboard.libsonnet", "pinyin_14", 14),
    ("pinyin17", "jsonnet/keyboards/pinyinGrouped/pinyin17/keyboard.libsonnet", "pinyin_17", 17),
    ("pinyin18", "jsonnet/keyboards/pinyinGrouped/pinyin18/keyboard.libsonnet", "pinyin_18", 18),
    ("pinyin26", "jsonnet/keyboards/keyboard26/pinyin/keyboard.libsonnet", "pinyin_26", 26),
    ("pinyin27", "jsonnet/keyboards/keyboard26/pinyin/keyboard.libsonnet", "pinyin_27", 27),
    ("tempPinyin", "jsonnet/keyboards/keyboard26/tempPinyin/keyboard.libsonnet", "temp_pinyin", None),
    ("iPadPinyin", "jsonnet/keyboards/keyboard26/pinyin/iPad.libsonnet", "ipad_pinyin_26", None),
    ("alphabetic", "jsonnet/keyboards/keyboard26/alphabetic/keyboard.libsonnet", "alphabetic_26", None),
    ("iPadAlphabetic", "jsonnet/keyboards/keyboard26/alphabetic/iPad.libsonnet", "ipad_alphabetic_26", None),
    ("numeric", "jsonnet/keyboards/numeric9/keyboard.libsonnet", "numeric_9", None),
    ("iPadNumeric", "jsonnet/keyboards/numeric9/iPad.libsonnet", "ipad_numeric_9", None),
    ("panel", "jsonnet/keyboards/floatPanel/keyboard.libsonnet", "panel", None),
]

CONFIG_SOURCE = (
    "local config = import 'jsonnet/build/skinConfig.libsonnet';\n"
    "{ 'config.yaml': std.manifestYamlDoc(config, indent_array_in_object=true, quote_keys=false) }\n"
)


def group_source(module, prefix, layout):
    call = (
        "module.new(theme, orientation, %d)" % layout
        if layout is not None
        else "module.new(theme, orientation)"
    )
    return (
        "local module = import '%s';\n"
        "local themes = ['light', 'dark'];\n"
        "local orientations = ['portrait', 'landscape'];\n"
        "{\n"
        "  [theme + '/%s_' + orientation + '.yaml']: std.toString(%s)\n"
        "  for theme in themes\n"
        "  for orientation in orientations\n"
        "}\n" % (module, prefix, call)
    )


def run(name, source, workdir):
    # jsonnet 的相对 import 基于源文件所在目录，临时文件必须落在皮肤根目录。
    src = os.path.join(SKIN, "_grp_%s.jsonnet" % name)
    out = os.path.join(workdir, name + ".json")
    with open(src, "w", encoding="utf-8") as f:
        f.write(source)
    started = time.time()
    proc = subprocess.run(
        ["jsonnet", "-o", out, src],
        cwd=SKIN,
        capture_output=True,
        text=True,
        timeout=3600,
    )
    os.remove(src)
    if proc.returncode != 0:
        sys.stderr.write("FAIL %s\n%s\n" % (name, proc.stderr))
        sys.exit(1)
    with open(out, encoding="utf-8") as f:
        data = json.load(f)
    print("ok  %-16s %6.1fs  %d files" % (name, time.time() - started, len(data)))
    return data


def main():
    workdir = tempfile.mkdtemp(prefix="wanxiangskin_build_")
    groups = [("config", CONFIG_SOURCE)]
    if "--check" not in sys.argv:
        groups += [(n, group_source(m, p, l)) for n, m, p, l in GROUPS]

    merged = {}
    try:
        for name, source in groups:
            merged.update(run(name, source, workdir))
    finally:
        shutil.rmtree(workdir, ignore_errors=True)

    for rel, text in sorted(merged.items()):
        path = os.path.join(SKIN, rel)
        os.makedirs(os.path.dirname(path) or SKIN, exist_ok=True)
        with open(path, "w", encoding="utf-8") as f:
            f.write(text)

    print("written %d files into %s" % (len(merged), SKIN))


if __name__ == "__main__":
    main()
