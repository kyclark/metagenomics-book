#!/usr/bin/env perl6

sub MAIN (
    Str :$name!,
    Str :$rank='NA',
    UInt :$serial-num where *.Str.chars == 7 = 1111111
) {
    put "name ($name) rank ($rank) serial number ($serial-num)";
}
