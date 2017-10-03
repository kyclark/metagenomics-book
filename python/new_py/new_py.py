#!/usr/bin/env python3
"""Python script to write a Python script"""

import argparse
import sys
import os
import re
import subprocess

# --------------------------------------------------
SIMPLE = """#!/usr/bin/env python3

import os
import sys

args = sys.argv

if len(args) != 2:
    print('Usage: {} ARG'.format(os.path.basename(args[0])))
    sys.exit(1)

arg = args[1]

print('Arg is "{}"'.format(arg))
"""

# --------------------------------------------------
ARGPARSE = """#!/usr/bin/env python3

import argparse
import os
import sys

def get_args():
    parser = argparse.ArgumentParser(description='Argparse Python script')
    parser.add_argument('-a', '--arg', help='An argument',
                        type=str, default='foo')
    return parser.parse_args()

def main():
    args = get_args()
    arg = args.arg

    if len(arg) < 1:
        print('Missing --arg!')
        sys.exit(1)


    print('Arg is "{}"'.format(arg))

if __name__ == '__main__':
    main()
"""

# --------------------------------------------------
def main():
    args = get_args()
    out_file = args.program

    if len(out_file) < 1:
        print('Usage: {} FILE'.format(os.path.basename(args[0])))
        sys.exit(1)

    if not re.search('\.py$', out_file):
        out_file = out_file + '.py'

    if os.path.isfile(out_file):
        yn = input('"{}" exists.  Overwrite? [yN] '.format(out_file))
        if not re.match('^[yY]', yn):
            print('Will not overwrite. Bye!')
            sys.exit()

    fh = open(out_file, 'w')
    text = ARGPARSE if args.use_argparse else SIMPLE
    fh.write(text)
    subprocess.run(['chmod', '+x', out_file])
    print('Done, see new script "{}."'.format(out_file))

# --------------------------------------------------
def get_args():
    """get arguments"""
    parser = argparse.ArgumentParser(description='Create Python script')
    parser.add_argument('program', help='Program name', type=str)
    parser.add_argument('-a', '--argparse', help='Use argparse',
                        dest='use_argparse', action='store_true')
    return parser.parse_args()

# --------------------------------------------------
if __name__ == '__main__':
    main()
