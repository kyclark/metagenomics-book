#!/usr/bin/env python3

import argparse
import csv
import os
import sys

# --------------------------------------------------
def get_args():
    parser = argparse.ArgumentParser(description='Parse Prodigal GFF')
    parser.add_argument('gff', metavar='GFF', help='Prodigal GFF output')
    parser.add_argument('-m', '--min', help='Minimum score',
                        metavar='float', type=float, default=0.0)
    return parser.parse_args()

# --------------------------------------------------
def main():
    args = get_args()
    gff_file = args.gff
    min_score = args.min
    flds = 'seqname source feature start end score strand frame attribute'.split()

    for line in open(gff_file):
        if line[0] == '#':
            continue

        row = dict(zip(flds, line.split('\t')))
        attrs = {}
        if 'attribute' in row:
            for fld in row['attribute'].split(';'):
                if '=' in fld:
                    name, val = fld.split('=')
                    attrs[name] = val

        if 'score' in attrs and float(attrs['score']) > min_score:
            print(row)
            break

# --------------------------------------------------
if __name__ == '__main__':
    main()
