#!/usr/bin/env perl6

sub MAIN (Str $dna) {
    my @gc = $dna.uc.comb.grep({$_ eq 'G' || $_ eq 'C'});
    say "$dna has {@gc.elems}";
}
