#!/usr/bin/env python3
"""Python script to write a Python script"""

import sys
import os
import re
import subprocess

args = sys.argv[1:]

if len(args) != 1:
    print('Usage: {} FILE'.format(os.path.basename(sys.argv[0])))
    sys.exit(1)

out_file = args[0]
if not re.search('\.py$', out_file):
    out_file = out_file + '.py'

if os.path.isfile(out_file):
    yn = input('"{}" exists.  Overwrite? [yN] '.format(out_file))
    if not re.match('^[yY]', yn): 
        print('Will not overwrite. Bye!')
        sys.exit()

TEXT = """#!/usr/bin/env python3

import sys
import os

args = sys.argv[1:]

if len(args) != 1:
    print('Usage: {} ARG'.format(os.path.basename(sys.argv[0])))
    sys.exit(1)

arg = args[0]

print('Arg is "{}"'.format(arg))
"""

fh = open(out_file, 'w')
fh.write(TEXT)
subprocess.run(['chmod', '+x', out_file])
print('Done, see new script "{}."'.format(out_file))
