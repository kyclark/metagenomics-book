#!/usr/bin/env perl6

sub MAIN ($file! where *.IO.f) {
    my @kmers = $file.IO.lines;
    my @ks    = @kmers.map(*.chars).unique;
    if @ks.elems != 1 {
        die sprintf "Kmers not of consistent length (%s)\n", @ks.join(', ');
    }
    my $k = @ks[0];
    put "n = {@kmers.elems}";
    put @kmers.join(' ');

    my (%prefix, %suffix);
    for @kmers -> $kmer {
        %prefix.append($kmer.substr(0, $k-1), $kmer);
        %suffix.append($kmer.substr(1, $k-1), $kmer);
        #push(%prefix{$kmer.substr(0, $k-1)}, $kmer);
        #push(%suffix{$kmer.substr(1, $k-1)}, $kmer);
    }

    dd %prefix;
    dd %suffix;
    exit;

    my @starts = @kmers.grep({!%suffix{$_.substr(0, $k-1)}.defined});
    my @ends   = @kmers.grep({!%prefix{$_.substr(1, $k-1)}.defined});

    my @paths;
    for @starts -> $kmer {
        say "kmer ($kmer)";
        my $next = $kmer;
        my @path = $next;
        my $i;
        loop {
            my $list = %prefix{$next.substr(1, $k-1)};
            say "list = ", $list.WHAT;
            say "$next => {$list.join(', ')}";
            $next = $list.shift;
            @path.push($next);
            last if $i++ > @kmers.elems;
        }
#        dd @path;
#        @paths.push(@path);
    }

    dd @starts;
    dd @ends;
    dd @paths;
}
