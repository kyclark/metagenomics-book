#!/usr/bin/env python3
"""docstring"""

import argparse
import os
import re
import sys
from collections import defaultdict

# --------------------------------------------------
def get_args():
    """get args"""
    parser = argparse.ArgumentParser(description='Annotate UProC')
    parser.add_argument('-k', '--kegg_out', help='KEGG out',
                        metavar='str', type=str, default='')
    parser.add_argument('-p', '--pfam_out', help='PFAM out',
                        metavar='str', type=str, default='')
    parser.add_argument('-e', '--kegg_desc', help='KEGG descriptions',
                        metavar='str', type=str, default='')
    parser.add_argument('-f', '--pfam_desc', help='PFAM descriptions',
                        metavar='str', type=str, default='')
    parser.add_argument('-o', '--out', help='Outfile',
                        metavar='str', type=str, default='out')
    return parser.parse_args()

# --------------------------------------------------
def main():
    """main"""
    args = get_args()
    kegg_out = args.kegg_out
    pfam_out = args.pfam_out
    kegg_desc = args.kegg_desc
    pfam_desc = args.pfam_desc
    out_file = args.out

    if not kegg_out and not pfam_out:
        print('Need --kegg_out and/or --pfam_out')
        sys.exit(1)

    if os.path.isfile(out_file):
        answer = input('--out "{}" exists. Overwrite [yN]? '.format(out_file))
        if not answer.lower().startswith('y'):
            print('Not OK, exiting')
            sys.exit(1)

    out_fh = open(out_file, 'w')
    num_written = 0
    num_written += process('kegg', kegg_out, kegg_desc, out_fh)
    num_written += process('pfam', pfam_out, pfam_desc, out_fh)
    print('Done, wrote {} to file "{}."'.format(num_written, out_file))

# --------------------------------------------------
def process(source, uproc_out, desc_file, fh):
    """do all the stuff"""
    if not uproc_out and desc_file:
        return

    id_to_desc = defaultdict(str)
    for line in open(desc_file):
        flds = line.rstrip().split('\t')
        if len(flds) == 2:
            id_to_desc[flds[0]] = flds[1]

    for i, line in enumerate(open(uproc_out)):
        flds = line.rstrip().split(',')
        gene = re.sub(r'\|.*', '', flds[1])
        prot_id = flds[6]
        score = flds[7]
        desc = id_to_desc.get(prot_id, 'NONE')
        fh.write('\t'.join([gene, source, prot_id, desc, score]) + '\n')

    return i + 1

# --------------------------------------------------
if __name__ == '__main__':
    main()
