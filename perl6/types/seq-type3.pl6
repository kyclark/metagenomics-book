#!/usr/bin/env perl6

sub MAIN (Str $input!) {
    my $dna     = /^ :i <[ACTGN]>+ $/;
    my $rna     = /^ :i <[ACUGN]>+ $/;
    my $protein = /^ :i <[A..Z]>+  $/;

    given $input {
        when $dna     { put "Looks like DNA" }
        when $rna     { put "Looks like RNA" }
        when $protein { put "Looks like protein"; }
        default       { put "Unknown sequence type" }
    }
}
