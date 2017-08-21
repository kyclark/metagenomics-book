#!/usr/bin/env python3
"""test the hellos"""

from subprocess import getstatusoutput, getoutput
import os.path
import re


def test_exists():
    """test that scripts exist"""
    for script in ["hello.sh", "hello-arg.sh", "hello-arg2.sh"]:
        assert os.path.exists(script)

def test_hello_out():
    """test"""
    out = getoutput("bash hello.sh")
    assert out == "Hello, World!"

def test_hello_arg_usage():
    """test"""
    (retval, out) = getstatusoutput("bash hello-arg.sh")
    assert retval > 0
    assert re.match("usage", out, re.IGNORECASE)

def test_hello_arg():
    """test"""
    out1 = getoutput("bash hello-arg.sh Doctor")
    assert out1 == "Hello, Doctor!"

    out2 = getoutput("bash hello-arg.sh Bowzer")
    assert out2 == "Hello, Bowzer!"

def test_hello_arg2_usage():
    """test"""
    (retval, out) = getstatusoutput("bash hello-arg2.sh")
    assert retval > 0
    assert re.match("usage", out, re.IGNORECASE)

def test_hello_arg2():
    """test"""
    out1 = getoutput("bash hello-arg2.sh Bonjour Madam")
    assert out1 == "Bonjour, Madam!"

    out2 = getoutput("bash hello-arg2.sh 'Good Boy' Bowzer")
    assert out2 == "Good Boy, Bowzer!"
