#!/usr/bin/env python3
"""tests for prot.sh"""

from subprocess import getstatusoutput, getoutput
import os.path
import re

prot = "./prot.py"

def test_exists():
    """scripts exist"""
    assert os.path.exists(prot)

def test_usage():
    """usage"""
    (retval, out) = getstatusoutput(prot)
    assert retval > 0
    assert re.match("usage", out, re.IGNORECASE)

def test_catn_run():
    """runs ok"""
    for test in [('UGGCCAUGGCGCCCAGAACUGAGAUCAAUAGUACCCGUAUUAACGGGUGAA', 'WPWRPELRSIVPVLTGE'), ('gaacuacaccguucuccuggu', 'ELHRSPG')]:
        seq, aa = test[0], test[1]
        (retval, output) = getstatusoutput("{} {}".format(prot, seq))

        assert retval == 0
        assert output.rstrip() == aa
