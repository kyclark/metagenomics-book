#!/usr/bin/env perl6

sub MAIN (Str $file='/usr/share/dict/words', :$min=2) {
    die "$file not a file" unless $file.IO.f;

    for $file.IO.lines.grep(*.chars >= $min).map(*.lc) -> $word {
        if $word eq $word.flip {
            put $word;
        }
    }
}
