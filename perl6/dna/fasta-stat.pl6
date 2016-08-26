#!/usr/bin/env perl6

use v6;
use BioInfo::Parser::FASTA;
use BioInfo::IO::FileParser;

sub MAIN (Str $file!) {
    die "Not a file ($file)" unless $file.IO.f;

    my $seq_file = BioInfo::IO::FileParser.new(
        file     => $file,
        parser   => BioInfo::Parser::FASTA
    );

    while (my $seq = $seq_file.get()) {
        say $seq.id;
    }
}
