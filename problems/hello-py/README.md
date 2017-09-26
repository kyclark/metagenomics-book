# Setup

Be sure you have Ken's "metagenomics-book" and your "abe487" directories
checked out, e.g., in your "$HOME/work" directory.  Pull the latest from Ken's
repo and copy the "problems/hello-py" directory into your "abe487/problems."

NB: If you have a trailing slash on the source dir for "cp," it will copy
THE CONTENTS of the directory and not the DIRECTORY ITSELF.  So don't do that.

```
$ ssh hpc
$ ocelote
$ cd work
$ (cd metagenomics-book && git pull)
$ cp -r metagenomics-book/problems/hello-py abe487/problems
$ cd abe487/problems
$ git add -A hello-py
$ git commit -am 'adding hello-py homework'
$ git push
```

# Hello, Python!

Write a Python program that warmly greets the names you provide.  When there
are two names, join them with "and."  When there are three or more, join them
on commas (INCLUDING THE OXFORD WE ARE NOT SAVAGES) and "and." If no names 
are supplied, print a usage:

```
$ ./hello.py
Usage: hello.py NAME [NAME2 ...]
$ ./hello.py Alice
Hello to the 1 of you: Alice!
$ ./hello.py Mike Carol
Hello to the 2 of you: Mike and Carol!
$ ./hello.py Greg Peter Bobby Marcia Jane Cindy
Hello to the 6 of you: Greg, Peter, Bobby, Marcia, Jane, and Cindy!
```

Think about how you solved these problems in bash:

* How do you find the number of arguments to your program?
* How do you print a usage statement?
* How do you exit with an error?
* How do you check for a condition, e.g., I have just one argument?
* How do you check for a second condition, e.g., I have two arguments?
* How do you check for a third/final condition, e.g., I have more than two arguments?
* How do you inspect the methods that Python lists have?

# Vowel Counter

Write a Python program that counts the number of vowels in a single string.
Be sure your subject and verb agree in number, and use proper plurals.

```
$ ./vowel_counter.py
Usage: vowel_counter.py STRING
$ ./vowel_counter.py for
There is 1 vowel in "for."
$ ./vowel_counter.py elliptical
There are 4 vowels in "elliptical."
$ ./vowel_counter.py YYZ
There are 0 vowels in "YYZ."
```

You can solve this exercise in many ways.  For example, you could 
use a `for` loop that iterates over a list of vowels and counts how
many times that vowels occurs in the word you were given.  (Hint: there
is a method in the `str` class that will do exactly this!)  Here is 
some pseudo-code:

```
create a variable to hold the count
for vowels in vowels:
    how often does vowel occur in word?
    add that number to the count
```

# Tests

A successful test suite looks like this:

```
$ make test
python3 -m pytest -v test.py
============================= test session starts ==============================
platform darwin -- Python 3.5.4, pytest-3.2.1, py-1.4.34, pluggy-0.4.0 -- /Users/kyclark/anaconda3/bin/python3
cachedir: .cache
rootdir: /Users/kyclark/work/secret-book/problems/hello-py, inifile:
collected 4 items

test.py::test_exists PASSED
test.py::test_usage PASSED
test.py::test_hello PASSED
test.py::test_counter PASSED

=========================== 4 passed in 0.33 seconds ===========================
```

# Grading

All tests must pass to receive credit.

# Help

Please feel free to email me (kyclark), stop by my office (Shantz 626), or
chat with me on Slack (abe487.slack.com).
