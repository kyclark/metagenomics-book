#!/usr/bin/env perl6

sub MAIN (Str :$name!, Str :$rank='NA', Int :$serial-num=0) {
    put "name ($name) rank ($rank) serial number ($serial-num)";
}
