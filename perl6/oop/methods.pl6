#!/usr/bin/env perl6

use lib '.';
use DNA;

sub MAIN (Str $str) {
    try {
        my $dna = DNA.new($str);
        for <Str chars revcomp> -> $method {
            printf "%20s: %s\n", $method, $dna."$method"();
        }

        CATCH {
            default { .Str.say }
        }
    }
}
