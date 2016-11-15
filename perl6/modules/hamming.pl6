#!/usr/bin/env perl6

use lib '.';
use DNA;

sub MAIN (DNA $seq1, DNA $seq2) {
    put "Hamming distance from '$seq1' to '$seq2': ", hamming($seq1, $seq2);
}
