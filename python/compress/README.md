# Compress

This program takes advantage of the fact that DNA might be repetitive.  It
takes a simple compression approach of finding repeated regions (homopolymer)
and representing them as the base + the number of repeats, e.g., "AAA" = "A3."
Single bases are represented as such.

* "make run" (or just "make") to test on command-line input.
* "make file" to test on a file input
* "make compare" to see how well the compression works

# Savings

```
$ make compare
./compress.py ../dna/input.txt | wc -c
      63
wc -c ../dna/input.txt
      71 ../dna/input.txt
```

In this simple test, we save around 11%.
