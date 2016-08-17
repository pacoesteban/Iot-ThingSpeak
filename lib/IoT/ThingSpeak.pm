package IoT::ThingSpeak;

use strict;
use warnings;
use 5.008_005;
use LWP::UserAgent;
use JSON;
use Carp;
use Moose;
use IoT::ThingSpeak::Channel;

our $BASEURL = 'https://api.thingspeak.com';

has api_key => (
    is  => 'ro',
    isa => 'Str',
);

has channel_id => (
    is  => 'ro',
    isa => 'Int',
);

has _ua => (
    is      => 'ro',
    default => sub {
        LWP::UserAgent->new( agent => 'curl/7.44.0' );
    }
);

sub view_channel {
    my $self = shift;
    my $res =
      $self->_ua->get( $BASEURL . "/channels/" . $self->channel_id . ".json" );
    if ( $res->is_success ) {
        return IoT::ThingSpeak::Channel->new(
            %{ decode_json $res->decoded_content } );
    }
    return undef;
}

sub get_feed {
    my $self = shift;
    my @feeds;
    my $res =
      $self->_ua->get(
        $BASEURL . "/channels/" . $self->channel_id . "/feeds.json" );
    if ( $res->is_success ) {
        my $rawJson = decode_json $res->decoded_content;
        foreach my $f ( @{ $rawJson->{feeds} } ) {
            push @feeds, IoT::ThingSpeak::Channel::Feed->new( %{$f} );
        }
        return \@feeds;
    }
    return undef;
}

no Moose;
__PACKAGE__->meta->make_immutable;

1;
