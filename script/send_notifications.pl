
use common::sense;

use lib 'lib';

use PWA::Configuration;
use PWA::BusinessLogic::Notifications;
use PWA::Model::FirebaseCloudMessaging;

my $config = PWA::Configuration->new;

my $model = PWA::Model::FirebaseCloudMessaging->new(
    key => $config->get(qw(Model::FirebaseCloudMessaging key)),
    url => $config->get(qw(Model::FirebaseCloudMessaging url)),
);

my $bl = PWA::BusinessLogic::Notifications->new( model_firebase => $model );

$bl->send_test;
