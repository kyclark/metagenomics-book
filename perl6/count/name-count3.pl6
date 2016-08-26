#!/usr/bin/env perl6

sub MAIN (Str $file! where *.IO.f, Bool :$desc=False) {
    my %keys;
    for $file.IO.lines -> $key {
        %keys{ $key }++;
    }

    my @sorted = %keys.sort(*.value);
    @sorted   .= reverse if $desc;

    for @sorted -> $pair {
        put join "\t", $pair.key, $pair.value;
    }
}
