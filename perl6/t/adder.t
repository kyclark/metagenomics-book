#!/usr/bin/env perl6

use Test;
use lib $*PROGRAM.dirname.Str;
use Runner;

plan 6;

my $dir     = $*SPEC.catdir($*PROGRAM.dirname, '..', 'adder');
my $script1 = $*SPEC.catfile($dir, 'adder1.pl6');
my $script2 = $*SPEC.catfile($dir, 'adder2.pl6');

ok $script1.IO.f, "$script1 exists";
ok $script2.IO.f, "$script2 exists";

for $script1, $script2 -> $script {
    my $out1 = runner-out($script);
    ok $out1 ~~ /Usage/, "$script prints usage";

    my $out2 = runner-out($script, '2', '5');
    is $out2, '7', "$script adds";
}
