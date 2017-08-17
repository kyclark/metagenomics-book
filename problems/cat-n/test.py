#!/usr/bin/env python3

from subprocess import getstatusoutput, getoutput
import os.path
import re

exe = "./cat-n-ky.sh"

def test_exists():
    assert os.path.exists(exe)

def test_usage():
    noargs = getoutput(exe) 
    assert re.match("usage", noargs, re.IGNORECASE)

def test_run1():
    run("input1.txt")

def test_run2():
    run("input2.txt")

def run(input):
    assert os.path.exists(input) == True

    fh = open(input, "r")
    expected = "".join(
        map(lambda x: '{} {}'.format(x[0] + 1, x[1]), 
            enumerate(fh.readlines())))

    #expected = ""
    #for (i, line) in enumerate(fh.readlines()):
    #    expected += "{} {}".format(i + 1, line)

    (retval, output) = getstatusoutput("{} {}".format(exe, input))

    assert retval == 0
    assert output.rstrip() == expected.rstrip()
