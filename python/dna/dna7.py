#!/usr/bin/env python3
"""Tetra-nucleotide counter"""

import sys
import os
from collections import defaultdict

args = sys.argv

if len(args) != 2:
    print('Usage: {} DNA'.format(os.path.basename(args[0])))
    sys.exit(1)

dna = args[1]

count = defaultdict(int)

for base in dna.lower():
    count[base] += 1

print(' '.join(map(lambda b: str(count[b]), "acgt")))
