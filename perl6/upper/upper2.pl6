#!/usr/bin/env perl6

sub MAIN (Str $file!) {
    die "Not a file ($file)" unless $file.IO.e;

    put $file.IO.lines.map(*.uc).join("\n");
}
