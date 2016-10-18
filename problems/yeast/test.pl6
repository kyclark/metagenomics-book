#!/usr/bin/env perl6

use Test;

plan 7;

my @tests = chr-count => 16, chr-size => 12359733, gene-count => 6604, 
    verified-genes => 5153, uncharacterized-genes => 688;

for @tests -> $test {
    my ($file, $answer) = $test.kv;
    if $file.IO.e {
        ok $file.IO.slurp ~~ /^\s*$answer\n/, "$file = $answer";
    }
    else {
        flunk "$file does not exist";
    }
}

my $gene-types = 'gene-types';
my %types = (
    'Dubious'                => 759,
    'Uncharacterized'        => 688,
    'Verified'               => 5153,
    'Verified|silenced_gene' => 4,
    'silenced_gene'          => 2
);

my %found;
if $gene-types.IO.e {
    for $gene-types.IO.lines -> $line {
        my $match = $line ~~ m/^\s* (\d+) \s+ (<[|\w]>+)/ or next;
        my $num   = +$match.caps[0].value;
        my $type  = ~$match.caps[1].value;

        if $num && $type {
            %found{ $type } = $num;
        }
    }
}

is-deeply %found, %types, "found all gene types";

my $terminated-genes = 'terminated-genes';
if $terminated-genes.IO.e {
    ok run(<<wc -l $terminated-genes>>, :out).out.slurp-rest ~~ /^\s*951\s*/, 
        "$terminated-genes = 951";
}
else {
    flunk "$terminated-genes does not exist";
}
