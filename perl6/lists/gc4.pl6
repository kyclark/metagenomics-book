#!/usr/bin/env perl6

sub MAIN (Str $dna) {
    my %hash = $dna.uc.comb.categorize({?/<[GC]>/});
    say "$dna has {%hash<True>.elems}";
}
