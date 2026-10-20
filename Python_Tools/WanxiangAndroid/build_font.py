"""Build a self-contained icon font from exported monochrome symbol masks.
Requires: fonttools, pillow, vtracer. Input: directory produced by export_symbols.swift.
"""
import argparse
import json
import re
import xml.etree.ElementTree as ET
from pathlib import Path

import vtracer
from fontTools.fontBuilder import FontBuilder
from fontTools.pens.cu2quPen import Cu2QuPen
from fontTools.pens.transformPen import TransformPen
from fontTools.pens.ttGlyphPen import TTGlyphPen
from PIL import Image, ImageChops


def build(exported, skin):
    entries = json.loads((exported / 'manifest.json').read_text())
    glyphs, metrics, cmap, mapping = {}, {}, {}, {}
    pen = TTGlyphPen(None)
    glyphs['.notdef'] = pen.glyph()
    metrics['.notdef'] = (1000, 0)
    for index, entry in enumerate(entries):
        name, weight = entry['symbol'], entry['weight']
        png = exported / entry['file']
        svg = png.with_suffix('.svg')
        # Some symbols use semantic system colors; retain their shapes as monochrome masks.
        rgb = Image.open(png).convert('RGB')
        red, green, blue = rgb.split()
        mask = ImageChops.darker(ImageChops.darker(red, green), blue)
        mono = png.with_name(png.stem + '-mask.png')
        mask.save(mono)
        vtracer.convert_image_to_svg_py(
            str(mono), str(svg), colormode='binary', mode='spline',
            filter_speckle=0, corner_threshold=60, length_threshold=2,
            max_iterations=10, splice_threshold=45, path_precision=3,
        )
        root = ET.parse(svg).getroot()
        for element in root.iter():
            transform = element.get('transform', '')
            if transform.startswith('translate('):
                values = re.findall(r'[-+]?[0-9]*\.?[0-9]+', transform)
                tx, ty = values if len(values) == 2 else (values[0], '0')
                element.set('transform', f'matrix(1 0 0 1 {tx} {ty})')
        pen = TTGlyphPen(None)
        factor = 1000 / (entry['pointSize'] * entry['scale'])
        transform = (factor, 0, 0, -factor,
                     -entry['padding'] * factor,
                     entry['height'] * factor / 2 + 375)
        transformed = TransformPen(Cu2QuPen(pen, max_err=0.4, reverse_direction=True), transform)
        from fontTools.svgLib.path import SVGPath
        # SVGPath handles per-path translate() emitted by vtracer.
        SVGPath.fromstring(ET.tostring(root, encoding='unicode')).draw(transformed)
        glyph = pen.glyph()
        assert glyph.numberOfContours > 0, f"Empty symbol: {name}/{weight}"
        glyph_name = f'icon{index:03d}'
        glyph.recalcBounds({glyph_name: glyph})
        advance = round((entry['width'] - 2 * entry['padding']) * factor)
        glyphs[glyph_name] = glyph
        metrics[glyph_name] = (advance, glyph.xMin if glyph.numberOfContours else 0)
        codepoint = 0xE000 + index
        cmap[codepoint] = glyph_name
        mapping.setdefault(name, {})[weight] = chr(codepoint)
    # Calculator is a code-native vector asset, not an unrelated remote-control symbol.
    from fontTools.pens.reverseContourPen import ReverseContourPen
    def rounded_rect(pen, x, y, width, height, radius):
        r = radius
        pen.moveTo((x + r, y))
        pen.lineTo((x + width - r, y))
        pen.qCurveTo((x + width, y), (x + width, y + r))
        pen.lineTo((x + width, y + height - r))
        pen.qCurveTo((x + width, y + height), (x + width - r, y + height))
        pen.lineTo((x + r, y + height))
        pen.qCurveTo((x, y + height), (x, y + height - r))
        pen.lineTo((x, y + r))
        pen.qCurveTo((x, y), (x + r, y))
        pen.closePath()
    if 'calculator' not in mapping:
        for weight in ['regular', 'medium']:
            pen = TTGlyphPen(None)
            stroke = 55 if weight == 'regular' else 65
            rounded_rect(pen, 100, -100, 650, 950, 95)
            rounded_rect(ReverseContourPen(pen), 100 + stroke, -100 + stroke,
                         650 - 2 * stroke, 950 - 2 * stroke, 95 - stroke)
            rounded_rect(pen, 220, 560, 410, 150, 24)
            for x in [220, 380, 540]:
                for y in [60, 225, 390]:
                    rounded_rect(pen, x, y, 90, 90, 18)
            index = len(cmap)
            glyph_name = f'icon{index:03d}'
            built = pen.glyph()
            built.recalcBounds({glyph_name: built})
            glyphs[glyph_name] = built
            metrics[glyph_name] = (850, built.xMin)
            codepoint = 0xE000 + index
            cmap[codepoint] = glyph_name
            mapping.setdefault('calculator', {})[weight] = chr(codepoint)
    font = FontBuilder(1000, isTTF=True)
    font.setupGlyphOrder(list(glyphs))
    font.setupCharacterMap(cmap)
    font.setupGlyf(glyphs)
    font.setupHorizontalMetrics(metrics)
    font.setupHorizontalHeader(ascent=1000, descent=-250, lineGap=0)
    font.setupNameTable({
        'familyName': 'Wanxiang Bundled Icons', 'styleName': 'Regular',
        'uniqueFontIdentifier': 'WanxiangBundledIcons-Test2',
        'fullName': 'Wanxiang Bundled Icons Regular',
        'psName': 'WanxiangBundledIcons-Regular', 'version': 'Version 0.2',
        'description': 'Private test icon subset for the referenced Wanxiang skin. Not a text font.',
    })
    font.setupOS2(sTypoAscender=1000, sTypoDescender=-250, sTypoLineGap=0,
                  usWinAscent=1250, usWinDescent=500, usWeightClass=400)
    font.setupPost()
    font.setupMaxp()
    target = skin / 'fonts'
    target.mkdir(exist_ok=True)
    font.save(target / 'WanxiangIcons.ttf')
    (skin / 'jsonnet/design/bundledIconGlyphs.libsonnet').write_text(
        '// Generated by Python_Tools/WanxiangIcons/build_font.py.\n' +
        json.dumps(mapping, ensure_ascii=True, indent=2) + '\n'
    )
    (target / 'WanxiangIcons-map.json').write_text(json.dumps({
        'firstCodepoint': 0xE000, 'length': len(cmap), 'symbols': mapping,
    }, ensure_ascii=True, indent=2) + '\n')
    print(f'Built {len(mapping)} symbols / {len(cmap)} glyphs')


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('exported', type=Path)
    parser.add_argument('skin', type=Path)
    args = parser.parse_args()
    build(args.exported, args.skin)
