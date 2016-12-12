#!/usr/bin/env perl6

sub MAIN (Numeric $a!, Numeric $b!) { put $a + $b }

sub USAGE {
    printf "Usage: %s <Numeric> <Numeric>\n", $*PROGRAM.basename;
}
