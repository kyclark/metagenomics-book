# Setup

Be sure you have Ken's "metagenomics-book" and your "abe487" directories
checked out, e.g., in your "$HOME/work" directory.  Pull the latest from Ken's
repo and copy the "problems/parse-blast" directory into your "abe487/problems."

NB: If you have a trailing slash on the source dir for "cp," it will copy
THE CONTENTS of the directory and not the DIRECTORY ITSELF.  So don't do that.

```
$ ssh hpc
$ ocelote
$ cd work
$ (cd metagenomics-book && git pull)
$ cp -r metagenomics-book/problems/parse-blast abe487/problems
$ cd abe487/problems
$ git add -A parse-blast
$ git commit -am 'adding parse-blast'
$ git push
```

# Parsing BLAST Tabular Output

Write a Python program called "parse_blast_tab.py" that handles the following input:

```
$ ./parse_blast_tab.py -h
usage: parse_blast_tab.py [-h] [-p float] [-e float] file

Parse BLAST tab

positional arguments:
  file                  BLAST tab output

optional arguments:
  -h, --help            show this help message and exit
  -p float, --pct_id float
                        Percent identity
  -e float, --evalue float
```

The positional argument "file" is the only one required. 

Good default values for the options:

* pct_id: 0
* evalue: None

Note the "evalue" is a MAXIMUM value.

According to the help page for BLASTN, the fields for "-outfmt 6" are:

- qseqid
- sseqid
- pident
- length
- mismatch
- gapopen
- qstart
- qend
- sstart
- send
- evalue
- bitscore

The output should be the fields "qseqid", "sseqid", "pident", and "evalue" 
separated by tabs:

```
$ ./parse_blast_tab.py dolphin.tab
GCVMJHE01CM1AV	CAM_READ_0403909775	96.00	1e-14
GCVMJHE01BL828	CAM_READ_0403909775	98.61	3e-28
GCVMJHE01BL828	CAM_READ_0403909775	98.25	7e-20
GCVMJHE01BL828	CAM_READ_0403909775	95.12	2e-09
GCVMJHE01D3LD2	CAM_READ_0403909775	97.96	1e-15
GCVMJHE01D3LD2	CAM_READ_0403909775	95.83	2e-13
GCVMJHE01EGOWM	CAM_READ_0403909775	95.38	2e-20
GCVMJHE01EGOWM	CAM_READ_0403909775	90.79	3e-19
GCVMJHE01BDM7X	CAM_READ_0403909775	95.16	3e-20
GCVMJHE01D5KQD	CAM_READ_0403909775	96.43	4e-18
GCVMJHE01DU0S0	CAM_READ_0403909775	96.49	2e-18
GCVMJHE01EL079	CAM_READ_0403909775	97.22	2e-26
GCVMJHE01EL079	CAM_READ_0403909775	97.06	3e-24
GCVMJHE01EL079	CAM_READ_0403909775	94.92	2e-17
GCVMJHE01D34LU	CAM_READ_0403909775	96.43	5e-18
GCVMJHE01CCRE3	CAM_READ_0403909775	93.85	1e-19
GCVMJHE01CI7AF	CAM_READ_0403909775	97.14	9e-26
$ ./parse_blast_tab.py dolphin.tab -p 98
GCVMJHE01BL828	CAM_READ_0403909775	98.61	3e-28
GCVMJHE01BL828	CAM_READ_0403909775	98.25	7e-20
$ ./parse_blast_tab.py dolphin.tab -e 5e-20
GCVMJHE01BL828	CAM_READ_0403909775	98.61	3e-28
GCVMJHE01EGOWM	CAM_READ_0403909775	95.38	2e-20
GCVMJHE01BDM7X	CAM_READ_0403909775	95.16	3e-20
GCVMJHE01EL079	CAM_READ_0403909775	97.22	2e-26
GCVMJHE01EL079	CAM_READ_0403909775	97.06	3e-24
GCVMJHE01CI7AF	CAM_READ_0403909775	97.14	9e-26
$ ./parse_blast_tab.py dolphin.tab -e 5e-20 -p 96
GCVMJHE01BL828	CAM_READ_0403909775	98.61	3e-28
GCVMJHE01EL079	CAM_READ_0403909775	97.22	2e-26
GCVMJHE01EL079	CAM_READ_0403909775	97.06	3e-24
GCVMJHE01CI7AF	CAM_READ_0403909775	97.14	9e-26
```
