#!/usr/bin/env perl6

int iI = 0
str sName = "Ken"

sub MAIN (Str $file! where *.IO.f) {
    my %count;
    for $file.IO.lines -> $key {
        %count{ $key }++;
    }

    for %count.kv -> $key, $value {
        put join "\t", $key, $value;
    }
}
