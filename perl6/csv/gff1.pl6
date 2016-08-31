#!/usr/bin/env perl6

# http://downloads.yeastgenome.org/curation/chromosomal_feature/saccharomyces_cerevisiae.gff

use URI::Encode;

sub MAIN (Str $gff! where *.IO.f) {
    my $fh = open $gff;

    my %loc;
    for $fh.lines -> $line {
        next if $line ~~ / ^ '#' /; # comment line
        my ($sequence, $source, $feature, $start, $end, $score,
            $strand, $frame, $attributes) = $line.split(/\t/);

        next unless ($feature.defined && $feature eq 'gene')
                 && ($strand.defined  && $strand ~~ / ^ <[+-]> $/);

        my %attr = $attributes.split(';').map(&uri_decode)
                   .map(*.split('=')).map({ $^a.[0].lc => $^a.[1] });
        my $name = %attr<name> || 'NA';

        %loc{ $sequence }{ $strand }.push(
            ($name, [+$start .. +$end]) # force numeric, important!
        );
    }
    $fh.close;

    for %loc.keys -> $chr {
        my @forward-genes = %loc{ $chr }{'+'}.list;
        my @reverse-genes = %loc{ $chr }{'-'}.list;
        note sprintf "chr (%s) has %s forward genes, %s reverse genes\n",
            $chr, @forward-genes.elems, @reverse-genes.elems;

        for @forward-genes -> ($gene1, $pos1) {
            for @reverse-genes -> ($gene2, $pos2) {
                if so $pos1 (&) $pos2 {
                    printf "%s [%s] (%s) => %s [%s] (%s)\n", 
                        $gene1, '+', $pos1[0,*-1].join('..'),
                        $gene2, '-', $pos2[0,*-1].join('..');
                }
            }
        }
    }
}
