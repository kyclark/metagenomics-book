#!/usr/bin/env perl6

sub MAIN (Str $input!, Int :$k=10) {
    my $seq   = $input.IO.f ?? $input.IO.slurp.chomp !! $input;
    my $n     = $seq.chars - $k + 1;
    my @kmers = gather for 0..^$n -> $i {
        take $seq.substr($i, $k);
    }

    dd @kmers;
}
