#!/usr/bin/env python3

import sys

args = list(map(float, sys.argv[1:]))
print(str(sum(args) // len(args)))
