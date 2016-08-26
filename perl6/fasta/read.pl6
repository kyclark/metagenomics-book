#!/usr/bin/env perl6

use v6;

sub MAIN (Str $file!) {
    my $fh = open $file, :nl('>');

    for $fh.lines -> $line {
        put "line '$line'";
    }
}
