from pathlib import Path
import json,time
import _jsonnet,yaml
from fontTools.ttLib import TTFont
import argparse
parser=argparse.ArgumentParser(description='Verify bundled icons and keyboard action wiring across all layouts')
parser.add_argument('--skin', type=Path, default=Path(__file__).resolve().parents[2] / 'Skin_Keyboard/万象-元书/WanxiangSkin-Android')
args=parser.parse_args()
root=args.skin.resolve()
start=time.monotonic()
def callback(base,relative):
 p=(Path(base)/relative).resolve();data=p.read_bytes()
 if p==root/'jsonnet/Custom.libsonnet':data=data.replace(b'enable_layout_switcher: false',b'enable_layout_switcher: true')
 return str(p),data
render=json.loads(_jsonnet.evaluate_file(str(root/'jsonnet/main.jsonnet'),import_callback=callback))
mapdata=json.loads((root/'fonts/WanxiangIcons-map.json').read_text())
font=TTFont(root/'fonts/WanxiangIcons.ttf');cmap=font.getBestCmap()
assert len(cmap)==166 and all(font['glyf'][g].numberOfContours>0 for g in cmap.values())
assert set(cmap)==set(range(0xE000,0xE000+166))
calc=mapdata['symbols']['calculator']['regular'];remote=set(mapdata['symbols']['av.remote.fill'].values())
clip={'combine':[{'shortcut':'#readSystemPasteboard'},{'shortcut':'#showPasteboardView'}]}
calc_action={'combine':[{'character':'V'},{'keyboardType':'numeric'}]}
eng_calc_action={'combine':[{'keyboardType':'pinyin'},{'character':'V'},{'keyboardType':'numeric'}]}
legacy=[];bad_date=[];orq=[];remote_refs=[];actions={};missing_refs=[]
def walk(v,path,keys):
 if isinstance(v,dict):
  for k,x in v.items():
   if k=='shortcutCommand':legacy.append(path)
   if k=='sendKeys' and x=='orc':bad_date.append(path)
   if k=='sendKeys' and x=='orq':orq.append(path)
   if k=='text' and isinstance(x,str) and x in remote:remote_refs.append(path)
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
 if any(('/'+p+'_') in path for p in ['pinyin_26','pinyin_27','temp_pinyin','ipad_pinyin_26']):
  assert data['zButton']['swipeDownAction']==calc_action,(path,data.get('zButton'))
  assert data['zButtonDownForegroundStyle']['text']==calc,path
 if '/alphabetic_' in path or '/ipad_alphabetic_26_' in path:
  assert data['zButton']['swipeDownAction']==eng_calc_action,(path,data.get('zButton'))
  assert data['zButtonDownForegroundStyle']['text']==calc,path
assert not legacy,legacy
assert not bad_date,bad_date
assert not remote_refs,remote_refs
assert orq
conf=yaml.safe_load(render['config.yaml'])
assert conf['fontFace'][0]['ranges'][0]['length']==166
from verify_theme_geometry import verify_theme_geometry
print('PASS: theme geometry parity:',verify_theme_geometry(render),'pairs')
print('PASS:',len(render),'outputs, all six layouts / light+dark / portrait+landscape')
print('PASS: fixed+sliding clipboard actions match; calculator action+glyph; no remote icon usages; no orc/legacy actions')
print('PASS: font 166 valid PUA glyphs; date triggers',len(orq))
print('Generated action types:',actions)
print('Seconds:',round(time.monotonic()-start,1))
