#!/usr/bin/env python3
"""Probabalistically subset FASTQ"""

import argparse
import os
import sys
from random import randint
from Bio import SeqIO

# --------------------------------------------------
def get_args():
    """get args"""
    parser = argparse.ArgumentParser(description='Randomly subset FASTQ')
    parser.add_argument('fastq', metavar='FASTQ', help='FASTQ file')
    parser.add_argument('-p', '--pct', help='Percent of reads (%(default)s)',
                        metavar='int', type=int, default=50)
    parser.add_argument('-f', '--format', help='Output format (%(default)s)',
                        metavar='FORMAT', type=str, default='fastq')
    parser.add_argument('-o', '--outfile', help='Output file',
                        metavar='FILE', type=str, default='')
    return parser.parse_args()

# --------------------------------------------------
def main():
    """main"""
    args = get_args()
    fastq = args.fastq
    pct = args.pct
    out_file = args.outfile
    out_format = args.format
    min_num = 0
    max_num = 100

    if not min_num < pct < max_num:
        print('--pct "{}" must be between {} and {}'.format(pct,
                                                            min_num,
                                                            max_num))
        sys.exit(1)

    ok_format = set(['fastq', 'fasta'])
    if out_format not in ok_format:
        print('--format ({}) must one of {}'.format(out_format,
                                                    ', '.join(ok_format)))
        sys.exit(1)

    if len(out_file) == 0:
        base, _ = os.path.splitext(fastq)
        out_file = base + '.sub.' + out_format

    out_fh = open(out_file, 'w')
    num_taken = 0
    total_num = 0

    with open(fastq) as fh:
        for rec in SeqIO.parse(fh, "fastq"):
            total_num += 1
            if randint(min_num, max_num) <= pct:
                num_taken += 1
                SeqIO.write(rec, out_fh, out_format)

    print('Wrote {} of {} ({:.02f}%) to "{}"'.format(num_taken,
                                                     total_num,
                                                     num_taken/total_num * 100,
                                                     out_file))

# --------------------------------------------------
if __name__ == '__main__':
    main()
