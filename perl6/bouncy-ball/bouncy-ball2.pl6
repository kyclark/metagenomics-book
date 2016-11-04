#!/usr/bin/env perl6

my enum HorzDir <Left Right>;
my enum VertDir <Up Down>;

class Ball {
    has Int $.max-row;
    has Int $.max-col;
    has Int $.row is rw;
    has Int $.col is rw;
    has HorzDir $.horz-dir is rw;
    has VertDir $.vert-dir is rw;

    method Str {
        return "($.row, $.col)";
    }

    method move {
        if $.horz-dir == Right {
            $.col++;
            $.horz-dir = Left if $.col >= $.max-col;
        }
        else {
            $.col--;
            $.horz-dir = Right if $.col <= 1;
        }

        if $.vert-dir == Down {
            $.row++;
            $.vert-dir = Up if $.row >= $.max-row;
        }
        else {
            $.row--;
            $.vert-dir = Down if $.row <= 1;
        }
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
    my Str $bar    = '+' ~ '-' x $cols ~ '+';
    my $icon       = $smiley ?? $SMILEY-FACE !! $star ?? $STAR !! $DOT;
    my Ball $ball .= new(:horz-dir(HorzDir.pick), :vert-dir(VertDir.pick),
                         :row((1..$rows).pick), :col((1..$cols).pick),
                         :max-row($rows), :max-col($cols));

    loop {
        $ball.move;

        print "\e[H";
        my $screen = "$bar\n";

        for 1..$rows -> $this-row {
            my $line = '|' ~ " " x $cols;

            if $this-row == $ball.row {
                $line.substr-rw($ball.col, 1) = $icon;
            }

            $screen ~= "$line|\n";
        }

        $screen ~= $bar;
        put $screen;
        sleep $refresh;
    }
}
