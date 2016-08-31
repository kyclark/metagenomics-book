#!/usr/bin/env perl6

sub MAIN ($input! where *.IO.f) {
    my @kmers = $input.IO.lines;
    my @ks    = @kmers.map(*.chars).unique;
    if @ks.elems != 1 {
        die sprintf "Kmers not of consistent length (%s)\n", @ks.join(', ');
    }
    my $k = @ks[0];
    put "n = {@kmers.elems}";
    put @kmers.join(' ');

    my (%prefix, %suffix);
    for @kmers -> $kmer {
        %prefix{ $kmer.substr(0, $k-1) } = $kmer;
        %suffix{ $kmer.substr(1, $k-1) } = $kmer;
    }

    dd %prefix;
    dd %suffix;

    my @starts = @kmers.grep({!%suffix{$_.substr(0, $k-1)}.defined});
    my @ends   = @kmers.grep({!%prefix{$_.substr(1, $k-1)}.defined});

    for @starts -> $start {
        my @path = $start;
        my $cur  = $start;
        for 0..^@kmers.elems -> $i {
            
        }
    }

    dd @starts;
    dd @ends;
}
