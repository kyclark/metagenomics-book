#!/usr/bin/env python3
"""Subset FASTA files"""

import argparse
import os
import sys
from Bio import SeqIO

# --------------------------------------------------
def get_args():
    """get args"""
    parser = argparse.ArgumentParser(description='Split FASTA files')
    parser.add_argument('fasta', help='FASTA input file', metavar='FILE')
    parser.add_argument('-n', '--num', help='Number of records per file',
                        type=int, metavar='NUM', default=500000)
    parser.add_argument('-o', '--out_dir', help='Output directory',
                        type=str, metavar='DIR', default='subset')
    return parser.parse_args()

# --------------------------------------------------
def main():
    """main"""
    args = get_args()
    fasta = args.fasta
    out_dir = args.out_dir
    num_seqs = args.num

    if not os.path.isfile(fasta):
        print('--fasta "{}" is not valid'.format(fasta))
        sys.exit(1)

    if os.path.dirname(fasta) == out_dir:
        print('--outdir cannot be the same as input files')
        sys.exit(1)

    if num_seqs < 1:
        print("--num cannot be less than one")
        sys.exit(1)

    if not os.path.isdir(out_dir):
        os.mkdir(out_dir)

    basename = os.path.basename(fasta)
    out_file = os.path.join(out_dir, basename)
    out_fh = open(out_file, 'wt')
    num_written = 0

    for record in SeqIO.parse(fasta, "fasta"):
        SeqIO.write(record, out_fh, "fasta")
        num_written += 1

        if num_written == num_seqs:
            break

    print('Done, wrote {} sequence{} to "{}"'.format(
        num_written, '' if num_written == 1 else 's', out_file))

# --------------------------------------------------
if __name__ == '__main__':
    main()
