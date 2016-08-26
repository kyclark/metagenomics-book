#!/usr/bin/env perl6

use v6;

multi foo(Str:D $s --> Str) { "Got Str '$s'" }

multi foo(Str:U $ --> Str) { fail "Got undefined string" }

multi foo(Int $i --> Str) { "Got Int '$i'" }

multi foo(Numeric $x, Numeric $y) returns Str { "Got $x/$y" }

CATCH {
    put foo("Ken");
#    put foo(Str);
    put foo(10);
    put foo(3.14, 8);
};
