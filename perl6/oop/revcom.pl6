#!/usr/bin/env perl6

use lib '.';
use DNA2;

sub MAIN (Str $str) {
    try {
        my $dna = DNA.new($str);
        printf "Input : %s\nRevcom: %s\n", $dna, $dna.revcom;
        CATCH { default { .Str.say } }
    }
}
