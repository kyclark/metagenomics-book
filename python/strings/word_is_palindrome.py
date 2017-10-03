#!/usr/bin/env python3
"""Report if the given word is a palindrome"""

import sys
import os

args = sys.argv

if len(args) != 2:
    print('Usage: {} STR'.format(os.path.basename(args[0])))
    sys.exit(1)

word = args[1]
rev = ''.join(list(reversed(word)))
print('"{}" is{} a palindrome.'.format(word, '' if word == rev else ' NOT'))
