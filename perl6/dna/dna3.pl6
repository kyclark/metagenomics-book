#!/usr/bin/env perl6

sub MAIN (Str $dna!) {
    my ($num-A, $num-C, $num-G, $num-T) = 0, 0, 0, 0;

    for $dna.lc.comb -> $letter {
        if    $letter eq 'a' { $num-A++ }
        elsif $letter eq 'c' { $num-C++ }
        elsif $letter eq 'g' { $num-G++ }
        elsif $letter eq 't' { $num-T++ }
    }

    put join ' ', $num-A, $num-C, $num-G, $num-T;
}
