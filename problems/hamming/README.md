# Setup

Be sure you have Ken's "metagenomics-book" and your "abe487" directories
checked out, e.g., in your "$HOME/work" directory.  Pull the latest from Ken's
repo and copy the "problems/hamming" directory into your "abe487/hamming."

NB: If you have a trailing slash on the source dir for "cp," it will copy
THE CONTENTS of the directory and not the DIRECTORY ITSELF.  So don't do that.

```
$ ssh hpc
$ ocelote
$ cd work
$ (cd metagenomics-book && git pull)
$ cp -r metagenomics-book/problems/hamming abe487/problems
$ cd abe487/problems
$ git add -A hamming
$ git commit -am 'adding hamming homework'
$ git push
```

# Hamming Distance

Solve http://rosalind.info/problems/hamm/

E.g.,

```
$ ./hamming.py foo boo
1
$ ./hamming.py foo faa
2
$ ./hamming.py foo foobar
3
$ ./hamming.py GAGCCTACTAACGGGAT CATCGTAATGACGGCCT
7
$ ./hamming.py TAGGGCAATCATCCGG ACCGTCAGTAATGCTAC
10
```

# Tests

Successful tests will look like

```
$ make test
python3 -m pytest -v test.py
============================= test session starts ==============================
platform darwin -- Python 3.6.1, pytest-3.0.7, py-1.4.33, pluggy-0.4.0 -- /Users/kyclark/anaconda/bin/python3
cachedir: .cache
rootdir: /Users/kyclark/work/secret-book/problems/hamming, inifile:
collected 3 items

test.py::test_exists PASSED
test.py::test_usage PASSED
test.py::test_run PASSED

=========================== 3 passed in 0.27 seconds ===========================
```
