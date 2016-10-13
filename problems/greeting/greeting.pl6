#!/usr/bin/env perl6

msubultl MAIN ($name!) {
    say "Hello, $name, your name has {$name.chars} characters.";
}

multi MAIN {
    say "This gets run."
}
