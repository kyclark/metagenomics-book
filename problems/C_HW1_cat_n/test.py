#!/usr/bin/env python3

from subprocess import getstatusoutput, getoutput
import os.path
import re

exe = "./cat-n.sh"

def test_exists():
    assert os.path.exists(exe)

def test_usage():
    noargs = getoutput(exe) 
    assert re.match("usage", noargs, re.IGNORECASE)

def test_run():
    for input in ["input1.txt", "input2.txt"]:
        assert os.path.exists(input)

        fh = open(input, "r")
        expected = "".join(
            map(lambda x: '{} {}'.format(x[0] + 1, x[1]), 
                enumerate(fh.readlines())))

        (retval, output) = getstatusoutput("{} {}".format(exe, input))

        assert retval == 0
        assert output.rstrip() == expected.rstrip()
