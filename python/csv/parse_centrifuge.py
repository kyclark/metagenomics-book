#!/usr/bin/env python3

import argparse
import csv
import os
import sys

# --------------------------------------------------
def get_args():
    parser = argparse.ArgumentParser(description='Argparse Python script')
    parser.add_argument('-a', '--arg', help='An argument',
                        type=str, default='foo')
    return parser.parse_args()

# --------------------------------------------------
def main():
    args = get_args()
    arg = args.arg

    if len(arg) < 1:
        print('Missing --arg!')
        sys.exit(1)


    print('Arg is "{}"'.format(arg))

# --------------------------------------------------
if __name__ == '__main__':
    main()
