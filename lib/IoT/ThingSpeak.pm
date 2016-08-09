package IoT::ThingSpeak;

use strict;
use warnings;
use 5.008_005;
use LWP::UserAgent;
use JSON;
use Carp;
use Moose;

our $BASEURL = 'https://api.thingspeak.com';

has api_key => (
    is  => 'ro',
    isa => 'Str',
);

has _ua => (
    is      => 'ro',
    default => sub {
        LWP::UserAgent->new( agent => 'curl/7.44.0' );
    }
);

no Moose;
__PACKAGE__->meta->make_immutable;

1;
