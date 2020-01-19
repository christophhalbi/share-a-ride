use common::sense;

use lib 't/lib';

use Mocker;

use Catalyst::Test 'PWA';
use JSON qw(from_json);
use Test::More;

my $mocker = Mocker->new;

subtest "get_rides empty" => sub {

    my $mock = $mocker->mock('PWA::Model',
        get => sub {

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

subtest "get_rides result" => sub {

    my $mock = $mocker->mock('PWA::Model',
        get => sub {

            return (
                {
                    from   => 'Linz',
                    to     => 'Leonding',
                    driver => 'Max Mustermann',
                    on     => '2019-01-01',
                    at     => '11:00',
                    seats  => 2,
                }
            );
        }
    );

    my $response = request('/get_rides');
    ok $response->is_success;

    is_deeply(
        from_json($response->decoded_content),
        {
            results => [
                {
                    from   => 'Linz',
                    to     => 'Leonding',
                    driver => 'Max Mustermann',
                    on     => '2019-01-01',
                    at     => '11:00',
                    seats  => 2,
                }

            ],
        },
    );
};

done_testing();