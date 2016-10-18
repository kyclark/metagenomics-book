#!/usr/bin/env perl6

use Bio::SeqIO;

sub MAIN (Str $file!) {
    die "Not a file ($file)" unless $file.IO.f;

    my $seqIO = Bio::SeqIO.new(format => 'fasta', file => $file);

    my @bases = <A C G T>;
    my %count; 
    while (my $seq = $seqIO.next-Seq) {
        my $b = $seq.seq.uc.comb.Bag;

        for @bases -> $base {
            %count{ $base } += $b{ $base }
        }
    }

    for @bases -> $base {
        printf "%10d %s\n", %count{ $base }, $base;
    }
}
