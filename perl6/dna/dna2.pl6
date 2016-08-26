#!/usr/bin/env perl6

sub MAIN (Str $dna!) {
    my ($num-A, $num-C, $num-G, $num-T) = 0, 0, 0, 0;

    for $dna.comb -> $letter {
        if    $letter eq 'a' | 'A' { $num-A++ }
        elsif $letter eq 'c' | 'C' { $num-C++ }
        elsif $letter eq 'g' | 'G' { $num-G++ }
        elsif $letter eq 't' | 'T' { $num-T++ }
    }

    put "$num-A $num-C $num-G $num-T";
}
