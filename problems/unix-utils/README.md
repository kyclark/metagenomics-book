# Setup

Be sure you have Ken's "metagenomics-book" and your "abe487" directories
checked out, e.g., in your "$HOME/work" directory.  Pull the latest from Ken's
repo and copy the "problems/unix-utils" directory into your "abe487/problems."

NB: If you have a trailing slash on the source dir for "cp," it will copy
THE CONTENTS of the directory and not the DIRECTORY ITSELF.  So don't do that.

```
$ ssh hpc
$ ocelote
$ cd work
$ (cd metagenomics-book && git pull)
$ cp -r metagenomics-book/problems/unix-utils abe487/problems
$ cd abe487/problems
$ git add -A unix-utils
$ git commit -am 'adding unix-utils homework'
$ git push
```

# cat-n.sh

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

If given an argument that is not a regular file, it should print 
"<argument> is not a file":

```
$ ./cat-n.sh foo
"foo" is not a file
```

You only need to worry about processing one file.

# head.sh

Write a bash script that mimics the "head" utility where it will print the
first few lines of a file.  The script should expect one required argument 
(the file) and a second optional argument of the number of lines, defaulting 
to 3.

```
$ ./head.sh input1.txt
foo
bar
baz
$ ./head.sh input1.txt 5
foo
bar
baz
quux
flip
```

If no arguments (files) are given, it should print a "usage" statement:

```
$ ./head.sh
Usage: head.sh FILE [NUM]
```

If the first argument is not a regular file, it should print 
"<argument> is not a file":

```
$ ./head.sh foo
"foo" is not a file
```

# Testing

"make test" should show:

```
]$ make test
python3 -m pytest -v test.py
============================= test session starts ==============================
platform darwin -- Python 3.6.1, pytest-3.0.7, py-1.4.33, pluggy-0.4.0 -- /Users/kyclark/anaconda/bin/python3
cachedir: .cache
rootdir: /Users/kyclark/work/secret-book/problems/unix-utils, inifile:
collected 5 items

test.py::test_exists PASSED
test.py::test_usage PASSED
test.py::test_bad_input PASSED
test.py::test_catn_run PASSED
test.py::test_head_run PASSED

=========================== 5 passed in 0.07 seconds ===========================
```

# Turn it in

When all tests are passing:

```
$ git commit -am 'all good'
$ git push
```

If you can see the work in Github, then I can pull it and check it.

Reminder: Homework is pass/fail.  All tests must pass to get full credit.

# Help 

Feel free to stop by my office (Shantz 626), email me, or use the new 
"abe487" Slack channel to discuss the problems.  No copying from others is 
allowed.
