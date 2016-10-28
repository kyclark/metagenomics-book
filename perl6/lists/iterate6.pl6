#!/usr/bin/env perl6

sub MAIN (Str $dna) {
    for $dna.comb.pairs -> (:$key, :$value) {
        say join ': ', $key + 1, $value;
    }
}
