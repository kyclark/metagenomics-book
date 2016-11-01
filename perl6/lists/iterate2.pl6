#!/usr/bin/env perl6

sub MAIN (Str $dna) {
    for $dna.comb.kv -> $k, $v {
        say "{$k+1}: $v";
    }
}
