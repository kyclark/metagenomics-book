#!/usr/bin/env perl6

sub MAIN (
    Str :$name!,
    Str :$rank='NA',
    UInt :$serial-num where *.Str.chars == 7 = 1111111
) {
    put "name ($name) rank ($rank) serial number ($serial-num)";
}

sub USAGE {
    printf "Usage:\n  %s --name=<Str> [--rank=<Str>] [--serial-num=<Int>]\n",
        $*PROGRAM.basename;

    put "Note: --serial-num must be 7 digits in length."
}
