#!/usr/bin/env perl6

subset File of Str where *.IO.f;

sub MAIN (File :$phred='phred.txt', File :$bases='bases.txt') {
    my $phred-fh = open $phred;
    my $bases-fh = open $bases;
    my %xlate    = map { chr($_ + 33) => $_ }, 1..8;

    for 1..* Z $phred-fh.IO.lines Z $bases-fh.IO.lines -> ($i, $score, $seq) {
        put join "\n",
            "Sequence_$i",
            (map { %xlate{$_} }, $score.comb).join("\t"),
            $seq.comb.join("\t");
    }
}
