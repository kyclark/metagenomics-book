#!/usr/bin/env perl6

sub MAIN (Str $input!) {
    my $dna = $input.IO.e ?? $input.IO.slurp !! $input;
    my $bag = $dna.lc.comb.Bag;
    put join ' ', $bag<a c g t>
}
