#!/usr/bin/env perl6

my %geddy = first_name => 'Geddy', last_name => 'Lee';
my %alex  = first_name => 'Alex',  last_name => 'Leifson';
my %neil  = first_name => 'Neil',  last_name => 'Peart';

sub full_name (%person) {
    join ' ', %person<first_name>, %person<last_name>;
}

for %geddy, %alex, %neil -> %person {
    printf "Full Name: %s\n", full_name(%person);
}
