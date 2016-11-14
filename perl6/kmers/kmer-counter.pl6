#!/usr/bin/env perl6

subset PosInt of Int where * > 0;

sub MAIN (PosInt :$k=5, PosInt :$max-sd=5, *@files) {
    die "No files" unless @files;
    my @bags = map { find-kmers(+$k, $_) }, @files;
    my %counts;
    for (1..@bags.elems).combinations(2) -> ($i, $j) {
        my $bag1  = @bags[$i-1];
        my $bag2  = @bags[$j-1];
        my $s1    = $bag1.Set;
        my $s2    = $bag2.Set;
        my @union = ($s1 (&) $s2).keys;
        my $sum   = (map { $bag1{ $_ } }, @union)
                  + (map { $bag2{ $_ } }, @union);
        %counts{"$i-$j"} = $sum;
    }

    my @n  = %counts.values;
    my $μ  = mean @n;
    my $sd = std-dev @n;
    my $d  = $sd/(@n.elems).sqrt;
    for %counts.kv -> $pair, $sum {
        # https://en.wikipedia.org/wiki/Student%27s_t-test
        my $t = ($sum - $μ) / $d;
        if $t.abs > $max-sd {
            my ($i, $j) = $pair.split('-');
            my $f1 = @files[$i-1].IO.basename;
            my $f2 = @files[$j-1].IO.basename;
            put "$pair ($sum) = $t [$f1, $f2]";
        }
    }
}

sub find-kmers (Int $k, Str $file) {
    my $text = $file.IO.lines.lc.join(' ')
               .subst(/:i <-[a..z\s]>/, '', :g).subst(/\s+/, ' ');
    $text.comb.rotor($k => -1 * ($k - 1)).map(*.join).Bag;
}

sub mean (*@n) { @n.sum / @n.elems }

sub std-dev (*@n) {
    # https://en.wikipedia.org/wiki/Standard_deviation
    my $mean = mean(@n);
    my @dev  = map { ($_ - $mean)² }, @n;
    my $var  = @dev.sum / @dev.elems;
    return $var.sqrt;
}
