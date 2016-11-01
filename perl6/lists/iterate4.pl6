#!/usr/bin/env perl6

sub MAIN (Str $dna) {
    for $dna.comb.pairs -> $pair {
        printf "%s: %s\n", $pair.key + 1, $pair.value;
    }
}
