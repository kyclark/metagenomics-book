#!/usr/bin/env perl6

sub MAIN (Str $dna!) {
    my ($num-A, $num-C, $num-G, $num-T) = 0, 0, 0, 0;

    for $dna.comb -> $letter {
        if    $letter eq 'a' || $letter eq 'A' { $num-A++ }
        elsif $letter eq 'c' || $letter eq 'C' { $num-C++ }
        elsif $letter eq 'g' || $letter eq 'G' { $num-G++ }
        elsif $letter eq 't' || $letter eq 'T' { $num-T++ }
    }

    put "$num-A $num-C $num-G $num-T";
}
