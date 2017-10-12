# Setup

Be sure you have Ken's "metagenomics-book" and your "abe487" directories
checked out, e.g., in your "$HOME/work" directory.  Pull the latest from Ken's
repo and copy the "problems/kmer_counter" directory into your "abe487/problems."

NB: If you have a trailing slash on the source dir for "cp," it will copy
THE CONTENTS of the directory and not the DIRECTORY ITSELF.  So don't do that.

```
$ ssh hpc
$ ocelote
$ cd work
$ (cd metagenomics-book && git pull)
$ cp -r metagenomics-book/problems/kmer_counter abe487/problems
$ cd abe487/problems
$ git add -A kmer_counter
$ git commit -am 'adding kmer_counter homework'
$ git push
```

# kmer_counter.py

Write a script that takes two arguments from the command line

1. an integer "kmer length"
2. a string 

You should print a usage if not provided enough arguments:

```
$ ./kmer_counter.py
Usage: kmer_counter.py LEN STR
```

You should complain if the first argument is not a positive integer:

```
$ ./kmer_counter.py 0 AACTAG
Kmer size "0" must be > 0
$ ./kmer_counter.py foo AACTAG
Kmer size "foo" is not a number
```

You should let the user know if there are no kmers of the given size 
in the given sequence:

```
$ ./kmer_counter.py 10 AACTAG
There are no 10-mers in "AACTAG"
```

If all the input is good, then print the given sequence and then a sorted
list of the kmers and their counts:

```
$ ./kmer_counter.py 3 AACCAACCAACCAACC
AACCAACCAACCAACC
AAC 4
ACC 4
CAA 3
CCA 3
$ ./kmer_counter.py 4 AACCAACCAACCAACC
AACCAACCAACCAACC
AACC 4
ACCA 3
CAAC 3
CCAA 3
```
