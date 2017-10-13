#!/usr/bin/env python3
"""Print GC content of a given sequence"""

import os
import sys

args = sys.argv[1:]

if len(args) != 1:
    print('Usage: {} SEQUENCE'.format(os.path.basename(sys.argv[0])))
    sys.exit(1)

seq = args[0]
seq_len = len(seq)

if seq_len < 1:
    print('No sequence!')
    sys.exit(1)

gc = 0
for char in seq.lower():
    #if char == 'g' or char == 'c':
    if char in 'gc':
        gc += 1

print('{}% GC'.format(int(gc/seq_len * 100)))
