#!/usr/bin/env perl6

sub MAIN (Str $dna) {
    my @gc;
    for $dna.uc.comb -> $base {
        @gc.push($base) if $base eq 'G' || $base eq 'C';
    }
    say "$dna has {@gc.elems}";
}
