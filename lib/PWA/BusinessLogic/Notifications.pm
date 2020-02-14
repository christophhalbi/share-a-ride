package PWA::BusinessLogic::Notifications;

use common::sense;

use Moose;

has 'model_firebase' => (
    is       => 'ro',
    isa      => 'PWA::Model::FirebaseCloudMessaging',
    required => 1,
);

=head2 send_test

=cut

sub send_test {


}

1;
