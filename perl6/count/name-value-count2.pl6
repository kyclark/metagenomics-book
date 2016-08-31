#!/usr/bin/env perl6

subset SortBy of Str where  /:i ^ [key|value]s? $ /;
sub MAIN (Str $file! where *.IO.f, SortBy :$sort-by='key', Bool :$desc=False) {
    my %counts;
    for $file.IO.lines.map(*.split(/\s+/)) -> [$key, $value] {
        %counts{ $key } += $value;
    }

    my @sorted = $sort-by ~~ /key/ ?? %counts.sort !! %counts.sort(*.value);
    @sorted   .= reverse if $desc;

    put @sorted.map(*.join("\t")).join("\n");
}
