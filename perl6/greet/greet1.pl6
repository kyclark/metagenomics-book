#!/usr/bin/env perl6

unless (1 <= @*ARGS.elems <= 2) {
    note "Usage:\n\t{$*PROGRAM-NAME.IO.basename} GREETING [NAME]";
    exit 1;
}

my ($greeting, $name) = @*ARGS;

put "$greeting, {$name // 'Stranger'}";
