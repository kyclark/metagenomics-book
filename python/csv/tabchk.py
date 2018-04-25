#!/usr/bin/env python3

import argparse
import csv
import os
import sys

# --------------------------------------------------
def get_args():
    parser = argparse.ArgumentParser(description='Check a delimited text file')
    parser.add_argument('file', metavar='str', help='File')
    parser.add_argument('-s', '--sep', help='Field separator',
                        metavar='str', type=str, default='\t')
    parser.add_argument('-l', '--limit', help='How many records to show',
                        metavar='int', type=int, default=1)
    parser.add_argument('-d', '--dense', help='Not sparse (skip empty fields)',
                        action='store_true')
    parser.add_argument('-n', '--number', 
                        help='Show field number (e.g., for awk)',
                        action='store_true')
    return parser.parse_args()

# --------------------------------------------------
def main():
    args = get_args()
    file = args.file
    limit = args.limit
    sep = args.sep
    dense = args.dense
    show_numbers = args.number

    if not os.path.isfile(file):
        print('"{}" is not a file'.format(file))
        sys.exit(1)

    with open(file) as csvfile:
        reader = csv.DictReader(csvfile, delimiter=sep)

        for i, row in enumerate(reader):
            vals = dict([x for x in row.items() if x[1] != '']) if dense else row
            flds = vals.keys()
            longest = max(map(len, flds))
            fmt = '{:' + str(longest + 1) + '}: {}'
            print('// ****** Record {} ****** //'.format(i+1))
            n = 0
            for key, val in vals.items():
                n += 1
                show = fmt.format(key, val)
                if show_numbers:
                    print('{:3} {}'.format(n, show))
                else:
                    print(show)

            if i + 1 == limit:
                break

# --------------------------------------------------
if __name__ == '__main__':
    main()
