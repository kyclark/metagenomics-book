#!/usr/bin/env perl6

foo('bar', 'baz');
foo('bar', 123);
foo('quux', 3.14);

multi foo ('bar', Str $str) {
    put "Bar got a string '$str'";
}

multi foo ('bar', Int $n) {
    put "Bar got an integer '$n'";
}

multi foo ('quux', Any $x) {
    put "Bar got an argument '$x'";
}
