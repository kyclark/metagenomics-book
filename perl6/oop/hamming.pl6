#!/usr/bin/env perl6

use lib '.';
use DNA3;

sub MAIN (Str $seq1, Str $seq2) {
    my $dna1 = DNA.new($seq1);          # create with one arg
    my $dna2 = DNA.new(value => $seq2); # create with Pairs (named args)

    put "Hamming distance from '$dna1' to '$dna2': ", $dna1.hamming($dna2);
}
