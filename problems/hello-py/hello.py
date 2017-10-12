#!/usr/bin/env python3
"""say hello to the arguments"""

import sys
import os

args = sys.argv

if len(args) < 2:
    print('Usage: {} NAME [NAME2 ...]'.format(os.path.basename(args[0])))
    sys.exit(1)

names = args[1:]
num = len(names)
phrase = ''
if num == 1:
    phrase = names[0]
elif num == 2:
    phrase = '{} and {}'.format(names[0], names[1])
else:
    last = names.pop()
    phrase = '{}, and {}'.format(', '.join(names), last)

print('Hello to the {} of you: {}!'.format(num, phrase))
