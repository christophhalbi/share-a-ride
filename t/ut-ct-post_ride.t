use common::sense;

use lib 't/lib';

use Mocker;

use Catalyst::Test 'PWA';
use HTTP::Request::Common;
use JSON qw(from_json);
use Test::More;

my $mocker = Mocker->new;

subtest "post_ride empty" => sub {

    my $response = request POST '/post_ride', [];
    ok $response->is_success;

    is_deeply(
        from_json($response->decoded_content),
        {
            validation_errors => {
                start_from => 'missing',
                go_to      => 'missing',
                start_on   => 'missing',
                start_at   => 'missing',
                seats      => 'missing',
            },
        },
    );
};

subtest "post_ride" => sub {

    my $mock = $mocker->mock('PWA::Model',
        save_ride => sub {

        }
    );

    my $response = request POST '/post_ride', [
        start_from => 'Linz',
        go_to      => 'Leonding',
        start_on   => '2019-01-01',
        start_at   => '11:00',
        seats      => '2',
    ];
    ok $response->is_success;

    is_deeply(
        from_json($response->decoded_content),
        {
            saved             => 1,
            validation_errors => {},
        },
    );
};

done_testing();
