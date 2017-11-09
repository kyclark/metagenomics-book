#!/usr/bin/env python3
"""tests for parse_blast_tab.sh"""

from subprocess import getstatusoutput, getoutput
import os
import re

parser = './parse_blast_tab.py'
dolphin = 'dolphin.tab'

def test_exists():
    """script exists"""
    assert os.path.exists(parser)

def test_usage():
    """usage"""
    (retval, out) = getstatusoutput(parser)
    assert retval > 0
    assert re.match("usage", out, re.IGNORECASE)

def test_run1():
    """runs ok"""
    out = getoutput('{} {}'.format(parser, dolphin))
    expected = """
GCVMJHE01CM1AV	CAM_READ_0403909775	96.00	1e-14
GCVMJHE01BL828	CAM_READ_0403909775	98.61	3e-28
GCVMJHE01BL828	CAM_READ_0403909775	98.25	7e-20
GCVMJHE01BL828	CAM_READ_0403909775	95.12	2e-09
GCVMJHE01D3LD2	CAM_READ_0403909775	97.96	1e-15
GCVMJHE01D3LD2	CAM_READ_0403909775	95.83	2e-13
GCVMJHE01EGOWM	CAM_READ_0403909775	95.38	2e-20
GCVMJHE01EGOWM	CAM_READ_0403909775	90.79	3e-19
GCVMJHE01BDM7X	CAM_READ_0403909775	95.16	3e-20
GCVMJHE01D5KQD	CAM_READ_0403909775	96.43	4e-18
GCVMJHE01DU0S0	CAM_READ_0403909775	96.49	2e-18
GCVMJHE01EL079	CAM_READ_0403909775	97.22	2e-26
GCVMJHE01EL079	CAM_READ_0403909775	97.06	3e-24
GCVMJHE01EL079	CAM_READ_0403909775	94.92	2e-17
GCVMJHE01D34LU	CAM_READ_0403909775	96.43	5e-18
GCVMJHE01CCRE3	CAM_READ_0403909775	93.85	1e-19
GCVMJHE01CI7AF	CAM_READ_0403909775	97.14	9e-26
""".strip()
    assert out.rstrip() == expected

def test_run2():
    """runs ok"""
    out = getoutput('{} -p 96 {}'.format(parser, dolphin))
    expected = """
GCVMJHE01CM1AV	CAM_READ_0403909775	96.00	1e-14
GCVMJHE01BL828	CAM_READ_0403909775	98.61	3e-28
GCVMJHE01BL828	CAM_READ_0403909775	98.25	7e-20
GCVMJHE01D3LD2	CAM_READ_0403909775	97.96	1e-15
GCVMJHE01D5KQD	CAM_READ_0403909775	96.43	4e-18
GCVMJHE01DU0S0	CAM_READ_0403909775	96.49	2e-18
GCVMJHE01EL079	CAM_READ_0403909775	97.22	2e-26
GCVMJHE01EL079	CAM_READ_0403909775	97.06	3e-24
GCVMJHE01D34LU	CAM_READ_0403909775	96.43	5e-18
GCVMJHE01CI7AF	CAM_READ_0403909775	97.14	9e-26
""".strip()
    assert out.rstrip() == expected

def test_run3():
    """runs ok"""
    out = getoutput('{} -e 1e-20 {}'.format(parser, dolphin))
    expected = """
GCVMJHE01BL828	CAM_READ_0403909775	98.61	3e-28
GCVMJHE01EL079	CAM_READ_0403909775	97.22	2e-26
GCVMJHE01EL079	CAM_READ_0403909775	97.06	3e-24
GCVMJHE01CI7AF	CAM_READ_0403909775	97.14	9e-26
""".strip()
    assert out.rstrip() == expected

def test_run4():
    """runs ok"""
    out = getoutput('{} --pct_id 98 --evalue 1e-20 {}'.format(parser, dolphin))
    expected = """
GCVMJHE01BL828	CAM_READ_0403909775	98.61	3e-28
""".strip()
    assert out.rstrip() == expected
