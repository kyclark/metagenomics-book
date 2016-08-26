#!/usr/bin/env perl6

sub MAIN (Str $dna!) {
    my $bag = $dna.lc.comb.Bag;

    put join ' ', $bag<a c g t>;
}
