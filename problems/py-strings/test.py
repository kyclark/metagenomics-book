#!/usr/bin/env python3
"""tests for gc.py, gc2.py, trim.py"""

from subprocess import getstatusoutput, getoutput
import os.path
import re
import random, string

gc = "./gc.py"
gc2 = "./gc2.py"
trimmer = "./trim.py"

def badfile():
    length = 10
    letters = string.ascii_lowercase
    badfile = ''
    while True:
        badfile = ''.join(random.choice(letters) for i in range(length))
        if not os.path.isfile(badfile):
            return badfile

def test_exists():
    """scripts exist"""
    for script in [gc, gc2, trimmer]:
        assert os.path.exists(script)

def test_usage():
    """usage"""
    for script in [gc, gc2, trimmer]:
        (retval, out) = getstatusoutput(script)
        assert retval > 0
        assert re.match("usage", out, re.IGNORECASE)

def test_gc():
    """gc"""
    out1 = getoutput(gc + ' AAAAA')
    assert out1.rstrip() == '0% GC'

    out2 = getoutput(gc + ' GCGCGC')
    assert out2.rstrip() == '100% GC'

    out3 = getoutput(gc + ' ACACGTGT')
    assert out3.rstrip() == '50% GC'

def test_gc2():
    """gc2"""
    out1 = getoutput(gc2 + ' seqs.txt')
    assert out1.rstrip() == '12\n0\n100'
    
    bad = badfile()
    retval, out2 = getstatusoutput('{} {}'.format(gc2, bad))
    assert retval > 0
    assert out2.rstrip() == '"{}" is not a file'.format(bad)

def test_trimmer():
    """trimmer"""
    out1 = getoutput(trimmer + ' AAAAAAAA')
    assert out1.rstrip() == 'AAAAA'

    out2 = getoutput(trimmer + ' AAAAAAAA 3')
    assert out2.rstrip() == 'AAA'

    out3 = getoutput(trimmer + ' seqs.txt')
    assert out3.rstrip() == 'TTACT\nAAAAA\nCCCCG'

    out4 = getoutput(trimmer + ' seqs.txt 3')
    assert out4.rstrip() == 'TTA\nAAA\nCCC'
