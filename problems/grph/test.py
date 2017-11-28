#!/usr/bin/env python3
"""tests for grph.py"""

from subprocess import getstatusoutput
import os
import random 
import re
import string
import sys

grph = './grph.py'

def test_exists():
    """scripts exist"""
    assert os.path.exists(grph)

def test_usage():
    """usage"""
    (ret1, out1) = getstatusoutput(grph)
    assert ret1 > 0
    assert re.match("usage", out1, re.IGNORECASE)

def bad_filename():
    while True:
        file = ''.join(random.choice(string.ascii_lowercase) for i in range(10))
        if not os.path.isfile(file):
            return file

def test_bad_input():
    """usage"""
    bad = bad_filename()
    (ret1, out1) = getstatusoutput('{} {}'.format(grph, bad))
    assert ret1 > 0
    assert out1.strip() == '"{}" is not a file'.format(bad)

def test_run():
    """runs ok"""
    for input in ['sample1.fa', 'sample2.fa', 'sample3.fa']:
        outfile = input + '.out'
        if not os.path.isfile(outfile):
            print('Missing expected output file "{}"'.format(outfile))
            sys.exit(1)

        expected = open(outfile).read().rstrip()
        (retval, output) = getstatusoutput('{} {}'.format(grph, input))
        assert retval == 0
        assert output.rstrip() == expected
