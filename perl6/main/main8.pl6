#!/usr/bin/env perl6

sub MAIN (Str :$name!, Str :$rank='NA', Int :$serial-num where * > 0 = 1) {
    put "name ($name) rank ($rank) serial number ($serial-num)";
}
