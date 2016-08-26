#!/usr/bin/env perl6

sub MAIN (Str $file! where *.IO.f) {
    put $file.IO.lines.Bag.map(*.kv.join("\t")).join("\n");
}
