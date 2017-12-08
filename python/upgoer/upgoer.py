#!/usr/bin/env python3
"""Find words in text not in 1000 most-common"""

import argparse
import os
import re
import string
import sys

# --------------------------------------------------
def get_args():
    """get args"""
    parser = argparse.ArgumentParser(description='Argparse Python script')
    parser.add_argument('file', metavar='FILE', help='File to check')
    parser.add_argument('-w', '--wordlist', help='Common word file',
                        metavar='str', type=str, default='1000.txt')
    return parser.parse_args()

# --------------------------------------------------
def main():
    """main"""
    args = get_args()
    infile = args.file
    wordlist = args.wordlist

    for argname, filename in [('file', infile), ('--wordlist', wordlist)]:
        if not os.path.isfile(filename):
            print('{} "{}" is not a file'.format(argname, filename))
            sys.exit(1)

    common = set()
    for line in open(wordlist):
        for word in line.rstrip().split():
            common.add(word)

    letters = re.compile('[' + string.ascii_lowercase + ']')
    not_letter = re.compile('[^' + string.ascii_lowercase + ']')
    num_bad = 0
    for line in open(infile):
        for word in line.lower().rstrip().split():
            if not re.match(letters, word):
                continue

            clean = re.sub(not_letter, '', word)
            if clean not in common:
                num_bad += 1
                print(clean)

    print('Found {} to change'.format(num_bad))

# --------------------------------------------------
if __name__ == '__main__':
    main()
