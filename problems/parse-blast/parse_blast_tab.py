#!/usr/bin/env python3
"""docstring"""

import argparse
import sys

# --------------------------------------------------
def get_args():
    """get args"""
    parser = argparse.ArgumentParser(description='Argparse Python script')
    parser.add_argument('positional', metavar='str', help='A positional argument')
    parser.add_argument('-a', '--arg', help='A named string argument',
                        metavar='str', type=str, default='')
    parser.add_argument('-i', '--int', help='A named integer argument',
                        metavar='int', type=int, default=0)
    parser.add_argument('-f', '--flag', help='A boolean flag', 
                        action='store_true')
    return parser.parse_args()

# --------------------------------------------------
def main():
    """main"""
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
