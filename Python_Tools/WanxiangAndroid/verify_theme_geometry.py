"""Check that paired themes differ only in color properties, including nested states."""
import argparse
import json
from pathlib import Path


def verify_theme_geometry(outputs):
    def normalized(value):
        if isinstance(value, dict):
            return {key: normalized(item) for key, item in value.items()
                    if not key.endswith('Color')}
        if isinstance(value, list):
            return [normalized(item) for item in value]
        return value

    checked = 0
    for name, content in outputs.items():
        if not name.startswith('light/'):
            continue
        dark = 'dark/' + name[len('light/'):]
        assert dark in outputs, f'Missing dark theme: {name}'
        light_data = json.loads(content)
        dark_data = json.loads(outputs[dark])
        assert normalized(light_data) == normalized(dark_data), \
            f'Themes differ outside color properties: {name}'
        checked += 1
    assert checked, 'No theme pairs found'
    return checked


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('rendered_outputs', type=Path)
    args = parser.parse_args()
    count = verify_theme_geometry(json.loads(args.rendered_outputs.read_text()))
    print(f'PASS: {count} theme pairs have identical layout, dimensions, insets, actions and fonts')
