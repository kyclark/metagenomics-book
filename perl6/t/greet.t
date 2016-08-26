#!/usr/bin/env perl6

use Test;
use lib $*PROGRAM.dirname;
use Runner;

plan 16;

my $dir     = $*SPEC.catdir($*PROGRAM.dirname, '..', 'greet');

for 1..4 -> $n {
    my $script = "$dir/greet$n.pl6";
    ok $script.IO.f, "$script exists";

    my $out1 = runner-err($script);
    ok $out1 ~~ /Usage/, 'Prints usages with no args';

    my $named = $n >= 3;
    my $out2 = runner-out($script, 
        sprintf "%s%s", $named ?? '--greeting=' !! '', 'Howdy'
    );
    is $out2, 'Howdy, Stranger', 'One arg';

    my $out3 = runner-out($script,
        sprintf("%s%s", $named ?? '--greeting=' !! '', 'Hola'),
        sprintf("%s%s", $named ?? '--name='     !! '', 'Amigo')
    );

    is $out3, 'Hola, Amigo', 'Two args';
}
