#!/usr/bin/env python3
"""Print GC content of a given sequence"""

import os
import sys

args = sys.argv[1:]

if len(args) != 1:
    print('Usage: {} SEQUENCE'.format(os.path.basename(sys.argv[0])))
    sys.exit(1)

filename = args[0]

if not os.path.isfile(filename):
    print('"{}" is not a file'.format(filename))
    sys.exit(1)

for seq in open(filename):
    seq_len = len(seq.rstrip())

    if seq_len < 1:
        continue

    gc = 0
    for char in seq.lower():
        if char == 'g' or char == 'c':
            gc += 1

    print('{}'.format(int(gc/seq_len * 100)))
