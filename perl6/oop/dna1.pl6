#!/usr/bin/env perl6

class DNA {
    has Str $.seq;
}

sub MAIN (Str $seq) {
    my $dna = DNA.new(seq => $seq);
    dd $dna;
}
