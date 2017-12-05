#!/usr/bin/env python3

import os
import sys
#from collections import defaultdict

args=sys.argv[1:]
if len(args) < 2:
    print("Usage: requires two strings")
    sys.exit(1)

s=args[0]
t=args[1]
counts=[]

for letter in range(len(s)):
    if s[letter:letter+len(t)] == t: #look at each t length segment
        counts.append(letter+1) #add 1 to account for offset

if counts:
    print(*counts, sep=' ')
else:
    print('Not found')
