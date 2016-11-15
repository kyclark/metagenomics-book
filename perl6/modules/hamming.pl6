#!/usr/bin/env perl6

use lib '.';
use DNA;

sub MAIN (DNA $seq1, DNA $seq2) {
    printf "Hamming distance from '%s' to '%s': %s\n",
        $seq1, $seq2, hamming($seq1, $seq2);
}
