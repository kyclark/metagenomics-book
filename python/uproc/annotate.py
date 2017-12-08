#!/usr/bin/env python3
"""docstring"""

import argparse
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
        print('Must have --kegg_out and/or --pfam_out')
        sys.exit(1)

    out_fh = open(out_file, 'w')
    total = 0
    total += process('kegg', kegg_out, kegg_desc, out_fh)
    total += process('pfam', pfam_out, pfam_desc, out_fh)

    print('Done, wrote {} to "{}"'.format(total, out_file))

# --------------------------------------------------
def process(source, uproc_file, desc_file, out_fh):
    if not uproc_file:
        return

    id_to_desc = defaultdict(str)
    for line in open(desc_file):
        vals = line.rstrip().split('\t')
        if len(vals) == 2:
            id = vals[0]
            desc = vals[1]
            id_to_desc[id] = desc

    #print(id_to_desc)

    num = 0
    for line in open(uproc_file):
        num += 1
        flds = line.rstrip().split(',')
        gene = re.sub(r'\|.*', '', flds[1])
        prot_id = flds[6]
        score = flds[7]
        desc = id_to_desc.get(prot_id, 'NONE')
        out_fh.write('\t'.join([gene, source, prot_id, desc, score]) + '\n')

    return num

# --------------------------------------------------
if __name__ == '__main__':
    main()
