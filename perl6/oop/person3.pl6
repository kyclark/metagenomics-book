#!/usr/bin/env perl6

my %geddy = first_name => 'Geddy', last_name => 'Lee';
my %alex  = frist_name => 'Alex',  last_name => 'Leifson';
my %neil  = first_name => 'Neil',  last_neme => 'Peart';

for %geddy, %alex, %neil -> %person {
    printf "%s %s\n", %person<first_name>, %person<last_name>;
}
