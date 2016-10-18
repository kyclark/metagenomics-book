#!/usr/bin/env perl6

sub MAIN (Str $file='/usr/share/dict/words', :$min=2) {
    die "$file not a file" unless $file.IO.f;

    for $file.IO.lines.map(*.lc) -> $word {
        next unless $word.chars >= $min;
        if $word eq $word.flip {
            put $word;
        }
    }
}
