#!/usr/bin/env perl6

use v6;
use CSV::Parser;

sub MAIN (Str $file!, Str :$sep=',', Int :$limit=0, Str :$comment) {
    die "Not a file ($file)" unless $file.IO.f;
    my $fh     = open $file;
    my $parser = CSV::Parser.new(
                 file_handle => $fh, contains_header_row => True );

    my @data;
    until $fh.eof {
        @data.push(%($parser.get_line))
    }

    say @data;
}
