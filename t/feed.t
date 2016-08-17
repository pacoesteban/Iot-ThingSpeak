use strict;
use Test::More;
use Test::LWP::UserAgent;
use IoT::ThingSpeak;
use IoT::ThingSpeak::Channel;
use IoT::ThingSpeak::Channel::Feed;
use Data::Dumper;

my $test_ua = Test::LWP::UserAgent->new;
$test_ua->map_response(
    qr{/channels/9/feeds.json},
    HTTP::Response->new(
        '200',
        HTTP::Status::status_message('200'),
        [ 'Content-Type' => 'application/json' ],
        '{
          "channel":
          {
            "id": 9,
            "name": "my_house",
            "description": "Netduino Plus connected to sensors around the house",
            "latitude": "40.44",
            "longitude": "-79.996",
            "field1": "Light",
            "field2": "Outside Temperature",
            "created_at": "2010-12-13T20:20:06-05:00",
            "updated_at": "2014-02-26T12:43:04-05:00",
            "last_entry_id": 6060625
          },
          "feeds":
          [
            {
              "created_at": "2014-02-26T12:42:49-05:00",
              "entry_id": 6060624,
              "field1": "188",
              "field2": "25.902335456475583"
            },
            {
              "created_at": "2014-02-26T12:43:04-05:00",
              "entry_id": 6060625,
              "field1": "164",
              "field2": "25.222929936305732"
            }
          ]
        }'
    ),
);

my $ts = IoT::ThingSpeak->new(
    api_key    => 'XXXXX',
    channel_id => 9,
    '_ua'      => $test_ua
);

isa_ok( $ts->get_feed, 'ARRAY' );
is( $ts->get_feed->[0]->{created_at}->year, 2014, 'test feeds' );

done_testing;
