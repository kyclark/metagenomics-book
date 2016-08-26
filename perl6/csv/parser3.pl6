#!/usr/bin/env perl6

use v6;

sub MAIN (Str $file!, Str :$sep=',', Int :$limit=0, Str :$comment) {
    die "Not a file ($file)" unless $file.IO.f;

    # copy to make mutable
    (my $delim = $sep) ~~ s/\\t/\t/;
    my $fh     = open $file;
    my @fields = $fh.get.split($delim);

    my @data;
    for $fh.lines -> $line {
        next if $comment.defined &&
                $line.substr(0, $comment.chars) eq $comment;
        @data.push(@fields Z=> $line.split($delim));
        last if $limit > 0 && @data.elems > $limit;
    }

    say @data;
}
