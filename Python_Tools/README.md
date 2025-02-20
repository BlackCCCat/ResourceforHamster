# Python Tools
用Python简化皮肤功能修改流程（仅针对该repo中的皮肤）
脚本修改自[xubai2001](https://github.com/xubai2001)，仅用于本项目下的皮肤修改
## 使用说明
- 划动、长按：用于修改中文输入26个按键的上下划动输入内容
- en划动、en长按：用于修改英文输入26个按键的上下划动输入内容

## 使用方法
需先安装`ruamel.yaml`：
```bash
pip install ruamel.yaml
```
### 传入参数调用
```bash
python 划动.py 皮肤文件路径
```
如：
将`.hskin`文件解压后得到名为`26_Rainbow`的文件夹且和`划动.py`在同一目录下，则
```bash
python 划动.py 26_Rainbow
```
### 直接运行
将需要修改的文件夹和脚本放在同一目录下，并将脚本中的`source_dir`为需要修改的文件夹名，然后运行脚本