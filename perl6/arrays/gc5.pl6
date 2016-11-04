#!/usr/bin/env perl6

sub MAIN (Str $dna) {
    my %hash = $dna.uc.comb.categorize({ /<[GC]>/ ?? 'GC' !! 'Other' });
    say "$dna has {%hash<GC>.elems}";
}
