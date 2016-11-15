#!/usr/bin/env perl6

use lib '.';
use DNA2;

sub MAIN (Str $str) {
    try {
        my $dna = DNA.new(value => $str, direction => Direction.pick);
        put "$dna has the direction {$dna.direction} and length {$dna.length}";

        CATCH {
            default { .Str.say }
        }
    }
}
