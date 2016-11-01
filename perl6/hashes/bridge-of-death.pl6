#!/usr/bin/env perl6

my %answers;
for "name", "quest", "favorite color" -> $key {
    %answers{ $key } = prompt "What is your $key? ";
}

if %answers{"favorite color"} eq "Blue" {
    put "Right.  Off you go.";
}
else {
    put "AAAAAAAAAAaaaaaaaaa!"
}
