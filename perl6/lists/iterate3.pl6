#!/usr/bin/env perl6

sub MAIN (Str $dna) {
    for $dna.comb.kv { say join ": ", $^k, $^v }
}
