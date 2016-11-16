#!/usr/bin/env perl6

enum Instrument <Guitar Bass Drums>;

class Person {
    has Str $.first_name is required;
    has Str $.last_name  is required;
    has Date $.birthday;
    has Instrument $.instrument;
    method full_name { join ' ', $!first_name, $!last_name }
}

my Person $geddy .= new(first_name => 'Geddy', last_name => 'Lee',
                    birthday => Date.new(1953, 6, 29), instrument => Bass);
my Person $alex  .= new(first_name => 'Alex',  last_name => 'Leifson',
                    birthday => Date.new(1953, 10, 27), instrument => Guitar);
my Person $neil  .= new(first_name => 'Neil',  last_name => 'Peart',
                    birthday => Date.new(1952, 9, 12), instrument => Drums);

for $geddy, $alex, $neil { 
    printf "%s (%s) born %s\n", .full_name, .instrument, .birthday;
}
