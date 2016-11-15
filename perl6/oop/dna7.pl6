#!/usr/bin/env perl6

use lib '.';
use DNA2;

sub MAIN (Str $str) {
    try {
        my $i    = 0;
        my $temp = "%s: %s has the direction '%s' and length '%s'.\n";

        my $dna1 = DNA.new($str);
        printf $temp, ++$i, $dna1, $dna1.direction, $dna1.length;

        my $dna2 = DNA.new(value => $str, direction => Forward);
        printf $temp, ++$i, $dna2, $dna2.direction, $dna2.length;

        my $dna3 = DNA.new(value => $str, direction => Direction.pick);
        printf $temp, ++$i, $dna3, $dna3.direction, $dna3.length;

        CATCH {
            default { .Str.say }
        }
    }
}
