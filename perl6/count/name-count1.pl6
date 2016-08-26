#!/usr/bin/env perl6

sub MAIN (Str $file! where *.IO.f) {
    my %count;
    for $file.IO.lines -> $key {
        %count{ $key }++;
    }

    for %count.kv -> $key, $value {
        put join "\t", $key, $value;
    }
}
