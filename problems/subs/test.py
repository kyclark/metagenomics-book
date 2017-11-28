#!/usr/bin/env python3
"""tests for subs.py"""

from subprocess import getstatusoutput
import os
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
    for i in range(1,6):
        test = 'input{}.txt'.format(i)
        seq, sub, answer = open(test).read().splitlines()
        (retval, output) = getstatusoutput('{} {} {}'.format(subs, seq, sub))

        assert retval == 0
        assert output.rstrip() == answer.rstrip()
