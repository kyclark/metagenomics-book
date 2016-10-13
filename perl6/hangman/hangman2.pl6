#!/usr/bin/env perl6

use lib $*PROGRAM.IO.dirname;
use Hangman;

sub MAIN(Int :$num-guesses = 10, :$min-word-len=5, :$max-word-len=9) {
    my $words  = '/usr/share/dict/words';
    my $word   = $words.IO.lines.grep(
                 {$min-word-len <= .chars <= $max-word-len}).pick.lc;
    my $puzzle = Puzzle.new(word => $word);

    loop {
        put ~$puzzle;
        if $puzzle.is-solved {
            put "You won!";
            last;
        }

        if $puzzle.number-guessed >= $num-guesses {
            put "Too many guesses. The word was '$word\.' You lose.";
            last;
        }

        my $guess = (prompt "What is your guess? ").lc;
        if $guess !~~ m:i/^<[a..z]>$/ {
            put "Please guess just one letter";
            next;
        }

        if $puzzle.was-guessed($guess) {
            put "You guessed that before!";
            next;
        }

        $puzzle.guess($guess);
    }
}
