#!/usr/bin/env python3
"""docstring"""

import argparse
import os
import sys

# --------------------------------------------------
def get_args():
    """get args"""
    parser = argparse.ArgumentParser(description='Prodigal GFF parser')
    parser.add_argument('gff', metavar='file', help='Prodigal GFF file')
    parser.add_argument('-m', '--min', help='Min score',
                        metavar='float', type=float, default=0)
    return parser.parse_args()

# --------------------------------------------------
def main():
    """main"""
    args = get_args()
    gff_file = args.gff
    min_score = args.min

    if not os.path.isfile(gff_file):
        print('GFF "{}" is not a file'.format(gff_file))
        sys.exit(1)

    flds = 'seqname source feature start end score strand frame attribute'.split()

    for line in open(gff_file):
        if line.startswith('#'):
            continue

        vals = line.rstrip().split('\t')
        rec = dict(zip(flds, vals))
        attrs = {}

        for x in rec['attribute'].split(';'):
            if '=' in x:
                key, value = x.split('=')
                attrs[key] = value

        score = attrs.get('score')
        if score is not None and float(score) >= min_score:
            print('{} {}'.format(rec['seqname'], score))

# --------------------------------------------------
if __name__ == '__main__':
    main()
