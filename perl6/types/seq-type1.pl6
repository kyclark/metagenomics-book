#!/usr/bin/env perl6

sub MAIN (Str $input!) {
    if $input ~~ /^ :i <[ACTGN]>+ $/ {
        put "Looks like DNA";
    }
    elsif $input ~~ /^ :i <[ACUGN]>+ $/ {
        put "Looks like RNA";
    }
    elsif $input ~~ /^ :i <[A..Z]>+ $/ {
        put "Looks like protein";
    }
    else {
        put "Unknown sequence type";
    }
}
