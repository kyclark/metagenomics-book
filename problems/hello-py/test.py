#!/usr/bin/env python3
"""tests for hello.py, vowel_counter.py"""

from subprocess import getstatusoutput, getoutput
import os.path
import re

hello = "./hello.py"
counter = "./vowel_counter.py"

# --------------------------------------------------
def test_exists():
    """scripts exist"""
    for script in [hello, counter]:
        assert os.path.exists(script)

# --------------------------------------------------
def test_usage():
    """usage"""
    for script in [hello, counter]:
        (retval, out) = getstatusoutput(script)
        assert retval > 0
        assert re.match("usage", out, re.IGNORECASE)

# --------------------------------------------------
def test_hello():
    """runs hello"""
    out1 = getoutput(hello + ' Alice')
    assert out1.rstrip() == 'Hello to the 1 of you: Alice!'

    out2 = getoutput(hello + ' Mike Carol')
    assert out2.rstrip() == 'Hello to the 2 of you: Mike and Carol!'

    out3 = getoutput(hello + ' Greg Peter Bobby Marcia Jane Cindy')
    assert out3.rstrip() == 'Hello to the 6 of you: Greg, Peter, Bobby, Marcia, Jane, and Cindy!'

# --------------------------------------------------
def test_counter():
    """runs counter"""
    out1 = getoutput(counter + ' if')
    assert out1.rstrip() == 'There is 1 vowel in "if."'

    out2 = getoutput(counter + ' foo')
    assert out2.rstrip() == 'There are 2 vowels in "foo."'

    out3 = getoutput(counter + ' covfefe')
    assert out3.rstrip() == 'There are 3 vowels in "covfefe."'

    out4 = getoutput(counter + ' YYZ')
    assert out4.rstrip() == 'There are 0 vowels in "YYZ."'
