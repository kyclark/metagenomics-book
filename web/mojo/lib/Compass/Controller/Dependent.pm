package Compass::Controller::Dependent;

use Mojo::Base 'Mojolicious::Controller';
use Compass::DB;

## --------------------------------------------------
#sub create {
#    my $self   = shift;
#    my $fname  = $self->param('first_name') || '';
#    my $lname  = $self->param('last_name')  || '';
#    my $schema = $self->db->schema;
#
#    if ($fname || $lname) {
#        my $Client = $schema->resultset('Client')->create({
#            first_name => $fname,
#            last_name  => $lname,
#        });
#
#        return $self->redirect_to("/client/view/" . $Client->id);
#    }
#    else {
#        return $self->redirect_to("/client/list");
#    }
#}
#
## --------------------------------------------------
#sub create_form {
#    my $self = shift;
#    $self->layout('default');
#    $self->render;
#}
#
## --------------------------------------------------
#sub edit {
#    my $self      = shift;
#    my $client_id = $self->param('client_id') or return
#                    $self->reply->exception("No client id");
#    my $schema    = $self->db->schema;
#    my $Client    = $schema->resultset('Client')->find($client_id) or return
#                    $self->reply->exception("No bad client id ($client_id)");
#
#    $self->layout('default');
#    $self->render(client => $Client);
#}
#
## --------------------------------------------------
#sub list {
#    my $self = shift;
#    my $schema = $self->db->schema;
#    my $Clients = $schema->resultset('Client')->search_rs;
#    $self->layout('default');
#    $self->render(clients => $Clients);
#}
#
## --------------------------------------------------
#sub update {
#    my $self      = shift;
#    my $client_id = $self->param('client_id') or return
#                    $self->reply->exception("No client id");
#    my $schema    = $self->db->schema;
#    my $Client    = $schema->resultset('Client')->find($client_id) or return
#                    $self->reply->exception("No bad client id ($client_id)");
#    my $vars      = $self->req->params->to_hash;
#    my $PK        = join '', $Client->result_source->primary_columns;
#
#    for my $fld ($Client->result_source->columns) {
#        next if $fld eq $PK;
#        next unless defined $vars->{ $fld };
#        my $val = $self->param($fld);
#        $val = '' unless defined $val;
#        $Client->$fld($val);
#    }
#
#    $Client->update;
#
#    return $self->redirect_to("/client/view/" . $Client->id);
#}

# --------------------------------------------------
sub view {
    my $self   = shift;
    my $dep_id = $self->param('dependent_id') or return
                 $self->reply->exception("No dependent_id");
    my $schema = $self->db->schema;
    my $Dep    = $schema->resultset('Dependent')->find($dep_id) or return
                 $self->reply->exception("Bad dependent id ($dep_id)");

    $self->layout('default');
    $self->render(dep => $Dep);
}

1;
