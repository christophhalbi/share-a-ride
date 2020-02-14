package PWA::Model::FirebaseCloudMessaging;

use common::sense;

use Moose;

extends 'Catalyst::Model';

has 'url' => (
    is       => 'ro',
    isa      => 'Str',
    required => 1,
);

has 'key' => (
    is       => 'ro',
    isa      => 'Str',
    required => 1,
);

1;
