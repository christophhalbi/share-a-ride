use common::sense;

use lib 't/lib';

use Mocker;

use Catalyst::Test 'PWA';
use JSON qw(from_json);
use Test::More;

my $mocker = Mocker->new;

subtest "get_rides empty" => sub { 

    my $mock = $mocker->mock('PWA::BusinessLogic::Rides', 
        rides => sub {

            return ();
        }
    );   

    my $response = request('/get_rides');
    ok $response->is_success;

    is_deeply(
        from_json($response->decoded_content),
        {
            results => [],       
        },
        "empty",
    );
};

done_testing();