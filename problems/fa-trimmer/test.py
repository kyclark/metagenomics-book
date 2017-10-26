#!/usr/bin/env python3
"""tests for trimmer.sh"""

from subprocess import getstatusoutput, getoutput
from stat import ST_SIZE
import os
import re

trimmer = './trimmer.py'
dolphin = 'dolphin.fa'

def test_exists():
    """scripts exist"""
    assert os.path.exists(trimmer)

def test_usage():
    """usage"""
    (retval, out) = getstatusoutput(trimmer)
    assert retval > 0
    assert re.match("usage", out, re.IGNORECASE)

def test_run1():
    """runs ok"""
    outfile = 'dolphin.fa.trimmed'
    if os.path.isfile(outfile):
        os.remove(outfile)

    out = getoutput('{} {}'.format(trimmer, dolphin))
    assert out.rstrip() == 'Wrote 14 sequences to "dolphin.fa.trimmed"'
    assert os.path.isfile(outfile)
    assert os.stat(outfile)[ST_SIZE] == 1952

def test_run2():
    """runs ok"""
    outfile = 'dolphin.fa.15'
    if os.path.isfile(outfile):
        os.remove(outfile)

    out = getoutput('{} -s 15 -o {} {}'.format(trimmer, outfile, dolphin))
    assert out.rstrip() == 'Wrote 14 sequences to "dolphin.fa.15"'
    assert os.path.isfile(outfile)
    assert os.stat(outfile)[ST_SIZE] == 1756

def test_run3():
    """runs ok"""
    outfile = 'dolphin.fa.15.100'
    if os.path.isfile(outfile):
        os.remove(outfile)

    out = getoutput('{} --start 15 --min 100 --outfile {} {}'.format(trimmer, outfile, dolphin))
    assert out.rstrip() == 'Wrote 3 sequences to "dolphin.fa.15.100"'
    assert os.path.isfile(outfile)
    assert os.stat(outfile)[ST_SIZE] == 653

def test_run4():
    """runs ok"""
    outfile = 'dolphin.fa.15.50'
    if os.path.isfile(outfile):
        os.remove(outfile)

    out = getoutput('{} --start 15 --end 50 --outfile {} {}'.format(trimmer, outfile, dolphin))
    assert out.rstrip() == 'Wrote 14 sequences to "dolphin.fa.15.50"'
    assert os.path.isfile(outfile)
    assert os.stat(outfile)[ST_SIZE] == 742
