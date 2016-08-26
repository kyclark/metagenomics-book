#!/usr/bin/env perl6

use v6;

sub MAIN (Str $file!, Int :$n=0, Str :$sep=',') {
    die "Not a file ($file)" unless $file.IO.f;

    for $file.IO.lines -> $line {
        my @fields = $line.split($sep);
        put @fields[$n];
    }
}
