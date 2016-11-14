#!/usr/bin/env perl6

use lib '.';
use DNA;

sub MAIN (Str $str) {
    try {
        my $dna = DNA.new($str);
        printf "Input  : %s\nRevcomp: %s\n", $dna, $dna.revcomp;

        CATCH {
            default { .Str.say }
        }
    }
}
