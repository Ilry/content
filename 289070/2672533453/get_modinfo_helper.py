# By Deeplogic
# Fetch the id and title from modinfo automatically
# run by `python get_modinfo_helper.py` in the folder contains mods.

import glob
from xml.dom.minidom import parse

ENG_TEXT_KEY = 'en_US'

def main():
    for g in glob.glob('*/*.modinfo'):
        # print('Processing {}'.format(g))
        DOMTree  = parse(g)
        collection = DOMTree.documentElement
        # print(collection.getAttribute('id'))
        ind = collection.getAttribute('id')
        poperty = collection.getElementsByTagName('Properties')[0]
        nameNode = poperty.getElementsByTagName('Name')[0]
        # print(name.childNodes[0].data)
        name = nameNode.childNodes[0].data
        new_tag = '"LOC_MTL_456789abcdefghijklmnopq_NAME"'
        print('    ("LOC_' + ind.replace('-', '') + '",  ' + new_tag + '),')
        print('    (' + new_tag + ',  "' + name + '"),')

if __name__ == '__main__':
    main()
