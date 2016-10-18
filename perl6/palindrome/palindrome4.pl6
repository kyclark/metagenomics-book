#!/usr/bin/env perl6

sub MAIN (Str $file='/usr/share/dict/words') {
    die "$file not a file" unless $file.IO.f;

    for $file.IO.lines.grep(*.chars>1).map(*.lc) -> $word {
        if $word eq $word.comb.reverse.join {
            put $word;
        }
    }
}