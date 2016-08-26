#!/usr/bin/env perl6

subset SortBy of Str where /:i ^keys?|values?$/;
sub MAIN (Str $file! where *.IO.f, SortBy :$sort-by='key', Bool :$desc=False) {
    my %counts;
    for $file.IO.lines -> $line {
        my ($key, $value) = $line.split("\t");
        %counts{ $key } += $value;
    }

    my @sorted = $sort-by ~~ /key/ ?? %counts.sort !! %counts.sort(*.value);
    @sorted   .= reverse if $desc;

    for @sorted -> $pair {
        put join "\t", $pair.key, $pair.value;
    }
}
