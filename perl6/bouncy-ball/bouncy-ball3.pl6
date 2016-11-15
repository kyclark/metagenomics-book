#!/usr/bin/env perl6

subset PosInt of Int where * > 0;

class Ball {
    has Int $.rows;
    has Int $.cols;
    has Int $.row is rw = (2..^$!rows).pick;
    has Int $.col is rw = (2..^$!cols).pick;
    has Int $.horz-dir is rw = (1, -1).pick;
    has Int $.vert-dir is rw = (1, -1).pick;

    method Str { join ',', $!row, $!col }

    method pos { ($.row, $.col) }

    method move {
        $!col += $!horz-dir;
        $!row += $!vert-dir;
        $!horz-dir *= -1 if $!col <= 1 || $!col >= $!cols;
        $!vert-dir *= -1 if $!row <= 1 || $!row >= $.rows;
    }
}

my $DOT           = "\x25A0"; # ■
my $STAR          = "\x2605"; # ★
my $SMILEY-FACE   = "\x263A"; # ☺
my ($ROWS, $COLS) = qx/stty size/.words;

sub MAIN (
    PosInt :$rows=$ROWS - 4,
    PosInt :$cols=$COLS - 2,
    PosInt :$balls=10,
    Numeric :$refresh=.075,
    Bool :$smiley=False,
) {
    print "\e[2J";
    my Str $bar    = '+' ~ '-' x $cols ~ '+';
    my $icon       = $smiley ?? $SMILEY-FACE !! $DOT;
    my Ball @balls = Ball.new(:$rows, :$cols) xx $balls;

    loop {
        .move for @balls;

        my $positions = (@balls».Str).Bag;

        my %row;
        for $positions.list -> (:$key, :$value) {
            my ($row, $col) = $key.split(',');
            %row{ $row }.append: $col => $value;
        }

        print "\e[H";
        my $screen = "$bar\n";

        for 1..$rows -> $this-row {
            my $line = '|' ~ " " x $cols;
            if %row{ $this-row }:exists {
                for %row{ $this-row }.list -> (:$key, :$value) {
                    $line.substr-rw($key, 1) = $value == 1 ?? $icon !! $STAR;
                }
            }

            $screen ~= "$line|\n";
        }

        $screen ~= $bar;
        put $screen;
        sleep $refresh;
        my @collisions = $positions.grep(*.value > 1).map(*.key);
        @balls = @balls.grep(none(@collisions) eq *.Str);
    }
}
