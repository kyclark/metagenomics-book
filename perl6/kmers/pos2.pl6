#!/usr/bin/env perl6

subset SmallPosInt of Int where 0 < * < 50 ;
sub MAIN (SmallPosInt :$k=10) {
    put "k = $k";
}
