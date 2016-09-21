#!/usr/bin/env perl6

use Test;

my @tests = chr-count => 16, chr-size => 12359733, gene-count => 6604, 
    verified-genes => 5153, uncharacterized-genes => 688;

for @tests -> $test {
    my ($file, $answer) = $test.kv;
    ok $file.IO.e, "$file exists";
    ok $file.IO.slurp ~~ /^\s*$answer\n/, "$file = $answer";
}

my $gene-types = 'gene-types';
ok $gene-types.IO.e, "$gene-types exists";
my %types = (
    'Dubious'                => 759,
    'Uncharacterized'        => 688,
    'Verified'               => 5153,
    'Verified|silenced_gene' => 4,
    'silenced_gene'          => 2
);

for $gene-types.IO.lines -> $line {
    my $match = $line ~~ m/^\s* (\d+) \s+ (<[|\w]>+)/ or next;
    my $num  = $match.caps[0].value;
    my $type = $match.caps[1].value;
    if %types{ $type }.defined {
        is %types{ $type }, $num, "$type = %types{ $type }";
    }
}

my $terminated-genes = 'terminated-genes';
ok $terminated-genes.IO.e, "$terminated-genes exists";
ok run(<<wc -l $terminated-genes>>, :out).out.slurp-rest ~~ /^\s*951\s*/, "$terminated-genes = 951";
