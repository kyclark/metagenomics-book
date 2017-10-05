# gc.py

Write a script that takes a sequence from the command line and prints 
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

Write a script that takes a filename from the command line and prints 
the percentage of the sequence that are G or C (case-insenstive) for 
each line in the file.  It should complain if provided a file that does
not exist.

```
$ cat seqs.txt
TTACTAAA
AAAAAAA
CCCCGCCC
$ ./gc2.py seqs.txt
12
0
100
$ ./gc2.py file-that-does-not-exist
"file-that-does-not-exist" is not a file
```

# Sequence trimmer

Write a script that takes:

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
