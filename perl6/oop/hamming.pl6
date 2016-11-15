#!/usr/bin/env perl6

use lib '.';
use DNA2;

sub MAIN (Str $seq1, Str $seq2) {
    try {
        my $dna1 = DNA.new($seq1);
        my $dna2 = DNA.new($seq2);
        put "Hamming distance from '$dna1' to '$dna2': ", $dna1.hamming($dna2);
        CATCH { default { .Str.say } }
    }
}
