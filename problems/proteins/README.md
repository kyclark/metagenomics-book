# Setup

Be sure you have Ken's "metagenomics-book" and your "abe487" directories
checked out, e.g., in your "$HOME/work" directory.  Pull the latest from Ken's
repo and copy the "problems/proteins" directory into your "abe487/problems."

NB: If you have a trailing slash on the source dir for "cp," it will copy
THE CONTENTS of the directory and not the DIRECTORY ITSELF.  So don't do that.

```
$ ssh hpc
$ ocelote
$ cd work
$ (cd metagenomics-book && git pull)
$ cp -r metagenomics-book/problems/proteins abe487/problems
$ cd abe487/problems
$ git add -A proteins
$ git commit -am 'adding proteins homework'
$ git push
```

# Translate RNA to AA

Write a Python script that uses the "codons.rna" file to build a dictionary
of RNA codons to amino acid codes, then translate the given RNA sequence
(in upper- or lowercase) into the AA codes:

```
$ ./prot.py
Usage: prot.py SEQ
$ ./prot.py UGGCCAUGGCGCCCAGAACUGAGAUCAAUAGUACCCGUAUUAACGGGUGAA
WPWRPELRSIVPVLTGE
$ ./prot.py gaacuacaccguucuccuggu
ELHRSPG
```

Passing tests should look like:

```
$ make test
python3 -m pytest -v test.py
============================= test session starts ==============================
platform darwin -- Python 3.6.1, pytest-3.0.7, py-1.4.33, pluggy-0.4.0 -- /Users/kyclark/anaconda/bin/python3
cachedir: .cache
rootdir: /Users/kyclark/work/secret-book/problems/proteins, inifile:
collected 3 items

test.py::test_exists PASSED
test.py::test_usage PASSED
test.py::test_run PASSED

=========================== 3 passed in 0.13 seconds ===========================```
