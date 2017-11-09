#!/usr/bin/env python3
"""Mimic seqmagick, print stats on FASTA sequences"""

import os
import sys
from statistics import mean
from Bio import SeqIO

files = sys.argv[1:]

if len(files) < 1:
    print('Usage: {} F1.fa [F2.fa...]'.format(os.path.basename(sys.argv[0])))
    sys.exit(1)

info = []
for file in files:
    lengths = []
    for record in SeqIO.parse(file, "fasta"):
        lengths.append(len(record.seq))

    info.append({'name': os.path.basename(file),
                 'min_len': min(lengths),
                 'max_len': max(lengths),
                 'avg_len': mean(lengths),
                 'num_seqs': len(lengths)})

if len(info):
    longest_file_name = max([len(f['name']) for f in info])
    fmt = '{:' + str(longest_file_name) + '} {:>10} {:>10} {:>10} {:>10}'
    flds = ['name', 'min_len', 'max_len', 'avg_len', 'num_seqs']
    print(fmt.format(*flds))
    for rec in info:
        print(fmt.format(*[rec[fld] for fld in flds]))
else:
    print('I had trouble parsing your data')
