#!/usr/bin/env perl6

my enum HorzDir <Left Right>;
my enum VertDir <Up Down>;

subset PosInt of Int where * > 0;

class Ball {
    has Int $.rows;
    has Int $.cols;
    has Int $.row is rw;
    has Int $.col is rw;
    has HorzDir $.horz-dir is rw;
    has VertDir $.vert-dir is rw;

    submethod BUILD (PosInt :$cols, PosInt :$rows) {
        $!cols     = $cols;
        $!rows     = $rows;
        $!horz-dir = HorzDir.pick;
        $!vert-dir = VertDir.pick;
        $!row      = (1..$rows).pick;
        $!col      = (1..$cols).pick;
    }

    method Str {
        return "($.row, $.col)";
    }

    method reverse-horz-dir {
        $.horz-dir = $.horz-dir == Left ?? Right !! Left;
    }

    method reverse-vert-dir {
        $.vert-dir = $.vert-dir == Down ?? Up !! Down;
    }

    method move {
        if $.horz-dir == Right {
            $.col += $.col < $.cols ?? 1 !! -1;
        }
        else {
            $.col += $.col > 1      ?? -1 !! 1;
        }

        if $.vert-dir == Down {
            $.row += $.row < $.rows ?? 1 !! -1;
        }
        else {
            $.row += $.row > 1      ?? -1 !! 1;
        }

        $.reverse-horz-dir if $.col <= 1 || $.col >= $.cols;
        $.reverse-vert-dir if $.row <= 1 || $.row >= $.rows;
    }
}

my $DOT           = "\x25A0"; # ■
my $STAR          = "\x2605"; # ★
my $SMILEY-FACE   = "\x263A"; # ☺
my ($ROWS, $COLS) = qx/stty size/.words;

sub MAIN (
    PosInt :$rows=$ROWS - 4,
    PosInt :$cols=$COLS - 2,
    PosInt :$balls=1,
    Numeric :$refresh=.1,
    Bool :$smiley=False,
    Bool :$star=False,
) {
    print "\e[2J";
    my Str $bar    = '+' ~ '-' x $cols ~ '+';
    my $icon       = $smiley ?? $SMILEY-FACE !! $star ?? $STAR !! $DOT;
    my Ball @balls = do for ^$balls { Ball.new(:rows($rows), :cols($cols)) };

    loop {
        @balls.map(*.move);

        print "\e[H";
        my $screen = "$bar\n";

        for 1..$rows -> $this-row {
            my $line = '|' ~ " " x $cols;

            for @balls -> $ball {
                if $this-row == $ball.row {
                    $line.substr-rw($ball.col, 1) = $icon;
                }
            }

            $screen ~= "$line|\n";
        }

        $screen ~= $bar;
        put $screen;
        sleep $refresh;
    }
}
