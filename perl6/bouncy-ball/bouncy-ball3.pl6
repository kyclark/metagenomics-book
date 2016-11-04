#!/usr/bin/env perl6

my enum Dir     <Horz Vert>;
my enum HorzDir <Left Right>;
my enum VertDir <Up Down>;

class Ball {
    has Int $.rows;
    has Int $.cols;
    has Int $.obstacles;
    has Int $.row is rw;
    has Int $.col is rw;
    has HorzDir $.horz-dir is rw;
    has VertDir $.vert-dir is rw;
    has %.obstacle-map;

    submethod BUILD (Int :$rows, Int :$cols, Int :$obstacles) {
        $!rows     = +$rows;
        $!cols     = +$cols;
        $!col      = (1..$cols).pick;
        $!row      = (1..$rows).pick;
        $!horz-dir = HorzDir.pick;
        $!vert-dir = VertDir.pick;

        for ^$obstacles {
            my $r = (1..$rows).roll;
            my $c = (1..$cols).roll;

            %!obstacle-map{ $r }.push: $c;
            if Dir.pick == Horz { 
                if $c < $cols { $c++ } else { $c-- }
            } 
            else { 
                if $r < $rows { $r++ } else { $r-- }
            }
            %!obstacle-map{ $r }.push: $c;
        }
    }

    method Str {
        return "($.row, $.col)";
    }

    method move {
        if $.horz-dir == Right {
            $.col++;
            $.reverse-horz-dir if $.col >= $.cols;
        }
        else {
            $.col--;
            $.reverse-horz-dir if $.col <= 1;
        }

        if $.vert-dir == Down {
            $.row++;
            $.reverse-vert-dir if $.row >= $.rows;
        }
        else {
            $.row--;
            $.reverse-vert-dir if $.row <= 1;
        }

        if %.obstacle-map{$.row}:exists &&
           any(%.obstacle-map{$.row}.list) == $.col
        {
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
    Int :$obstacles=0,
    Numeric :$refresh=.1,
    Bool :$smiley=False,
    Bool :$star=False,
) {
    my Str $bar    = '+' ~ '-' x $cols ~ '+';
    my $icon       = $smiley ?? $SMILEY-FACE !! $star ?? $STAR !! $DOT;
    my Ball $ball .= new(:rows(+$rows), :cols(+$cols), :obstacles(+$obstacles));
    my %obstacles  = $ball.obstacle-map;

    print "\e[2J"; # clear screen

    loop {
        $ball.move;

        print "\e[H";
        my $screen = "$bar\n";

        for 1..$rows -> $this-row {
            my $line = '|' ~ " " x $cols;

            if my $ob-cols = %obstacles{ $this-row } {
                for $ob-cols.list -> $c {
                    $line.substr-rw($c, 1) = $BLOCK;
                }
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
