#!/usr/bin/env python3
"""Count words/frequencies in two files"""

import os
import re
import sys
import string
from collections import defaultdict

# --------------------------------------------------
def get_kmers(file, size):
    """Return a dictionary of kmers/counts"""
    kmers = defaultdict(int)
    regex = re.compile('[' + string.punctuation + ']')
    for line in open(file):
        for word in [regex.sub('', w) for w in line.lower().split()]:
            nkmers = len(word) - size + 1
            for kmer in [word[i:i+size] for i in range(nkmers)]:
                kmers[kmer] += 1
    return kmers

# --------------------------------------------------
def main():
    """Start here"""
    args = sys.argv[1:]

    if not 2 <= len(args) <= 3:
        msg = 'Usage: {} FILE1 FILE2 [SIZE]'
        print(msg.format(os.path.basename(sys.argv[0])))
        sys.exit(1)

    for file in args[0:2]:
        if not os.path.isfile(file):
            print('"{}" is not a file'.format(file))
            sys.exit(1)

    file1 = args[0]
    file2 = args[1]
    size = int(args[2]) if len(args) == 3 and args[2].isdigit() else 3
    kmers1 = get_kmers(file1, size)
    kmers2 = get_kmers(file2, size)
    common = set(kmers1.keys()).intersection(set(kmers2.keys()))
    num_common = len(common)
    verb = 'is' if num_common == 1 else 'are'
    plural = '' if num_common == 1 else 's'
    tot1 = len(kmers1.keys())
    tot2 = len(kmers2.keys())
    msg = 'There {} {} kmer{} in common between "{}" ({}) and "{}" ({}).'
    print(msg.format(verb, num_common, plural, file1, tot1, file2, tot2))

    freq_kmers1 = sum(kmers1.values())
    freq_kmers2 = sum(kmers2.values())
    freq_shared1 = sum([kmers1[w] for w in common])
    freq_shared2 = sum([kmers2[w] for w in common])

    if num_common > 0:
        fmt = '{:>3} {:20} {:>5} {:>5}'
        print(fmt.format('#', 'kmer', '1', '2'))
        print('-' * 36)
        for i, kmer in enumerate(sorted(common)):
            print(fmt.format(i + 1, kmer, kmers1[kmer], kmers2[kmer]))

        print(fmt.format('', '-----', '--', '--'))
        print(fmt.format('', 'total', freq_shared1, freq_shared2))
        print(fmt.format('', 'pct',
                         int(freq_shared1/freq_kmers1 * 100), 
                         int(freq_shared2/freq_kmers2 * 100)))

# --------------------------------------------------
if __name__ == '__main__':
    main()
