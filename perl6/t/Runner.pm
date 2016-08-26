unit module Runner;

sub runner-out($script!, *@args) is export {
    my $proc = run $script, @args, :out;
    $proc.out.slurp-rest.chomp;
}

sub runner-err($script!, *@args) is export {
    my $proc = run $script, @args, :err;
    $proc.err.slurp-rest.chomp;
}
