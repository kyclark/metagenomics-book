#!/usr/bin/env perl6

use Test;
use lib $*PROGRAM.dirname.Str;
use Runner;

my $dir   = $*SPEC.catdir($*PROGRAM.dirname, '..', 'count');
my $names = $*SPEC.catfile($dir, 'names.txt');

for 1..7 -> $i {
    my $script = $*SPEC.catfile($dir, "name-count$i.pl6");

    ok $script.IO.f, "{$script.IO.basename} exists";
    my $out1 = runner-err($script);
    ok $out1 ~~ /Usage/, 'Prints usage';

    my $out2 = runner-out($script, $names);
    ok $out2 ~~ /dog\t2/, 'Counts "dog" OK';

    given $i {
        when * (elem) [1,5] { next }
        when 3 {
            my $expect = q:to/END/.chomp;
                bird	1
                mouse	1
                dog	2
                cat	3
                END
            is $out2, $expect, 'Output OK';
        }
        default {
            my $expect = q:to/END/.chomp;
                bird	1
                cat	3
                dog	2
                mouse	1
                END
            is $out2, $expect, 'Output OK';
        }
    }
}
