#!/usr/bin/env perl6

subset SerialNum of UInt where *.Str.chars == 7;
my @ranks = <NA Recruit Private PSC PFC Specialist>;
subset Rank of Str where * eq any(@ranks);

sub MAIN (
    Str :$name!,
    Rank :$rank='NA',
    SerialNum :$serial-num=1111111
) {
    put "name ($name) rank ($rank) serial number ($serial-num)";
}

sub USAGE {
    printf "Usage:\n  %s --name=<Str> [--rank=<Str>] [--serial-num=<Int>]\n",
        $*PROGRAM.basename;

    put "--rank must be one of: {@ranks.join(', ')}";
    put "--serial-num must be 7 digits in length."
}
