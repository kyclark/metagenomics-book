#!/usr/bin/env python3

import os
import sys
import re

args = sys.argv[1:]
fh = None

if len(args) == 0:
    fh = sys.stdin
elif len(args) == 1:
    file = args[0]
    if os.path.isfile(file):
        fh = open(file, 'rt')
    else:
        print('"{}" is not a file'.format(file))
        sys.exit(1)
else:
    print('Usage: {} <stdin|file>'.format(os.path.basename(args[0])))

dir_re = re.compile('^(\/[^:]+)')
coll_re = re.compile('^\s{2}C-\s+')
file_re = re.compile('^\s{2}([^/]+)')

dir = ''
for line in fh:
    line = line.rstrip()
    dir_match = dir_re.search(line)
    coll_match = coll_re.search(line)
    file_match = file_re.search(line)

    if dir_match:
        dir = dir_match.groups()[0]
    elif coll_match:
        continue
    elif file_match and dir:
        filename = file_match.groups()[0]
        print(os.path.join(dir, filename))
