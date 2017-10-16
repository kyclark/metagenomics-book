#!/usr/bin/env python3

import argparse
from itertools import zip_longest
import os
import string
import random
import sys

# --------------------------------------------------
def get_args():
    parser = argparse.ArgumentParser(description='ROT13')
    parser.add_argument('file', help='File to process', type=str)
    parser.add_argument('-c', '--cols', help='Number of columns', 
                        type=int, default=3)
    parser.add_argument('-d', '--decrypt', help='Decrypt', 
                        action='store_true')
    return parser.parse_args()

# --------------------------------------------------
def main():
    args = get_args()
    file = args.file
    cols = args.cols

    if not os.path.isfile(file):
        print('"{}" is not a file.'.format(file))
        sys.exit(1)

    letters = list(string.ascii_uppercase)
    num_letters = len(letters)
    middle = (num_letters//2) - 1
    lookup = dict(zip(letters, letters[middle + 1:] + letters[0:middle + 1]))

    nums = {'1': 'ONE', '2': 'TWO', '3': 'THREE', '4': 'FOUR', '5': 'FIVE',
            '6': 'SIX', '7': 'SEVEN', '8': 'EIGHT', '9': 'NINE', '0': 'ZERO'}
#
#    if args.decrypt:
#        for line in open(file):
#            line = line.strip()
#            chars = []
#            for char in line:
#                if char in lookup:
#                    chars.append(lookup[char])
#            print(' '.join(chars))
#    else:
    xform = []
    for line in open(file):
        for arabic, english in nums.items():
            line = line.replace(arabic, english + ' ')

        for char in line.upper():
            if char in lookup:
                xform.append(lookup[char])

    chunk_size = 5
    line_len = cols * chunk_size
    too_short = line_len - (len(xform) % line_len)
    for i in range(0, too_short):
        xform.append(random.choice(letters))

    for chunk in grouper(xform, line_len, fillvalue=' '):
        for chunk in grouper(chunk, chunk_size):
            print(' '.join(chunk), end='  ')
        print()

    
# --------------------------------------------------
def grouper(iterable, n, fillvalue=None):
    "Collect data into fixed-length chunks or blocks"
    # grouper('ABCDEFG', 3, 'x') --> ABC DEF Gxx"
    args = [iter(iterable)] * n
    return zip_longest(*args, fillvalue=fillvalue)

# --------------------------------------------------
if __name__ == '__main__':
    main()
