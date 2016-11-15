#!/usr/bin/env perl6

use lib '.';
use DNA;

sub MAIN (DNA $seq) {
    put "$seq revcom is {revcom($seq)}";
}
