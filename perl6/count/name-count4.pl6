#!/usr/bin/env perl6

subset SortBy of Str where /^keys?|values?$/;
sub MAIN (Str $file! where *.IO.f, SortBy :$sort-by='key', Bool :$desc=False) {
    my %keys;
    for $file.IO.lines -> $key {
        %keys{ $key }++;
    }

    my @sorted = $sort-by ~~ /key/ ?? %keys.sort !! %keys.sort(*.value);
    @sorted   .= reverse if $desc;

    for @sorted -> $pair {
        put join "\t", $pair.key, $pair.value;
    }
}
