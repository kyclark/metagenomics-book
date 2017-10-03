#!/usr/bin/env python3
"""Tetra-nucleotide counter"""

import sys
import os

args = sys.argv

if len(args) != 2:
    print('Usage: {} DNA'.format(os.path.basename(args[0])))
    sys.exit(1)

dna = args[1]

count = {'a': 0, 'c': 0, 'g': 0, 't': 0}

for base in dna.lower():
    if base in count:
        count[base] += 1

counts = []
for base in "acgt":
    counts.append(str(count[base]))

print(' '.join(counts))
