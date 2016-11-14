#!/usr/bin/env perl6

class DNA {
    has Str $.seq;
}

sub MAIN (Str $seq) {
    if so $seq.uc ~~ /^ <[ACGTN]>+ $/ {
        my $dna = DNA.new(seq => $seq);
        dd $dna;
    }
    else {
        put "Not a DNA sequence.";
    }
}
