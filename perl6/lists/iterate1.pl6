#!/usr/bin/env perl6

sub MAIN (Str $dna) {
    my $i = 0;
    for $dna.comb -> $letter {
        $i++;
        say "$i: $letter";
    }
}
