#!/usr/bin/env python3
"""docstring"""

import os
import sys

args = sys.argv[1:]

if len(args) != 1:
    print('Usage: {} RNA'.format(os.path.basename(sys.argv[0])))
    sys.exit(1)

rna = args[0]

print('RNA is "{}"'.format(rna))

codon_table = dict()

for line in open('codons.rna'):
    codon, prot = line.rstrip().split()
    codon_table[codon] = prot

print(codon_table)

k = 3
for codon in [rna[i:i+k] for i in range(0, len(rna), k)]:
    print(codon)
