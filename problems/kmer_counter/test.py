#!/usr/bin/env python3
"""tests for gc.py, gc2.py, trim.py"""

from subprocess import getstatusoutput, getoutput
import re
import os

counter = "./kmer_counter.py"
dna = 'ACTGACGTACTGAGAAGCTG'

def test_exists():
    """scripts exist"""
    for script in [counter]:
        assert os.path.exists(script)

def test_usage():
    """usage"""
    for script in [counter]:
        (retval, out) = getstatusoutput(script)
        assert retval > 0
        assert re.match("usage", out, re.IGNORECASE)

def test_arg_count():
    """not enough args"""
    retval, out = getstatusoutput('{} 1'.format(counter))
    assert retval > 0
    assert re.match("usage", out, re.IGNORECASE)

def test_nan():
    """not a number arg"""
    retval, out = getstatusoutput('{} foo {}'.format(counter, dna))
    assert retval > 0
    assert out.rstrip() == 'Kmer size "foo" is not a number'

def test_bad_mer_size():
    """bad mer size"""
    retval, out = getstatusoutput('{} 0 {}'.format(counter, dna))
    assert retval > 0
    assert out.rstrip() == 'Kmer size "0" must be > 0'

def test_big_mer_size():
    """big mer size"""
    too_big = len(dna) + 1
    retval, out = getstatusoutput('{} {} {}'.format(counter, too_big, dna))
    assert retval > 0
    assert out.rstrip() == 'There are no {}-mers in "{}"'.format(too_big, dna)

def test_4mers():
    """4 mers"""
    out = getoutput('{} {} {}'.format(counter, 4, dna))
    expected = """
ACTGACGTACTGAGAAGCTG
AAGC 1
ACGT 1
ACTG 2
AGAA 1
AGCT 1
CGTA 1
CTGA 2
GAAG 1
GACG 1
GAGA 1
GCTG 1
GTAC 1
TACT 1
TGAC 1
TGAG 1
"""
    assert out.strip() == expected.strip()

def test_5mers():
    """5 mers"""
    out = getoutput('{} {} {}'.format(counter, 5, dna))

    expected = """
ACTGACGTACTGAGAAGCTG
AAGCT 1
ACGTA 1
ACTGA 2
AGAAG 1
AGCTG 1
CGTAC 1
CTGAC 1
CTGAG 1
GAAGC 1
GACGT 1
GAGAA 1
GTACT 1
TACTG 1
TGACG 1
TGAGA 1
"""
    assert out.strip() == expected.strip()
