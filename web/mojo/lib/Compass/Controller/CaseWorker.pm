package Compass::Controller::CaseWorker;

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

# --------------------------------------------------
sub list {
    my $self = shift;
    my $schema = $self->db->schema;
    my $CaseWorkers = $schema->resultset('CaseWorker')->search_rs;
    $self->layout('default');
    $self->render(case_workers => $CaseWorkers);
}

## --------------------------------------------------
#sub update {
#    my $self      = shift;
#    my $client_id = $self->param('client_id') or return
#                    $self->reply->exception("No client id");
#    my $schema    = $self->db->schema;
#    my $Client    = $schema->resultset('Client')->find($client_id) or return
#                    $self->reply->exception("No bad client id ($client_id)");
#
#    for my $fld (qw[first_name last_name]) {
#        my $val = $self->param($fld) or next;
#        $Client->$fld($val);
#    }
#
#    $Client->update;
#
#    return $self->redirect_to("/client/view/" . $Client->id);
#}
#
# --------------------------------------------------
sub view {
    my $self       = shift;
    my $cw_id      = $self->param('case_worker_id') or return
                     $self->reply->exception("No case_worker_id");
    my $schema     = $self->db->schema;
    my $CaseWorker = $schema->resultset('CaseWorker')->find($cw_id) or return
                     $self->reply->exception("Bad case worker id ($cw_id)");

    $self->layout('default');
    $self->render(case_worker => $CaseWorker);
}

1;
