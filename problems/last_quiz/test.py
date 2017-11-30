#!/usr/bin/env python3
"""tests for adder.py"""

from subprocess import getstatusoutput
import os
import re

adder = './adder.py'

def test_exists():
    """scripts exist"""
    assert os.path.exists(adder)

def test_usage():
    """usage"""
    (ret1, out1) = getstatusoutput(adder)
    assert ret1 > 0
    assert re.match("usage", out1, re.IGNORECASE)

    (ret2, out2) = getstatusoutput('{} foo'.format(adder))
    assert ret2 > 0
    assert re.match("usage", out2, re.IGNORECASE)

def test_run():
    """runs ok"""
    tests = [('foo', 'bar', 'foo and bar', 0),
             ('3', '4', '7', 0),
             ('Sam', 'Dave', 'Sam and Dave', 0),
             ('21', '9', '30', 0),
             ('foo', '9', 'Cannot combine number and string', 1)]

    for arg1, arg2, answer, exitval in tests:
        (retval, output) = getstatusoutput('{} {} {}'.format(adder, arg1, arg2))
        assert retval == exitval
        assert output.rstrip() == answer.rstrip()
