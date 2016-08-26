#!/usr/bin/env perl6

use v6;
use Bio::SeqIO;

sub MAIN (Str $file!) {
    die "Not a file ($file)" unless $file.IO.f;

    my $seqIO = Bio::SeqIO.new(format => 'fasta', file => $file);

    while (my $seq = $seqIO.next-Seq) {
        say $seq.seq;
    }
}
