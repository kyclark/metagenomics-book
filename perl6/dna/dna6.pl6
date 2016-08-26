#!/usr/bin/env perl6

sub MAIN (Str $dna!) {
    my %count = A => 0, C => 0, G => 0, T => 0;;

    for $dna.lc.comb {
        when 'a' { %count<A>++ }
        when 'c' { %count<C>++ }
        when 'g' { %count<G>++ }
        when 't' { %count<T>++ }
    }

    put join ' ', %count<A C G T>;
}
