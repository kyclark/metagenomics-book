#!/usr/bin/env perl6

# http://downloads.yeastgenome.org/curation/chromosomal_feature/saccharomyces_cerevisiae.gff

use URI::Encode;

constant @FIELDS =
    <sequence source feature start end score strand frame attributes>;

sub MAIN (Str $gff! where *.IO.f) {
    my $fh = open $gff;

    my %loc;
    my $i;
    for $fh.lines -> $line {
        next if $line ~~ / ^ '#' /; # comment line
        my %data = @FIELDS Z=> $line.split(/\t/);
        next unless %data<feature> eq 'gene';
        my %attr = %data<attributes>.split(';').map(&uri_decode)
                   .map(*.split('=')).map({ $^a.[0].lc => $^a.[1] });
        %loc{ %data<sequence> }.push({
            name => %attr<name>,
            pos  => [+%data<start> .. +%data<end>],
        });
        last if $i++ > 10;
    }

    for %loc.keys -> $chr {
        my @genes = %loc{ $chr }.list;
        put "chr ($chr) has {@genes.elems} genes";
        for 0..^@genes.elems -> $i {
            my %gene1 = @genes[$i];
            for 1..^@genes.elems -> $j {
                next if $i == $j;
                my %gene2 = @genes[$j];
                if so %gene1<pos> (&) %gene2<pos> {
                    printf "%s (%s) => %s (%s)\n", 
                        %gene1<name>, %gene1<pos>[0,*-1].join('..'),
                        %gene2<name>, %gene2<pos>[0,*-1].join('..');
                }
            }
        }
    }
}
