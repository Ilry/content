from xml.etree import ElementTree
import os

def load_languages():
    with open('chinese_s.po', encoding='utf8') as fin:
        content = fin.read()
    content = content[content.index('\n\n\n') + 3:]
    items = content.split('\n\n')[1:]
    d = {}
    for item in items:
        ds = item.split('\n')
        if len(ds) != 4:
            continue
        t, _, _, s = ds
        t = t[3:]
        s = s[8:-1]
        d[t] = s
    return d


def main():
    lang = load_languages()
    filenames = ['inventoryimages1.xml', 'inventoryimages2.xml', 'inventoryimages3.xml', 'avatars.xml']
    content = 'local images = {\n'
    for filename in filenames:
        elements = ElementTree.parse(filename).find('Elements')
        for element in elements:
            key = element.attrib['name']
            if key.endswith('.tex'):
                key = key[:-4]
            name = lang.get('STRINGS.NAMES.' + key.upper(), None) or lang.get('STRINGS.SKIN_NAMES.' + key, key)
            content += f'\t{{ name = "{name}", key = "{key}", ' \
                       f'atlas = "images/{filename}", image = "{element.attrib["name"]}" }},\n'
    content += '}\nreturn images'
    root = '../scripts/utils'
    os.makedirs(root, exist_ok=True)
    with open(os.path.join(root, 'images.lua'), 'w', encoding='utf8') as out:
        out.write(content)


if __name__ == '__main__':
    main()
