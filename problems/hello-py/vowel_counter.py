#!/usr/bin/env python3
"""count the vowels in a word"""

import sys
import os

args = sys.argv

if len(args) != 2:
    print('Usage: {} STRING'.format(os.path.basename(args[0])))
    sys.exit(1)

word = args[1]

count = 0
for vowel in "aeiou":
    count += word.count(vowel)

#count = sum([word.count(v) for v in "aeiou"])

#count = sum(map(word.count, "aeiou"))

print('There {} {} vowel{} in "{}."'.format(
    'are' if count > 1 or count == 0 else 'is',
    count,
    '' if count == 1 else 's',
    word))
