use strict;
use Test::More;
use Test::LWP::UserAgent;
use IoT::ThingSpeak;
use IoT::ThingSpeak::Channel;

my $test_ua = Test::LWP::UserAgent->new;
$test_ua->map_response(
    qr{/channels/4.json},
    HTTP::Response->new(
        '200',
        HTTP::Status::status_message('200'),
        [ 'Content-Type' => 'application/json' ],
        '{
          "id": 4,
          "name": "My New Channel",
          "description": null,
          "metadata": null,
          "latitude": null,
          "longitude": null,
          "created_at": "2014-03-25T13:12:50-04:00",
          "elevation": null,
          "last_entry_id": null,
          "ranking": 15,
          "username": "hans",
          "tags": []
        }'
    ),
);

my $ts = IoT::ThingSpeak->new(
    api_key    => 'XXXXX',
    channel_id => 4,
    '_ua'      => $test_ua
);

isa_ok($ts, 'IoT::ThingSpeak');
isa_ok($ts->view_channel, 'IoT::ThingSpeak::Channel');
like( $ts->view_channel->name, qr/My New Channel/, 'public channels test' );

done_testing;
