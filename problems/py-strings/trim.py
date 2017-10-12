#!/usr/bin/env python3
"""Trim sequences to a set length"""

import os
import sys

args = sys.argv[1:]

if len(args) < 1:
    print('Usage: {} SEQ [LEN]'.format(os.path.basename(sys.argv[0])))
    sys.exit(1)

arg = args[0]

seq_len = 5
if len(args) == 2:
    if not args[1].isdigit():
        print('"{}" is not a digit'.format(args[1]))
        sys.exit(1)

    seq_len = int(args[1])

seqs = open(arg) if os.path.isfile(arg) else [arg]

for seq in seqs:
    print(seq[:seq_len])
