#!/usr/bin/env perl6

use lib '.';
use DNA2;

sub MAIN (Str :$seq, Int :$start=0, Int :$stop=0) {
    try {
        my $dna = DNA.new($seq);
        $stop ||= $dna.chars;
        put "DNA from $start to $stop: ", $dna.substr($start, $stop);
        CATCH { default { .Str.say } }
    }
}
