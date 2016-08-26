#!/usr/bin/env perl6

use v6;

sub MAIN (Str $file!, Str :$sep=',') {
    die "Not a file ($file)" unless $file.IO.f;

    my $fh = open $file;
    my @fields = $fh.get.split($sep);

    my %causes;
    for $fh.lines -> $line {
        my %rec = @fields Z=> $line.split($sep);
        %causes{ %rec{'Cause of Death'} }++;
    }

    print %causes;
}
