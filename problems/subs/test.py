#!/usr/bin/env python3
"""tests for subs.py"""

from subprocess import getstatusoutput, getoutput
import os.path
import re

subs = './subs.py'

def test_exists():
    """scripts exist"""
    assert os.path.exists(subs)

def test_usage():
    """usage"""
    (ret1, out1) = getstatusoutput(subs)
    assert ret1 > 0
    assert re.match("usage", out1, re.IGNORECASE)

    (ret2, out2) = getstatusoutput('{} foo'.format(subs))
    assert ret2 > 0
    assert re.match("usage", out2, re.IGNORECASE)

def test_run():
    """runs ok"""
    for test in [('foobarfoo', 'foo', '1 7'),
                 ('foobarfoo', 'blip', 'Not found'),
                 ('GATATATGCATATACTT', 'ATAT', '2 4 10'),
                 ('ACCGTCAGTACCGACCC', 'ACC', '1 10')]:

        s1, s2, answer = test[0], test[1], test[2]
        (retval, output) = getstatusoutput('{} {} {}'.format(subs, s1, s2))

        assert retval == 0
        assert output.rstrip() == answer
