#!/usr/bin/env perl6

sub MAIN (Int :$n=1) {
    my @adjectives = qw{scurvy old filthy scurry lascivious
        foolish rascaly gross rotten corrupt foul loathsome irksome
        heedless unmannered whoreson cullionly false filthsome
        toad-spotted caterwauling wall-eyed insatiate vile peevish
        infected sodden-witted lecherous ruinous indistinguishable
        dishonest thin-faced slanderous bankrupt base detestable
        rotten dishonest lubbery}; 
    my @nouns = qw{knave coward liar swine villain beggar
        slave scold jolthead whore barbermonger fishmonger carbuncle
        fiend traitor block ape braggart jack milksop boy harpy
        recreant degenerate Judas butt cur Satan ass coxcomb dandy
        gull minion ratcatcher maw fool rogue lunatic varlet worm};

    printf "You %s, %s, %s %s!\n", 
        @adjectives.pick(3), @nouns.pick for ^$n;
}
