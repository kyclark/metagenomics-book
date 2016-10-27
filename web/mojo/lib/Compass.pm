package Compass;

use Mojo::Base 'Mojolicious';

use lib '/usr/local/compass/lib';
use Compass::DB;

sub startup {
    my $self = shift;

    $self->plugin('tt_renderer');

    $self->plugin('PODRenderer');

    $self->plugin('JSONConfig', { file => 'compass.json' });

    my $r = $self->routes;

    $r->get('/')->to('home#index');

    $r->get('/case_worker/list')->to('case_worker#list');

    $r->get('/case_worker/view/:case_worker_id')->to('case_worker#view');

    $r->get('/client/list')->to('client#list');
  
    $r->post('/client/create')->to('client#create');

    $r->get('/client/create_form')->to('client#create_form');

    $r->get('/client/edit/:client_id')->to('client#edit');

    $r->post('/client/update')->to('client#update');

    $r->get('/client/view/:client_id')->to('client#view');

    $r->get('/dependent/view/:dependent_id')->to('dependent#view');

    $self->helper(
        db => sub {
            my $self   = shift;
            my $config = $self->config;
            return Compass::DB->new;
        }
    );
}

1;
