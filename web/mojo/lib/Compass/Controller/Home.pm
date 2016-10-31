package Compass::Controller::Home;

use Mojo::Base 'Mojolicious::Controller';

# --------------------------------------------------
sub index {
    my $self   = shift;
    $self->layout('default');
    $self->render;
}

1;
