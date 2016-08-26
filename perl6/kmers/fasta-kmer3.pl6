#!/usr/bin/env perl6

use Bio::SeqIO;

sub MAIN (Str $file!, UInt :$k=10) {
    die "Not a file ($file)" unless $file.IO.f;
    my $seqIO = Bio::SeqIO.new(format => 'fasta', file => $file);

    my $j = -1 * ($k - 1);
    while (my $seq = $seqIO.next-Seq) {
        put $seq.seq.comb.rotor($k => $j).map(*.join).join("\n");
    }
}
