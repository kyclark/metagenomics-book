#!/usr/bin/env python3
"""
Author : Ken Youens-Clark <kyclark@gmail.com>
Date   : 2018-10-24
Purpose: Get NCBI lineage
"""

import argparse
import os
import re
import sys
import xml.etree.ElementTree as ET
from Bio import Entrez


# --------------------------------------------------
def get_args():
    """get args"""
    parser = argparse.ArgumentParser(
        description='Query NCBI Taxonomy full lineage by taxa',
        formatter_class=argparse.ArgumentDefaultsHelpFormatter)

    parser.add_argument('file', metavar='str', help='Input file of taxa')

    parser.add_argument(
        '-o',
        '--output',
        help='Output file name',
        metavar='str',
        type=str,
        default='')

    parser.add_argument(
        '-f',
        '--force',
        help='Overwrite existing',
        dest='overwrite',
        action='store_true')

    parser.add_argument(
        '-e',
        '--email',
        help='A named string argument',
        metavar='str',
        type=str,
        default='{}@email.arizona.edu'.format(os.getlogin()))

    parser.add_argument(
        '-d',
        '--dbname',
        help='NCBI database',
        metavar='str',
        type=str,
        default='BioSample')

    parser.add_argument(
        '-v', '--verbose', help='Talk about (pop music)', action='store_true')

    return parser.parse_args()


# --------------------------------------------------
def warn(msg):
    """Print a message to STDERR"""
    print(msg, file=sys.stderr)


# --------------------------------------------------
def die(msg='Something bad happened'):
    """warn() and exit with error"""
    warn(msg)
    sys.exit(1)


# --------------------------------------------------
def main():
    """main"""
    args = get_args()
    acclist = args.file
    Entrez.email = args.email
    db_name = args.dbname
    out_file = args.output

    if not out_file:
        basename, _ = os.path.splitext(acclist)
        out_file = '{}.lineage.txt'.format(basename)

    if os.path.isfile(out_file) and not args.overwrite:
        answer = input('"{}" exists.  Overwrite? [yN] '.format(out_file))
        if not re.match('^[yY]', answer):
            print('Will not overwrite. Bye!')
            sys.exit()

    def debug(msg):
        if args.verbose:
            warn(msg)

    out_fh = open(out_file, 'w')
    v_re = re.compile('^(.+)\s+v\d+\.\d+$')
    ok = 0
    errors = 0

    for i, term in enumerate(open(acclist)):
        term = term.rstrip()
        match = v_re.match(term)

        if match:
            term = match.group(1)

        print('{:4}: {}'.format(i + 1, term))

        # TODO: Handle searches by name (genus sp strain) and tax_id (int)
        #handle = Entrez.esearch(db=db_name, term=term, idtype="id")
        handle = Entrez.esearch(db=db_name, term=term)
        result = Entrez.read(handle)
        handle.close()

        if len(result['IdList']) == 1:
            id = result['IdList'][0]
            debug('{} => {}'.format(term, id))

            fetch = Entrez.efetch(
                db=db_name, id=id, retmode="xml", rettype="full")

            xml = ''.join(fetch.readlines())

            debug(xml)
            tree = ET.fromstring(xml)
            orgs = tree.findall('BioSample/Description/Organism')

            if orgs:
                org = orgs[0].attrib
                tax_id = org['taxonomy_id']
                tax_fetch = Entrez.efetch(
                    db="taxonomy", id=tax_id, retmode="xml", rettype="full")
                tax_xml = ''.join(tax_fetch.readlines())
                debug(tax_xml)
                tax_info = ET.fromstring(tax_xml)
                lineage = tax_info.findall('Taxon/Lineage')[0]
                org_name = tax_info.findall('Taxon/ScientificName')[0].text
                out_fh.write('\t'.join(
                    ['{} ({})'.format(org_name, tax_id), lineage.text]) + '\n')
                ok += 1
        else:
            warn('"{}" not found'.format(term))
            errors += 1

    print('Done, skipped {}, wrote {} to "{}"'.format(errors, ok, out_file))


# --------------------------------------------------
if __name__ == '__main__':
    main()
