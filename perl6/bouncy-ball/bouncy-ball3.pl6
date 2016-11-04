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
    has Int %.obstacles;

    method Str {
        return "($.row, $.col)";
    }

    method move {
        if $.horz-dir == Right {
            $.col++;
            $.reverse-horz-dir if $.col >= $.max-col;
        }
        else {
            $.col--;
            $.reverse-horz-dir if $.col <= 1;
        }

        if $.vert-dir == Down {
            $.row++;
            $.reverse-vert-dir if $.row >= $.max-row;
        }
        else {
            $.row--;
            $.reverse-vert-dir if $.row <= 1;
        }

        if %.obstacles{($.row, $.col).join('-')}:exists {
            #$.reverse-horz-dir;
            $.reverse-vert-dir;
        }
    }

    method reverse-horz-dir {
        $.horz-dir = $.horz-dir == Left ?? Right !! Left;
    }

    method reverse-vert-dir {
        $.vert-dir = $.vert-dir == Down ?? Up !! Down;
    }
}

my $DOT          := "\x25A0"; # ■
my $STAR         := "\x2605"; # ★
my $SMILEY-FACE  := "\x263A"; # ☺
my $BLOCK        := "\x2588"; # █
my ($ROWS, $COLS) = qx/stty size/.words;

sub MAIN (
    Int :$rows=$ROWS - 4,
    Int :$cols=$COLS - 2,
    Numeric :$refresh=.1,
    Int :$obstacles=0,
    Bool :$smiley=False,
    Bool :$star=False,
) {
    my Str $bar    = '+' ~ '-' x $cols ~ '+';
    my $icon       = $smiley ?? $SMILEY-FACE !! $star ?? $STAR !! $DOT;
    my @row-range  = 1..$rows;
    my @col-range  = 1..$cols;
    my %obstacles  = do @row-range.pick => @col-range.pick for ^$obstacles;
    my Ball $ball .= new(:horz-dir(HorzDir.pick), :vert-dir(VertDir.pick),
                         :row(@row-range.pick), :col(@col-range.pick),
                         :max-row($rows), :max-col($cols),
                         :obstacles(%obstacles.map(*.kv.join('-') => 1)));

    print "\e[2J"; # clear screen

    loop {
        $ball.move;

        print "\e[H";
        my $screen = "$bar\n";

        for 1..$rows -> $this-row {
            my $line = '|' ~ " " x $cols;

            if my $ob-col = %obstacles{ $this-row } {
                $line.substr-rw($ob-col, 1) = $BLOCK;
            }
            elsif $this-row == $ball.row {
                $line.substr-rw($ball.col, 1) = $icon;
            }

            $screen ~= "$line|\n";
        }

        $screen ~= $bar;
        put $screen;
        sleep $refresh;
    }
}
