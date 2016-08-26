#!/usr/bin/env perl6

#sub MAIN (*@a where { .all ~~ Int }) {

sub MAIN(*@numbers (Int $, Int $, *@_)) { say [+] @numbers };

#multi MAIN (Int $n) {
#    put $n;
#}
#
#multi MAIN (Int *@n) {
#    put [+] @n;
#}
