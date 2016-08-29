#!/usr/bin/env perl6

use URI::Encode;

constant @FIELDS =
    <sequence source feature start end score strand frame attributes>;

sub MAIN (Str $gff! where *.IO.f) {
    my $fh = open $gff;

    my %loc;
    for $fh.lines -> $line {
        next if $line ~~ / ^ '#' /; # comment line
        my %data = @FIELDS Z=> $line.split(/\t/);
        next unless %data<feature> eq 'gene';
        dd %data;
        dd %data<attributes>.split(';').map(&uri_decode).map(*.split('=')).map({ $^a.[0] => $^a.[1] });
        %loc{ %data{'sequence'} }.push({ start => %data<start>, end => %data<end> });
        last;
    }

    dd %loc;
}
