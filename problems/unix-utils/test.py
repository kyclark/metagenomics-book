#!/usr/bin/env python3
"""tests for cat-n.sh, head.sh"""

from subprocess import getstatusoutput, getoutput
import os.path
import re

cat_n = "./cat-n.sh"
head = "./head.sh"

def test_exists():
    """scripts exist"""
    for script in [cat_n, head]:
        assert os.path.exists(script)

def test_usage():
    """usage"""
    for script in [cat_n, head]:
        (retval, out) = getstatusoutput(script)
        assert retval > 0
        assert re.match("usage", out, re.IGNORECASE)

def test_bad_input():
    """bad input"""
    for script in [cat_n, head]:
        (retval, out) = getstatusoutput('{} {}'.format(script, 'foo'))
        assert retval > 0
        assert out == '"foo" is not a file'

def test_catn_run():
    """runs ok"""
    for file in ["input1.txt", "input2.txt"]:
        assert os.path.exists(file)

        fh = open(file, "r")
        expected = "".join(
            map(lambda x: '{} {}'.format(x[0] + 1, x[1]), 
                enumerate(fh.readlines())))

        (retval, output) = getstatusoutput("{} {}".format(cat_n, file))

        assert retval == 0
        assert output.rstrip() == expected.rstrip()

def test_head_run():
    """runs ok"""
    input1 = 'input1.txt'
    out1 = getoutput("{} {}".format(head, input1))
    assert out1.rstrip() == 'foo\nbar\nbaz'
    out2 = getoutput("{} {} 5".format(head, input1))
    assert out2.rstrip() == 'foo\nbar\nbaz\nquux\nflip'

    input2 = 'input2.txt'
    out3 = getoutput("{} {}".format(head, input2))
    assert out3.rstrip() == 'this is\nthe\nway the'
    out4 = getoutput("{} {} 4".format(head, input2))
    assert out4.rstrip() == 'this is\nthe\nway the\nworld'
