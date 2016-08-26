#!/usr/bin/env perl6

use v6;

sub MAIN (Str $file!, Str :$sep=',', Int :$limit=0) {
    die "Not a file ($file)" unless $file.IO.f;

    my $fh = open $file;
    my @fields = $fh.get.split($sep);

    my @data;
    for $fh.lines -> $line {
        my @values = $line.split($sep);
        my %record;
        for 0..^@fields.elems -> $i {
            my $key = @fields[$i];
            my $val = @values[$i];
            %record{ $key } = $val;
        }
        @data.push(%record);

        last if $limit > 0 && @data.elems > $limit;
    }

    say @data;
}
