#!/usr/bin/env python3
"""Python script to write a Python script"""

import argparse
import sys
import os
import re
import subprocess

# --------------------------------------------------
def get_args():
    """get arguments"""
    parser = argparse.ArgumentParser(
        description='Create Python script',
        formatter_class=argparse.ArgumentDefaultsHelpFormatter)

    parser.add_argument('program',
                        help='Program name',
                        type=str)

    parser.add_argument('-a', '--argparse',
                        help='Use argparse',
                        dest='use_argparse',
                        action='store_true')

    parser.add_argument('-f', '--force',
                        help='Overwrite existing',
                        dest='overwrite',
                        action='store_true')
    return parser.parse_args()

# --------------------------------------------------
def main():
    """main"""
    args = get_args()
    out_file = args.program

    if len(out_file.strip()) < 1:
        print('Not a usable filename "{}"'.format(out_file))
        sys.exit(1)

    out_file = re.sub(r'-', r'_', out_file)
    if not re.search(r'\.py$', out_file):
        out_file = out_file + '.py'

    if os.path.isfile(out_file) and not args.overwrite:
        answer = input('"{}" exists.  Overwrite? [yN] '.format(out_file))
        if not re.match('^[yY]', answer):
            print('Will not overwrite. Bye!')
            sys.exit()

    out_fh = open(out_file, 'w')
    text = ARGPARSE if args.use_argparse else SIMPLE
    out_fh.write(text)
    subprocess.run(['chmod', '+x', out_file])
    print('Done, see new script "{}."'.format(out_file))


# --------------------------------------------------
SIMPLE = """#!/usr/bin/env python3
\"\"\"docstring\"\"\"

import os
import sys

args = sys.argv[1:]

if len(args) != 1:
    print('Usage: {} ARG'.format(os.path.basename(sys.argv[0])))
    sys.exit(1)

arg = args[0]

print('Arg is "{}"'.format(arg))
"""

# --------------------------------------------------
ARGPARSE = """#!/usr/bin/env python3
\"\"\"docstring\"\"\"

import argparse
import sys

# --------------------------------------------------
def get_args():
    \"\"\"get args\"\"\"
    parser = argparse.ArgumentParser(
        description='Argparse Python script',
        formatter_class=argparse.ArgumentDefaultsHelpFormatter)

    parser.add_argument('positional',
                        metavar='str',
                        help='A positional argument')

    parser.add_argument('-a', '--arg',
                        help='A named string argument',
                        metavar='str',
                        type=str,
                        default='')

    parser.add_argument('-i', '--int',
                        help='A named integer argument',
                        metavar='int',
                        type=int,
                        default=0)

    parser.add_argument('-f', '--flag',
                        help='A boolean flag',
                        action='store_true')

    return parser.parse_args()

# --------------------------------------------------
def warn(msg):
    \"\"\"Print a message to STDERR\"\"\"
    print(msg, file=sys.stderr)

# --------------------------------------------------
def die(msg='Something bad happened'):
    \"\"\"warn() and exit with error\"\"\"
    warn(msg)
    sys.exit(1)

# --------------------------------------------------
def main():
    \"\"\"main\"\"\"
    args = get_args()
    str_arg = args.arg
    int_arg = args.int
    flag_arg = args.flag
    pos_arg = args.positional

    print('str_arg = "{}"'.format(str_arg))
    print('int_arg = "{}"'.format(int_arg))
    print('flag_arg = "{}"'.format(flag_arg))
    print('positional = "{}"'.format(pos_arg))

# --------------------------------------------------
if __name__ == '__main__':
    main()
"""

# --------------------------------------------------
if __name__ == '__main__':
    main()
