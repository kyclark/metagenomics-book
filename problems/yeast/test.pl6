#!/usr/bin/env perl6

use Test;

my @tests = chr-count => 16, chr-size => 12359733, gene-count => 6604, 
    verified-genes => 5151, uncharacterized-genes => 668;
my $no-file = "No file";

for @tests -> $test {
    my ($file, $answer) = $test.kv;
    ok $file.IO.e, "$file exists";
    if $file.IO.e {
        ok $file.IO.slurp ~~ /^\s*$answer\n/, "Correct answer";
    }
    else {
        flunk $no-file;
    }
}

my $gene-types = 'gene-types';
ok $gene-types.IO.e, "$gene-types exists";
if $gene-types.IO.f {
    is $gene-types.IO.slurp, q:to/END/, "Correct answer";
    781 Dubious
    668 Uncharacterized
    5151 Verified
    4 Verified|silenced_gene
    END
}
else {
    flunk $no-file;
}

my $terminated-genes = 'terminated-genes';
ok $terminated-genes.IO.e, "$terminated-genes exists";
if $terminated-genes.IO.e {
    ok run(<<wc -l $terminated-genes>>, :out).out.slurp-rest ~~ /^\s*951\s*/, "Correct answer";
}
else {
    flunk $no-file;
}
