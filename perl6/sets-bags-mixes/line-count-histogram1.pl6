#!/usr/bin/env perl6

sub MAIN (Str $file) {
    my $bag = $file.IO.lines.map(*.chars).Bag;
    put $bag.pairs.sort(*.key).map(*.kv.join("\t")).join("\n");
}
