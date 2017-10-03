#!/usr/bin/env python3
"""Tetra-nucleotide counter"""

import sys
import os

args = sys.argv

if len(args) != 2:
    print('Usage: {} DNA'.format(os.path.basename(args[0])))
    sys.exit(1)

dna = args[1]

count = {}

for base in dna.lower():
    if not base in count:
        count[base] = 0

    count[base] += 1

counts = []
for base in "acgt":
    num = count[base] if base in count else 0
    counts.append(str(num))

print(' '.join(counts))
