#!/usr/bin/env perl6

use Test;

my $expected = q:to/END/;
Sequence_1
1	2	3	4
A	B	C	D
Sequence_2
5	6	7	8
E	F	G	H
END

ok my $proc =
    run("./parallel.pl6", "--phred=phred.txt", "--seq=seq.txt", :out),
    "Ran script";

is $proc.out.slurp-rest, $expected, "Got expected output";

done-testing();
