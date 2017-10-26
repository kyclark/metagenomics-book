# Setup

Be sure you have Ken's "metagenomics-book" and your "abe487" directories
checked out, e.g., in your "$HOME/work" directory.  Pull the latest from Ken's
repo and copy the "problems/fa-trimmer" directory into your "abe487/problems."

NB: If you have a trailing slash on the source dir for "cp," it will copy
THE CONTENTS of the directory and not the DIRECTORY ITSELF.  So don't do that.

```
$ ssh hpc
$ ocelote
$ cd work
$ (cd metagenomics-book && git pull)
$ cp -r metagenomics-book/problems/fa-trimmer abe487/problems
$ cd abe487/problems
$ git add -A fa-trimmer
$ git commit -am 'adding fa-trimmer'
$ git push
```

# FASTA Read Trimmer

Write a Python program called "trimmer.py" using "new_py.py -a trimmer" to 
stub out a program that uses "argparse" to handle the following arguments:

```
$ ./trimmer.py -h
usage: trimmer.py [-h] [-s int] [-e int] [-m int] [-o str] file

FASTA trimmer

positional arguments:
  file                  FASTA file

optional arguments:
  -h, --help            show this help message and exit
  -s int, --start int   Start position
  -e int, --end int     End position
  -m int, --min int     Minimum length
  -o str, --outfile str
                        Output file
```

The positional argument "file" is the only one required. 

Default values for the options:

* start: 0
* end: 0
* min: 0
* outfile: [file] + ".trimmed"

So, e.g., given "dolphin.fa" as the input file, you would create an output 
file called "dolphin.fa.trimmed."

Assume that the user will give 1-based start position; therefore, if 
start/stop are provided, then you will need to subtract 1 to account for 
Python's 0-based offset position.

NB: If not provided "end" position, you may find it convenient to set it to 
None.  E.g.:

```
>>> start = 0
>>> end = 10
>>> seq = 'abcdefghijklmnopqrstuvwxyz'
>>> seq[start:end]
'abcdefghij'
>>> len(seq[start:end])
10
>>> start = 5
>>> end = None
>>> seq[start:end]
'fghijklmnopqrstuvwxyz'
```
