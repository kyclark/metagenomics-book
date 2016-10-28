#!/usr/bin/env perl6

sub MAIN (Str $dna) {
    my @gc = $dna.uc.comb.grep(/<[GC]>/);
    say "$dna has {@gc.elems}";
}
