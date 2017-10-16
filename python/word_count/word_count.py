#!/usr/bin/env python3

import os
import re
import sys
from collections import defaultdict
from itertools import permutations
from math import log

files = sys.argv[1:]
min_len = 3

if len(files) < 2:
    msg = 'Usage: {} FILE1 FILE2 [FILE3...]'
    print(msg.format(os.path.basename(sys.argv[0])))
    sys.exit(1)

regex = re.compile('[^a-zA-Z]')
count_by_file = {}
for file in files:
    if not os.path.isfile(file):
        print('"{}" is not a file'.format(file))
        continue

    basename = os.path.basename(file)
    count = defaultdict(int)
    for line in open(file):
        words = [regex.sub('', w) for w in line.lower().split()]
        for word in words:
            if len(word) >= min_len:
                count[word] += 1
    count_by_file[basename] = count

filenames = count_by_file.keys()
totals = dict([(f, sum(count_by_file[f].values())) for f in filenames])

combos = permutations(filenames, 2)
for f1, f2 in combos:
    w1 = set(count_by_file[f1].keys())
    w2 = set(count_by_file[f2].keys())
    tot = totals[f1]
    if tot > 0:
        common = w1.intersection(w2)
        common_freq = sum(count_by_file[f1][w] for w in common)
        pct = common_freq / tot * 100
        print('{:6.02f}% [{:.02f}] {} -> {}'.format(pct, log(pct), f1, f2))
