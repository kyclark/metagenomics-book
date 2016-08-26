#!/usr/bin/env perl6

put $*IN.lines.Bag.map(*.join("\t")).join("\n")
