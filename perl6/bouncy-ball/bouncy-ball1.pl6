#!/usr/bin/env perl6

my enum HorzDir <Left Right>;
my enum VertDir <Up Down>;

class Ball {
    has Int $.row;
    has Int $.col;
    has HorzDir $.horz-dir;
    has VertDir $.vert-dir;

    sub move {
                if $hdir == Right {
                    $show-col++;
                    $hdir = Left if $show-col == $cols;
                }
                else {
                    $show-col--;
                    $hdir = Right if $show-col == 1;
                }
}

my $DOT           = "\x25A0"; # ■
my $STAR          = "\x2605"; # ★
my $SMILEY-FACE   = "\x263A"; # ☺
my ($ROWS, $COLS) = qx/stty size/.words;

sub MAIN (
    Int :$rows=$ROWS - 4,
    Int :$cols=$COLS - 2,
    Numeric :$refresh=.1,
    Bool :$smiley=False,
    Bool :$star=False,
) {
    print "\e[2J";
    my $icon = $smiley ?? $SMILEY-FACE !! $star ?? $STAR !! $DOT;
    my Int $show-row = (1..$rows).pick;
    my Int $show-col = (1..$cols).pick;
    my HorzDir $hdir = HorzDir.pick;
    my VertDir $vdir = VertDir.pick;
    my Str $bar = '+' ~ '-' x $cols ~ '+';

    loop {
        print "\e[H";
        my $screen = "$bar\n";

        for 1..$rows -> $this-row {
            my $line = '|' ~ " " x $cols;

            if $this-row == $show-row {
                if $hdir == Right {
                    $show-col++;
                    $hdir = Left if $show-col == $cols;
                }
                else {
                    $show-col--;
                    $hdir = Right if $show-col == 1;
                }

                $line.substr-rw($show-col, 1) = $icon;
            }

            $screen ~= "$line|\n";

        }

        if $vdir == Down {
            $show-row++;
            $vdir = Up if $show-row == $rows;
        }
        else {
            $show-row--;
            $vdir = Down if $show-row == 1;
        }

        $screen ~= $bar;
        put $screen;
        sleep $refresh;
    }
}
