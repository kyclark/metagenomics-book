#!/usr/bin/env perl6

sub MAIN (Int $a!, Int $b!) { put $a + $b }

sub USAGE {
    printf "Usage: %s <Int> <Int>\n", $*PROGRAM.basename;
}
