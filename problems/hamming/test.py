#!/usr/bin/env python3
"""tests for hamming.py"""

from subprocess import getstatusoutput, getoutput
import os.path
import re

hamm = "./hamming.py"

def test_exists():
    """scripts exist"""
    assert os.path.exists(hamm)

def test_usage():
    """usage"""
    (ret1, out1) = getstatusoutput(hamm)
    assert ret1 > 0
    assert re.match("usage", out1, re.IGNORECASE)

    (ret2, out2) = getstatusoutput('{} foo'.format(hamm))
    assert ret2 > 0
    assert re.match("usage", out2, re.IGNORECASE)

def test_run():
    """runs ok"""
    for test in [('foo', 'boo', '1'),
                 ('foo', 'faa', '2'),
                 ('foo', 'foobar', '3'),
                 ('TAGGGCAATCATCCGAG', 'ACCGTCAGTAATGCTAC', '9'), 
                 ('TAGGGCAATCATCCGG', 'ACCGTCAGTAATGCTAC', '10')]:

        s1, s2, n = test[0], test[1], test[2]
        (retval, output) = getstatusoutput('{} {} {}'.format(hamm, s1, s2))

        assert retval == 0
        assert output.rstrip() == n
