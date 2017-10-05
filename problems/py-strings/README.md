# Setup

Be sure you have Ken's "metagenomics-book" and your "abe487" directories
checked out, e.g., in your "$HOME/work" directory.  Pull the latest from Ken's
repo and copy the "problems/py-strings" directory into your "abe487/problems."

NB: If you have a trailing slash on the source dir for "cp," it will copy
THE CONTENTS of the directory and not the DIRECTORY ITSELF.  So don't do that.

```
$ ssh hpc
$ ocelote
$ cd work
$ (cd metagenomics-book && git pull)
$ cp -r metagenomics-book/problems/py-strings abe487/problems
$ cd abe487/problems
$ git add -A py-strings
$ git commit -am 'adding py-strings homework'
$ git push

```
# gc.py

Write a script "gc.py" that takes a sequence from the command line and prints 
the percentage of the sequence that are G or C (case-insenstive).

```
$ ./gc.py TTACTAAA
12% GC
$ ./gc.py AAAAAAA
0% GC
$ ./gc.py CCCCGCCC
100% GC
```

# gc2.py

Write a script "gc2.py" that takes a filename from the command line and prints 
the percentage of the sequence that are G or C (case-insenstive) for 
each line in the file:

```
$ cat seqs.txt
TTACTAAA
AAAAAAA
CCCCGCCC
$ ./gc2.py seqs.txt
12
0
100
```

# Sequence trimmer

Write a script "trim.py" that takes:

1. either sequence or a filename from the command line (required)
2. sequence length (optional, default = 5)

and trims the sequence or each line/sequence in the file to that length.

```
$ ./trim.py AACATAGA
AACAT
$ ./trim.py AACATAGA 3
AAC
$ cat seqs.txt
TTACTAAA
AAAAAAA
CCCCGCCC
$ ./trim.py seqs.txt 4
TTAC
AAAA
CCCC
```
