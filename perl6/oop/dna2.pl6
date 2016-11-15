#!/usr/bin/env perl6

class DNA is Str {}

sub MAIN (Str $seq) {
    if so $seq.uc ~~ /^ <[ACGTN]>+ $/ {
        my $dna = DNA.new(value => $seq);
        dd $dna;
    }
    else {
        put "'$seq' not a DNA sequence.";
    }
}
