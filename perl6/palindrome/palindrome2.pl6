#!/usr/bin/env perl6

sub MAIN (Str $file='/usr/share/dict/words') {
    die "$file not a file" unless $file.IO.f;

    for $file.IO.lines -> $word {
        next if $word.chars == 1;
        if $word.lc eq $word.lc.comb.reverse.join {
            put $word;
        }
    }
}
