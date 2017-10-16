#!/usr/bin/env python3

import os
import re
import sys
from collections import defaultdict
from itertools import combinations

files = sys.argv[1:]
min_len = 3

if len(files) != 2:
    msg = 'Usage: {} FILE1 FILE2'
    print(msg.format(os.path.basename(sys.argv[0])))
    sys.exit(1)

regex = re.compile('[^a-zA-Z]')
words_by_file = []
for file in files:
    if not os.path.isfile(file):
        print('"{}" is not a file'.format(file))
        continue

    basename = os.path.basename(file)
    words_set = set()
    for line in open(file):
        words = [regex.sub('', w) for w in line.lower().split()]
        for word in words:
            if len(word) >= min_len:
                words_set.add(word)

    words_by_file.append((basename, words_set))

(file1, words1), (file2, words2) = words_by_file
common = words1.intersection(words2)
num_common = len(common)
msg = 'There are {} word{} in common between {} and {}'
print(msg.format(num_common, '' if num_common == 1 else 's', file1, file2))
if num_common > 0:
    print('\n'.join(sorted(common)))
