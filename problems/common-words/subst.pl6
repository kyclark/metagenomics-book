#!/usr/bin/env perl6
#
# This is an example to show you how to remove the punction
# from the US Constitution file.
#

for 'const.txt'.IO.lines -> $line {
    dd $line.subst(/<-[\w\s]>/, '', :g).words;
}
