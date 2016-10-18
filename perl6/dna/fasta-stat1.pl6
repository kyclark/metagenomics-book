#!/usr/bin/env perl6

use BioInfo::Parser::FASTA;
use BioInfo::IO::FileParser;

sub MAIN (Str $file!) {
    die "Not a file ($file)" unless $file.IO.f;

    my $seq_file = BioInfo::IO::FileParser.new(
        file     => $file,
        parser   => BioInfo::Parser::FASTA
    );

    my @bases = <A C G T>;
    my %count; 
    while (my $seq = $seq_file.get()) {
        my $b = $seq.sequence.uc.comb.Bag;

        for @bases -> $base {
            %count{ $base } += $b{ $base }
        }
    }

    for @bases -> $base {
        printf "%10d %s\n", %count{ $base }, $base;
    }
}
