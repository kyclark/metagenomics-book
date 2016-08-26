#!/usr/bin/env perl6

sub MAIN (Str $dna!) {
    my ($num-A, $num-C, $num-G, $num-T) = 0, 0, 0, 0;

    for $dna.lc.comb -> $letter {
        given $letter {
            when 'a' { $num-A++ }
            when 'c' { $num-C++ }
            when 'g' { $num-G++ }
            when 't' { $num-T++ }
        }
    }

    put ($num-A, $num-C, $num-G, $num-T).join(' ');
}
