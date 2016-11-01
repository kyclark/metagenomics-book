#!/usr/bin/env perl6

subset DNA     of Str where * ~~ /^ :i <[ACTGN]>+ $/;
subset RNA     of Str where * ~~ /^ :i <[ACUGN]>+ $/;
subset Protein of Str where * ~~ /^ :i <[A..Z]>+  $/;

sub MAIN (Str $input!) {
    given $input {
        when DNA     { put "Looks like DNA" }
        when RNA     { put "Looks like RNA" }
        when Protein { put "Looks like protein" }
        default      { put "Unknown sequence type" }
    }
}
