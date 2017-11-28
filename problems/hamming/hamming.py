#!/usr/bin/env python3
"""docstring"""

import os
import sys

args = sys.argv[1:]

if len(args) != 2:
    print('Usage: {} S1 S2'.format(os.path.basename(sys.argv[0])))
    sys.exit(1)

s1, s2 = args[0], args[1]
hamm = abs(len(s1) - len(s2))

for i in range(min(len(s1), len(s2))):
    if s1[i] != s2[i]:
        hamm += 1

for c1, c2 in zip(s1, s2):
    if c1 != c2:
        hamm += 1

print(hamm)
