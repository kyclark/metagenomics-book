#!/usr/bin/env perl6

class Person {
    has Str $.first_name;
    has Str $.last_name;
}

my $geddy = Person.new(first_name => 'Geddy', last_name => 'Lee');
my $alex  = Person.new(first_name => 'Alex',  last_name => 'Leifson');
my $neil  = Person.new(first_name => 'Neil',  last_name => 'Peart');

for $geddy, $alex, $neil -> $person {
    printf "%s %s\n", $person.first_name, $person.last_name;
}
