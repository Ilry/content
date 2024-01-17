import json
import os


def convert_data(data):
    content = ''
    for item in data:
        content += f'''{{
            x = {item['x']},
            y = {item['y']},
            z = {item['z']},
            layer = {item['layer']},
            rotation = {item['rotation']},
            name = "{item['name']}",
            anim = {('"' + item['anim'] + '"') if 'anim' in item else 'nil' },
            bank = {('"' + item['bank'] + '"') if 'bank' in item else 'nil' },
            prefab = "{item['prefab']}",
            build = "{item['build']}",
            scale = {{{item['scale'][0]}, {item['scale'][1]}, {item['scale'][2]}}}
        }},'''
    return content


def main():
    for file in os.listdir('json'):
        with open(os.path.join('json', file), encoding='utf8') as fin:
            record = json.load(fin)
        with open('scripts/blue_prints/' + file[:-4] + 'lua', 'w', encoding='utf8') as out:
            out.write(f'''
                local record = {{
                    x = {record['x']},
                    y = {record['y']},
                    z = {record['z']},
                    blue_print = true,
                    name = "{record['name']}",
                    data = {{{convert_data(record['data'])}}}
                }};
                return record
            ''')
        print("require 'blue_prints/" + file[:-5] + "',")


if __name__ == '__main__':
    main()
