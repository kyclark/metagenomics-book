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
    has Bool %.obstacle-map;
    has Str $.message is rw = "";

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

            %!obstacle-map{"$r:$c"} = True;
            if Dir.pick == Horz {
                if $c < $cols { $c++ } else { $c-- }
            }
            else {
                if $r < $rows { $r++ } else { $r-- }
            }
            %!obstacle-map{"$r:$c"} = True;
        }
    }

    method Str { "($.row, $.col)" }

    method move {
        $.message = "";
        my %checks = 
            'Up-Right'   => $.row + 1, $.col + 1,
            'Up-Left'    => $.row + 1 => $.col - 1,
            'Down-Right' => $.row - 1 => $.col + 1,
            'Down-Left'  => $.row - 1 => $.col - 1;

        my %blocks     = map { $_ => %.obstacle-map{ $_ }:exists }, @checks;
        my $new-col    = $.col;
        my $new-row    = $.row;
        my $trajectory = join('-', ~$.horz-dir, ~$.vert-dir);

        if $.horz-dir == Right {
            $new-col++;
        }
        else {
            $new-col--;
        }

        if $.vert-dir == Down {
            $new-row++;
        }
        else {
            $new-row--;
        }

        if %blocks{ ($new-row, $new-col).join(':') } {
            $.message = "HIT on ($new-row, $new-col)!";
            $.reverse-vert-dir;
        }
        else {
            $.row = $new-row;
            $.col = $new-col;

            if $.col >= $.cols || $.col <= 1 {
                $.message = "hit side wall";
                $.reverse-horz-dir;
            }

            if $.row >= $.rows || $.row <= 1 {
                $.message = "hit top or bottom";
                $.reverse-vert-dir;
            }
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
    my %ob-map;
    for $ball.obstacle-map.keys.map(*.split(':')) -> ($k, $v) {
        %ob-map{ $k }.push: $v;
    }

    print "\e[2J"; # clear screen

    loop {
        $ball.move;

        print "\e[H";
        my $screen = "$bar\n";

        for 1..$rows -> $this-row {
            my $line = '|' ~ " " x $cols;

            if my $ob-cols = %ob-map{ $this-row } {
                for $ob-cols.list -> $c {
                    $line.substr-rw($c, 1) = $BLOCK;
                }
            }

            if $this-row == $ball.row {
                $line.substr-rw($ball.col, 1) = $icon;
            }

            $screen ~= "$line|\n";
        }

        $screen ~= "$bar\n";
        put $screen;
        sleep $refresh;
    }
}
