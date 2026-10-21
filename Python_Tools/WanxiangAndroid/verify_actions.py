from pathlib import Path
import json,time
import _jsonnet,yaml
import argparse
parser=argparse.ArgumentParser(description='Verify Android native icons and keyboard actions across all layouts')
parser.add_argument('--skin', type=Path, default=Path(__file__).resolve().parents[2] / 'Skin_Keyboard/万象-元书/WanxiangSkin-Android')
parser.add_argument('--dump', type=Path, help='Write generated outputs for package verification')
args=parser.parse_args()
root=args.skin.resolve()
start=time.monotonic()
def callback(base,relative):
 p=(Path(base)/relative).resolve();data=p.read_bytes()
 if p==root/'jsonnet/Custom.libsonnet':data=data.replace(b'enable_layout_switcher: false',b'enable_layout_switcher: true')
 return str(p),data
render=json.loads(_jsonnet.evaluate_file(str(root/'jsonnet/main.jsonnet'),import_callback=callback))
assert not (root/'fonts').exists(), 'Custom font files must not be included'
clip={'combine':[{'shortcut':'#readSystemPasteboard'},{'shortcut':'#showPasteboardView'}]}
calc_action={'combine':[{'character':'V'},{'keyboardType':'numeric'}]}
eng_calc_action={'combine':[{'keyboardType':'pinyin'},{'character':'V'},{'keyboardType':'numeric'}]}
legacy=[];bad_date=[];orq=[];remote_refs=[];actions={};missing_refs=[];native_icons=set()
def walk(v,path,keys):
 if isinstance(v,dict):
  for k,x in v.items():
   if k=='shortcutCommand':legacy.append(path)
   if k=='sendKeys' and x=='orc':bad_date.append(path)
   if k=='sendKeys' and x=='orq':orq.append(path)
   if isinstance(x,str):
    assert not any(0xE000 <= ord(c) <= 0xF8FF for c in x), ('Private-use text',path,k)
   if k in ['systemImageName','highlightSystemImageName']:
    assert isinstance(x,str) and x.startswith('material:'),(path,k,x)
    native_icons.add(x[9:])
    if x=='material:settings_remote':remote_refs.append(path)
   if k=='action' and isinstance(x,dict):
    for action in x: actions[action]=actions.get(action,0)+1
   if k in ['backgroundStyle','foregroundStyle'] and isinstance(x,str) and x not in keys:missing_refs.append(path+'.'+k+':'+x)
   walk(x,path+'.'+k,keys)
 elif isinstance(v,list):
  for i,x in enumerate(v):walk(x,path+f'[{i}]',keys)
for path,output in render.items():
 if path=='config.yaml':continue
 data=json.loads(output);walk(data,path,set(data))
 if 'toolbarButtonClipboardStyle' in data: assert data['toolbarButtonClipboardStyle']['action']==clip,path
 for datasource in ['horizontalSymbolsDataSourceLeft','horizontalSymbolsDataSourceRight','horizontalSymbolsDataSourceCenter']:
  for item in data.get(datasource,[]):
   if item.get('styleName')=='toolbarButtonClipboardStyle':assert item['action']==clip,path
   assert item.get('styleName')!='toolbarButtonAppleStyle',path
 if 'toolbarButtonCommandStyle' in data:
  assert data['toolbarButtonCommandStyle']['action']=={'shortcut':'#toggleCommandView'},path
  assert data['toolbarButtonCommandForegroundStyle']['systemImageName']=='material:terminal',path
  assert data['toolbarButtonSymbolsStyle']['action']=={'shortcut':'#toggleSymbolBar'},path
  assert data['toolbarButtonSymbolsForegroundStyle']['systemImageName']=='material:auto_awesome',path
  assert data['toolbarButtonSymbolStyle']['action']=={'keyboardType':'symbolic'},path
  assert data['toolbarButtonSymbolForegroundStyle']['systemImageName']=='material:emoji_symbols',path
 if 'toolbarButton7ForegroundStyle' in data:
  for style,icon in [('toolbarButton7ForegroundStyle','material:search'),('toolbarButtonBingForegroundStyle','material:travel_explore'),('toolbarButtonBaiduForegroundStyle','material:manage_search')]:
   assert data[style]['buttonStyleType']=='systemImage' and data[style]['systemImageName']==icon,(path,style)
  for style,url in [('toolbarButtonGoogleStyle','https://www.google.com/search?q=#pasteboardContent'),('toolbarButtonBingStyle','https://www.bing.com/search?q=#pasteboardContent'),('toolbarButtonBaiduStyle','https://www.baidu.com/s?wd=#pasteboardContent')]:
   assert data[style]['action']=={'openURL':url},(path,style)
 if any(('/'+p+'_') in path for p in ['pinyin_26','pinyin_27','temp_pinyin','ipad_pinyin_26']):
  assert data['zButton']['swipeDownAction']==calc_action,(path,data.get('zButton'))
  assert data['zButtonDownForegroundStyle']['buttonStyleType']=='systemImage',path
  assert data['zButtonDownForegroundStyle']['systemImageName']=='material:calculate',path
 if '/alphabetic_' in path or '/ipad_alphabetic_26_' in path:
  assert data['zButton']['swipeDownAction']==eng_calc_action,(path,data.get('zButton'))
  assert data['zButtonDownForegroundStyle']['buttonStyleType']=='systemImage',path
  assert data['zButtonDownForegroundStyle']['systemImageName']=='material:calculate',path
assert not legacy,legacy
assert not bad_date,bad_date
assert not remote_refs,remote_refs
assert orq
conf=yaml.safe_load(render['config.yaml'])
assert 'fontFace' not in conf
from verify_theme_geometry import verify_theme_geometry
print('PASS: theme geometry parity:',verify_theme_geometry(render),'pairs')
print('PASS:',len(render),'outputs, all six layouts / light+dark / portrait+landscape')
print('PASS: fixed+sliding clipboard actions match; calculator action+glyph; no remote icon usages; no orc/legacy actions')
print('PASS: native Material icons:',len(native_icons),'; no fontFace / PUA / bundled font; date triggers',len(orq))
if args.dump: args.dump.write_text(json.dumps(render))
print('Generated action types:',actions)
print('Seconds:',round(time.monotonic()-start,1))
