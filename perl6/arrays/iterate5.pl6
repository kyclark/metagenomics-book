#!/usr/bin/env perl6

sub MAIN (Str $dna) {
    for $dna.comb.pairs { say join ': ', $^pair.key + 1, $^pair.value }
}
