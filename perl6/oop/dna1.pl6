#!/usr/bin/env perl6

#subset Nucleotide of Str where /^ <[ACGTN]>+ $/;

class DNA is Str {}

sub MAIN (Str $seq) {
    my $dna = DNA.new(value => $seq);
    dd $dna;
}
