use strict;
use warnings;

use PWA;

my $app = PWA->apply_default_middlewares(PWA->psgi_app);
$app;

