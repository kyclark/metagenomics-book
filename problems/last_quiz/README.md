# Problem

Write a Python program called "adder.py" that takes exactly two arguments.
If given the incorrect number of arguments, print a "usage" statement.
If both are numbers, print the result of adding the numbers.  If both are
strings, print the result of concatenating them with " and " in between.  If
one is a string and one is number, then print the message "Cannot combine
number and string" and exit with an error.

```
$ ./adder.py
Usage: adder.py ARG1 ARG2
$ ./adder.py foo bar
foo and bar
$ ./adder.py 3 4
7
$ ./adder.py foo 3
Cannot combine number and string
```

Passing tests should look like:

```
$ make test
python3 -m pytest -v test.py
============================= test session starts ==============================
platform darwin -- Python 3.6.1, pytest-3.0.7, py-1.4.33, pluggy-0.4.0 -- /Users/kyclark/anaconda/bin/python3
cachedir: .cache
rootdir: /Users/kyclark/work/secret-book/problems/last_quiz, inifile:
collected 3 items

test.py::test_exists PASSED
test.py::test_usage PASSED
test.py::test_run PASSED

=========================== 3 passed in 0.30 seconds ===========================
```
