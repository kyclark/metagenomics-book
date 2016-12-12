#!/usr/bin/env perl6

subset File of Str where *.IO.f;

sub MAIN (File :$phred='phred.txt', File :$seq='seq.txt') {
    my $phred-fh = open $phred;
    my $seq-fh   = open $seq;
    my %xlate    = map { chr($_ + 33) => $_ }, 1..8;

    for 1..* Z $phred-fh.IO.lines Z $seq-fh.IO.lines -> ($i, $score, $bases) {
        put join "\n",
            "Sequence_$i",
            (map { %xlate{$_} }, $score.comb).join("\t"),
            $bases.comb.join("\t");
    }
}
