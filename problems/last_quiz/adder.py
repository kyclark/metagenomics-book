#!/usr/bin/env python3
"""docstring"""

import os
import sys

args = sys.argv[1:]

if len(args) != 2:
    print('Usage: {} ARG1 ARG2'.format(os.path.basename(sys.argv[0])))
    sys.exit(1)

arg1, arg2 = args[0], args[1]

if arg1.isdigit() and arg2.isdigit():
    print(int(arg1) + int(arg2))
elif arg1.isalpha() and arg2.isalpha():
    print(arg1 + ' and ' + arg2)
    #print(' and '.join([arg1, arg2]))
else:
    print("I'll do anything for love, but I won't do that.")
    sys.exit(1)
