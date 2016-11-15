#!/usr/bin/env perl6

class DNA is Str {}

sub MAIN (Str $seq) {
    my $dna = DNA.new(value => $seq);
    dd $dna;
    printf "%s is %s characters long.\n", $dna, $dna.chars;
}
