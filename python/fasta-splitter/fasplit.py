#!/usr/bin/env python3
"""split FASTA files"""

import argparse
import os
from Bio import SeqIO

# --------------------------------------------------
def get_args():
    """get args"""
    parser = argparse.ArgumentParser(description='Split FASTA files')
    parser.add_argument('-f', '--fasta', help='FASTA input file',
                        type=str, metavar='FILE', required=True)
    parser.add_argument('-n', '--num', help='Number of records per file',
                        type=int, metavar='NUM', default=50)
    parser.add_argument('-o', '--out_dir', help='Output directory',
                        type=str, metavar='DIR', default='fasplit')
    return parser.parse_args()

# --------------------------------------------------
def main():
    """main"""
    args = get_args()
    fasta = args.fasta
    out_dir = args.out_dir
    max_per = args.num

    if not os.path.isfile(fasta):
        print('--fasta "{}" is not valid'.format(fasta))
        exit(1)

    if not os.path.isdir(out_dir):
        os.mkdir(out_dir)

    if max_per < 1:
        print("--num cannot be less than one")
        exit(1)

    i = 0
    nseq = 0
    nfile = 0
    out_fh = None
    basename, ext = os.path.splitext(os.path.basename(fasta))

    for record in SeqIO.parse(fasta, "fasta"):
        if i == max_per:
            i = 0
            if out_fh is not None:
                out_fh.close()
                out_fh = None

        i += 1
        nseq += 1
        if out_fh is None:
            nfile += 1
            path = os.path.join(out_dir, basename + '.' + str(nfile) + ext)
            out_fh = open(path, 'wt')

        SeqIO.write(record, out_fh, "fasta")

    print('Done, wrote {} sequence{} to {} file{}'.format(
        nseq, '' if nseq == 1 else 's',
        nfile, '' if nfile == 1 else 's'))

# --------------------------------------------------
if __name__ == '__main__':
    main()
