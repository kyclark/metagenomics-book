#!/usr/bin/env python3
"""Report if the given word is a palindrome"""

import sys
import os

args = sys.argv

if len(args) != 2:
    print('Usage: {} FILE'.format(os.path.basename(args[0])))
    sys.exit(1)

file = args[1]

if not os.path.isfile(file):
    print('"{}" is not a file'.format(file))
    sys.exit(1)

for line in open(file):
    for word in line.split():
        if len(word) > 1:
            rev = ''.join(list(reversed(word)))
            if rev == word:
                print(word)
