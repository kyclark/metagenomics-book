#!/usr/bin/env perl6

sub MAIN (Str $file!) {
    die "Not a file ($file)" unless $file.IO.f;

    for $file.IO.lines -> $line {
        put $line.uc;
    }
}
