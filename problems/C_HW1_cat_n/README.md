# Assignment

Write a bash script called "cat-n.sh" that mimics "cat -n" where you print 
the line number before each line of input from a given file.  E.g.:

```
$ ./cat-n.sh input1.txt
1 foo
2 bar
```

If no arguments (files) are given, it should print a "usage" statement:

```
$ ./cat-n.sh
Usage: cat-n.sh file
```

You only need to worry about processing one file.

# Testing

When the script is not working, "make test" will show something like this:

```
$ make test
python3 -m pytest test.py
============================= test session starts ==============================
platform linux -- Python 3.6.2, pytest-3.2.1, py-1.4.34, pluggy-0.4.0
rootdir: /home/u20/kyclark/work/metagenomics-book/problems/cat-n, inifile:
collected 4 items

test.py ..FF

=================================== FAILURES ===================================
__________________________________ test_run1 ___________________________________

    def test_run1():
>       run("input1.txt")

test.py:17:
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _

input = 'input1.txt'

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
>       assert output.rstrip() == expected.rstrip()
E       AssertionError: assert '1: foo\n2: bar' == '1 foo\n2 bar'
E         - 1: foo
E         ?  -
E         + 1 foo
E         - 2: bar
E         ?  -
E         + 2 bar

test.py:37: AssertionError
__________________________________ test_run2 ___________________________________

    def test_run2():
>       run("input2.txt")

test.py:20:
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _

input = 'input2.txt'

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
>       assert output.rstrip() == expected.rstrip()
E       AssertionError: assert '1: this is\n...rld\n5: ends.' == '1 this is\n2 ...orld\n5 ends.'
E         - 1: this is
E         ?  -
E         + 1 this is
E         - 2: the
E         ?  -
E         + 2 the
E         - 3: way the...
E
E         ...Full output truncated (9 lines hidden), use '-vv' to show

test.py:37: AssertionError
====================== 2 failed, 2 passed in 0.06 seconds ======================
make: *** [test] Error 1
```

Can you spot the error?  The program is adding a colon (":") after the line
number.

Your program is correct when you see this output:

```
$ make test
python3 -m pytest test.py
============================= test session starts ==============================
platform linux -- Python 3.6.2, pytest-3.2.1, py-1.4.34, pluggy-0.4.0
rootdir: /home/u20/kyclark/work/metagenomics-book/problems/cat-n, inifile:
collected 4 items

test.py ....

=========================== 4 passed in 0.02 seconds ===========================
```
