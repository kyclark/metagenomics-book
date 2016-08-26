#!/usr/bin/env perl6

use Bio::SeqIO;

sub MAIN (Str $file! where *.IO.f, UInt :$k=10) {
    my $seqIO = Bio::SeqIO.new(format => 'fasta', file => $file);

    while (my $seq = $seqIO.next-Seq) {
        put join "\n", get-kmers(str => $seq.seq, k => $k);
    }
}

sub get-kmers(Int :$k, Str :$str) {
    my $n = $str.chars - $k + 1;
    map { $str.substr($_, $k) }, 0..^$n;
}
