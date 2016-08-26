#!/usr/bin/env perl6

sub MAIN (Str $dna!) {
    my %count;

    for $dna.lc.comb {
        when 'a' { %count<A>++ }
        when 'c' { %count<C>++ }
        when 'g' { %count<G>++ }
        when 't' { %count<T>++ }
    }

    put join ' ', %count<A C G T>.map({ $_ // 0 });
}
