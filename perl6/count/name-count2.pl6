#!/usr/bin/env perl6

sub MAIN (Str $file! where *.IO.f, :$desc=False) {
    my %count;
    for $file.IO.lines -> $key {
        %count{ $key }++;
    }

    my @sorted = %count.sort;
    @sorted   .= reverse if $desc;

    for @sorted -> $pair {
        put join "\t", $pair.key, $pair.value;
    }
}
